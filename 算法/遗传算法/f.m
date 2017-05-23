%总体方向图函数
function F=f(theta,phi,pop,I_phi)%参数包含球坐标下theta角与phi角，激励相位的初始位置，激励相位数组
    phi_Z=[0,pi/2,pi,3*pi/2];%单元分布角度
    d_busbar=[0,15,30,45];
    R=40;%底面圆半径
    Phi_Y=atan(2);%椎体底角
    e=zeros(100,100);
        for Ai=1:length(phi_Z)%确定层数
         zarc=phi_Z(Ai);%柱坐标下phi角
            for Zi=1:length(d_busbar)%母线上单元方向图的叠加
                phi_i=I_phi(pop:pop,Ai*Zi:Ai*Zi);%单元激励相位
                d_z=2*d_busbar(Zi)./sqrt(5);%计算Zn
                e=e+xchange(zarc,Phi_Y,theta,phi,phi_i,d_z,R);%方向图函数的复数域的叠加(matlab可以直接计算复数)
            end
        end
      F=abs(e)./max(max(abs(e)));%总体方向图函数归一化
end