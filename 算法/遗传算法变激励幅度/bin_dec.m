%����ת������
function BB=bin_dec(popsize,num,pop)
    %�������ƻ���ת��Ϊʮ������λ
    BB=zeros(popsize,num);%����һ��ȫΪ��ľ���
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