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