%道尔夫_切比雪夫分布
%激励电流分布
clear;
clc;
%*******************
%参数定义
lamda=10;%天线的波长(mm)
theta=0:1:180;
phi=0:1:360;
%*******************
%参数输入
N=input('天线阵元个数：');%阵元个数
d=input('天线阵元间距（波长的倍数：）');%阵元间距（波长的倍数）
SLL=input('副瓣电平要求(dB)：');

%*******************
%求解计算
R0=10^(abs(SLL)/20);%等效的副瓣电平(单位1)
x0=cosh(1/(N-1)*acosh(R0));%求辅助参数

%求半边激励幅度
if (mod(N,2)==1)
   M=(N-1)/2;
   Im=zeros(1,M);
   for n=2:M+1
    for p=n:M+1
        Im(n-1)=Im(n-1)+(-1)^(M-p+1)*x0^(2*p-2)*factorial(p+M-2)*M/factorial(p-n)/factorial(p+n-2)/factorial(M-p+1);
    end
   end
   Im=Im./Im(M);       
end
