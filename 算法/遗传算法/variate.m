%变异算子
function NewPop2=variate(Pv,pop)
        [px,py]=size(pop);
    for i=1:px        %px一般取偶数值
        if(rand<Pv)       %每次进行随机变异
            copoint=round(rand*(py-1));%随机确定变异点
            pop(i,copoint+1)=not(pop(i,copoint+1));%对变异点取非
        end
    end
    NewPop2=pop;
end