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

`ifndef OUTPUT_MANAGER
 `define OUPUT_MANAGER

module Output(
	      input wire 	clk,
	      input wire 	reset,
	      input wire [5:0] 	operation,
	      input wire [31:0] in,
	      output reg [7:0] out
	      );
   
   always @(posedge clk) begin
      if (reset == 1)begin
	 out <= 8'b0;	 
      end
      else begin
	 if ((operation == `LED) || (operation == `LEDI))begin
	    out <= in[7:0];	    
	 end
	 else begin
	    out <= out;
	 end
      end
   end
endmodule // Output


`endif
