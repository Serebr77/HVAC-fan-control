#!/usr/bin/python3

# Autostart commands is placed in rc.local: sudo nano /etc/rc.local

# The GPIO must be one of the following:

# 12  PWM channel 0  All models but A and B
# 13  PWM channel 1  All models but A and B
# 18  PWM channel 0  All models
# 19  PWM channel 1  All models but A and B

import pigpio
from signal import pause
import time
import datetime
import sys

from time import strftime
strftime("%m/%d/%Y %H:%M:%S")

default_dutycycle = 0.18 # Forced duty cycle when AC PWM is idle

default_night     = default_dutycycle # Duty cycle during the night
default_day       = 0.15              # Duty cycle during the day

pwm_out_pin = 12
pwm_input_pin = 6
pwm_range = 1e4
pwm_output_frequency = 30 # Hz

print_enabled = 0

pi=pigpio.pi()

pi.set_PWM_range(pwm_out_pin, pwm_range)
# pi.hardware_PWM(pwm_out_pin, 100, 1e6*0.425) # 100Hz 42.5% dutycycle - original for ventilation
pi.hardware_PWM(pwm_out_pin, pwm_output_frequency, 1e6*default_dutycycle) # 200Hz default dutycycle

# pi.hardware_PWM(19, 200, 1e6*0.425) # Debug pin!!! 101Hz 42.5% dutycycle

NAN = 2**40

current_high = NAN
current_low  = NAN
last_rising  = NAN
last_falling = NAN

target_dutycycle = 0
get_pwm_dutycycle  = 0
measured_dutycycle = 1.0
timeout_counter = 10
change_dutycycle = 1
first_write = 'w'

def cbf(gpio, level, tick):
   #print(gpio, level, tick)
  
  global current_high
  global current_low 
  global last_rising 
  global last_falling
  global pwm_range
  global pwm_out_pin
  global get_pwm_dutycycle
  global target_dutycycle
  global measured_dutycycle
  global default_dutycycle, change_dutycycle
  global timeout_counter, first_write
  
  print_now = 0
  
  if level == 0:   # falling edge
    if last_falling < NAN:
      if last_rising > tick: 
        last_rising = last_rising - 2**32
        print_now = 1
      current_high = tick - last_rising
    last_falling = tick
  elif level == 1: # rising edge
    if last_rising < NAN:
      if last_falling > tick: 
        last_falling = last_falling - 2**32
        print_now = 1
      current_low = tick - last_falling
    last_rising = tick
  else:            # callback timeout - no edges on PWM wire detected
    current_high = NAN
    current_low  = NAN
    last_rising  = NAN
    last_falling = NAN
    timeout_counter = 0
    change_dutycycle = 1
    target_dutycycle = default_dutycycle

  if timeout_counter > 0:
    timeout_counter = timeout_counter - 1

  # if print_now: # Debug counter roll-off
    # print('Event. current_low: %d, current_high: %d, low/(high+low): %7.5f' % (current_low,current_high,
      # float(current_low)/(current_low+current_high)))
    
  if current_high < NAN and current_low < NAN:
    measured_dutycycle = float(current_low)/(current_low + current_high)
    # target_dutycycle = default_dutycycle
    # change_dutycycle = 1
  else:
    measured_dutycycle = 0
    
  if measured_dutycycle > target_dutycycle * 1.05: # External PWM detected
    timeout_counter  = 10
    if target_dutycycle > 0:
      change_dutycycle = 1
      target_dutycycle = 0
  
  get_pwm_dutycycle = pi.get_PWM_dutycycle(pwm_out_pin) / pwm_range

  if get_pwm_dutycycle > 1:
    get_pwm_dutycycle = 1
  
  # if (change_dutycycle == 1 and abs(get_pwm_dutycycle - target_dutycycle) > 0.01):
  if abs(get_pwm_dutycycle - target_dutycycle) > 0.01:
    pi.set_PWM_dutycycle(pwm_out_pin,target_dutycycle * pwm_range)
    
    change_dutycycle = 0
    
    s = time.strftime("%d/%m/%Y %H:%M:%S")
    if print_enabled:
      print('%s Measured: %4.1f%% Changed from %4.1f%% to %4.1f%%' % 
        (s, measured_dutycycle*100, get_pwm_dutycycle*100, target_dutycycle*100))

    with open('/var/tmp/changes.html', first_write) as f:
      buf = s + ' Measured: %4.1f%% Changed from %4.1f%% to %4.1f%%' % \
        (measured_dutycycle*100, get_pwm_dutycycle*100, target_dutycycle*100)
      f.write(buf + '<br>')
      first_write = 'a'
  
pi.set_PWM_frequency(pwm_out_pin,pwm_output_frequency)

pi.set_pull_up_down(pwm_input_pin, pigpio.PUD_OFF)
cb1 = pi.callback(pwm_input_pin, pigpio.EITHER_EDGE, cbf)
pi.set_glitch_filter(pwm_input_pin, 100) # debouncing for 100 us
pi.set_watchdog(pwm_input_pin, 100)      # 100 ms watchdog on GPIO pwm_input_pin

with open('/var/tmp/index.html', 'w') as f:
  f.write('<!DOCTYPE html><html><body><p>')
  f.write('<iframe src="status.html"  height="70" width="700" title="Status" ></iframe>' + '\n')
  f.write('<br>')
  f.write('<iframe src="changes.html" width="700" title="Changes"></iframe>' + '\n')
  f.write('</p></body></html>')

while 1:

  measured = 0
  if current_low < NAN and current_high < NAN:
    measured = float(current_low)/(current_low+current_high)

  buf = ' Measured: %4.1f%% PWM Target: %4.1f%% PWM Output: %4.1f%%' % \
    (measured*100, target_dutycycle*100, get_pwm_dutycycle*100)
    
  if print_enabled:
    s = time.strftime("  %H:%M:%S")
    buf = '         ' + s + buf
    sys.stdout.write(buf + '\r')
    sys.stdout.flush()
    
  with open('/var/tmp/status.html', 'w') as f:
    s = time.strftime("%d/%m/%Y %H:%M:%S")
    button = '<button type="button" \
      onclick="document.getElementById(\'demo\').innerHTML = Date()"> \
      Click me to display Date and Time.</button> \
      <p id="demo"></p>'
    buf = s + buf #  + button

    buf = '<!DOCTYPE html><html><body><p>' + buf + '</p></body></html>'
    f.write(buf)

  now = datetime.datetime.now()
  minutes_total = now.hour * 60 + now.minute
  
  if minutes_total >= 7 * 60 + 0 and minutes_total <= 21 * 60 + 30: # day
    if default_dutycycle != default_day:
      default_dutycycle = default_day
      change_dutycycle = 1
  else:                                                             # night
    if default_dutycycle != default_night:
      default_dutycycle = default_night
      change_dutycycle = 1
  
  time.sleep(10)
    

#pause()