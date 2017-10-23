function et= unit_fun(theta,phi)
%UNIT_FUN 此处显示有关此函数的摘要
%   此处显示详细说明
    phi_Z=[0,90,180,270];%单元分布角度
    d_busbar=[0,15,30,45];%单元分布层数
%     R=40;%底面圆半径
%     Phi_Y=atand(2);%椎体底角
    Phi_Y=90;%圆柱体
    et=zeros(180*16,180);
        for Ai=1:length(phi_Z)%确定层数
         zarc=phi_Z(Ai);%柱坐标下phi角
            for Zi=1:length(d_busbar)%母线上单元方向图的叠加
%                 d_z=2*d_busbar(Zi)./sqrt(5);%计算Zn
                en=(Ai-1)*4+Zi;
                et(180*(en-1)+1:180*en,:)=xchange(zarc,Phi_Y,theta,phi);
            end
        end
end

