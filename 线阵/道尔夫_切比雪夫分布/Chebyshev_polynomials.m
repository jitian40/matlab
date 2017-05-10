%阵列列天线中的切比雪夫多项式
clear;
clc;
N=input('天线单元个数：');
P=N-1;
syms x;
Tp=cos(P.*acos(x));
plot(x,Tp,'r');
xlabel('X');
ylabel('Y');
new_fig_handle=shift_axis_to_origin(gca) ;