%总体方向图函数
function F=f(theta,phi,et,phi_Z,d_busbar,R,phase,pop,I_phi,I_im)%参数包含球坐标下theta角与phi角，激励相位的初始位置，激励相位数组
        e=zeros(180,180);
        IP=I_phi(pop:pop,:);
        IM=I_im(pop:pop,:);
        for Ai=1:length(phi_Z)%确定层数
         zarc=phi_Z(Ai);%柱坐标下phi角
            for Zi=1:length(d_busbar)%母线上单元方向图的叠加
                phi_i=IP(Ai*Zi:Ai*Zi);%单元激励相位
                I_i=IM(Ai*Zi:Ai*Zi);
                if(phase==90)
                    d_z=d_busbar(Zi);%计算Zn
                else
                    d_z=2*d_busbar(Zi)./sqrt(5);
                end
                en=(Ai-1)*4+Zi;
                ft=et(180*(en-1)+1:180*en,:);
                e=e+I_i*ft.*exp(1i*(2*pi/15.*(sind(theta).*cosd(phi-zarc).*(R-d_z*cosd(phase))+d_z.*cosd(theta))+phi_i));%方向图函数的复数域的叠加(matlab可以直接计算复数)s
%                 e=e+xchange(zarc,Phi_Y,theta,phi,phi_i,d_z,R);%方向图函数的复数域的叠加(matlab可以直接计算复数)
            end
        end
      F=abs(e)./max(max(abs(e)));%总体方向图函数归一化
end