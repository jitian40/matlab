 clear all;
clc;
%������ز���
a=1:1:180;
b=2:2:360;
[theta,phi]=meshgrid(a,b);
trans_val=zeros(length(a),length(b));%һ������ֵ�������Ÿ���
%������Ϻ���
% req_e=sin(4*pi.*cos(theta/180*pi))./sin(0.4*pi.*(cosd(theta)-1));
% req_e=cos(6*theta).*(theta<pi/12);
% req_fun=req_e./max(max(req_e));
%�㷨��ز���
num=16;%���ߵ�Ԫ��Ŀ
popsize=50;%��Ⱥ������Ŀ
generations=100;%��������
P_cross=0.8;%�������,Խ������Խ��
P_variation=0.05;%�������
rate=0.5;%ѡ���ж�����
alpha=0.5;%��Ӧ�Ⱥ���������ԽС�仯Խ��
chromlength=7*num;%���򳤶�, ÿ����Ԫ����λ�� 7 λ����������ʾ
pop=round(rand(popsize,chromlength));%���������ʼ����Ⱥ��popsize*chromlength
trans_phase=zeros(1,num);%һ������ֵ�������Ÿ����Ӧ�ļ�����λ
fits=zeros(1,popsize);%������Ⱥ��Ӧ�Ⱦ���
gene=0;
%������Ӧ�ȳ�ʼֵ
fitness=0;
t=fitness;
et=unit_fun(theta,phi);
while(gene<generations)
%�������ƻ���ת��Ϊʮ���ƻ���
BB=bin_dec(popsize,num,pop);
I_phi=BB*(2*pi/(2^7-1));%���ÿ������ļ�����λs
%   I_phi=BB/(2^7-1);
%��Ӧ�ȼ���
for pop1=0:popsize-1
    rec_fun=f(theta,phi,pop1+1,I_phi,et);%�õ��ķ���ͼ����
%     fitness=fit(req_fun,rec_fun);
    fitness=para(theta,rec_fun);
    fits(pop1+1)=fitness;
    if t<fitness %�������Ž�
       t=fitness;
       trans_val=rec_fun;
       trans_phase=BB(pop1+1:pop1+1,:);
    end
end
%ѡ������
% pop=Roulette(fits,pop);%�����µ���Ⱥ
pop=select(fits,pop,rate);
%���������
pop=Cross(P_cross,pop);%����
pop=variate(P_variation,pop);%����
%��������������ʵı仯
P_cross=P_cross-0.4/generations;
P_variation=P_variation+0.4/generations;
%��һ��
gene=gene+1;
% rate=rate-0.4/generations^2*gene^2;
end
%��ͼ����������
    X=trans_val.*sind(theta).*cosd(phi);
    Y=trans_val.*sind(theta).*sind(phi);
    Z=trans_val.*cosd(theta);
    mesh(X,Y,Z);
    









