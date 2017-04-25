%阵列列天线中的切比雪夫多项式
clear all;
clc;
P=input('天线单元个数：');
x=linspace(-1.1,1.1);
Tp=cos(P.*acos(x)).*(x<1&x>-1)+cosh(P.*acosh(x)).*(x>=1|x<=-1);
plot(x,Tp,'r');
xlabel('X');
ylabel('Y');
new_fig_handle=shift_axis_to_origin(gca) ;