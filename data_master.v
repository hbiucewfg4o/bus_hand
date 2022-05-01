`timescale 1ns/1ns
module data_master #(parameter width=4) //����������ɶ�������λ�����ݴ���
(
	input clk,
	input rst_n,
	input data_valid,//��紫��������Ч��־λ
	input [width-1:0] outside_data,//��紫������
	input ready,		//��һ���Ƿ�׼���ý�������
	output reg [width-1:0]data,	//��ʱ�����ݶ�Ϊ4bits��λ��
	output reg valid
	);
    //����ź���ʱ�Ӳ�ͬ��ʱ����ready���д��ģ�ͬ������ǰʱ����
    reg ready_reg1;
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            ready_reg1<=0;
        end
        else begin
            ready_reg1<=ready;
        end
    end
    //����������ݺ���Чλ���и�ֵ
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            valid<=0; 
        else if(data_valid)	//����������Чʱ��������
            valid<=1;   
        else if(ready_reg1)//������������Чʱ���������Ѿ����������ݣ�������
            valid<=0;
        else
            valid<=0;
    end
    always@(posedge clk or negedge rst_n)begin
        if(!rst_n)
            data<=0;
        else if(data_valid)//����������Чʱ
            data<=outside_data; 
        else 
            data<=data;
    end
endmodule

