clear all;
clc;
%天线相关参数
a=pi/100:pi/100:pi;
b=pi/50:pi/50:2*pi;
[theta,phi]=meshgrid(a,b);
trans_val=zeros(100,100);%一个过渡值存着最优个体
%定义拟合函数
req_e=sin(4*pi.*cos(theta))./sin(0.4*pi.*(cos(theta)-1));
req_fun=req_e./max(max(req_e));
%算法相关参数
num=16;%天线单元数目
popsize=50;%种群个体数目
generations=1000;%进化代数
P_cross=0.8;%交叉概率,越大收敛越快
P_variation=0.05;%变异概率
alpha=0.5;%适应度函数参数，越小变化越快
chromlength=7*num ;%基因长度, 每个单元的相位用 7 位二进制数表示
pop=round(rand(popsize,chromlength));%随机产生初始化种群，popsize*chromlength
trans_phase=zeros(1,num);%一个过渡值存着最优个体对应的激励相位
fits=zeros(1,popsize);%定义种群适应度矩阵
gene=0;
%定义适应度初始值
fitness=0;
t=fitness;
while(gene<generations)
%将二进制基因转化为十进制基因
BB=bin_dec(popsize,num,pop);
I_phi=BB*(2*pi/(2^7-1));%求出每个个体的激励相位
%适应度计算
for pop1=0:popsize-1
    rec_fun=f(theta,phi,pop1*num,I_phi);%得到的方向图函数
    fitness=fit(req_fun,rec_fun);
    fits(pop1+1)=fitness;
    if t<fitness %保留最优解
       t=fitness;
       trans_val=rec_fun;
       trans_phase=BB(pop1+1:pop1+1,:);
    end
end
%选择算子
pop=Roulette(fits,pop);%生成新的种群
%交叉与变异
pop=Cross(P_cross,pop);%交叉
pop=variate(P_variation,pop);%变异
%交叉概率与变异概率的变化
P_cross=P_cross-0.4/generations;
P_variation=P_variation+0.4/generations;
%下一代
gene=gene+1;
end
%画图函数，具象化
    X=trans_val.*sin(theta).*cos(phi);
    Y=trans_val.*sin(theta).*sin(phi);
    Z=trans_val.*cos(theta);
    mesh(X,Y,Z);
    

%适应度评价函数:改进的均方差评价函数
function fitness=fit(req_dirfun,rec_dirfun)
    variance=sum(sum((((req_dirfun-rec_dirfun)./req_dirfun).^2)/10000));
    covariance=sqrt(variance);
    fitness=1./(1+covariance^0.3);
end
%总体方向图函数
function F=f(theta,phi,pop_num,I_phi)%参数包含球坐标下theta角与phi角，激励相位的初始位置，激励相位数组
    phi_Z=[0,pi/2,pi,3*pi/2];%单元分布角度
    d_busbar=[0,15,30,45];
    R=40;%地面圆半径
    Phi_Y=atan(2);%椎体底角
    e=zeros(100,100);
        for Ai=1:length(phi_Z)%确定层数
         zarc=phi_Z(Ai);%柱坐标下phi角
            for Zi=1:length(d_busbar)%母线上单元方向图的叠加
                phi_i=I_phi(pop_num+Ai*Zi);%单元激励相位
                d_z=2*d_busbar(Zi)./sqrt(5);%计算Zn
                e=e+xchange(zarc,Phi_Y,theta,phi,phi_i,d_z,R);%方向图函数的复数域的叠加(matlab可以直接计算复数)
            end
        end
      F=abs(e)./max(max(abs(e)));%总体方向图函数归一化
end
%旋转函数依赖于椎体的旋转函数
function dirGrah=xchange(zarc,yarc,t,p,phi_i,zn,R)%单元天线的排列角度，参数包含圆锥体的底角，球坐标下theta角与phi角，激励相位，单元的Z坐标值，椎体的底面圆的半径
    Z_arc=zarc+pi;
    Y_arc=2*pi-yarc;
    %绕着Z轴旋转Z_arc
    theta_1=t;
    phi_1=p-Z_arc;
    %绕着Y轴旋转Y_arc;
    theta_2=acos(cos(theta_1).*cos(Y_arc)-sin(theta_1).*cos(phi_1).*sin(Y_arc));%变化后的theta角
    Phi_2=atan((sin(theta_1).*sin(phi_1))./(cos(theta_1).*sin(Y_arc)+sin(theta_1).*cos(phi_1).*cos(Y_arc)));%变化后的phi角
    dirGrah=sin(5/2.*pi.*cos(theta_2))./(5*sin(pi/2.*cos(theta_2))).*exp(1i*(phi_i+2*pi/15.*(sin(t).*cos(p-zarc).*(R-zn/2)+zn.*cos(t))));
end

%进制转化函数
function BB=bin_dec(popsize,num,pop)
    %将二进制基因转化为十进制相位
    BB=zeros(popsize,num);%生成一个全为零的矩阵
    for n=1:popsize
        for n1=1:num
            n3=0;
            for n2=(n1-1)*7+1:n1*7
                BB(n,n1)=BB(n,n1)+pop(n,n2)*2^n3;
                n3=n3+1;
            end
        end
    end
end


%轮盘赌选择算子，生成新的种群
function NewPop=Roulette(fit,pop)
    fitvalue=fit./sum(fit);
    fitvalue1=cumsum(fitvalue);
    [px,py]=size(pop);
    newpop=zeros(px,py);
    rns=sort(rand(1,px));%随机转动px次轮盘
    fitin=1;
    newin=1;
    while newin<=px
         if(rns(newin)<fitvalue1(fitin))
             newpop(newin,:)=pop(fitin,:);%如果选中，保留该个体
             newin=newin+1;
         else
             fitin=fitin+1;
         end
    end
    NewPop=newpop;
end

%交叉算子
function NewPop1=Cross(Pc,pop)
    [px,py]=size(pop);
    newpops=zeros(px,py);
    for i=1:2:px-1        %px一般取偶数值
        if(rand<Pc)       %每次进行随机交叉
            copoint=round(rand*py);%随机确定交叉点
            newpops(i,:)=[pop(i,1:copoint),pop(i+1,copoint+1:py)];
            newpops(i+1,:)=[pop(i+1,1:copoint),pop(i,copoint+1:py)];
        else
            newpops(i,:)=pop(i,:);
            newpops(i+1,:)=pop(i+1,:);
        end
    end
    NewPop1=newpops;
end
%变异算子
function NewPop2=variate(Pv,pop)
        [px,py]=size(pop);
    for i=1:px        %px一般取偶数值
        if(rand<Pv)       %每次进行随机变异
            copoint=round(rand*(py-1));%随机确定变异点
            pop(i,copoint+1)=not(pop(i,copoint+1));%对变异点取非
        end
    end
    NewPop2=pop;
end
