function et= unit_fun(theta,phi)
%UNIT_FUN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    phi_Z=[0,90,180,270];%��Ԫ�ֲ��Ƕ�
    d_busbar=[0,15,30,45];%��Ԫ�ֲ�����
%     R=40;%����Բ�뾶
%     Phi_Y=atand(2);%׵��׽�
    Phi_Y=90;%Բ����
    et=zeros(180*16,180);
        for Ai=1:length(phi_Z)%ȷ������
         zarc=phi_Z(Ai);%��������phi��
            for Zi=1:length(d_busbar)%ĸ���ϵ�Ԫ����ͼ�ĵ���
%                 d_z=2*d_busbar(Zi)./sqrt(5);%����Zn
                en=(Ai-1)*4+Zi;
                et(180*(en-1)+1:180*en,:)=xchange(zarc,Phi_Y,theta,phi);
            end
        end
end

