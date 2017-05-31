%泰勒—切比雪夫误差方法
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
N_=input('零点变换点：');

%*******************
%方法参数计算
R0=10^(abs(SLL)/20);%主副瓣电平比
A=acosh(R0)/pi;%参数
sigma=N_/sqrt(A^2+(N_-0.5)^2);%波瓣展宽因子
x=N.*d.*cos(theta./180.*pi);
M=fix(N/2);
Zn=zeros(1,N);
%激励幅度计算
if mod(N,2)==1
    Zn=(-M:M)*d;
else 
    Zn(M+1:N)=(2.*(0:M-1)+1)./2;
    Zn(1:M)=fliplr(-Zn(M+1:N));
end
s11=0;
for I=1:N_-1
    s12=1;
    for n=1:N_-1;
        s12=s12*(1-I^2/sigma^2/(A^2+(n-0.5)^2));
    end
    s11=s11+s12.*prod(1:N_-1)^2/prod(1:N_+I-1)/prod(1:N_-1-I).*cos(2.*I.*pi.*Zn./N/d);
end
Im=1+2.*s11;
Im=Im./max(Im);
%天线性能参数计算l
BWhp=2*asin(sigma/N/d/pi*((acosh(R0))^2-(acosh(R0/sqrt(2)))^2)^0.5);%半功率波瓣宽度
%计算方向图函数
s1=1;
s2=1;
for n=1:N_-1
    Xn=sigma.*sqrt(A^2+(n-0.5).^2);
    s1=s1.*(1-(x./Xn).^2);
    s2=s2.*(1-(x./n).^2);
end
S=cosh(pi*A).*sin(pi.*x).*s1./pi./x./s2; %归一化方向图函数
S=abs(S)./max(abs(S));
s=20*log10(S);
% subplot(1,2,1)
plot(theta,s,'r');
title({[num2str(N),'泰勒线源幅度方向图','SLL',num2str(SLL),'dB,','N_=',num2str(N_)]});
xlabel('角度\theta/(\circ)');
ylabel('相对幅度/dB');
grid on;
% subplot(1,2,2)
% polar(theta./180.*pi,S);
