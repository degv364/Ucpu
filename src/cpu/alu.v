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

`ifndef ALU_
`define ALU_
`timescale 1ns / 1ps
//`include "Defintions.v"

/*
 # ALU

 Este modulo es el ALU, se encarga de las operaciones aritmeticas del CPU.
 */
module Alu # (parameter SIZE=32, parameter OP_SIZE=6, parameter INM_SIZE=16)
   (
    input wire [OP_SIZE-1:0]  operation,
    input wire [SIZE-1:0]     operand0,
    input wire [SIZE-1:0]     operand1,
    input wire [SIZE-1:0]     operand2,
    input wire [INM_SIZE-1:0] inmediate,
    output reg [SIZE-1:0]     result,
    output reg 		      write_enable,
    output reg 		      branch_taken
    );

   reg [2*SIZE-1:0] 	      mult_result;

   always @ ( * )
     begin
	result = 0;
	branch_taken = 0;
	mult_result = mult_result;
	write_enable = 0;

	case (operation)
	  //-------------------------------------
	  `ADDI:
	    begin
	       result = operand1+inmediate;
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `ADD:
	    begin
	       result = operand1 + operand0;
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `SUBI:
	    begin
	       result = operand1-inmediate;
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `SUB:
	    begin
	       result = operand1 - operand0;
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `AND:
	    begin
	       result = operand1 & operand0;
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `OR:
	    begin
	       result = operand1 | operand0;
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `XOR:
	    begin
	       result = operand1 ^ operand0;
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `NOR:
	    begin
	       result = ~(operand1|operand0);
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `SLT:
	    begin
	       if (operand1 < operand0) begin
		  result = 1;
	       end else begin
		  result = 0;
	       end
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `SLTI:
	    begin
	       if (operand1 < inmediate) begin
		  result = 1;
	       end else begin
		  result = 0;
	       end
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `ANDI:
	    begin
	       result = operand1 & inmediate;
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `ORI:
	    begin
	       result = operand1 | inmediate;
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `XORI:
	    begin
	       result = operand1 ^ inmediate;
	       write_enable = 1;
	    end
	  // Shifts---------------------------------------------
	  `SLL:
	    begin
	       result = operand1 << inmediate[15:10];
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `SRL:
	    begin
	       result = operand1 >> inmediate[15:10];
	       write_enable = 1;
	    end
	  // Multiplication -----------------------------------
	  `MULT:
	    begin
	       mult_result = operand1*operand0;
	    end
	  //-------------------------------------
	  `MFHI:
	    begin
	       result = mult_result[63:32];
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `MTHI:
	    begin
	       mult_result[63:32] = inmediate;
	    end
	  //-------------------------------------
	  `MFLO:
	    begin
	       result = mult_result[31:0];
	       write_enable = 1;
	    end
	  //-------------------------------------
	  `MTLO:
	    begin
	       mult_result[31:0] = inmediate;
	    end
	  //-------------------------------------
	  `DIV:
	    begin
	       //FIXME: ISE unable to synthesize mod and div
	       mult_result[63:32] = 0;//operand1 % operand0;
	       mult_result[31:0]  = 0;//operand1 / operand0;
	    end
	  // branches-----------------------------
	  `BLTZ:
	    begin
	       if (operand1 < 0)begin
		  branch_taken = 1;
	       end else begin
		  branch_taken = 0;
	       end
	    end
	  //-------------------------------------
	  `BGEZ:
	    begin
	       if (operand1 >= 0) begin
		  branch_taken = 1;
	       end else begin
		  branch_taken = 0;
	       end
	    end
	  //-------------------------------------
	  `BLTZAL:
	    begin
	       if (operand1 < 0) begin
		  branch_taken = 1;
	       end else begin
		  branch_taken = 0;
	       end
	    end
	  //-------------------------------------
	  `BGEZAL:
	    begin
	       if (operand1 >= 0) begin
		  branch_taken = 1;
	       end else begin
		  branch_taken = 0;
	       end
	    end
	  //-------------------------------------
	  `BEQ:
	    begin
	       if (operand1 == operand2) begin
		  branch_taken = 1;
	       end else begin
		  branch_taken = 0;
	       end
	    end
	  //-------------------------------------
	  `BNE:
	    begin
	       if (operand1 != operand2) begin
		  branch_taken = 1;
	       end else begin
		  branch_taken = 0;
	       end
	    end
	  //-------------------------------------
	  `BLEZ:
	    begin
	       if (operand1 <= 0) begin
		  branch_taken = 1;
	       end else begin
		  branch_taken = 0;
	       end
	    end
	  //-------------------------------------
	  `BGTZ:
	    begin
	       if (operand1 > 0) begin
		  branch_taken = 1;
	       end else begin
		  branch_taken = 0;
	       end
	    end
	  //------------------------------------
	  `LED:
	    begin
	       result = operand1;	       
	    end
	  `LEDI:
	    begin
	       result = inmediate;	       
	    end	  
	  //-------------------------------------
	  
	  default:
	    begin
	       result = 0;
	       branch_taken = 0;
	       mult_result = mult_result;
	       write_enable = 0;
	    end
	  //-------------------------------------
	endcase
     end
endmodule

`endif
