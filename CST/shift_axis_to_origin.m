function new_fig_handle = shift_axis_to_origin( fig_handle )
% ������Ŀ���ǰ� matlab ����ͼ�������Ƶ�ͼ�ε��м䲿��ȥ(����ѧ����ͼϰ��һ��)
% 2008.10.10 in pku
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure('Name','shift_axis_to_origin','NumberTitle','off')                         % Create a new figure
% ����ͼ�ε�һ���µĴ���
new_fig_handle = copyobj( fig_handle , gcf );
xL=xlim ;
yL=ylim ;
zL=zlim ;
xt=get(gca,'xtick') ;
yt=get(gca,'ytick') ;
zt=get(gca,'ztick') ;
set(gca,'XTick',[],'XColor','w') ;
set(gca,'YTick',[],'YColor','w') ;
set(gca,'ZTick',[],'ZColor','w') ;
% �� x �� y �����������������ӳ� 10% ��Ϊ���Ӿ��Ϻÿ���
extend_x = ( xL(2)-xL(1) ) * 0.1 ;
extend_y = ( yL(2)-yL(1) ) * 0.1 ;
extend_z = ( zL(2)-zL(1) ) * 0.1 ;
xxL = xL + [ -extend_x extend_x] ;
yyL = yL + [ -extend_y extend_y] ;
zzL = zL + [ -extend_z extend_z] ;
set(gca,'xlim', xxL) ;
set(gca,'ylim', yyL) ;
set(gca,'zlim', zzL) ;
pos = get(gca,'Position') ;
box off;
x_shift = abs( yyL(1)/(yyL(2)-yyL(1)) ) ;
y_shift = abs( xxL(1)/(xxL(2)-xxL(1)) ) ;
z_shift = abs( zzL(1)/(zzL(2)-zzL(1)) ) ;
temp_1 = axes( 'Position', pos + [ 0 , pos(4) * x_shift , 0 , - pos(4)* x_shift*0.99999 ] ) ;
xlim(xxL) ;
box off ;
set(temp_1,'XTick',xt,'Color','None','YTick',[]) ;
set(temp_1,'YColor','w') ;
temp_2 = axes( 'Position', pos + [ pos(3) * y_shift , 0 , -pos(3)* y_shift*0.99999 , 0 ] ) ;
ylim(yyL) ;
box off ;
set(temp_2,'YTick',yt,'Color','None','XTick',[]) ;
set(temp_2,'XColor','w') ;
Base_pos = get(new_fig_handle,'Position') ;
arrow_pos_in_x_dircetion = Base_pos(2) - Base_pos(4) * yyL(1)/(yyL(2)-yyL(1)) ;
arrow_pos_in_y_dircetion = Base_pos(1) - Base_pos(3) * xxL(1)/(xxL(2)-xxL(1)) ;
annotation('arrow',[Base_pos(1) , Base_pos(1)+Base_pos(3)] , [arrow_pos_in_x_dircetion , arrow_pos_in_x_dircetion ] , 'Color','k');
annotation('arrow',[arrow_pos_in_y_dircetion , arrow_pos_in_y_dircetion ] , [Base_pos(2) , Base_pos(2)+Base_pos(4)] , 'Color','k');
end