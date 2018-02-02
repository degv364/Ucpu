`ifndef REG_FILE
`define REG_FILE

`timescale 1ns / 1ps

module Register_file # ( parameter DATA_WIDTH= 32, parameter ADDR_WIDTH=5, parameter MEM_SIZE=32 )
   (
    input wire                   Clock,
    input wire                   iWriteEnable,
    input wire [ADDR_WIDTH-1:0]  iReadAddress0,
    input wire [ADDR_WIDTH-1:0]  iReadAddress1,
    input wire [ADDR_WIDTH-1:0]  iReadAddress2,
    input wire [ADDR_WIDTH-1:0]  iWriteAddress,
    input wire [DATA_WIDTH-1:0]  iDataIn,
    output reg [DATA_WIDTH-1:0]  oDataOut0,
    output reg [DATA_WIDTH-1:0]  oDataOut1,
    output reg [DATA_WIDTH-1:0]  oDataOut2,
    output wire [DATA_WIDTH-1:0] visR1,
    output wire [DATA_WIDTH-1:0] visR2,
    output wire [DATA_WIDTH-1:0] visR3,
    output wire [DATA_WIDTH-1:0] visR4,
    output wire [DATA_WIDTH-1:0] visR5,
    output wire [DATA_WIDTH-1:0] visR6,
    output wire [DATA_WIDTH-1:0] visR7,
    output wire [DATA_WIDTH-1:0] visR8,
    output wire [DATA_WIDTH-1:0] visR9,
    output wire [DATA_WIDTH-1:0] visR10,
    output wire [DATA_WIDTH-1:0] visR11,
    output wire [DATA_WIDTH-1:0] visR12,
    output wire [DATA_WIDTH-1:0] visR13,
    output wire [DATA_WIDTH-1:0] visR14,
    output wire [DATA_WIDTH-1:0] visR15,
    output wire [DATA_WIDTH-1:0] visR16,
    output wire [DATA_WIDTH-1:0] visR17,
    output wire [DATA_WIDTH-1:0] visR18,
    output wire [DATA_WIDTH-1:0] visR19,
    output wire [DATA_WIDTH-1:0] visFP,
    output wire [DATA_WIDTH-1:0] visRA,
    output wire [DATA_WIDTH-1:0] visSP
    );

   reg [DATA_WIDTH-1:0] 	Ram [MEM_SIZE:0];

   assign visR1 = Ram[1];
   assign visR1 = Ram[1];
   assign visR2 = Ram[2];
   assign visR3 = Ram[3];
   assign visR4 = Ram[4];
   assign visR5 = Ram[5];
   assign visR6 = Ram[6];
   assign visR7 = Ram[7];
   assign visR8 = Ram[8];
   assign visR9 = Ram[9];
   assign visR10 = Ram[10];
   assign visR11 = Ram[11];
   assign visR12 = Ram[12];
   assign visR13 = Ram[13];
   assign visR14 = Ram[14];
   assign visR15 = Ram[15];
   assign visR16 = Ram[16];
   assign visR17 = Ram[17];
   assign visR18 = Ram[18];
   assign visR19 = Ram[19];

   assign visFP = Ram[30];
   assign visRA = Ram[31];
   assign visSP = Ram[29];


   always @(posedge Clock)
     begin
	Ram[0] <= 0;

	if (iWriteEnable && iWriteAddress!=0)
	  Ram[iWriteAddress] <= iDataIn;

	oDataOut0 <= Ram[iReadAddress0];
	oDataOut1 <= Ram[iReadAddress1];
	oDataOut2 <= Ram[iReadAddress2];

     end
endmodule // Register_file

`endif
