`ifndef RAM
`define RAM

`timescale 1ns / 1ps

module Ram # ( parameter DATA_WIDTH= 32, parameter ADDR_WIDTH=32, parameter MEM_SIZE=80 )
   (
    input wire 			 clk,
    input wire 			 write_en,
    input wire 			 read_en,
    input wire [ADDR_WIDTH-1:0]  address,
    input wire [DATA_WIDTH-1:0]  data_in,
    output wire [DATA_WIDTH-1:0] data_out,
    //0
    output wire [DATA_WIDTH-1:0] visR1,
    output wire [DATA_WIDTH-1:0] visR2,
    output wire [DATA_WIDTH-1:0] visR3,
    output wire [DATA_WIDTH-1:0] visR4,
    output wire [DATA_WIDTH-1:0] visR5,
    output wire [DATA_WIDTH-1:0] visR6,
    output wire [DATA_WIDTH-1:0] visR7,
    output wire [DATA_WIDTH-1:0] visR8,
    output wire [DATA_WIDTH-1:0] visR9,
    //10
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
    //20
    output wire [DATA_WIDTH-1:0] visR20,
    output wire [DATA_WIDTH-1:0] visR21,
    output wire [DATA_WIDTH-1:0] visR22,
    output wire [DATA_WIDTH-1:0] visR23,
    output wire [DATA_WIDTH-1:0] visR24,
    output wire [DATA_WIDTH-1:0] visR25,
    output wire [DATA_WIDTH-1:0] visR26,
    output wire [DATA_WIDTH-1:0] visR27,
    output wire [DATA_WIDTH-1:0] visR28,
    output wire [DATA_WIDTH-1:0] visR29,
    //30
    output wire [DATA_WIDTH-1:0] visR30,
    output wire [DATA_WIDTH-1:0] visR31,
    output wire [DATA_WIDTH-1:0] visR32,
    output wire [DATA_WIDTH-1:0] visR33,
    output wire [DATA_WIDTH-1:0] visR34,
    output wire [DATA_WIDTH-1:0] visR35,
    output wire [DATA_WIDTH-1:0] visR36,
    output wire [DATA_WIDTH-1:0] visR37,
    output wire [DATA_WIDTH-1:0] visR38,
    output wire [DATA_WIDTH-1:0] visR39,
    //40
    output wire [DATA_WIDTH-1:0] visR40,
    output wire [DATA_WIDTH-1:0] visR41,
    output wire [DATA_WIDTH-1:0] visR42,
    output wire [DATA_WIDTH-1:0] visR43,
    output wire [DATA_WIDTH-1:0] visR44,
    output wire [DATA_WIDTH-1:0] visR45,
    output wire [DATA_WIDTH-1:0] visR46,
    output wire [DATA_WIDTH-1:0] visR47,
    output wire [DATA_WIDTH-1:0] visR48,
    output wire [DATA_WIDTH-1:0] visR49,
    //50
    output wire [DATA_WIDTH-1:0] visR50,
    output wire [DATA_WIDTH-1:0] visR51,
    output wire [DATA_WIDTH-1:0] visR52,
    output wire [DATA_WIDTH-1:0] visR53,
    output wire [DATA_WIDTH-1:0] visR54,
    output wire [DATA_WIDTH-1:0] visR55,
    output wire [DATA_WIDTH-1:0] visR56,
    output wire [DATA_WIDTH-1:0] visR57,
    output wire [DATA_WIDTH-1:0] visR58,
    output wire [DATA_WIDTH-1:0] visR59,
    //60
    output wire [DATA_WIDTH-1:0] visR60/*,
    output wire [DATA_WIDTH-1:0] visR61,
    output wire [DATA_WIDTH-1:0] visR62,
    output wire [DATA_WIDTH-1:0] visR63,
    output wire [DATA_WIDTH-1:0] visR64,
    output wire [DATA_WIDTH-1:0] visR65,
    output wire [DATA_WIDTH-1:0] visR66,
    output wire [DATA_WIDTH-1:0] visR67,
    output wire [DATA_WIDTH-1:0] visR68,
    output wire [DATA_WIDTH-1:0] visR69,
    //70
    output wire [DATA_WIDTH-1:0] visR70,
    output wire [DATA_WIDTH-1:0] visR71,
    output wire [DATA_WIDTH-1:0] visR72,
    output wire [DATA_WIDTH-1:0] visR73,
    output wire [DATA_WIDTH-1:0] visR74,
    output wire [DATA_WIDTH-1:0] visR75,
    output wire [DATA_WIDTH-1:0] visR76,
    output wire [DATA_WIDTH-1:0] visR77,
    output wire [DATA_WIDTH-1:0] visR78,
    output wire [DATA_WIDTH-1:0] visR79,
    //80
    output wire [DATA_WIDTH-1:0] visR80,
    output wire [DATA_WIDTH-1:0] visR81,
    output wire [DATA_WIDTH-1:0] visR82,
    output wire [DATA_WIDTH-1:0] visR83,
    output wire [DATA_WIDTH-1:0] visR84,
    output wire [DATA_WIDTH-1:0] visR85,
    output wire [DATA_WIDTH-1:0] visR86,
    output wire [DATA_WIDTH-1:0] visR87,
    output wire [DATA_WIDTH-1:0] visR88,
    output wire [DATA_WIDTH-1:0] visR89,
    //90
    output wire [DATA_WIDTH-1:0] visR90,
    output wire [DATA_WIDTH-1:0] visR91,
    output wire [DATA_WIDTH-1:0] visR92,
    output wire [DATA_WIDTH-1:0] visR93,
    output wire [DATA_WIDTH-1:0] visR94,
    output wire [DATA_WIDTH-1:0] visR95,
    output wire [DATA_WIDTH-1:0] visR96,
    output wire [DATA_WIDTH-1:0] visR97,
    output wire [DATA_WIDTH-1:0] visR98,
    output wire [DATA_WIDTH-1:0] visR99,
    //100
    output wire [DATA_WIDTH-1:0] visR100,
    output wire [DATA_WIDTH-1:0] visR101,
    output wire [DATA_WIDTH-1:0] visR102,
    output wire [DATA_WIDTH-1:0] visR103,
    output wire [DATA_WIDTH-1:0] visR104,
    output wire [DATA_WIDTH-1:0] visR105,
    output wire [DATA_WIDTH-1:0] visR106,
    output wire [DATA_WIDTH-1:0] visR107,
    output wire [DATA_WIDTH-1:0] visR108,
    output wire [DATA_WIDTH-1:0] visR109,
    //110
    output wire [DATA_WIDTH-1:0] visR110,
    output wire [DATA_WIDTH-1:0] visR111,
    output wire [DATA_WIDTH-1:0] visR112,
    output wire [DATA_WIDTH-1:0] visR113,
    output wire [DATA_WIDTH-1:0] visR114,
    output wire [DATA_WIDTH-1:0] visR115,
    output wire [DATA_WIDTH-1:0] visR116,
    output wire [DATA_WIDTH-1:0] visR117,
    output wire [DATA_WIDTH-1:0] visR118,
    output wire [DATA_WIDTH-1:0] visR119,
    //120
    output wire [DATA_WIDTH-1:0] visR120,
    output wire [DATA_WIDTH-1:0] visR121,
    output wire [DATA_WIDTH-1:0] visR122,
    output wire [DATA_WIDTH-1:0] visR123,
    output wire [DATA_WIDTH-1:0] visR124,
    output wire [DATA_WIDTH-1:0] visR125,
    output wire [DATA_WIDTH-1:0] visR126,
    output wire [DATA_WIDTH-1:0] visR127,
    output wire [DATA_WIDTH-1:0] visR128*/
    );

   reg [DATA_WIDTH-1:0]          ram [MEM_SIZE:0];
   //0
   assign visR1 = ram[1];
   assign visR1 = ram[1];
   assign visR2 = ram[2];
   assign visR3 = ram[3];
   assign visR4 = ram[4];
   assign visR5 = ram[5];
   assign visR6 = ram[6];
   assign visR7 = ram[7];
   assign visR8 = ram[8];
   assign visR9 = ram[9];
   //10
   assign visR10 = ram[10];
   assign visR11 = ram[11];
   assign visR12 = ram[12];
   assign visR13 = ram[13];
   assign visR14 = ram[14];
   assign visR15 = ram[15];
   assign visR16 = ram[16];
   assign visR17 = ram[17];
   assign visR18 = ram[18];
   assign visR19 = ram[19];
   //20
   assign visR20 = ram[20];
   assign visR21 = ram[21];
   assign visR22 = ram[22];
   assign visR23 = ram[23];
   assign visR24 = ram[24];
   assign visR25 = ram[25];
   assign visR26 = ram[26];
   assign visR27 = ram[27];
   assign visR28 = ram[28];
   assign visR29 = ram[29];
   //30
   assign visR30 = ram[30];
   assign visR31 = ram[31];
   assign visR32 = ram[32];
   assign visR33 = ram[33];
   assign visR34 = ram[34];
   assign visR35 = ram[35];
   assign visR36 = ram[36];
   assign visR37 = ram[37];
   assign visR38 = ram[38];
   assign visR39 = ram[39];
   //40
   assign visR40 = ram[40];
   assign visR41 = ram[41];
   assign visR42 = ram[42];
   assign visR43 = ram[43];
   assign visR44 = ram[44];
   assign visR45 = ram[45];
   assign visR46 = ram[46];
   assign visR47 = ram[47];
   assign visR48 = ram[48];
   assign visR49 = ram[49];
   //50
   assign visR50 = ram[50];
   assign visR51 = ram[51];
   assign visR52 = ram[52];
   assign visR53 = ram[53];
   assign visR54 = ram[54];
   assign visR55 = ram[55];
   assign visR56 = ram[56];
   assign visR57 = ram[57];
   assign visR58 = ram[58];
   assign visR59 = ram[59];
   //60
   assign visR60 = ram[60];/*
   assign visR61 = ram[61];
   assign visR62 = ram[62];
   assign visR63 = ram[63];
   assign visR64 = ram[64];
   assign visR65 = ram[65];
   assign visR66 = ram[66];
   assign visR67 = ram[67];
   assign visR68 = ram[68];
   assign visR69 = ram[69];
   //70
   assign visR70 = ram[70];
   assign visR71 = ram[71];
   assign visR72 = ram[72];
   assign visR73 = ram[73];
   assign visR74 = ram[74];
   assign visR75 = ram[75];
   assign visR76 = ram[76];
   assign visR77 = ram[77];
   assign visR78 = ram[78];
   assign visR79 = ram[79];
   //80
   assign visR80 = ram[80];
   assign visR81 = ram[81];
   assign visR82 = ram[82];
   assign visR83 = ram[83];
   assign visR84 = ram[84];
   assign visR85 = ram[85];
   assign visR86 = ram[86];
   assign visR87 = ram[87];
   assign visR88 = ram[88];
   assign visR89 = ram[89];
   //90
   assign visR90 = ram[90];
   assign visR91 = ram[91];
   assign visR92 = ram[92];
   assign visR93 = ram[93];
   assign visR94 = ram[94];
   assign visR95 = ram[95];
   assign visR96 = ram[96];
   assign visR97 = ram[97];
   assign visR98 = ram[98];
   assign visR99 = ram[99];
   //100
   assign visR100 = ram[100];
   assign visR101 = ram[101];
   assign visR102 = ram[102];
   assign visR103 = ram[103];
   assign visR104 = ram[104];
   assign visR105 = ram[105];
   assign visR106 = ram[106];
   assign visR107 = ram[107];
   assign visR108 = ram[108];
   assign visR109 = ram[109];
   //110
   assign visR110 = ram[110];
   assign visR111 = ram[111];
   assign visR112 = ram[112];
   assign visR113 = ram[113];
   assign visR114 = ram[114];
   assign visR115 = ram[115];
   assign visR116 = ram[116];
   assign visR117 = ram[117];
   assign visR118 = ram[118];
   assign visR119 = ram[119];
   //120
   assign visR120 = ram[120];
   assign visR121 = ram[121];
   assign visR122 = ram[122];
   assign visR123 = ram[123];
   assign visR124 = ram[124];
   assign visR125 = ram[125];
   assign visR126 = ram[126];
   assign visR127 = ram[127];
   assign visR128 = ram[128];*/


   reg 				 delayed_read_en, output_en;
   

   reg [DATA_WIDTH-1:0]          temp_read_data;
   assign data_out= (output_en)? temp_read_data: 32'b0;


   always @(posedge clk)
     begin
	delayed_read_en <= read_en;
	output_en <= delayed_read_en;	
        if (write_en) begin
           ram[address[ADDR_WIDTH-1:2]] <= data_in;
        end

        temp_read_data <= ram[address[ADDR_WIDTH-1:2]];
     end
endmodule // Ram


`endif
