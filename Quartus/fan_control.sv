module fan_control (
  input  clk,   // 50 MHz
  input  pwm_i, // active low
  output pwm_o  // active high
);

localparam CLKDIV = 50; // 1 MHz

// full period = 10ms = 10000 @ 1 MHz clocks, duty cycle = 19%
localparam PWM_LENGTH = 1900; 

// Rearm pause to avoid catching current cycle active pwm
localparam PWM_REARM  = 10000 - PWM_LENGTH - 500; // 500 - 5% margin for the full cycle length

enum bit [2:0] {IDLE, RUN, STOP} state = IDLE; // one-hot

reg strobe_1us = 0;

reg [$clog2(CLKDIV)-1:0] clk_cnt = 0;

reg [$clog2(PWM_LENGTH + PWM_REARM)-1:0] pwm_cnt = 0;

reg [4:0] pwm_d   = 0;
reg       pwm_out = 0; // pwm out active high

always @(posedge clk)
  if (clk_cnt == CLKDIV-1)
    begin
      clk_cnt    <= 0;
      strobe_1us <= 1'b1;
    end
  else
    begin
      clk_cnt    <= clk_cnt + 1'b1;
      strobe_1us <= 0;
    end

always @(posedge clk)
  if (strobe_1us) 
    begin
      pwm_d <= {pwm_d[3:0],pwm_i};
      
      case (state)
        IDLE : 
          if (pwm_d[4:2] == 0) // pwm_i active low
            begin
              state   <= RUN;
              pwm_cnt <= 0;
              pwm_out <= 0; // pwm out active high
            end
        RUN : 
          begin
            pwm_cnt <= pwm_cnt + 1'b1;
            pwm_out <= 1'b1; // pwm out active high
            
            if (pwm_cnt >= PWM_LENGTH - 1) 
              state <= STOP;
          end
            
        STOP : 
          begin
            pwm_cnt <= pwm_cnt + 1'b1;
            pwm_out <= 0; // pwm out active high
            
            if (pwm_cnt >= PWM_LENGTH + PWM_REARM - 1) 
              state <= IDLE;
          end
          
        default : state <= IDLE;
      
      endcase;
      
    end

assign pwm_o = pwm_out;    
  


endmodule
