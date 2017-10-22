function F = f( theta,phi,I_phi,I_im,et )
%F 此处显示有关此函数的摘要
%   此处显示详细说明
    %     phi_Z=[0,pi/2,pi,3*pi/2];%单元分布角度
    phi_Z=[0,90,180,270];
    d_busbar=[0,15,30,45];
    R=40;%底面圆半径
%   Phi_Y=atand(2);%椎体底角
    e=zeros(180,180);
        for Ai=1:length(phi_Z)%确定层数
         zarc=phi_Z(Ai);%柱坐标下phi角
            for Zi=1:length(d_busbar)%母线上单元方向图的叠加
                phi_i=I_phi(Ai*Zi:Ai*Zi);%单元激励相位
                I_i=I_im(Ai*Zi:Ai*Zi);
                d_z=2*d_busbar(Zi)./sqrt(5);%计算Zn
                en=(Ai-1)*4+Zi;
                ft=et(180*(en-1)+1:180*en,:);
                e=e+I_i*ft.*exp(1i*(2*pi/15.*(sind(theta).*cosd(phi-zarc).*(R-d_z/2)+d_z.*cosd(theta))+phi_i+pi/2));%方向图函数的复数域的叠加(matlab可以直接计算复数)s
%                 e=e+xchange(zarc,Phi_Y,theta,phi,phi_i,d_z,R);%方向图函数的复数域的叠加(matlab可以直接计算复数)
            end
        end
      F=abs(e)./max(max(abs(e)));%总体方向图函数归一化
end

