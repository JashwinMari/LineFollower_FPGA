`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.03.2023 13:25:34
// Design Name: 
// Module Name: controller
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
module controller(
input clk, input CONT_SWITCH,
input IR_L, input IR_R,
input [3:0] speed,
output reg L_M, output reg IN1, output reg IN2,
output reg R_M, output reg IN3, output reg IN4
);
reg [19:0] DutyCounter = 20'd0;
parameter divideClk = 20'd100000;

always@(IR_L or IR_R or CONT_SWITCH)
begin
    if(CONT_SWITCH == 1)
        begin
        case({IR_L, IR_R})
            2'b00: begin IN1 = 0; IN2 = 0; IN3 = 0; IN4 = 0; end
            2'b01: begin IN1 = 0; IN2 = 1; IN3 = 1; IN4 = 0; end
            2'b10: begin IN1 = 1; IN2 = 0; IN3 = 0; IN4 = 1; end
            2'b11: begin IN1 = 1; IN2 = 0; IN3 = 1; IN4 = 0; end
        endcase
        end
    else
        {IN1, IN2, IN3, IN4} = 0;
end

always@(posedge clk)
begin
    if (DutyCounter < divideClk) DutyCounter <= DutyCounter + 20'd1;
    else DutyCounter <= 20'd0;
    L_M = (DutyCounter < (divideClk*speed/10)) ? 1'b1:1'b0;
    R_M = L_M;
end
//generatePWM CONTROL_L(clk, speed, L_M);
//generatePWM CONTROL_R(clk, speed, R_M);
endmodule
