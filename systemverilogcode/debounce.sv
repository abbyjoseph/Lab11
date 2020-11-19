`timescale 1ns / 1ps
// ELC 2137, John Miller, 2019-11-08 

module debounce #(parameter N=21)
   (input clk, reset,
    input  in,
    output reg out,
    output reg tick);
    
   // define states as local parameters (constants)
   localparam [1:0]
      zero   = 2'b00,
      wait1  = 2'b01,
      one    = 2'b11,
      wait0  = 2'b10;
      
   // internal signals
   reg [1:0] state, state_next;
   reg [N-1:0] counter, counter_next;
   
   // state memory (register)
   always_ff @(posedge clk or posedge reset)
      if (reset) begin
         state   <= zero;
         counter <= {N{1'b1}};
      end
      else begin
         state   <= state_next;
         counter <= counter_next;
      end
      
   // combined next-state and output logic
   always_comb begin
      // default behavior
      state_next   = state;
      counter_next = counter;
      tick = 0;
      
      case(state)
         zero: begin
            out = 0;
            counter_next = {N{1'b1}};
            if (in)
               state_next = wait1;
         end
         
         wait1: begin
            out = 0;     // Moore output
            counter_next = counter - 1;
            if (counter == 0) begin
               tick = 1'b1; // Mealy output
               state_next = one;
            end
            else if (~in)
               state_next = zero;
         end
         
         one: begin
            out = 1;
            counter_next = {N{1'b1}};
            if (~in)
               state_next   = wait0;
         end
         
         wait0: begin
            out = 1;
            counter_next = counter - 1;
            if (counter == 0)
               state_next = zero;
            else if (in)
               state_next = one;
         end
      endcase
   end
   
endmodule // debounce
