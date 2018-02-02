`ifndef INIT_FSM
 `define INIT_FSM
 `define RESET 0
 `define INIT_WAIT 1
 `define PHASE1_A 2
 `define PHASE1_B 3
 `define PHASE2_A 4
 `define PHASE2_B 5
 `define PHASE3_A 6
 `define PHASE3_B 7
 `define PHASE4_A 8
 `define PHASE4_B 9
 `define INIT_HALT 10
 `define INIT_DEFAULT 11

/*
 # InitFSM

 This module takes care of the LCD screen power init sequence, in
 accordance to the Spartan-3E manual.

 *Important*: This module is not intended to be used on its own and
  it's internal to the LCD screen controller, please use that module
  instead.

 Since this module is not intended for the user, input and outputs
 remain undocumented, the interface may change between versions
 without notice to the user. Please use the LCDController module instead.
*/

module InitFSM(
                input wire clk,
                input wire reset,
                input wire [19:0] count,
                output reg finished,
                output reg count_reset,
                output reg [3:0] sf_d,
                output reg lcd_e
                );

   reg [3:0]               state, next_state;

   always @(posedge clk)
     begin
        if(reset)
          begin
             state <= `RESET;
          end
        else
          begin
             state <= next_state;
          end
     end // always posedge

   always @(*)
     begin
        lcd_e = 0;
        count_reset = 0;
        finished = 0;
        case(state)
          `RESET:
            begin
               count_reset = 1;
	       sf_d = 0;
               next_state = `INIT_WAIT;
            end
          `INIT_WAIT:
            begin
               if(count > 750000)
                 begin
                    next_state = `PHASE1_A;
                    count_reset = 1;
		    sf_d = 4'h3;		    
                 end
               else
                 begin
		    sf_d = 4'h3;
                    next_state = `INIT_WAIT;
                 end
            end
          `PHASE1_A:
            begin

               lcd_e = 1;
               if(count > 12)
                 begin
		    sf_d = 4'h3;
                    next_state = `PHASE1_B;
                    count_reset = 1;
                 end
               else
                 begin
		    sf_d = 4'h3;
                    next_state = `PHASE1_A;
                 end
               end
          `PHASE1_B:
            begin
               if(count > 205000)
                 begin
		    sf_d = 4'h3;
                    next_state = `PHASE2_A;
                    count_reset = 1;
                 end
               else
                 begin
		    sf_d = 4'h3;
                    next_state = `PHASE1_B;
                 end
            end
          `PHASE2_A:
            begin
               lcd_e = 1;
               if(count > 12)
                 begin
		    sf_d = 4'h3;
                    next_state = `PHASE2_B;
                    count_reset = 1;
                 end
               else
                 begin
		    sf_d = 4'h3;
                    next_state = `PHASE2_A;
                 end
               end
          `PHASE2_B:
            begin
               if(count > 5000)
                 begin
		    sf_d = 4'h3;
                    next_state = `PHASE3_A;
                    count_reset = 1;
                 end
               else
                 begin
		    sf_d = 4'h3;	    
                    next_state = `PHASE2_B;
                 end
            end
          `PHASE3_A:
            begin
               lcd_e = 1;
               if(count > 12)
                 begin
                    next_state = `PHASE3_B;
                    count_reset = 1;
		    sf_d = 4'h3;
                 end
               else
                 begin
		    sf_d = 4'h3;
                    next_state = `PHASE3_A;
                 end
               end
          `PHASE3_B:
            begin
               if(count > 2000)
                 begin
                    next_state = `PHASE4_A;
                    count_reset = 1;
		    sf_d = 4'h2;
                 end
               else
                 begin
                    next_state = `PHASE3_B;
		    if (count > 1920)
		      begin
			 sf_d = 4'h2;
		      end
		    else begin
		       sf_d = 4'h3;
		    end
                 end	      
            end
          `PHASE4_A:
            begin
               lcd_e = 1;
               if(count > 12)
                 begin
                    next_state = `PHASE4_B;
                    count_reset = 1;
		    sf_d = 4'h2;
                 end
               else
                 begin
		    sf_d = 4'h2;
                    next_state = `PHASE4_A;
                 end
               end
          `PHASE4_B:
            begin
               if(count > 2000)
                 begin
		    sf_d = 4'h2;
                    next_state = `INIT_HALT;
                    count_reset = 1;
                 end
               else
                 begin
		    sf_d = 4'h2;
                    next_state = `PHASE4_B;
                 end
            end // case: `PHASE4_B
          `INIT_HALT:
            begin
               next_state = `INIT_HALT;
               finished = 1;
	       sf_d = 0;
            end
          `INIT_DEFAULT:
            begin
	       sf_d = 0;
	       
               next_state = `INIT_DEFAULT;
            end
          default:
            begin
	       sf_d = 0;
	       
               next_state = `INIT_DEFAULT;
            end
          endcase
        end // always @ (*)
endmodule // InitFSM
`endif // INIT_FSM
