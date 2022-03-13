module fan_control_tb ();


reg  clk   = 0; // 50 MHz
reg  pwm_i = 0; // active low
wire pwm_o;     // active high

reg clk_1MHz = 0; // 1 MHz

int cnt = 0;

initial
  forever 
    clk      = #10ns  !clk;      // 50 MHz

initial
  forever 
    clk_1MHz = #500ns !clk_1MHz; // 1 MHz
    
always @(posedge clk_1MHz)
  begin
    cnt <= ( (cnt+1) % 10000); // 100 Hz
    
    if (cnt >= 1 && cnt <= 10) // typical PWM idle pulse width = 10 us
      pwm_i <= 0;
    else
      pwm_i <= 1'b1;
      
  end

fan_control fan_control (
  .clk   ( clk   ),
  .pwm_i ( pwm_i ),
  .pwm_o ( pwm_o )
);


endmodule : fan_control_tb
