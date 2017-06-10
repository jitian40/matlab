%������_�б�ѩ��ֲ�
clear;
clc;
%*******************
%��������
lamda=10;%���ߵĲ���(mm)
theta=0:1:180;
phi=0:1:360;
%*******************
%��������
N=input('������Ԫ������');%��Ԫ����
d=input('������Ԫ��ࣨ�����ı�������');%��Ԫ��ࣨ�����ı�����
SLL=input('�����ƽҪ��(dB)��');

%*******************
%������
P=N-1;%�б�ѩ�����Ľ�
R0=10^(abs(SLL)/20);%��Ч�ĸ����ƽ(��λ1)
x0=cosh(1/(N-1)*acosh(R0));%��������

%���б�ѩ�����ĸ�
syms x;
y=cos(P.*acos(x));%�б�ѩ�����ĸ�λ��[-1,1]֮�䣬��˿���ֻȡ��һ�����ڵĺ������
c=sym2poly(y);%����ʽ����
r=sort(roots(c));%��ȡ�����ĸ�
u=2.*acos(r./x0);
w=exp(1j.*u);

%��������
syms t S
S=1;
for wq=1:length(w)
    S=S*(t-w(wq));
end
Im=abs(sym2poly(collect(S)));%��������

%************************
figure(1)
%����ͼ�����Լ���ͼ
f=subs(S,t,exp(1j*2*pi*d.*cos(theta./180.*pi)));%����ͼ����
s=20.*log10(abs(f)./max(abs(f)));%����Ⱥ���
subplot(1,2,1)
plot(theta,s,'r');
title({[num2str(N),'Ԫ������-�б�ѩ��������ȷ���ͼ','���d=',num2str(d),'�����ƽΪ',num2str(SLL),'dB']});
xlabel('�Ƕ�\theta/(\circ)');
ylabel('��Է���/dB');
grid on;
subplot(1,2,2)
F=abs(f)./max(abs(f));
polar(theta/180*pi,F);
%**************************

%**************************
%�����в���
syms K
M=fix(N/2);
a0=R0/(2*M+1);
a1=cosh((acosh(R0))^2-pi^2)^0.5/(2*M+1);
bw_f=0.707*(1+2*K^2*a1/a0/(1-K^2))^(-1)-sin(pi*K)/pi/K;
K=solve(bw_f,K);
BWhp=vpa(2*(acos(K/N/d)-pi/2)/pi*180,9);%�빦�ʲ�����
fa=1+0.635*(2/R0*cosh(sqrt((acosh(R0))^2-pi^2)))^2;%����չ������
D=2*R0^2/(1+(R0^2-1)*fa/N/d);%������ϵ��