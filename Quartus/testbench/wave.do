onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group fan_control -radix binary -radixshowbase 0 /fan_control_tb/fan_control/clk
add wave -noupdate -expand -group fan_control -radix unsigned -radixshowbase 0 /fan_control_tb/fan_control/pwm_i
add wave -noupdate -expand -group fan_control -radix unsigned -radixshowbase 0 /fan_control_tb/fan_control/pwm_o
add wave -noupdate -expand -group fan_control -radix unsigned -radixshowbase 1 /fan_control_tb/fan_control/state
add wave -noupdate -expand -group fan_control -radix unsigned -radixshowbase 0 /fan_control_tb/fan_control/strobe_1us
add wave -noupdate -expand -group fan_control -radix unsigned -childformat {{{/fan_control_tb/fan_control/clk_cnt[5]} -radix unsigned} {{/fan_control_tb/fan_control/clk_cnt[4]} -radix unsigned} {{/fan_control_tb/fan_control/clk_cnt[3]} -radix unsigned} {{/fan_control_tb/fan_control/clk_cnt[2]} -radix unsigned} {{/fan_control_tb/fan_control/clk_cnt[1]} -radix unsigned} {{/fan_control_tb/fan_control/clk_cnt[0]} -radix unsigned}} -radixshowbase 0 -subitemconfig {{/fan_control_tb/fan_control/clk_cnt[5]} {-height 20 -radix unsigned -radixshowbase 0} {/fan_control_tb/fan_control/clk_cnt[4]} {-height 20 -radix unsigned -radixshowbase 0} {/fan_control_tb/fan_control/clk_cnt[3]} {-height 20 -radix unsigned -radixshowbase 0} {/fan_control_tb/fan_control/clk_cnt[2]} {-height 20 -radix unsigned -radixshowbase 0} {/fan_control_tb/fan_control/clk_cnt[1]} {-height 20 -radix unsigned -radixshowbase 0} {/fan_control_tb/fan_control/clk_cnt[0]} {-height 20 -radix unsigned -radixshowbase 0}} /fan_control_tb/fan_control/clk_cnt
add wave -noupdate -expand -group fan_control -radix unsigned -childformat {{{/fan_control_tb/fan_control/pwm_cnt[13]} -radix unsigned} {{/fan_control_tb/fan_control/pwm_cnt[12]} -radix unsigned} {{/fan_control_tb/fan_control/pwm_cnt[11]} -radix unsigned} {{/fan_control_tb/fan_control/pwm_cnt[10]} -radix unsigned} {{/fan_control_tb/fan_control/pwm_cnt[9]} -radix unsigned} {{/fan_control_tb/fan_control/pwm_cnt[8]} -radix unsigned} {{/fan_control_tb/fan_control/pwm_cnt[7]} -radix unsigned} {{/fan_control_tb/fan_control/pwm_cnt[6]} -radix unsigned} {{/fan_control_tb/fan_control/pwm_cnt[5]} -radix unsigned} {{/fan_control_tb/fan_control/pwm_cnt[4]} -radix unsigned} {{/fan_control_tb/fan_control/pwm_cnt[3]} -radix unsigned} {{/fan_control_tb/fan_control/pwm_cnt[2]} -radix unsigned} {{/fan_control_tb/fan_control/pwm_cnt[1]} -radix unsigned} {{/fan_control_tb/fan_control/pwm_cnt[0]} -radix unsigned}} -radixshowbase 0 -subitemconfig {{/fan_control_tb/fan_control/pwm_cnt[13]} {-height 20 -radix unsigned} {/fan_control_tb/fan_control/pwm_cnt[12]} {-height 20 -radix unsigned} {/fan_control_tb/fan_control/pwm_cnt[11]} {-height 20 -radix unsigned} {/fan_control_tb/fan_control/pwm_cnt[10]} {-height 20 -radix unsigned} {/fan_control_tb/fan_control/pwm_cnt[9]} {-height 20 -radix unsigned} {/fan_control_tb/fan_control/pwm_cnt[8]} {-height 20 -radix unsigned} {/fan_control_tb/fan_control/pwm_cnt[7]} {-height 20 -radix unsigned} {/fan_control_tb/fan_control/pwm_cnt[6]} {-height 20 -radix unsigned} {/fan_control_tb/fan_control/pwm_cnt[5]} {-height 20 -radix unsigned} {/fan_control_tb/fan_control/pwm_cnt[4]} {-height 20 -radix unsigned} {/fan_control_tb/fan_control/pwm_cnt[3]} {-height 20 -radix unsigned} {/fan_control_tb/fan_control/pwm_cnt[2]} {-height 20 -radix unsigned} {/fan_control_tb/fan_control/pwm_cnt[1]} {-height 20 -radix unsigned} {/fan_control_tb/fan_control/pwm_cnt[0]} {-height 20 -radix unsigned}} /fan_control_tb/fan_control/pwm_cnt
add wave -noupdate -expand -group fan_control -radix unsigned -radixshowbase 0 /fan_control_tb/fan_control/pwm_d
add wave -noupdate -expand -group fan_control -radix unsigned -radixshowbase 0 /fan_control_tb/fan_control/pwm_out
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {161642 ns} 0} {{Cursor 2} {10007010 ns} 0}
quietly wave cursor active 2
configure wave -namecolwidth 150
configure wave -valuecolwidth 65
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {9925978 ns} {10090042 ns}
