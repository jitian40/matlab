%��������
% function NewPop1=Cross(Pc,pop)
%     [px,py]=size(pop);
%     newpops=zeros(px,py);
%     for i=1:2:px-1        %pxһ��ȡż��ֵ
%         if(rand<Pc)       %ÿ�ν����������
%             copoint=round(rand*py);%���ȷ�������
%             newpops(i,:)=[pop(i,1:copoint),pop(i+1,copoint+1:py)];
%             newpops(i+1,:)=[pop(i+1,1:copoint),pop(i,copoint+1:py)];
%         else
%             newpops(i,:)=pop(i,:);
%             newpops(i+1,:)=pop(i+1,:);
%         end
%     end
%     NewPop1=newpops;
% end
%��������
function NewPop1=Cross(Pc,pop)
    [px,py]=size(pop);
    newpops=zeros(px,py);
    for i=1:2:px-1        %pxһ��ȡż��ֵ
        if(rand<Pc)       %ÿ�ν����������
            copoint=round(rand*py);%���ȷ�������
%             T=pop(i,copoint+1:py);
            newpops(i,:)=[pop(i,1:copoint),pop(i+1,copoint+1:py)];
            newpops(i+1,:)=[pop(i+1,1:copoint),pop(i,copoint+1:py)];
        else
            newpops(i,:)=pop(i,:);
            newpops(i+1,:)=pop(i+1,:);
        end
    end
    NewPop1=newpops;
end