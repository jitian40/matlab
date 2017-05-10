%¶à·åÖµº¯Êý
x=linspace(-5,5);
y=linspace(-5,5);
[x1,y1]=meshgrid(x,y);
z=20+1.^2+y.^2-10*(cos(2*pi.*1)+cos(2*pi.*y));
z1=20+x1.^2+y1.^2-10*(cos(2*pi.*x1)+cos(2*pi.*y1));
plot(y,z);
new_fig_handle=shift_axis_to_origin(gca);
