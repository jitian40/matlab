clear all;
clc;
%������ز���
a=pi/100:pi/100:pi;
b=pi/50:pi/50:2*pi;
[theta,phi]=meshgrid(a,b);
trans_val=zeros(100,100);%һ������ֵ�������Ÿ���
%������Ϻ���
req_e=sin(4*pi.*cos(theta))./sin(0.4*pi.*(cos(theta)-1));
req_fun=req_e./max(max(req_e));
%�㷨��ز���
num=16;%���ߵ�Ԫ��Ŀ
popsize=50;%��Ⱥ������Ŀ
generations=1000;%��������
P_cross=0.8;%�������,Խ������Խ��
P_variation=0.05;%�������
alpha=0.5;%��Ӧ�Ⱥ���������ԽС�仯Խ��
chromlength=7*num ;%���򳤶�, ÿ����Ԫ����λ�� 7 λ����������ʾ
pop=round(rand(popsize,chromlength));%���������ʼ����Ⱥ��popsize*chromlength
trans_phase=zeros(1,num);%һ������ֵ�������Ÿ����Ӧ�ļ�����λ
fits=zeros(1,popsize);%������Ⱥ��Ӧ�Ⱦ���
gene=0;
%������Ӧ�ȳ�ʼֵ
fitness=0;
t=fitness;
while(gene<generations)
%�������ƻ���ת��Ϊʮ���ƻ���
BB=bin_dec(popsize,num,pop);
I_phi=BB*(2*pi/(2^7-1));%���ÿ������ļ�����λ
%��Ӧ�ȼ���
for pop1=0:popsize-1
    rec_fun=f(theta,phi,pop1*num,I_phi);%�õ��ķ���ͼ����
    fitness=fit(req_fun,rec_fun);
    fits(pop1+1)=fitness;
    if t<fitness %�������Ž�
       t=fitness;
       trans_val=rec_fun;
       trans_phase=BB(pop1+1:pop1+1,:);
    end
end
%ѡ������
pop=Roulette(fits,pop);%�����µ���Ⱥ
%���������
pop=Cross(P_cross,pop);%����
pop=variate(P_variation,pop);%����
%��������������ʵı仯
P_cross=P_cross-0.4/generations;
P_variation=P_variation+0.4/generations;
%��һ��
gene=gene+1;
end
%��ͼ����������
    X=trans_val.*sin(theta).*cos(phi);
    Y=trans_val.*sin(theta).*sin(phi);
    Z=trans_val.*cos(theta);
    mesh(X,Y,Z);
    

%��Ӧ�����ۺ���:�Ľ��ľ��������ۺ���
function fitness=fit(req_dirfun,rec_dirfun)
    variance=sum(sum((((req_dirfun-rec_dirfun)./req_dirfun).^2)/10000));
    covariance=sqrt(variance);
    fitness=1./(1+covariance^0.3);
end
%���巽��ͼ����
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
%��ת����������׵�����ת����
function dirGrah=xchange(zarc,yarc,t,p,phi_i,zn,R)%��Ԫ���ߵ����нǶȣ���������Բ׶��ĵ׽ǣ���������theta����phi�ǣ�������λ����Ԫ��Z����ֵ��׵��ĵ���Բ�İ뾶
    Z_arc=zarc+pi;
    Y_arc=2*pi-yarc;
    %����Z����תZ_arc
    theta_1=t;
    phi_1=p-Z_arc;
    %����Y����תY_arc;
    theta_2=acos(cos(theta_1).*cos(Y_arc)-sin(theta_1).*cos(phi_1).*sin(Y_arc));%�仯���theta��
    Phi_2=atan((sin(theta_1).*sin(phi_1))./(cos(theta_1).*sin(Y_arc)+sin(theta_1).*cos(phi_1).*cos(Y_arc)));%�仯���phi��
    dirGrah=sin(5/2.*pi.*cos(theta_2))./(5*sin(pi/2.*cos(theta_2))).*exp(1i*(phi_i+2*pi/15.*(sin(t).*cos(p-zarc).*(R-zn/2)+zn.*cos(t))));
end

%����ת������
function BB=bin_dec(popsize,num,pop)
    %�������ƻ���ת��Ϊʮ������λ
    BB=zeros(popsize,num);%����һ��ȫΪ��ľ���
    for n=1:popsize
        for n1=1:num
            n3=0;
            for n2=(n1-1)*7+1:n1*7
                BB(n,n1)=BB(n,n1)+pop(n,n2)*2^n3;
                n3=n3+1;
            end
        end
    end
end


%���̶�ѡ�����ӣ������µ���Ⱥ
function NewPop=Roulette(fit,pop)
    fitvalue=fit./sum(fit);
    fitvalue1=cumsum(fitvalue);
    [px,py]=size(pop);
    newpop=zeros(px,py);
    rns=sort(rand(1,px));%���ת��px������
    fitin=1;
    newin=1;
    while newin<=px
         if(rns(newin)<fitvalue1(fitin))
             newpop(newin,:)=pop(fitin,:);%���ѡ�У������ø���
             newin=newin+1;
         else
             fitin=fitin+1;
         end
    end
    NewPop=newpop;
end

%��������
function NewPop1=Cross(Pc,pop)
    [px,py]=size(pop);
    newpops=zeros(px,py);
    for i=1:2:px-1        %pxһ��ȡż��ֵ
        if(rand<Pc)       %ÿ�ν����������
            copoint=round(rand*py);%���ȷ�������
            newpops(i,:)=[pop(i,1:copoint),pop(i+1,copoint+1:py)];
            newpops(i+1,:)=[pop(i+1,1:copoint),pop(i,copoint+1:py)];
        else
            newpops(i,:)=pop(i,:);
            newpops(i+1,:)=pop(i+1,:);
        end
    end
    NewPop1=newpops;
end
%��������
function NewPop2=variate(Pv,pop)
        [px,py]=size(pop);
    for i=1:px        %pxһ��ȡż��ֵ
        if(rand<Pv)       %ÿ�ν����������
            copoint=round(rand*(py-1));%���ȷ�������
            pop(i,copoint+1)=not(pop(i,copoint+1));%�Ա����ȡ��
        end
    end
    NewPop2=pop;
end
