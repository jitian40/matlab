%非均匀等间距线阵的一般化分析
clear all;
clc;
%天线相关参数
a=linspace(0,2*pi);
b=linspace(0,2*pi);
[theta,phi]=meshgrid(a,b);
%五元阵
N=5;
Im=[1,2,3,2,1];
%条件定义
lamda=100;%单位毫米
k=2*pi/lamda;%波传播常数
d=lamda/2;%单元间距
alpha=0;%定义激励相位，边射时取零
%判断就奇偶性
if mod(N,2)==1  %如果单元数为奇数
   initial_num=-(N-1)/2;     
else            %如果单元数为偶数
    initial_num=-N/2;  
end
%归一化阵因子函数
S=0;
for im=1:N
    S=S+Im(im).*exp(1j.*(k*d*(initial_num+im-1).*cos(a)));
end
s=abs(S)./sum(Im);
subplot(1,2,1)
plot(a,20.*log10(s),'r');
xlabel('角度theta\(rad)');
ylabel('相对幅度\(dB)');
title('五元非均匀等间距边射阵方向图')
subplot(1,2,2)
polar(a,s,'r');
title('五元非均匀等间距边射阵极坐标方向图')