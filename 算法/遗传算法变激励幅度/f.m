%���巽��ͼ����
function F=f(theta,phi,pop,I_phi,et)%����������������theta����phi�ǣ�������λ�ĳ�ʼλ�ã�������λ����
%     phi_Z=[0,pi/2,pi,3*pi/2];%��Ԫ�ֲ��Ƕ�
    phi_Z=[0,90,180,270];
    d_busbar=[0,15,30,45];
    R=40;%����Բ�뾶
%     Phi_Y=atand(2);%׵��׽�
    e=zeros(180,180);
        for Ai=1:length(phi_Z)%ȷ������
         zarc=phi_Z(Ai);%��������phi��
            for Zi=1:length(d_busbar)%ĸ���ϵ�Ԫ����ͼ�ĵ���
                phi_i=I_phi(pop:pop,Ai*Zi:Ai*Zi);%��Ԫ������λ
                d_z=2*d_busbar(Zi)./sqrt(5);%����Zn
                en=(Ai-1)*4+Zi;
                ft=et(180*(en-1)+1:180*en,:);
                e=e+phi_i*ft.*exp(1i*(2*pi/15.*(sind(theta).*cosd(phi-zarc).*(R-d_z/2)+d_z.*cosd(theta))));%����ͼ�����ĸ�����ĵ���(matlab����ֱ�Ӽ��㸴��)s
%                 e=e+xchange(zarc,Phi_Y,theta,phi,phi_i,d_z,R);%����ͼ�����ĸ�����ĵ���(matlab����ֱ�Ӽ��㸴��)
            end
        end
      F=abs(e)./max(max(abs(e)));%���巽��ͼ������һ��
end