clear all;
clc;
%������ز���
a=pi/100:pi/100:pi;
b=pi/50:pi/50:2*pi;
[theta,phi]=meshgrid(a,b);
trans_val=zeros(100,100);%һ������ֵ�������Ÿ���
%������Ϻ���

% req_e=cos(6*theta).*(theta<pi/12);
req_fun=req_e./max(max(req_e));
%�㷨��ز���
num=16;%���ߵ�Ԫ��Ŀ
popsize=50;%��Ⱥ������Ŀ
generations=500;%��������
P_cross=0.8;%�������,Խ������Խ��
P_variation=0.05;%�������
alpha=0.5;%��Ӧ�Ⱥ���������ԽС�仯Խ��
chromlength=7*num ;%���򳤶�, ÿ����Ԫ����λ�� 7 λ����������ʾ
pop=round(rand(popsize,chromlength));%���������ʼ����Ⱥ��popsize*chromlength
trans_phase=zeros(1,num);%һ������ֵ�������Ÿ����Ӧ�ļ�����λ
fits=zeros(1,popsize);%������Ⱥ��Ӧ�Ⱦ���
gene=0;
%������Ӧ�ȳ�ʼֵ
fitness=0;
t=fitness;
while(gene<generations)
%�������ƻ���ת��Ϊʮ���ƻ���
BB=bin_dec(popsize,num,pop);
I_phi=BB*(2*pi/(2^7-1));%���ÿ������ļ�����λ
%��Ӧ�ȼ���
for pop1=0:popsize-1
    rec_fun=f(theta,phi,pop1+1,I_phi);%�õ��ķ���ͼ����
    fitness=fit(req_fun,rec_fun);
    fits(pop1+1)=fitness;
    if t<fitness %�������Ž�
       t=fitness;
       trans_val=rec_fun;
       trans_phase=BB(pop1+1:pop1+1,:);
    end
end
%ѡ������
pop=Roulette(fits,pop);%�����µ���Ⱥ
%���������
pop=Cross(P_cross,pop);%����
pop=variate(P_variation,pop);%����
%��������������ʵı仯
P_cross=P_cross-0.4/generations;
P_variation=P_variation+0.4/generations;
%��һ��
gene=gene+1;
end
%��ͼ����������
    X=trans_val.*sin(theta).*cos(phi);
    Y=trans_val.*sin(theta).*sin(phi);
    Z=trans_val.*cos(theta);
    mesh(X,Y,Z);
    









