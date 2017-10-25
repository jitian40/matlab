%总体方向图函数
function F=f(theta,phi,et)%参数包含球坐标下theta角与phi角，激励相位的初始位置，激励相位数组
    phi_Z=[0,90,180,270];%单元分布角度
    d_busbar=[0,8,16,24];%单元分布层数
    R=20;%底面圆半径ss
%     Phi_Y=atand(2);%椎体底角
%     Phi_Y=pi/2;%圆柱体
    e=zeros(180,180);
        for Ai=1:length(phi_Z)%确定层数
         zarc=phi_Z(Ai);%柱坐标下phi角
            for Zi=1:length(d_busbar)%母线上单元方向图的叠加
                d_z=d_busbar(Zi);%计算Zn
                en=(Ai-1)*4+Zi;
                ft=et(180*(en-1)+1:180*en,:);
                e=e+ft.*exp(1i*(pi/5.*(sind(theta).*cosd(phi-zarc).*(R)+d_z.*cosd(theta))));%方向图函数的复数域的叠加(matlab可以直接计算复数)
            end
        end
      F=abs(e)./max(max(abs(e)));%总体方向图函数归一化
end