clear all;
clc;
num=16;%���ߵ�Ԫ��Ŀ
popsize=4;%��Ⱥ������Ŀ
chromlength=7*num ;%���򳤶�, ÿ����Ԫ����λ�� 7 λ����������ʾ
pop=round(rand(popsize,chromlength));%���������ʼ����Ⱥ��popsize*chromlength
BB=zeros(popsize,num);%����һ��300*18��ȫΪ��ľ���
for n=1:popsize-1
    for n1=1:num
        n3=0;
        for n2=(n1-1)*7+1:n1*7
            BB(n,n1)=BB(n,n1)+pop(n,n2)*2^n3;
            n3=n3+1;
        end
    end
end
I_phi=BB*(2*pi/(2^7-1));%���ÿ������ļ�����λ

Theta=linspace(0,pi);%��Z������ļн�
Phi=linspace(0,2*pi);%ͶӰ��
[theta,phi]=meshgrid(Theta,Phi);
for pop1=0:popsize-1
    e=f(theta,phi,pop1*num,I_phi);
    ans=sum(sum(e.^2));
    X=e.*sin(theta).*cos(phi);
    Y=e.*sin(theta).*sin(phi);
    Z=e.*cos(theta);
    subplot(2,2,pop1+1);
    mesh(X,Y,Z);
    axis equal;
end
%e1=e1+xchange(phi_Z,Phi_Y,theta,phi);

function F=f(theta,phi,pop_num,I_phi)%����������������theta����phi�ǣ�������λ�ĳ�ʼλ�ã�������λ����
    phi_Z=[0,pi/2,pi,3*pi/2];%��Ԫ�ֲ��Ƕ�
    d_busbar=[0,15,30,45];
    R=40;%����Բ�뾶
    Phi_Y=atan(2);%׵��׽�
    e=zeros(100,100);
        for Ai=1:length(phi_Z)%ȷ������
         zarc=phi_Z(Ai);%��������phi��
            for Zi=1:length(d_busbar)%ĸ���ϵ�Ԫ����ͼ�ĵ���
                phi_i=I_phi(pop_num+Ai*Zi);%��Ԫ������λ
                d_z=2*d_busbar(Zi)./sqrt(5);%����Zn
                e=e+xchange(zarc,Phi_Y,theta,phi,phi_i,d_z,R);%����ͼ�����ĸ�����ĵ���(matlab����ֱ�Ӽ��㸴��)
            end
        end
      F=abs(e)./max(max(abs(e)));%���巽��ͼ������һ��
end
%��ת����
function dirGrah=xchange(zarc,yarc,t,p,phi_i,zn,R)
    Z_arc=zarc+pi;
    Y_arc=2*pi-yarc;
    %����Z����תZ_arc
    theta_1=t;
    phi_1=p-Z_arc;
    %����Y����תY_arc;
    theta_2=acos(cos(theta_1).*cos(Y_arc)-sin(theta_1).*cos(phi_1).*sin(Y_arc));
    Phi_2=atan((sin(theta_1).*sin(phi_1))./(cos(theta_1).*sin(Y_arc)+sin(theta_1).*cos(phi_1).*cos(Y_arc)));
    dirGrah=cos(pi/2.*cos(theta_2))./sin(theta_2).*exp(j*(phi_i-2*pi/15.*(sin(t).*cos(p-zarc).*(R-zn/2)+zn.*cos(t))));
end




