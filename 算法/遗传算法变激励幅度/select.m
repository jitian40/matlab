%自定义选择算子，取较差的个体与最优个体随机进行多点交叉生成新的个体替换原来较差的个体，较优的个体保持不变
function NewPop= select(fit,pop,rate)
%SELECT 此处显示有关此函数的摘要
%   此处显示详细说明
%     fitvalue=fit./sum(fit);
%     fitvalue1=cumsum(fitvalue);
    [px,py]=size(pop);
    newpop=zeros(px,py);
%     rns=sort(rand(1,px));%随机转动px次轮盘
    num=round(length(fit)*rate);
    trans=sort(fit);
    t=trans(num);
    [~,index]=max(fit);
    tan=reshape(pop(index,:),7,16);
    tans=tan';
    fitin=1;
    newin=1;
    while newin<=px
         if(fit(fitin)<t)
             copoint=round(rand*5)+1;%随机确定交叉点
             tant=reshape(pop(fitin,:),7,16);
             tant=tant';
             kt=[tans(:,1:copoint),tant(:,copoint+1:7)];%将其与最优个体多点交叉
             kt=reshape(kt',1,[]);
             newpop(newin,:)=kt;
         else
              newpop(newin,:)=pop(fitin,:);
         end
         newin=newin+1;
         fitin=fitin+1;
    end
    NewPop=newpop;

end

