function et= unit_fun(theta,phi,phi_Z,Phi_Y)
%UNIT_FUN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    busbar_length=4;%ĸ���ϵĵ�Ԫ��s
    et=zeros(180*16,180);
        for Ai=1:length(phi_Z)%ȷ������
         zarc=phi_Z(Ai);%��������phi��
            for Zi=1:busbar_length%ĸ���ϵ�Ԫ����ͼ�ĵ���
                en=(Ai-1)*4+Zi;
                et(180*(en-1)+1:180*en,:)=xchange(zarc,Phi_Y,theta,phi);
            end
        end
end

