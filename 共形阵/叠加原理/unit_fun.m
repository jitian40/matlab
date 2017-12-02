function et= unit_fun(theta,phi,phi_Z,Phi_Y)
%UNIT_FUN 此处显示有关此函数的摘要
%   此处显示详细说明
    busbar_length=4;%母线上的单元数s
    et=zeros(180*16,180);
        for Ai=1:length(phi_Z)%确定层数
         zarc=phi_Z(Ai);%柱坐标下phi角
            for Zi=1:busbar_length%母线上单元方向图的叠加
                en=(Ai-1)*4+Zi;
                et(180*(en-1)+1:180*en,:)=xchange(zarc,Phi_Y,theta,phi);
            end
        end
end

