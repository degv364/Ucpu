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

`ifndef BUBBLER
 `define BUBBLER
//`include "definitions.v"
/**
 # Bubbler

 This module is in charge of making the pipeline bubble on Read after
 write, if a RAW is detected it will stall the instruction fetching
 until the hazard has passed.

**/
module Bubbler #(parameter R_ADDR_SIZE=5, parameter OP_SIZE=6, parameter INSTRUCTION_SIZE = 32, parameter INMEDIATE_SIZE = 16, parameter ZERO_PAD = 11)
   (
    input wire 			    Clock,
    input wire 			    Reset,
    input wire [31:0] 		    current_address,
    input wire 			    global_branch_taken,
    input wire [OP_SIZE-1:0] 	    operation,
    input wire [INMEDIATE_SIZE-1:0] inmediate,
    input wire [R_ADDR_SIZE-1:0]    destination,
    input wire [R_ADDR_SIZE-1:0]    read0,
    input wire [R_ADDR_SIZE-1:0]    read1,
    input wire [R_ADDR_SIZE-1:0]    read2,
    input wire 			    branch_taken,
    input wire 			    link,
    input wire 			    from_register,
    input wire 			    ram_enable_write,
    input wire 			    ram_enable_read,

    // THis are the ops and destination form every phase of the pipeline
    input wire [OP_SIZE-1:0] 	    past_operation0,
    input wire [OP_SIZE-1:0] 	    past_operation1,
    input wire [OP_SIZE-1:0] 	    past_operation2,
    input wire [R_ADDR_SIZE-1:0]    past_destination0,
    input wire [R_ADDR_SIZE-1:0]    past_destination1,
    input wire [R_ADDR_SIZE-1:0]    past_destination2,

    output reg 			    stall,
    output reg [31:0] 		    overwrite_address,
    output reg [OP_SIZE-1:0] 	    out_operation,
    output reg [INMEDIATE_SIZE-1:0] out_inmediate,
    output reg [R_ADDR_SIZE-1:0]    out_destination,
    output reg [R_ADDR_SIZE-1:0]    out_read0,
    output reg [R_ADDR_SIZE-1:0]    out_read1,
    output reg [R_ADDR_SIZE-1:0]    out_read2,
    output reg 			    out_branch_taken,
    output reg 			    out_link,
    output reg 			    out_from_register,
    output reg 			    out_ram_enable_write,
    output reg 			    out_ram_enable_read
                                    );

   // Condition for stall changes depending on the type of instruction
   wire 			    not_null_destination;   
   wire 			    condition_for_I; // inmediate
   wire 			    condition_for_R; // only registers
   wire 			    condition_for_branch; //conditional branch
   
   
   

    always @ (posedge Clock)
      begin
	 overwrite_address <= current_address;
	 
        // Resetting flushes the pipeline, everything is set to 0
    if(Reset)
      begin
	 overwrite_address <= 0;
         out_inmediate <= 0;
         out_destination <= 0;
         out_read0 <= 0;
         out_read1 <= 0;
         out_read2 <= 0;
         out_branch_taken <= 0;
         out_link <= 0;
         out_from_register <= 0;
         out_ram_enable_write <= 0;
         out_ram_enable_read <= 0;
      end
    else
      begin         
         if(stall)
           begin
	      overwrite_address <= overwrite_address;	      
              out_operation <= 0;
              out_inmediate <= 0;
              out_destination <= 0;
              out_read0 <= 0;
              out_read1 <= 0;
              out_read2 <= 0;
              out_branch_taken <= 0;
              out_link <= 0;
              out_from_register <= 0;
              out_ram_enable_write <= 0;
              out_ram_enable_read <= 0;
           end // if (stall)
	 else
	   begin
	      out_operation <= operation;
              out_inmediate <= inmediate;
              out_destination <= destination;
              out_read0 <= read0;
              out_read1 <= read1;
              out_read2 <= read2;
              out_branch_taken <= branch_taken;
              out_link <= link;
              out_from_register <= from_register;
              out_ram_enable_write <= ram_enable_write;
              out_ram_enable_read <= ram_enable_read;
	   end // else: !if(stall)	 
      end // else: !if(Reset)
    end // always @ (posedge Clock)

   assign condition_for_I = ((read1 == past_destination0 && past_destination0 !=0) || 
			     (read1 == past_destination1 && past_destination1 !=0) || 
			     (read1 == past_destination2 && past_destination2 !=0));
   
   assign condition_for_R = ((read1 == past_destination0 && past_destination0 !=0) || 
			     (read1 == past_destination1 && past_destination1 !=0) || 
			     (read1 == past_destination2 && past_destination2 !=0) ||
			     (read0 == past_destination0 && past_destination0 !=0) || 
			     (read0 == past_destination1 && past_destination1 !=0) || 
			     (read0 == past_destination2 && past_destination2 !=0));
   
   assign condition_for_branch = ((read1 == past_destination0 && past_destination0 !=0) || 
				  (read1 == past_destination1 && past_destination1 !=0) || 
				  (read1 == past_destination2 && past_destination2 !=0) ||
				  (read2 == past_destination0 && past_destination0 !=0) || 
				  (read2 == past_destination1 && past_destination1 !=0) || 
				  (read2 == past_destination2 && past_destination2 !=0));

   
   
   

   always @(*)
     begin
        stall = 0;
        case(operation)
          //----------------------------------------------------------------------------------------------
	  `NOP:
            begin
               stall = 0;
            end
	  //----------------------------------------------------------------------------------------------
	  `ADDI:
	    begin
	       if (condition_for_I)
		  stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `ADD:
	    begin
	       if (condition_for_R)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `SUB:
	    begin
	       if (condition_for_R)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `SUBI:
	    begin
	       if (condition_for_I)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `AND:
	    begin
	       if (condition_for_R)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `OR:
	    begin
	       if (condition_for_R)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `XOR:
	    begin
	       if (condition_for_R)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `NOR:
	    begin
	       if (condition_for_R)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `SLT:
	    begin
	       if (condition_for_R)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `SLTI:
	    begin
	       if (condition_for_I)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `ANDI:
	    begin
	       if (condition_for_I)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `ORI:
	    begin
	       if (condition_for_I)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `XORI:
	    begin
	       if (condition_for_I)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `SLL:
	    begin
	       if (condition_for_I)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `SRL:
	    begin
	       if (condition_for_I)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `MULT:
	    begin
	       if (condition_for_R)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `MFHI:
	    begin
	       stall = 0;
	    end
	  //----------------------------------------------------------------------------------------------
	  `MTHI:
	    begin
	       stall = 0;
	    end
	  //----------------------------------------------------------------------------------------------
	  `MFLO:
	    begin
	       stall = 0;
	    end
	  //----------------------------------------------------------------------------------------------
	  `MTLO:
	    begin
	       stall = 0;
	    end
	  //----------------------------------------------------------------------------------------------
	  `DIV:
	    begin
	       if (condition_for_R)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `J:
	    begin
	       stall = 0;
	    end
	  //----------------------------------------------------------------------------------------------
	  `JR:
	    begin
	       if (read0 == past_destination0 || read0 == past_destination1 || read0 == past_destination2)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `JALR:
	    begin
	       if (read0 == past_destination0 || read0 == past_destination1 || read0 == past_destination2)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `BLTZ:
	    begin
	       if (condition_for_branch)
		 stall =1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `JAL:
	    begin
	       stall = 0;
	    end
	  //----------------------------------------------------------------------------------------------
	  `BEQ:
	    begin
	       if(condition_for_branch)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `BNE:
	    begin
	       if(condition_for_branch)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `BGTZ:
	    begin
	       if(condition_for_branch)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `LW:
	    begin
	       if (condition_for_I)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
	  `SW:
	    begin
	       // Chek for WAW also
	       if (condition_for_branch)
		 stall = 1;
	    end
	  //----------------------------------------------------------------------------------------------
          `LEDI:
            begin
               stall = 0;
            end
	  //----------------------------------------------------------------------------------------------
          `LED:
            begin
               if(condition_for_I)
                 stall = 1;
            end
	  //----------------------------------------------------------------------------------------------
          default:
	    // All implemented instructions are covered. Unimplemented isntructions will stall
            begin
               stall = 1;               
            end
        endcase // case (operation)
     end // always @ (*)
endmodule // Bubbler

`endif //  `ifndef BUBBLER
