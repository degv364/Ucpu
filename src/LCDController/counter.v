`ifndef LCD_COUNTER
`define LCD_COUNTER
/*
 # Counter

 19-bit counter intended it can be used as a general counter.

 # Inputs

 - clk: Clock signal
 - reset: Reset signal, makes count = 0

 # Output
 - count: Corrent count, if max count is reach it will overflow and go around.
*/

module Counter(
               input wire clk,
               input wire reset,
               output reg [19:0] count
               );
   always @(posedge clk)
     begin
        if(reset)
          begin
             count <= 0;
          end
        else
          begin
             count <= count+1;
          end
     end
endmodule // counter
`endif //  `ifndef LCD_COUNTER
