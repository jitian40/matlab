clear all;
clc;
num=16;%天线单元数目
popsize=4;%种群个体数目
chromlength=7*num ;%基因长度, 每个单元的相位用 7 位二进制数表示
pop=round(rand(popsize,chromlength));%随机产生初始化种群，popsize*chromlength
BB=zeros(popsize,num);%生成一个300*18的全为零的矩阵
for n=1:popsize-1
    for n1=1:num
        n3=0;
        for n2=(n1-1)*7+1:n1*7
            BB(n,n1)=BB(n,n1)+pop(n,n2)*2^n3;
            n3=n3+1;
        end
    end
end
I_phi=BB*(2*pi/(2^7-1));%求出每个个体的激励相位

Theta=linspace(0,pi);%与Z坐标轴的夹角
Phi=linspace(0,2*pi);%投影角
[theta,phi]=meshgrid(Theta,Phi);
for pop1=0:popsize-1
    e=f(theta,phi,pop1*num,I_phi);
    ans=sum(sum(e.^2));
    X=e.*sin(theta).*cos(phi);
    Y=e.*sin(theta).*sin(phi);
    Z=e.*cos(theta);
    subplot(2,2,pop1+1);
    mesh(X,Y,Z);
    axis equal;
end
%e1=e1+xchange(phi_Z,Phi_Y,theta,phi);

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
%旋转函数
function dirGrah=xchange(zarc,yarc,t,p,phi_i,zn,R)
    Z_arc=zarc+pi;
    Y_arc=2*pi-yarc;
    %绕着Z轴旋转Z_arc
    theta_1=t;
    phi_1=p-Z_arc;
    %绕着Y轴旋转Y_arc;
    theta_2=acos(cos(theta_1).*cos(Y_arc)-sin(theta_1).*cos(phi_1).*sin(Y_arc));
    Phi_2=atan((sin(theta_1).*sin(phi_1))./(cos(theta_1).*sin(Y_arc)+sin(theta_1).*cos(phi_1).*cos(Y_arc)));
    dirGrah=cos(pi/2.*cos(theta_2))./sin(theta_2).*exp(j*(phi_i-2*pi/15.*(sin(t).*cos(p-zarc).*(R-zn/2)+zn.*cos(t))));
end




