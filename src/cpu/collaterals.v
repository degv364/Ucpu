`ifndef COLLATERALS
 `define COLLATERALS


`timescale 1ns / 1ps
//------------------------------------------------
module UPCOUNTER_POSEDGE # (parameter SIZE=8) 
   (
    input wire 		  Clock, Reset,
    input wire [SIZE-1:0] Initial,
    input wire 		  Enable,
    output reg [SIZE-1:0] Q,
    output reg [SIZE-1:0] prev_Q
    );

   reg [SIZE-1:0] 	  next_Q;
   
   
   always @(*)
     begin
	next_Q = Q+1;	
	if (Reset==1) begin
	   next_Q=Initial;
	end
	if (Enable==0) begin
	   next_Q = Q;
	end
     end
   always @(posedge Clock)
     begin
	Q <= next_Q;
     end


	  
   // make reset and enable asynchronic
   /*always @(posedge Clock)
     begin
	if (Reset==1)begin
           Q <= Initial;
	   prev_Q<= Initial-1;
	end
	else begin
	     if (Enable==1) begin
		Q <= Q + 1;
		prev_Q <= Q;
	     end		
	     else begin
		Q<=prev_Q;
		prev_Q <= prev_Q;		
	     end
	end // else: !if(Reset==1)	
     end*/
   
endmodule // UPCOUNTER_POSEDGE

//----------------------------------------------------
module FFD_POSEDGE_SYNCHRONOUS_RESET # ( parameter SIZE=8 )
   (
    input wire 		  Clock,
    input wire 		  Reset,
    input wire 		  Enable,
    input wire [SIZE-1:0] D,
    output reg [SIZE-1:0] Q
    );
   
   
   always @ (posedge Clock) 
     begin
	if ( Reset )
	  Q <= 0;
	else
	  begin	
	     if (Enable) 
	       Q <= D; 
	  end	
	
  end//always
   
endmodule // FFD_POSEDGE_SYNCRONOUS_RESET
/*
module MUX4 #(parameter DATA_SIZE = 16)
   (
    input wire [1:0] 	       control,
    input wire [DATA_SIZE-1:0] input_data_a,
    input wire [DATA_SIZE-1:0] input_data_b,
    input wire [DATA_SIZE-1:0] input_data_c,
    input wire [DATA_SIZE-1:0] input_data_d,
    output reg [DATA_SIZE-1:0] selected_data
    );

    always @ (*)
      begin
	 case (control)
	    2'b00: selected_data = input_data_a;
	    2'b01: selected_data = input_data_b;
	    2'b10: selected_data = input_data_c;
	    2'b11: selected_data = input_data_d;
	 endcase
      end

endmodule // MUX4
*/
//----------------------------------------------------------------------


`endif
