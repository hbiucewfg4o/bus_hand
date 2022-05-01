`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/04/30 10:50:50
// Design Name: 
// Module Name: data_top
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


module data_top #(parameter width_top=4)//定义位宽
(
	input clk,
	input rst_n,
	input outside_data_valid,//外界传入数据有效标志位
	input [width_top-1:0] outside_data,//外界传入数据
	output [width_top-1:0]	data_out

);

//子模块间变量
wire [width_top-1:0]	data_middle;
wire ready,valid;

//例化发送端
 data_master  #(.width (width_top))
 data_master_U(
	.clk			(clk	),
	.rst_n			(rst_n),
	.data_valid     (outside_data_valid),
	.outside_data   (outside_data),
	.ready			(ready),		//下一级是否准备好接收数据
	.data			(data_middle),	//暂时将数据定为4bits的位宽
	.valid			(valid)
	);
//例化接收端
 data_slave  #(.width (width_top))
 data_slave_U(
    .clk		(clk	),		
    .rst_n		(rst_n	),
    .data		(data_middle	),
    .valid		(valid	),
    .ready		(ready	),
	.data_out	(data_out)
);

endmodule
