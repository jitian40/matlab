%�Զ���ѡ�����ӣ�ȡ�ϲ�ĸ��������Ÿ���������ж�㽻�������µĸ����滻ԭ���ϲ�ĸ��壬���ŵĸ��屣�ֲ���
function NewPop= select(fit,pop,rate)
%SELECT �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
%     fitvalue=fit./sum(fit);
%     fitvalue1=cumsum(fitvalue);
    [px,py]=size(pop);
    newpop=zeros(px,py);
%     rns=sort(rand(1,px));%���ת��px������
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
             copoint=round(rand*5)+1;%���ȷ�������
             tant=reshape(pop(fitin,:),7,16);
             tant=tant';
             kt=[tans(:,1:copoint),tant(:,copoint+1:7)];%���������Ÿ����㽻��
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

