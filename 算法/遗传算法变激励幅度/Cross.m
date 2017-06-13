%交叉算子
% function NewPop1=Cross(Pc,pop)
%     [px,py]=size(pop);
%     newpops=zeros(px,py);
%     for i=1:2:px-1        %px一般取偶数值
%         if(rand<Pc)       %每次进行随机交叉
%             copoint=round(rand*py);%随机确定交叉点
%             newpops(i,:)=[pop(i,1:copoint),pop(i+1,copoint+1:py)];
%             newpops(i+1,:)=[pop(i+1,1:copoint),pop(i,copoint+1:py)];
%         else
%             newpops(i,:)=pop(i,:);
%             newpops(i+1,:)=pop(i+1,:);
%         end
%     end
%     NewPop1=newpops;
% end
%交叉算子
function NewPop1=Cross(Pc,pop)
    [px,py]=size(pop);
    newpops=zeros(px,py);
    for i=1:2:px-1        %px一般取偶数值
        if(rand<Pc)       %每次进行随机交叉
            copoint=round(rand*py);%随机确定交叉点
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