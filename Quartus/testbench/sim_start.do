vlog ../fan_control.sv
vlog fan_control_tb.sv
vsim -voptargs=+acc +acc work.fan_control_tb
