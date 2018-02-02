`ifndef LCD_CONTROLLER
 `define LCD_CONTROLLER
 `include "init_fsm.v"
 `include "buffer.v"
 `include "counter.v"
 `include "command_fsm.v"
/*
 # LCDController

 Module to control the LCD on the Spartan-3E it exposes a unifed
 interface to sending commands and data to the LCD
 screen. Commands/Data are buffered and executed in order once the
 power initialization is done. This allows the user of this module to
 insert data as fast as it can without waiting for the LCD to finish
 it's operations. For more information consult the Spartan-3E user
 guide, LCD screen section.

 This module is design to work @ 50 MHz please confiure your
 Spartan-3E to work accordingly.

 *Important*: The controller only takes care of power up init, display
  configuration is left to the user.

 ## Usage

 The interface is simple, put the commands on buffer data and raise
 req_buff_write. Data is written to the command buffer and executed in
 FIFO order as quick as the LCD allows. User should check if the
 buffer is full before attempting to write new commands to the buffer.

 ## Inputs

 - clk: Clock signal
 - reset: Reset signal
 - buffer_data: Data to be written to the buffer.
                     See also Usage, req_buffer_write, full
 - req_buffer_write: Set to high and buffer_data is written to the
                     buffer on the next posedge of clk

## Outputs

 - full: Signal that the command buffer is full no new commands should
         be written to buffer if this is high.
 - sf_d[3:0]: Data for the LCD, must be wired to sf_d pins
 - lcd_e: LCD screen enable must be wired to that pin
 - lcd_rs: LCD RS flag, must be wired to that pin
 - lcd_rw: LCD R/W flag, must be wired to that pin
 - sf_ce0: Disables RAM that is wired to the same pins that the LCD uses,
           must be wired to the pin of the same name
*/
module LCDController(
                     input wire clk,
                     input wire reset,
                     input wire [9:0] buffer_data,
                     input wire req_buff_write,
                     output wire full,
                     output wire [3:0] sf_d,
                     output wire lcd_e,
                     output wire lcd_rs,
                     output wire lcd_rw,
                     output wire sf_ce0
);

   wire [19:0] count;
   wire  [9:0] command;
   wire  [3:0] init_sf_d, cmd_sf_d;
   wire        init_count_reset, cmd_count_reset, count_reset;
   wire        not_empty, req_command;
   wire        init_lcd_e, cmd_lcd_e;
   wire        init_finished;

   assign count_reset = init_count_reset || cmd_count_reset;
   assign sf_d = init_sf_d | cmd_sf_d;
   assign lcd_e = init_lcd_e || cmd_lcd_e;

   Counter Counter(
                   .clk(clk),
                   .reset(count_reset || reset),
                   .count(count)
                   );

   CmdBuffer CmdBuffer(
                    .clk(clk),
                    .reset(reset),
                    .data_in(buffer_data),
                    .req_read(req_command),
                    .req_write(req_buff_write),
                    .data_out(command),
                    .not_empty(not_empty),
                    .full(full)
                    );
   InitFSM InitFSM(
                   .clk(clk),
                   .reset(reset),
                   .count(count),
                   .count_reset(init_count_reset),
                   .finished(init_finished),
                   .sf_d(init_sf_d),
                   .lcd_e(init_lcd_e)
                   );
   CmdFSM CmdFSM(
                 .clk(clk),
                 .reset(reset),
                 .enable(init_finished),
                 .count(count),
                 .count_reset(cmd_count_reset),
                 .buffer(command),
                 .next_command(not_empty),
                 .req_command(req_command),
                 .sf_d(cmd_sf_d),
                 .lcd_e(cmd_lcd_e),
                 .lcd_rs(lcd_rs),
                 .lcd_rw(lcd_rw),
                 .sf_ce0(sf_ce0)
                 );
endmodule // LCDController
`endif //  `ifndef LCD_CONTROLLER
