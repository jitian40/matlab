%9阶多项式
x=linspace(-1,1);
y=1/128*(12155*x.^9-25740*x.^7+18018*x.^5-4620*x.^3+315*x);
plot(x,y,'r');
xlabel('X');
ylabel('Y');
title('9阶勒让德函数多项式');
new_fig_handle=shift_axis_to_origin(gca) ;