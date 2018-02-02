`ifndef BUFFER
`define BUFFER
`define CLOG2(x) \
   (x <= 2) ? 1 : \
   (x <= 4) ? 2 : \
   (x <= 8) ? 3 : \
   (x <= 16) ? 4 : \
   (x <= 32) ? 5 : \
   (x <= 64) ? 6 : \
   -1

/* # CmdBuffer

  A module to buffer commands for the lcd, this allows the ALU
  write commands as fast as it can and the lcd fsm read the commands
  slowly. Implemented as a circular buffer.

 This module can be used as a regular circular buffer.

  ## Inputs
  - clk: clock signal
  - reset: reset signal
  - data_in: the LCD command to buffer, has the following form
             {lcd_rs, lcd_rw, sf (all 8 bits)}
  - req_read: a read request signal, puts the next data in data_out
  - req_write: a write request, puts data_in into the  buffer

  ## Outputs
  - data_out: The read data
  - full: if high buffer is full and there should not be any wirtes incoming
  - not_empty: if high the buffer has useful data in it

  ## Parameters
  - DATA_WIDTH: The number of bits used for the command data
  - BUFF_SIZE: The total number of DATA_WIDTH spaces on the buffer
 */

module CmdBuffer #(
                    parameter DATA_WIDTH = 10,
                    parameter BUFF_SIZE = 64
                    )(
                      input wire                  clk,
                      input wire                  reset,
                      input wire [DATA_WIDTH-1:0] data_in,
                      input wire                  req_read,
                      input wire                  req_write,
                      output wire [DATA_WIDTH-1:0] data_out,
                      output reg                  not_empty,
                      output reg                  full		   
                      );

   // INTERNAL VARIABLES
   reg [DATA_WIDTH-1:0]                buffer [BUFF_SIZE-1:0];
   // head is the position where the next data is gonna be stored
   // tail is the positions where data is being read
   reg [`CLOG2(BUFF_SIZE)-1:0]                                head, tail, next_head, next_tail;

   assign data_out = buffer[tail];

  
   
   always @(posedge clk)
     begin
        if(reset)
          begin
             head <= 0;
             tail <= 0;
             full <= 0;
             not_empty <= 0;
	     next_head <=0;
	     next_tail <=0;
	     
             //data_out <= 0;
          end
        else
          begin
             //data_out <= buffer[tail];
             full <= 0;
             not_empty <= 1;
	     head <= next_head;
	     tail <= next_tail;
	     

             // Buffer stop signal conditions
             if(head == tail)
               begin
                  not_empty <= 0;
               end
             if(head == tail-1)
               begin
                  full <= 1;
               end
             // data r/w conditions
             if(req_write)
               begin
                  buffer[head] <= data_in;
                  next_head <= head+1;
               end
             if(req_read)
               begin
                  next_tail <= tail+1;
               end
          end // else: !if(reset)
     end // always @ (posedge clk)
        endmodule // cmd_buffer
`endif //  `ifndef BUFFER
