# HVAC-fan-control
Some HVAC systems lack an ability to set air ventilation by arbitrary schedule and flow rate. In my house I have Carrier furnace model 58TP1A70V14R installed. This furnace supports 2-stage variable speed control but Google Nest thermostat is unable to control blower fan speed when mode is set to ventilation only.
I wanted to have forced air flow running continuously with only intensity varying over the day and night time by some schedule.

I discovered that:
-	my furnace blower motor is controlled by PWM protocol
-	PWM is done as open drain circuit with ~5K pull up resistor from +18v power rail
-	when thermostat commands to turn on blower then blower runs with the speed being set up by dials on the furnace controller board
-	the same blower fan speed is used by furnace controller both for ventilation and cooling mode
-	the lowest blower fan speed I can set by dials on the furnace controller board is 51%
-	when my furnace is in heating mode it runs blower fan at 19%

To avoid excessive noise and reduce power consumption I wanted to have blower fan running all the time at 19%.

