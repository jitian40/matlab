%������Ƭ���߲�������
clear all;
clc;
%�̶�����
c=300;%��λMm/s
%��������
% materail_name=input('name is');%���ʻ�Ƭ����
materail_epsilon=input('epsilon= ');%���ʻ�Ƭ����Խ�糣��
materail_mue=input('mue= ');%���ʻ�Ƭ����Դŵ���
materail_frequency=input('frequency(GHz)= ');%���ߵ�����Ƶ��
materail_height=input('height(mm)= ');%���ʻ�Ƭ�ĺ��
%���߲���
%��Ƭ��ȼ��㣨mm��
Width=c/2/materail_frequency/sqrt(materail_epsilon/2+1/2);
%���ʻ�Ƭ��Ч��糣��
if(Width>materail_height)
    materail_effepsilon=(materail_epsilon+1)/2+(materail_epsilon-1)/2/sqrt(1+12*materail_height/Width);
else
    materail_effepsilon=(materail_epsilon+1)/2+(materail_epsilon-1)/2*(1/sqrt(1+12*materail_height/Width)+0.04*(1-Width/materail_height)^2);
end
%���ʻ�Ƭ�߳�������(mm)
materail_dertalenght=0.412*materail_height*(materail_effepsilon+0.3)*(Width/materail_height+0.264)/(materail_effepsilon-0.258)/(Width/materail_height+0.8);
%��Ƭ����(mm)
Length=c/2/materail_frequency/sqrt(materail_effepsilon)-2*materail_dertalenght;
%ͬ���������
L1=Length/2*(1-1/sqrt(materail_effepsilon));

%Ƕ����������
trans=0.001699*materail_epsilon^7+0.13761*materail_epsilon^6-6.1783*materail_epsilon^5+93.187*materail_epsilon^4-682.69*materail_epsilon^3+2561.9*materail_epsilon^2-4043*materail_epsilon+6697;
Dig_height=trans*Length/10^4/2;