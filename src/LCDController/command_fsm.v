`ifndef COMMAND_FSM
 `define COMMAND_FSM
 `define HALT 0
 `define UPPER 1
 `define SMALL_WAIT 2
 `define LOWER 3
 `define BIG_WAIT 4
 `define CMD_DEFAULT 5
`define INITIAL_WAIT 6
`define GLORIOUS_WAIT 7
/*
 # CmdFSM

 Finite state machine that takes care of sending data/commands to the
 LCD screen. Data/Commands are 8 bit but there are only 4 cables to
 the LCD screen. This FSM checks if there are commands to send on the
 command buffer and first send the upper half, waits 1 us and then
 sends the lower half. Then, it waits for the previous command is done
 before sending the next one.

 *Important*: This module is not intended to be used on its own and
  it's internal to the LCD screen controller, please use that module
  instead.

 Since this module is not intended for the user, input and outputs
 remain undocumented, the interface may change between versions
 without notice to the user. Please use the LCDController module instead.
  */


module CmdFSM(
                   input wire 	     clk,
                   input wire 	     reset,
                   input wire 	     enable,
                   input wire [19:0] count,
                   input wire [9:0]  buffer, // {lcd_rs, lcd_rw, sf 8 bit}
                   input wire 	     next_command,
                   output reg 	     req_command,
                   output reg 	     count_reset,
                   output reg [3:0]  sf_d,
                   output reg 	     lcd_e,
                   output wire 	     lcd_rs,
		   output wire 	     lcd_rw,
                   output wire 	     sf_ce0
                   );

   assign sf_ce0 = 0;
   reg [2:0]                         state, next_state;

   assign lcd_rs = buffer[8];
   assign lcd_rw = buffer[9];
   

   always @(posedge clk)
     if(!enable)
       begin
          state <=`CMD_DEFAULT;
       end
     else
       begin
          begin
             if(reset)
               begin
                  state <= `HALT;
               end
             else
               begin
                  state <= next_state;
               end
          end // else: !if(!enable)
     end // always @ (posedge clk)

   always @(*)
     begin
        count_reset = 0;
        req_command = 0;
        lcd_e = 0;
        case(state)
          `HALT:
            begin
	       sf_d = buffer[7:4];
               if(next_command)
                 begin


                    count_reset = 1;
                    next_state = `INITIAL_WAIT;
                 end
               else
                 begin
                    next_state = `HALT;
                 end
            end // case: `HALT
	  `INITIAL_WAIT:
	    begin
	       sf_d = buffer[7:4];
	       if (count >4)
		 begin
		    next_state = `UPPER;
		    count_reset = 1;
		 end
	       else
		 begin
		    next_state = `INITIAL_WAIT;
		 end
	    end

	       
          `UPPER:
            begin
               lcd_e = 1;
               sf_d = buffer[7:4];
               if(count > 13) // 280 ns @ 50 MHz
                 begin
                    next_state = `SMALL_WAIT;
                    count_reset = 1;
                 end
               else
                 begin
                    next_state = `UPPER;
                 end
            end // case: `UPPER
          `SMALL_WAIT:
            begin
               if(count > 49) // 1 us @ 50 MHz
                 begin
		    sf_d = buffer[3:0];
                    count_reset = 1;
                    next_state = `LOWER;
                 end
               else
                 begin
		    if (count > 35)
		      begin
			 sf_d = buffer[3:0];	 
		      end
		    else
		      begin
			 sf_d = buffer[7:4];
		      end
                    next_state = `SMALL_WAIT;
                 end
            end // case: `SMALL_WAIT
          `LOWER:
            begin
	       sf_d = buffer[3:0];
               lcd_e = 1;
               if(count > 13) // 280 ns @ 50 MHz
                 begin
		    if(buffer != 10'b1)
		      begin
			 count_reset = 1;
			 req_command = 1;
			 next_state = `BIG_WAIT;
		      end
		    else
		      begin 
			 count_reset = 1;
			 req_command = 1;
			 next_state = `GLORIOUS_WAIT;
		      end
                 end
               else
                 begin
                    next_state = `LOWER;
                 end
            end // case: `LOWER
          `BIG_WAIT:
            begin
               if(count > 1999) // 40 us @ 50 MHz
                 begin
		    sf_d = buffer[7:4];
                    if(next_command)
                      begin
                         count_reset = 1;
                         next_state = `UPPER;
                      end
                    else
                      begin
                         next_state = `HALT;
                      end
                 end
               else
                 begin
		    if (count > 1980)
		      begin
			 sf_d = buffer[7:4];
		      end
		    else begin
		       sf_d = buffer[3:0];
		    end
                    next_state = `BIG_WAIT;
                 end
            end // case: `BIG_WAIT
	  `GLORIOUS_WAIT:
            begin
               if(count > 820000) // 1.64 ms @ 50 MHz
                 begin
		    sf_d = buffer[7:4];
                    if(next_command)
                      begin
                         count_reset = 1;
                         next_state = `UPPER;
                      end
                    else
                      begin
                         next_state = `HALT;
                      end
                 end
               else
                 begin
		    if (count > 819200)
		      begin
			 sf_d = buffer[7:4];
		      end
		    else begin
		       sf_d = buffer[3:0];
		    end
		    
                    next_state = `GLORIOUS_WAIT;
                 end
            end // case: `GLORIOUS_WAIT
          `CMD_DEFAULT:
            begin
               next_state = `HALT;
	       sf_d = 0;
            end
          default:
            begin
               next_state = `CMD_DEFAULT;
	       sf_d = 0;
            end
        endcase // case (state)
     end // always @ (*)
endmodule // command_fsm
`endif //  `ifndef COMMAND_FSM
