%泰勒综合法-单变量方法
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
d=input('天线阵元间距(波长的倍数)：');%阵元间距（波长的倍数）
SLL=input('副瓣电平要求(dB)：');

%*******************
%参数计算
syms B
L=N*d;%阵列的长度
R0=10^(abs(SLL)/20);
Zero=4.603*sinh(pi*B)/pi/B-10;
B=solve(Zero,B);

x=linspace(-N*d/2,N*d/2,N);%在[-L/2,L/2]均等分取N个点
Im=besselj(0,1j.*pi.*B.*sqrt(1-(2.*x/N/d).^2));
Im=eval(Im./max(Im));

