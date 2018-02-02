/* Copyright (c) 2017
   Authors: Daniel Garcia Vaglio, Javier Peralta Saenz

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program. If not, see <http://www.gnu.org/licenses/>
*/

`ifndef DECOD
`define DECOD
//`include "Defintions.v"
/*
 # Decoder

 Este modulo decodifica instrucciones en sus señales básicas (source,
 dest, ect) y además levanta señales de control de saltos.


*/
module Decoder #(parameter R_ADDR_SIZE=5, parameter OP_SIZE=6, parameter INSTRUCTION_SIZE = 32, parameter INMEDIATE_SIZE = 16, parameter ZERO_PAD = 11)
   (
    input wire [INSTRUCTION_SIZE-1:0] instruction,
    output wire [OP_SIZE-1:0] 	      operation,
    output wire [INMEDIATE_SIZE-1:0]  inmediate,
    output wire [R_ADDR_SIZE-1:0]     destination,
    output wire [R_ADDR_SIZE-1:0]     read0,
    output wire [R_ADDR_SIZE-1:0]     read1,
    output wire [R_ADDR_SIZE-1:0]     read2,
    output reg 			      branch_taken,
    output reg 			      link,
    output reg 			      from_register,
    output reg 			      ram_enable_write,
    output reg 			      ram_enable_read
    );

   assign operation = instruction[INSTRUCTION_SIZE-1:INSTRUCTION_SIZE-OP_SIZE];
   assign read0 = instruction[ZERO_PAD+R_ADDR_SIZE-1:ZERO_PAD];
   assign read1 = instruction[ZERO_PAD+2*R_ADDR_SIZE-1:ZERO_PAD+R_ADDR_SIZE];
   assign read2 = instruction[ZERO_PAD+3*R_ADDR_SIZE-1:ZERO_PAD+2*R_ADDR_SIZE];
   assign destination = read2;
   assign inmediate = instruction[INMEDIATE_SIZE-1:0];

   always @ ( * )
     begin
	branch_taken = 0;
	link = 0;
	from_register = 0;
        ram_enable_write = 0;
	ram_enable_read = 0;


	case (operation)
	  `J:
	    begin
	       branch_taken = 1;
	    end
	  `JR:
	    begin
	       branch_taken = 1;
	       from_register = 1;
	    end
	  `JAL:
	    begin
	       branch_taken = 1;
	       link = 1;
	    end
	  `JALR:
	    begin
	       branch_taken = 1;
	       link = 1;
	       from_register = 1;
	    end
	  `SW:
	    begin
	       ram_enable_write = 1;
	    end
	  `LW:
	    begin
	       ram_enable_read = 1;
	    end


	  default:
	    begin
	       branch_taken = 0;
	       link=0;
	       from_register = 0;
	       ram_enable_write = 0;
	       ram_enable_read = 0;
	    end
	  //-------------------------------------
	endcase
     end
endmodule // Decoder
`endif
