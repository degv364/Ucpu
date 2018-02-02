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

`ifndef CPU
`define CPU

/*
 * FIXME: Find a better place to put this
 * first add a w or r if this is a wire or reg.
 * then name the signal
 * then name the stage in the pipeline:
 * fd : fetch and decode
 * rf : reg_file
 * ex : execute
 * me : memory
 * wb : write_back
 * gl : global
 */

`define WORD_SIZE      32
`define OP_CODE_SIZE   6
`define INMEDIATE_SIZE 16
`define REGISTER_SIZE  5
// Return Address
`define RA 31
// Stack Pointer
`define STACK_POINTER 29

module CPU(
	   input wire 	      clk,
	   input wire 	      reset,
	   output wire [7:0]  data,
	   // FIXME: re-enable this once we support LCD
	   //output wire 	      LCD_RS,
	   //output wire 	      LCD_RW,
	   //output wire 	      write_output,
	   //RAM interface
	   output wire 	      ram_enable_read,
	   output wire 	      ram_enable_write,
	   output wire [31:0] ram_data_write,
	   input wire [31:0]  ram_data_read,
	   output wire [31:0] ram_address
	    );

   //FIXME use parametric sizes
   // global wires
   wire                  	      branch_taken_gl;
   wire [`WORD_SIZE-1:0] 	      inmediate_addr_gl;
   wire 			      return_branch_gl;
   wire [`WORD_SIZE-1:0] 	      return_addr_gl;
   wire [`WORD_SIZE-1:0] 	      hard_ip_gl;
   wire [`WORD_SIZE-1:0] 	      bub_hard_ip_gl;
   wire [`WORD_SIZE-1:0] 	      next_ip_gl;
   wire [`WORD_SIZE-1:0] 	      current_ip_gl;
   wire [`WORD_SIZE-1:0] 	      bub_current_ip_gl;
   wire 			      write_enable_gl;
   wire [`REGISTER_SIZE-1:0] 	      destination_gl;
   wire [`WORD_SIZE-1:0] 	      register_data_in_gl;
   wire 			      stall_gl;
   
   
   

   // fetch and decode
   wire [`WORD_SIZE-1:0] 	      instruction_fd;
   wire 			      branch_taken_fd;
   wire 			      from_register_fd;
   wire 			      sto_ip_fd;
   wire [`OP_CODE_SIZE-1:0] 	      operation_fd;
   wire [`INMEDIATE_SIZE-1:0] 	      inmediate_fd;
   wire [`REGISTER_SIZE-1:0] 	      destination_fd;
   wire [`REGISTER_SIZE-1:0] 	      read0_fd;
   wire [`REGISTER_SIZE-1:0] 	      read1_fd;
   wire [`REGISTER_SIZE-1:0] 	      read2_fd;
   wire 			      ram_enable_write_fd;
   wire 			      ram_enable_read_fd;

   wire 			      bub_branch_taken_fd;
   wire 			      bub_from_register_fd;
   wire 			      bub_sto_ip_fd;
   wire [`OP_CODE_SIZE-1:0] 	      bub_operation_fd;
   wire [`INMEDIATE_SIZE-1:0] 	      bub_inmediate_fd;
   wire [`REGISTER_SIZE-1:0] 	      bub_destination_fd;
   wire [`REGISTER_SIZE-1:0] 	      bub_read0_fd;
   wire [`REGISTER_SIZE-1:0] 	      bub_read1_fd;
   wire [`REGISTER_SIZE-1:0] 	      bub_read2_fd;
   wire 			      bub_ram_enable_write_fd;
   wire 			      bub_ram_enable_read_fd;

   

   // register file
   wire 			      branch_taken_rf;
   wire 			      from_register_rf;
   wire 			      sto_ip_rf;
   wire [`REGISTER_SIZE-1:0] 	      read0_rf;
   wire [`REGISTER_SIZE-1:0] 	      read1_rf;
   wire [`REGISTER_SIZE-1:0] 	      read2_rf;
   wire [`WORD_SIZE-1:0] 	      operand0_rf;
   wire [`WORD_SIZE-1:0] 	      operand1_rf;
   wire [`WORD_SIZE-1:0] 	      operand2_rf;
   wire [`OP_CODE_SIZE-1:0] 	      operation_rf;
   wire [`REGISTER_SIZE-1:0] 	      destination_rf;
   wire [`INMEDIATE_SIZE-1:0] 	      inmediate_rf;
   wire 			      ram_enable_write_rf;
   wire 			      ram_enable_read_rf;

   // execute
   wire [`OP_CODE_SIZE-1:0] 	      operation_ex;
   wire [`WORD_SIZE-1:0] 	      operand0_ex;
   wire [`WORD_SIZE-1:0] 	      operand1_ex;
   wire [`WORD_SIZE-1:0] 	      operand2_ex;
   wire [`WORD_SIZE-1:0] 	      result_ex;
   wire 			      write_enable_ex;
   wire 			      branch_taken_ex;
   wire [`REGISTER_SIZE-1:0] 	      destination_ex;
   wire [`INMEDIATE_SIZE-1:0] 	      inmediate_ex;
   wire 			      ram_enable_write_ex;
   wire 			      ram_enable_read_ex;
   wire 			      from_register_ex;
			      

   // Memory
   wire [`OP_CODE_SIZE-1:0] 	      operation_me;
   wire [`WORD_SIZE-1:0] 	      ram_data_write_me;
   wire [`WORD_SIZE-1:0] 	      ram_data_read_me;
   wire [`REGISTER_SIZE-1:0] 	      destination_me;
   wire [`WORD_SIZE-1:0] 	      result_me;
   wire [`WORD_SIZE-1:0] 	      operand0_me;
   wire [`WORD_SIZE-1:0] 	      operand1_me;
   wire [`WORD_SIZE-1:0] 	      operand2_me;
   wire [`INMEDIATE_SIZE-1:0] 	      inmediate_me;
   wire 			      write_enable_me;
   wire 			      branch_taken_me;
   wire 			      ram_enable_write_me;
   wire 			      ram_enable_read_me;

   // write back
   wire [`REGISTER_SIZE-1:0] 	      destination_wb;
   wire [`WORD_SIZE-1:0] 	      result_wb;
   wire [`WORD_SIZE-1:0] 	      operand2_wb;
   wire [`INMEDIATE_SIZE-1:0] 	      inmediate_wb;
   wire 			      write_enable_wb;
   wire 			      branch_taken_wb;
   wire [`WORD_SIZE-1:0] 	      mem_wb;
   wire [`WORD_SIZE-1:0] 	      data_wb;
   wire 			      ram_enable_read_wb;
   


   // If we need JR, from register will be enabled
   assign branch_taken_gl = ((branch_taken_rf || branch_taken_wb) && 
			     !(from_register_rf)) || from_register_ex;
   
   // This is for inconditional branching
   assign inmediate_addr_gl = (from_register_ex)? operand0_rf : inmediate_rf;
   // Destination for conditional branches are in operan2
   assign hard_ip_gl = (branch_taken_wb)? inmediate_wb : inmediate_addr_gl;
   //assign hard_ip_gl = (branch_taken_me)? inmediate_me : inmediate_addr_gl;
   assign bub_hard_ip_gl = (stall_gl && !branch_taken_gl)? bub_current_ip_gl : hard_ip_gl;
   

   // To make linking possible
   assign write_enable_gl = sto_ip_rf | write_enable_wb | ram_enable_read_wb;
   assign destination_gl = (sto_ip_rf)? `RA : destination_wb;
   assign data_wb = (ram_enable_read_wb)? ram_data_read: result_wb;   
   assign register_data_in_gl = (sto_ip_rf)? return_addr_gl: data_wb;
   


   UPCOUNTER_POSEDGE #(32) IP
     (
      .Clock(clk),
      .Reset(reset | branch_taken_gl | stall_gl),
      .Initial(bub_hard_ip_gl),
      .Enable(1'b1 && !stall_gl || branch_taken_gl),
      .Q(next_ip_gl)
      //.prev_Q(next_ip_gl)
      );

   FFD_POSEDGE_SYNCHRONOUS_RESET #(32) FF_ip
     (
      .Clock(clk),
      .Reset(reset),
      .Enable(1'b1),
      .D(next_ip_gl),
      .Q(current_ip_gl)
      );


   FFD_POSEDGE_SYNCHRONOUS_RESET #(32) FF_return
     (
      .Clock(clk),
      .Reset(reset),
      .Enable(sto_ip_fd),
      .D(bub_current_ip_gl+1),
      .Q(return_addr_gl)
      );


   // Pipeline Fetch
   ROM InstructionRom
     (
      .iAddress (bub_current_ip_gl),
      .oInstruction(instruction_fd)
      );

   // Pipeline Decode and Register File
   Decoder Ins_decod
     (
      .instruction(instruction_fd),
      .branch_taken(branch_taken_fd),
      .link(sto_ip_fd),
      .from_register(from_register_fd),
      .operation(operation_fd),
      .inmediate(inmediate_fd),
      .destination(destination_fd),
      .read0(read0_fd),
      .read1(read1_fd),
      .read2(read2_fd),
      .ram_enable_write(ram_enable_write_fd),
      .ram_enable_read(ram_enable_read_fd)
      );

      Bubbler Bubbler
     (
      .Clock(clk),
      .Reset(reset | branch_taken_gl ),
      .current_address(next_ip_gl),
      .global_branch_taken(branch_taken_gl),
      .operation(operation_fd),
      .inmediate(inmediate_fd),
      .destination(destination_fd),
      .link(sto_ip_fd),
      .read0(read0_fd),
      .read1(read1_fd),
      .read2(read2_fd),
      .branch_taken(branch_taken_fd),
      .from_register(from_register_fd),
      .ram_enable_write(ram_enable_write_fd),
      .ram_enable_read(ram_enable_read_fd),

      .past_operation0(operation_rf),
      .past_operation1(operation_ex),
      .past_operation2(operation_me),

      .past_destination0(destination_rf),
      .past_destination1(destination_ex),
      .past_destination2(destination_me),

      .stall(stall_gl),
      .overwrite_address(bub_current_ip_gl),
/*
      .out_operation(bub_operation_fd),
      .out_inmediate(bub_inmediate_fd),
      .out_destination(bub_destination_fd),
      .out_read0(bub_read0_fd),
      .out_read1(bub_read1_fd),
      .out_read2(bub_read1_fd),
      .out_branch_taken(bub_branch_taken_fd),
      .out_link(bub_sto_ip_fd),
      .out_from_register(bub_from_register_fd),
      .out_ram_enable_write(bub_ram_enable_write_fd),
      .out_ram_enable_read(bub_ram_enable_read_fd)
 */
      .out_operation(operation_rf),
      .out_inmediate(inmediate_rf),
      .out_destination(destination_rf),
      .out_read0(read0_rf),
      .out_read1(read1_rf),
      .out_read2(read2_rf),
      .out_branch_taken(branch_taken_rf),
      .out_link(sto_ip_rf),
      .out_from_register(from_register_rf),
      .out_ram_enable_write(ram_enable_write_rf),
      .out_ram_enable_read(ram_enable_read_rf)
      );

   
/*
   //FIXME: Use parametric size
   FFD_POSEDGE_SYNCHRONOUS_RESET #(6+5+5+5+5+16+1+1+1+1+1) FF_fd
     (
      .Clock(clk),
      .Reset(reset | branch_taken_gl),
      .Enable(1'b1),
      .D({bub_operation_fd, bub_destination_fd, bub_read2_fd, bub_read1_fd, bub_read0_fd, bub_inmediate_fd, bub_branch_taken_fd, bub_from_register_fd, bub_sto_ip_fd, bub_ram_enable_write_fd, bub_ram_enable_read_fd}),
      .Q({operation_rf, destination_rf, read2_rf, read1_rf, read0_rf, inmediate_rf, branch_taken_rf, from_register_rf, sto_ip_rf, ram_enable_write_rf, ram_enable_read_rf})
      );
 */

   // We must have the destination delayed from the fd stage to wb stage
   // Incase we actually need a write back
   // Also delay inmediate

   Register_file Register_file
     (
      .Clock(clk),
      .iWriteEnable(write_enable_gl),
      .iReadAddress0(read0_rf),
      .iReadAddress1(read1_rf),
      .iReadAddress2(read2_rf),
      .iWriteAddress(destination_gl),
      .iDataIn(register_data_in_gl),
      .oDataOut0(operand0_rf),
      .oDataOut1(operand1_rf),
      .oDataOut2(operand2_rf)
      );
   

   //FIXME: uSE PARAMETRIC SIZE
   FFD_POSEDGE_SYNCHRONOUS_RESET #(6+5+32+32+32+16+1+1+1) FF_rf
     (
      .Clock(clk),
      .Reset(reset | branch_taken_gl),
      .Enable(1'b1),
      .D({operation_rf, destination_rf, operand2_rf, operand1_rf, operand0_rf, inmediate_rf, ram_enable_write_rf, ram_enable_read_rf, from_register_rf}),
      .Q({operation_ex, destination_ex, operand2_ex, operand1_ex, operand0_ex, inmediate_ex, ram_enable_write_ex, ram_enable_read_ex, from_register_ex})
      );


   // Pipeline ALU

   Alu Alu
     (
      .operation(operation_ex),
      .operand0(operand0_rf), //RF has 1 cycle delay
      .operand1(operand1_rf), //RF has 1 cycle delay
      .operand2(operand2_rf), //RF has 1 cycle delay
      .inmediate(inmediate_ex),
      .result(result_ex),
      .write_enable(write_enable_ex),
      .branch_taken(branch_taken_ex)
      );

   Output Output
		(
		 .clk(clk),
		 .reset(reset),
		 .operation(operation_ex),
		 .out(data),
		 .in(result_ex)
		 );
   



   FFD_POSEDGE_SYNCHRONOUS_RESET #(6+5+32+32+32+32+16+1+1+1+1) FF_ex
     (
      .Clock(clk),
      // This reset is never flushed. Previous instruction shoul finish execution
      .Reset(reset),
      .Enable(1'b1),
      .D({operation_ex, destination_ex, result_ex, operand2_ex, operand1_ex, operand0_ex, inmediate_ex, write_enable_ex, branch_taken_ex, ram_enable_write_ex, ram_enable_read_ex}),
      .Q({operation_me, destination_me, result_me, operand2_me, operand1_me, operand0_me, inmediate_me, write_enable_me, branch_taken_me, ram_enable_write_me, ram_enable_read_me})
      );

   // Pipeline MEM

   assign ram_enable_write = ram_enable_write_me;
   assign ram_data_write   = operand2_ex; // operand2_me
   assign ram_address      = operand1_ex+inmediate_me; // operand1_me+inmediate_me
   assign ram_enable_read  = ram_enable_read_ex;
   //assign mem_wb = ram_data_read;
   


   FFD_POSEDGE_SYNCHRONOUS_RESET #(5+32+32+16+1+1+1+32) FF_me
     (
      .Clock(clk),
      // This reset is never flushed. Previous instruction shoul finish execution
      .Reset(reset),
      .Enable(1'b1),
      // Write enabel wb should be activated when we read the ram
      .D({destination_me, operand2_me, result_me, inmediate_me, write_enable_me, ram_enable_read_me, branch_taken_me, ram_data_read}),
      .Q({destination_wb, operand2_wb, result_wb, inmediate_wb, write_enable_wb, ram_enable_read_wb, branch_taken_wb, mem_wb})
      );


endmodule // CPU

`endif
