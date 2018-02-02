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

`ifndef CORE
`define CORE

module Core( //FIXME: check outputs
	    input wire 	     Clock,
	    input wire 	     Reset,
	    output wire [7:0] Led
	    );
   wire                       cpu_read_en, cpu_write_en;
   wire [31:0] 		      cpu_address;
   wire [31:0] 		      cpu_read_data, cpu_write_data;
   
   CPU CPU(
	   .clk(Clock),
	   .reset(Reset),
	   .data(Led),
           .ram_enable_read(cpu_read_en),
           .ram_enable_write(cpu_write_en),
           .ram_data_write(cpu_write_data),
           .ram_data_read(cpu_read_data),
           .ram_address(cpu_address)
	   );
   
   
   Ram Ram(
	   .clk(Clock),
	   .write_en(cpu_write_en),
	   .read_en(cpu_read_en),
	   .address(cpu_address),
	   .data_in(cpu_write_data),
	   .data_out(cpu_read_data)
	   );   

endmodule // Core

`endif
