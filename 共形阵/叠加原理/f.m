%���巽��ͼ����
function F=f(theta,phi)%����������������theta����phi�ǣ�������λ�ĳ�ʼλ�ã�������λ����
    phi_Z=[0,90,180,270];%��Ԫ�ֲ��Ƕ�
    d_busbar=[0,15,30,45];%��Ԫ�ֲ�����
    R=40;%����Բ�뾶
    Phi_Y=atand(2);%׵��׽�
%     Phi_Y=pi/2;%Բ����
    e=zeros(180,180);
        for Ai=1:length(phi_Z)%ȷ������
         zarc=phi_Z(Ai);%��������phi��
            for Zi=1:length(d_busbar)%ĸ���ϵ�Ԫ����ͼ�ĵ���
                d_z=2*d_busbar(Zi)./sqrt(5);%����Zn
                e=e+xchange(zarc,Phi_Y,theta,phi,d_z,R);%����ͼ�����ĸ�����ĵ���(matlab����ֱ�Ӽ��㸴��)
            end
        end
      F=abs(e)./max(max(abs(e)));%���巽��ͼ������һ��
end