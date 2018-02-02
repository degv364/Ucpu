`timescale 1ns / 1ps

module test_leds;
   
   // Inputs
   reg clk;
   reg reset;
   wire [7:0] led;
   
   
   
   Core uut(
	    .Clock(clk),
	    .Reset(reset),
	    .Led(led)
	    );
   
   always
     begin
	#1  clk =  ! clk;	
     end
   
   initial begin
      $dumpfile("test_leds.vcd");
      $dumpvars(0, test_leds);
      
      // Initialize Inputs
      clk = 0;
      reset = 0;
      
      // Wait 100 ns for global reset to finish
      #2;
      reset = 1;
      #50;      
      reset = 0;
      # 5000000 reset = 1;
      $finish;
      
      
   end // initial begin
   
endmodule

