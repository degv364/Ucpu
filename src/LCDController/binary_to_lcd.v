`ifndef BINARY_TO_LCD
 `define BINARY_TO_LCD

 `define DATA_SIZE = 32

module Binary2char(input wire [3:0] number,
		   output reg [7:0] char);
   always @(*)
     begin
	case (number)
	  0: char = 8'h30;
	  1: char = 8'h31;
	  2: char = 8'h32;
	  3: char = 8'h33;
	  4: char = 8'h34;
	  5: char = 8'h35;
	  6: char = 8'h36;
	  7: char = 8'h37;
	  8: char = 8'h38;
	  9: char = 8'h39;	  
	  10: char = 8'h41;
	  11: char = 8'h42;
	  12: char = 8'h43;
	  13: char = 8'h44;
	  14: char = 8'h45;
	  15: char = 8'h46;
	  default:
	    char = 8'hFF;
	endcase
     end
endmodule // Binary2char


`endif
