`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 13:26:10
// Design Name: 
// Module Name: generatePWM
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


module generatePWM(input clk, input [3:0] speed, output reg PWM);
//speed 1 - 10
reg [19:0] DutyCounter = 20'd0;
parameter divideClk = 20'd100000;
always@(posedge clk)
begin
    if (DutyCounter < divideClk) DutyCounter <= DutyCounter + 20'd1;
    else DutyCounter <= 20'd0;
    PWM = (DutyCounter < (divideClk*speed/10)) ? 1'b1:1'b0;
end
endmodule
