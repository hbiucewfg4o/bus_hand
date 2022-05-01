`timescale 1ns/1ns
module data_master #(parameter width=4) //顶层参数，可定义任意位宽数据传输
(
	input clk,
	input rst_n,
	input data_valid,//外界传入数据有效标志位
	input [width-1:0] outside_data,//外界传入数据
	input ready,		//下一级是否准备好接收数据
	output reg [width-1:0]data,	//暂时将数据定为4bits的位宽
	output reg valid
	);
    //针对信号与时钟不同步时，对ready进行打拍，同步到当前时钟下
    reg ready_reg1;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            ready_reg1<=0;
        end
        else begin
            ready_reg1<=ready;
        end
    end
    //对输出的数据和有效位进行赋值
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            valid<=0; 
        else if(data_valid)	//传入数据有效时，则拉高
            valid<=1;   
        else if(ready_reg1)//当传输数据无效时，且下游已经接收了数据，则拉低
            valid<=0;
        else
            valid<=0;
    end
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            data<=0;
        else if(data_valid)//传入数据有效时
            data<=outside_data; 
        else 
            data<=data;
    end
endmodule

