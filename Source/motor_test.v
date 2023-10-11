`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.02.2023 10:01:18
// Design Name: 
// Module Name: motor
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


module motor(input clk, input m1EN, input [3:0] speed, input forward, output reg m1PWM, output reg m1IN1, output reg m1IN2, output reg statusLED);
reg [19:0] DutyCounter = 20'd0;
parameter divideClk = 20'd100000;
always@(posedge clk)
begin
    if (DutyCounter < divideClk) DutyCounter <= DutyCounter + 20'd1;
    else DutyCounter <= 20'd0;
    if(m1EN)
    begin
        statusLED = 1;
        if(forward)
        begin
            m1IN1 = 1;
            m1IN2 = 0;            
        end
        else
        begin
            m1IN1 = 0;
            m1IN2 = 1;
        end
    end
    else
    begin
        statusLED = 0;
        m1IN1 = 0;
        m1IN2 = 0;
    end
    m1PWM = (DutyCounter < (divideClk*speed*m1EN/10)) ? 1'b1:1'b0;
end
endmodule
