%���巽��ͼ����
function F=f(theta,phi,et,phi_Z,d_busbar,R,phase)%����������������theta����phi�ǣ�������λ�ĳ�ʼλ�ã�������λ����
        e=zeros(180,180);
        for Ai=1:length(phi_Z)%ȷ������
         zarc=phi_Z(Ai);%��������phi��
            for Zi=1:length(d_busbar)%ĸ���ϵ�Ԫ����ͼ�ĵ���
                if(phase==90)
                    d_z=d_busbar(Zi);%����Zn
                else
                    d_z=2*d_busbar(Zi)./sqrt(5);
                end
                en=(Ai-1)*4+Zi;
                ft=et(180*(en-1)+1:180*en,:);
                e=e+ft.*exp(1i*(pi/5.*(sind(theta).*cosd(phi-zarc).*(R-d_z*cosd(phase))+d_z.*cosd(theta))));%����ͼ�����ĸ�����ĵ���(matlab����ֱ�Ӽ��㸴��)
            end
        end
      F=abs(e)./max(max(abs(e)));%���巽��ͼ������һ��
end