`timescale 1ns / 1ps
`ifndef DEFINTIONS_V
`define DEFINTIONS_V
	
`default_nettype none

//NOP
`define NOP    6'd0

// Arithmetic, simple
`define ADDI   6'd2
`define ADD    6'd3
`define SUB    6'd4
`define SUBI   6'd5
`define AND    6'd6
`define OR     6'd7
`define XOR    6'd8
`define NOR    6'd9
`define SLT    6'd10
`define SLTI   6'd11
`define ANDI   6'd12
`define ORI    6'd13
`define XORI   6'd14

//Shifts
`define SLL    6'd15
`define SRL    6'd16

// Multiplication and division
`define MULT   6'd17
`define MFHI   6'd18
`define MTHI   6'd19
`define MFLO   6'd20
`define MTLO   6'd21
`define DIV    6'd22

// Branches
`define J      6'd23
`define JR     6'd24
`define JALR   6'd25
`define BLTZ   6'd26
`define BGEZ   6'd27 // Not implemented yet
`define BLTZAL 6'd28 // Not implemented yet
`define BGEZAL 6'd29 // Not implemented yet
`define JAL    6'd30
`define BEQ    6'd31
`define BNE    6'd32
`define BLEZ   6'd33 // Not implemented yet
`define BGTZ   6'd34

//Memory
`define LW     6'd35
`define SW     6'd36


//LAB 5
`define LED    6'd37
`define LEDI   6'd38

//Registers addresses
`define R0  5'd0
`define R1  5'd1
`define R2  5'd2
`define R3  5'd3
`define R4  5'd4
`define R5  5'd5
`define R6  5'd6
`define R7  5'd7
`define R8  5'd8
`define R9  5'd9
`define R10 5'd10
`define R11 5'd11
`define R12 5'd12
`define R13 5'd13
`define R14 5'd14
`define R15 5'd15
`define R16 5'd16
`define R17 5'd17
`define R18 5'd18
`define R19 5'd19
`define R20 5'd20
`define R21 5'd21
`define R22 5'd22
`define R23 5'd23
`define R24 5'd24
`define R25 5'd25
`define R26 5'd26
`define R27 5'd27
`define R28 5'd28
`define R29 5'd29
`define R30 5'd30
`define R31 5'd31

`define SP 5'd31

`endif
