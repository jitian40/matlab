%�����������е��б�ѩ�����ʽ
clear;
clc;
N=input('���ߵ�Ԫ������');
P=N-1;
x=linspace(-1.1,1.1);
Tp=cos(P.*acos(x));
plot(x,Tp,'r');
xlabel('X');
ylabel('Y');
new_fig_handle=shift_axis_to_origin(gca) ;