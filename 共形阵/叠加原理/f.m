%���巽��ͼ����
function F=f(theta,phi,et)%����������������theta����phi�ǣ�������λ�ĳ�ʼλ�ã�������λ����
    phi_Z=[0,90,180,270];%��Ԫ�ֲ��Ƕ�
    d_busbar=[0,8,16,24];%��Ԫ�ֲ�����
    R=20;%����Բ�뾶ss
%     Phi_Y=atand(2);%׵��׽�
%     Phi_Y=pi/2;%Բ����
    e=zeros(180,180);
        for Ai=1:length(phi_Z)%ȷ������
         zarc=phi_Z(Ai);%��������phi��
            for Zi=1:length(d_busbar)%ĸ���ϵ�Ԫ����ͼ�ĵ���
                d_z=d_busbar(Zi);%����Zn
                en=(Ai-1)*4+Zi;
                ft=et(180*(en-1)+1:180*en,:);
                e=e+ft.*exp(1i*(pi/5.*(sind(theta).*cosd(phi-zarc).*(R)+d_z.*cosd(theta))));%����ͼ�����ĸ�����ĵ���(matlab����ֱ�Ӽ��㸴��)
            end
        end
      F=abs(e)./max(max(abs(e)));%���巽��ͼ������һ��
end