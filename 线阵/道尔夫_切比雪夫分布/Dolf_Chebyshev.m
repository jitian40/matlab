%道尔夫_切比雪夫分布
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
P=N-1;%切比雪夫函数的阶
R0=10^(abs(SLL)/20);%等效的副瓣电平(单位1)
x0=cosh(1/(N-1)*acosh(R0));%求辅助参数

%求切比雪夫函数的根
syms x;
y=cos(P.*acos(x));%切比雪夫函数的根位于[-1,1]之间，因此可以只取这一区间内的函数求根
c=sym2poly(y);%多项式解析
r=sort(roots(c));%求取函数的根
u=2.*acos(r./x0);
w=exp(1j.*u);

%求激励幅度
syms t S
S=1;
for wq=1:length(w)
    S=S*(t-w(wq));
end
Im=abs(sym2poly(collect(S)));%求激励电流

%************************
figure(1)
%求方向图函数以及画图
f=subs(S,t,exp(1j*2*pi*d.*cos(theta./180.*pi)));%求方向图函数
s=20.*log10(abs(f)./max(abs(f)));%求幅度函数
subplot(1,2,1)
plot(theta,s,'r');
title({[num2str(N),'元道尔夫-切比雪夫线阵幅度方向图','间距d=',num2str(d),'副瓣电平为',num2str(SLL),'dB']});
xlabel('角度\theta/(\circ)');
ylabel('相对幅度/dB');
grid on;
subplot(1,2,2)
F=abs(f)./max(abs(f));
polar(theta/180*pi,F);
%**************************

%**************************
%求阵列参数
syms K
M=fix(N/2);
a0=R0/(2*M+1);
a1=cosh((acosh(R0))^2-pi^2)^0.5/(2*M+1);
bw_f=0.707*(1+2*K^2*a1/a0/(1-K^2))^(-1)-sin(pi*K)/pi/K;
K=solve(bw_f,K);
BWhp=vpa(2*(acos(K/N/d)-pi/2)/pi*180,9);%半功率波瓣宽度
fa=1+0.635*(2/R0*cosh(sqrt((acosh(R0))^2-pi^2)))^2;%波瓣展宽因子
D=2*R0^2/(1+(R0^2-1)*fa/N/d);%方向性系数