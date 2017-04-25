%�Ǿ��ȵȼ�������һ�㻯����
clear all;
clc;
%������ز���
a=linspace(0,2*pi);
b=linspace(0,2*pi);
[theta,phi]=meshgrid(a,b);
%��Ԫ��
N=5;
Im=[1,2,3,2,1];
%��������
lamda=100;%��λ����
k=2*pi/lamda;%����������
d=lamda/2;%��Ԫ���
alpha=0;%���弤����λ������ʱȡ��
%�жϾ���ż��
if mod(N,2)==1  %�����Ԫ��Ϊ����
   initial_num=-(N-1)/2;     
else            %�����Ԫ��Ϊż��
    initial_num=-N/2;  
end
%��һ�������Ӻ���
S=0;
for im=1:N
    S=S+Im(im).*exp(1j.*(k*d*(initial_num+im-1).*cos(a)));
end
s=abs(S)./sum(Im);
subplot(1,2,1)
plot(a,20.*log10(s),'r');
xlabel('�Ƕ�theta\(rad)');
ylabel('��Է���\(dB)');
title('��Ԫ�Ǿ��ȵȼ���������ͼ')
subplot(1,2,2)
polar(a,s,'r');
title('��Ԫ�Ǿ��ȵȼ����������귽��ͼ')