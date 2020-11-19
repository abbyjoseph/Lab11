`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2020 11:46:18 AM
// Design Name: 
// Module Name: guess_FSM
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module guess_FSM(
    input [3:0] b,
    input rst,
    input clk,
    output reg win,
    output reg lose,
    output reg [3:0] y);
    
//state definitions
    localparam[2:0]
        s0 = 3'b000,
        s1 = 3'b001,
        s2 = 3'b010,
        s3 = 3'b011,
        swin = 3'b100,
        slose = 3'b101;
 
 reg [2:0] state, next_state;       

        
// register 
   always_ff begin @(posedge clk, posedge rst)
      if (rst)
         state = s0;
      else 
        state = next_state;
    end
 
 //next-state and output logic   
 always_comb begin
 //default
    next_state = s0;
    y=4'b0000;
    win=1'b0;
    lose=1'b0;
    
    case(state)
    
        s0: begin
        y[0]=1'b1;
        
            if(~b[3] & ~b[2] & ~b[1] & b[0])
            next_state = swin;
            
            else if(b[3] | b[2] | b[1])
            next_state = slose;
            
            else if(~b[3] & ~b[2] & ~b[1] & ~b[0])
            next_state = s1;
            
            end
            
        s1: begin
        y[1]=1'b1;
        
            if(~b[3] & ~b[2] & b[1] & ~b[0])
            next_state = swin;
            
            else if(b[3] | b[2] | b[0])
            next_state = slose;
            
            else if(~b[3] & ~b[2] & ~b[1] & ~b[0])
            next_state = s2;
            
            end 
            
        s2: begin
        y[2]=1'b1;
        
            if(~b[3] & b[2] & ~b[1] & ~b[0])
            next_state = swin;
            
            else if(b[3] | b[1] | b[0])
            next_state = slose;
            
            else if(~b[3] & ~b[2] & ~b[1] & ~b[0])
            next_state = s3;
            
            end 
            
        s3: begin
        y[3]=1'b1;
        
            if(b[3] & ~b[2] & ~b[1] & ~b[0])
            next_state = swin;
            
            else if(b[2] | b[1] | b[0])
            next_state = slose;
            
            else if(~b[3] & ~b[2] & ~b[1] & ~b[0])
            next_state = s0;
            
            end
            
        swin: begin
        win=1;
         
            if(b[1] | b[2] | b[1] | b[0])
            next_state = swin;
            
            else if(~b[3] & ~b[2] & ~b[1] & ~b[0])
            next_state = s0;
            
            end 
            
        slose: begin 
        lose=1;
        
            if(b[1] | b[2] | b[1] | b[0])
            next_state = slose;
            
            else if(~b[3] & ~b[2] & ~b[1] & ~b[0])
            next_state = s0;
            
            end                       
    
       
    endcase 
    end  
    
    
    
endmodule
