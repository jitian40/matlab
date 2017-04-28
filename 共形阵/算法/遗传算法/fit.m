
%适应度评价函数:改进的均方差评价函数
function fitness=fit(req_dirfun,rec_dirfun)
    variance=sum(sum((((req_dirfun-rec_dirfun)./req_dirfun).^2)/10000));
    covariance=sqrt(variance);
    fitness=1./(1+covariance^0.3);
end
