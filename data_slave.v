`timescale 1ns/1ns
module data_slave #(parameter width=4)
(
    input clk,
    input rst_n,
    input  [width-1:0]data,
    input  valid,
    output ready,
	output [width-1:0]	data_out

);
    //打一拍同步到当前时钟
   reg valid_reg1; 
   always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            valid_reg1<=0;
        end
        else begin
            valid_reg1<=valid;
        end
    end 
    //发送有效信号
    reg ready_temp;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            ready_temp<=0;
        else if(valid_reg1)
            ready_temp<=1;	//接收到数据后，拉高ready_temp反压源端
        else
            ready_temp<=0;   
    end
    assign ready=ready_temp;
	
    //暂时用一个寄存器将得到的数据存起来
    reg [width-1:0] data_out_temp;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
           data_out_temp<=0;
        else if(valid_reg1)
            data_out_temp<=data;
        else
            data_out_temp<=data_out_temp;
    end 
	assign data_out=data_out_temp;
endmodule
