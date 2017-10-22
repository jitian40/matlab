function [er,ur] = calc_material(num1,S11,S21)
%CALC_MATERAIL 此处显示有关此函数的摘要
%   此处显示详细说明
    d=10e-3;
    V1=S21+S11;
    V2=S21-S11;
    X=(1-V1.*V2)./(V1-V2);
    Ref=zeros(1,length(X));
    for num=1:length(X)
        Ref1=X(num)+sqrt(X(num)^2-1);
        Ref2=X(num)-sqrt(X(num)^2-1);
        if abs(Ref1)<1
            Ref(num)=Ref1;
        else
            Ref(num)=Ref2;   
        end
    end
    Ref=Ref';
    P=(V1-Ref)./(1-V1.*Ref);
    P_abs=abs(P);
    P_phase=zeros(1,length(P));
    for(num=1:length(P))
        if(real(P(num))>0&&imag(P(num))>0)
            P_phase(num)=acos(real(P(num))/P_abs(num));
        elseif(real(P(num))>0&&imag(P(num))<0)
            P_phase(num)=asin(imag(P(num))/P_abs(num));
        elseif(real(P(num))<0&&imag(P(num))>0)
            P_phase(num)=acos(real(P(num))/P_abs(num));
        else 
            P_phase(num)=-acos(real(P(num))/P_abs(num));      
        end
    end
    P_phase=P_phase';
    F=(1-Ref)./(1+Ref);
    n=0.06;
    K=(n-P_phase./2./pi)/d.*0.3./num+1j.*log(P_abs)/2/pi/d*0.3./num;
    er=K.*F;
    ur=K./F;
    
%     gamr=-1/0.535*log(T);
%     ur=-(1j*0.3./num1.*gamr).*(1+Ref)./(1-Ref)./sqrt(1-(40./num1).^2)/2/pi;
%     er=(-gamr.^2.*(0.3./num1./2/pi).^2+(40./num1).^2)./ur;
end

