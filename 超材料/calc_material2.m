function [er,ur] = calc_material2(num1,S11,S21)
%CALC_MATERIAL2 此处显示有关此函数的摘要
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
    lamda=0.3./num1;
    lam=0.1;
    T=(V1-Ref)./(1-V1.*Ref);
    K=-(1/2/pi/d.*log(1./T)).^2;
    ur=(1+Ref)./(1-Ref).*sqrt(K)./sqrt((1./lamda).^2-(1/lam).^2);
    er=lamda.^2.*(K+1/lam.^2)./ur;
end

