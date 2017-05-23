%进制转化函数
function BB=bin_dec(popsize,num,pop)
    %将二进制基因转化为十进制相位
    BB=zeros(popsize,num);%生成一个全为零的矩阵
    for n=1:popsize
        for n1=1:num
            n3=0;
            for n2=(n1-1)*4+1:n1*4
                BB(n,n1)=BB(n,n1)+pop(n,n2)*2^n3;
                n3=n3+1;
            end
        end
    end
end