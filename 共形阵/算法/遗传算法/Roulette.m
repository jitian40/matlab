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