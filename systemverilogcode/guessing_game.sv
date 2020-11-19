`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2020 12:46:42 PM
// Design Name: 
// Module Name: guessing_game
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


module guessing_game(
    input btnU,
    input btnD,
    input btnR,
    input btnL,
    input btnC,
    input [15:0] sw,
    input clk,
    output [6:0] seg,
    output [3:0] an,
    output [15:0] led
    );
    
    wire btnU_i, btnD_i, btnL_i, btnR_i, b_i, win, lose;
    wire [3:0] y;
    
   debounce #(.N(21)) debounce_btnU (
   .clk(clk),
   .reset(btnC),
   .in(btnU),
   .out(btnU_i),
   .tick() ); //need to set
   
   debounce #(.N(21)) debounce_btnD (
   .clk(clk),
   .reset(btnC),
   .in(btnD),
   .out(btnD_i),
   .tick() ); //need to set
   
   debounce #(.N(21)) debounce_btnL (
   .clk(clk),
   .reset(btnC),
   .in(btnL),
   .out(btnL_i),
   .tick() ); //need to set
    
   debounce #(.N(21)) debounce_btnR (
   .clk(clk),
   .reset(btnC),
   .in(btnR),
   .out(btnR_i),
   .tick() );  //need to set
   
  assign b_i={btnL_i, btnD_i, btnR_i, btnU_i};
   
   guess_FSM my_guess_FSM(
    .b(b_i),
    .rst(btnC),
    .clk(clk),
    .win(win),
    .lose(lose),
    .y(y));
 
 
 //set top half of sseg display as the states for guess_FSM
 assign seg[5]=y[3];
 assign seg[6]=y[2];
 assign seg[1]=y[1];
 assign seg[0]=y[0];
 
 //set win/lose LEDs
 assign led[15] = win;
 assign led[7] = lose;
   
endmodule
