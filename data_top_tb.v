`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/30 11:17:23
// Design Name: 
// Module Name: data_top_tb
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


module data_top_tb(
    );
 parameter width_top=4;
 reg clk,rst_n;
 reg data_valid;
 reg [width_top-1:0] outside_data;
 initial begin
    clk<=0;
    rst_n<=0;
    data_valid<=0;
    #15
    rst_n<=1;
    //先单次传输，再突发传输
    #10
    data_valid<=1;
    outside_data<=4'd10;
    #20
    data_valid<=0;
    #40
    data_valid<=1;
    outside_data<=4'd6;
    #40
    outside_data<=4'd4;
    #20
    outside_data<=4'd8;
    #20
    outside_data<=4'd9;
    #20
    outside_data<=4'd1;
    #20
    outside_data<=4'd15;
    #20
    outside_data<=4'd13;
    #20
    data_valid<=0;
    #40
    data_valid<=1;
    outside_data<=4'd12;
    #40
    outside_data<=4'd10;
    #20
    outside_data<=4'd8;
    #20
    outside_data<=4'd9;
    #20
    outside_data<=4'd2;
    #20
    outside_data<=4'd5;
    #20
    data_valid<=0;
    #20
    data_valid<=1;
    outside_data<=4'd7;
    #40
    data_valid<=0;
    #40
    data_valid<=1;
    outside_data<=4'd3;
    #40
    outside_data<=4'd9;
    #20
    outside_data<=4'd1;
    #20
    outside_data<=4'd15;
    #20
    outside_data<=4'd13;
    #20
    data_valid<=0;
    #40
    data_valid<=1;
    outside_data<=4'd7;
    #20
    data_valid<=0;
    #40
    data_valid<=1;
    outside_data<=4'd8;
    #20
    data_valid<=0;
    #40
    data_valid<=1;
    outside_data<=4'd10;
    #40
    outside_data<=4'd13;
    #20
    outside_data<=4'd7;
    #20
    outside_data<=4'd1;
    #20
    outside_data<=4'd6;
    #20
    data_valid<=0;
 end   
 always #10 clk<=~clk;   
 
 wire [width_top-1:0] data_out;
 //例化顶层模块
 data_top #(.width_top  (width_top))
 data_top_U(
	.clk       (clk     ),
	.rst_n     (rst_n   ),
	.outside_data_valid    (data_valid),//外界传入数据有效标志位
	.outside_data  (outside_data),//外界传入数据
	.data_out  (data_out)

);
 
endmodule
