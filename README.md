# HVAC-fan-control
Some HVAC systems lack an ability to set air ventilation by arbitrary schedule and flow rate. In my house I have Carrier furnace model 58TP1A70V14R installed. This furnace supports 2-stage variable speed control but Google Nest thermostat is unable to control blower fan speed when mode is set to ventilation only.
I wanted to keep air flow running continuously when it's commanded to be off by the HVAC controller. This default ventilation should have its intensity programmable by the arbitrary schedule.

I discovered that:
-	my furnace blower motor is controlled by PWM protocol
-	PWM is done as open drain circuit with ~5K pull up resistor from +18v power rail
-	PWM frequency is 101 Hz
-	when blower motor is off HVAC controller still sends 10us long (0.1% duty cycle) pulses to the blower while maintaning the same 101 Hz repetition rate
-	when thermostat commands to turn on blower then blower runs with the speed being set up by dials on the furnace controller board
-	the same blower fan speed (51%) is used by furnace controller both for ventilation and cooling mode
-	the lowest blower fan speed I can set by dials on the furnace controller board is 51%
-	when my furnace is in heating mode it commands blower fan to run at 19%

To avoid excessive noise and reduce power consumption I wanted to have blower fan running at 19% when it's supposed to be off by HVAC controller.

