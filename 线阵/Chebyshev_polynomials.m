%�����������е��б�ѩ�����ʽ
clear all;
clc;
P=input('���ߵ�Ԫ������');
x=linspace(-1.1,1.1);
Tp=cos(P.*acos(x)).*(x<1&x>-1)+cosh(P.*acosh(x)).*(x>=1|x<=-1);
plot(x,Tp,'r');
xlabel('X');
ylabel('Y');
new_fig_handle=shift_axis_to_origin(gca) ;