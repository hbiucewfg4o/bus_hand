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


module data_top #(parameter width_top=4)//����λ��
(
	input clk,
	input rst_n,
	input outside_data_valid,//��紫��������Ч��־λ
	input [width_top-1:0] outside_data,//��紫������
	output [width_top-1:0]	data_out

);

//��ģ������
wire [width_top-1:0]	data_middle;
wire ready,valid;

//�������Ͷ�
 data_master  #(.width (width_top))
 data_master_U(
	.clk			(clk	),
	.rst_n			(rst_n),
	.data_valid     (outside_data_valid),
	.outside_data   (outside_data),
	.ready			(ready),		//��һ���Ƿ�׼���ý�������
	.data			(data_middle),	//��ʱ�����ݶ�Ϊ4bits��λ��
	.valid			(valid)
	);
//�������ն�
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
