%���巽��ͼ����
function F=f(theta,phi,et,phi_Z,d_busbar,R,phase,pop,I_phi,I_im)%����������������theta����phi�ǣ�������λ�ĳ�ʼλ�ã�������λ����
        e=zeros(180,180);
        IP=I_phi(pop:pop,:);
        IM=I_im(pop:pop,:);
        for Ai=1:length(phi_Z)%ȷ������
         zarc=phi_Z(Ai);%��������phi��
            for Zi=1:length(d_busbar)%ĸ���ϵ�Ԫ����ͼ�ĵ���
                phi_i=IP(Ai*Zi:Ai*Zi);%��Ԫ������λ
                I_i=IM(Ai*Zi:Ai*Zi);
                if(phase==90)
                    d_z=d_busbar(Zi);%����Zn
                else
                    d_z=2*d_busbar(Zi)./sqrt(5);
                end
                en=(Ai-1)*4+Zi;
                ft=et(180*(en-1)+1:180*en,:);
                e=e+I_i*ft.*exp(1i*(2*pi/15.*(sind(theta).*cosd(phi-zarc).*(R-d_z*cosd(phase))+d_z.*cosd(theta))+phi_i));%����ͼ�����ĸ�����ĵ���(matlab����ֱ�Ӽ��㸴��)s
%                 e=e+xchange(zarc,Phi_Y,theta,phi,phi_i,d_z,R);%����ͼ�����ĸ�����ĵ���(matlab����ֱ�Ӽ��㸴��)
            end
        end
      F=abs(e)./max(max(abs(e)));%���巽��ͼ������һ��
end