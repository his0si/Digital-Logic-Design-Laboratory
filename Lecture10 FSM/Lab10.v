`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/05/22 11:51:52
// Design Name: 
// Module Name: Lab10
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
//���� �� veilog �ڵ�� ��ȣ���� �����ϰ� �;�. �� �ڵ带 ������
//out1, out2 �� ���� 2���� ��ȣ���̰� out[1]�� ������, out[2]�� �����, out3�� �ʷϺ��̾�
//���� ��ư�� ������ zero�� ���ư�
//zero ������ ���� out1 out2�� �ʷϺ� �������̾�
//1�ʰ� �帣�� oneOne ���� out1 out2�� ����� �������̾�
//1�ʰ� �帣�� twoOne ���� out1 out2�� ������ �ʷϺ��̾�
//1�ʰ� �帣�� threeOne ���� out1 out2�� ������ ������̰� 
//1�ʰ� �帣�� zero�� ���ư�

/*
module Lab10(clk,reset,in,out1,out2);
input clk;
input reset;
input in;
output reg [0:2] out1;
output reg [0:2] out2;

parameter zero=2'b00;
parameter oneOne=2'b01;
parameter twoOne=2'b10;
parameter threeOne=2'b11;

reg [1:0] curState;
reg [1:0] nextState;

always @(posedge clk or negedge reset) begin
    if(reset==0) curState=zero;
    else curState=nextState;
end

always @(in or curState) begin
    case(curState)
    zero:
        begin
            if(in)  nextState=oneOne;
            else    nextState=zero;
        end
    oneOne:
        begin
            if(in)  nextState=oneOne;
            else    nextState=zero;
        end
    twoOne:
        begin
            if(in)  nextState=twoOne;
            else    nextState=zero;
        end
     threeOne:
        begin
            if(in)  nextState=twoOne;
            else    nextState=zero;
        end
     endcase
end

always @(curState) begin
    if(curState==twoOne) out=1;
    else    out=0;
end

if(rst==0) begin
    count=0;  // ���� �� ��� �������͸� 0���� �ʱ�ȭ
    outputLed=0;
    end
    
    else if(count<10000000) begin
    count=count+1;
    end
    
    else begin
    count=0;
    outputLed=outputLed+1;
    endcase
    
endmodule
*/


module Lab10(clk, reset, out1, out2);
    input clk;
    input reset;
    output reg [2:0] out1; // out1: {r, y, g}
    output reg [2:0] out2; // out2: {r, y, g}

    parameter zero = 2'b00;
    parameter oneOne = 2'b01;
    parameter twoOne = 2'b10;
    parameter threeOne = 2'b11;

    reg [1:0] curState;
    reg [1:0] nextState;
    integer count;

    always @(posedge clk or negedge reset) begin
        if (!reset) begin
            curState = zero;
            count=0;
        end else if (count<100000000) begin
             count = count + 1;
        end else begin
            count = 0;
            curState = nextState;
        end
    end

    always @(*) begin
        case (curState)
            zero: begin
                out1 = 3'b001; // g
                out2 = 3'b100; // r
                nextState = oneOne;
            end
            oneOne: begin
                out1 = 3'b010; // y
                out2 = 3'b100; // r
                nextState = twoOne;
            end
            twoOne: begin
                out1 = 3'b100; // r
                out2 = 3'b001; // g
                nextState = threeOne;
            end
            threeOne: begin
                out1 = 3'b100; // r
                out2 = 3'b010; // y
                nextState = zero;
            end
        endcase
    end
endmodule
