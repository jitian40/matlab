 clear all;
clc;
%天线相关参数
a=1:1:180;
b=2:2:360;
[theta,phi]=meshgrid(a,b);
trans_val=zeros(length(a),length(b));%一个过渡值存着最优个体
%定义拟合函数
% req_e=sin(4*pi.*cos(theta/180*pi))./sin(0.4*pi.*(cosd(theta)-1));
% req_e=cos(6*theta).*(theta<pi/12);
% req_fun=req_e./max(max(req_e));
%算法相关参数
num=16;%天线单元数目
popsize=50;%种群个体数目
generations=100;%进化代数
P_cross=0.8;%交叉概率,越大收敛越快
P_variation=0.05;%变异概率
rate=0.5;%选择判断因子
alpha=0.5;%适应度函数参数，越小变化越快
chromlength=7*num;%基因长度, 每个单元的相位用 7 位二进制数表示
pop=round(rand(popsize,chromlength));%随机产生初始化种群，popsize*chromlength
trans_phase=zeros(1,num);%一个过渡值存着最优个体对应的激励相位
fits=zeros(1,popsize);%定义种群适应度矩阵
gene=0;
%定义适应度初始值
fitness=0;
t=fitness;
et=unit_fun(theta,phi);
while(gene<generations)
%将二进制基因转化为十进制基因
BB=bin_dec(popsize,num,pop);
I_phi=BB*(2*pi/(2^7-1));%求出每个个体的激励相位s
%   I_phi=BB/(2^7-1);
%适应度计算
for pop1=0:popsize-1
    rec_fun=f(theta,phi,pop1+1,I_phi,et);%得到的方向图函数
%     fitness=fit(req_fun,rec_fun);
    fitness=para(theta,rec_fun);
    fits(pop1+1)=fitness;
    if t<fitness %保留最优解
       t=fitness;
       trans_val=rec_fun;
       trans_phase=BB(pop1+1:pop1+1,:);
    end
end
%选择算子
% pop=Roulette(fits,pop);%生成新的种群
pop=select(fits,pop,rate);
%交叉与变异
pop=Cross(P_cross,pop);%交叉
pop=variate(P_variation,pop);%变异
%交叉概率与变异概率的变化
P_cross=P_cross-0.4/generations;
P_variation=P_variation+0.4/generations;
%下一代
gene=gene+1;
% rate=rate-0.4/generations^2*gene^2;
end
%画图函数，具象化
    X=trans_val.*sind(theta).*cosd(phi);
    Y=trans_val.*sind(theta).*sind(phi);
    Z=trans_val.*cosd(theta);
    mesh(X,Y,Z);
    









