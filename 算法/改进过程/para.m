function D = para(theta,e)
%PARA 此处显示有关此函数的摘要
%   此处显示详细说明
    F=e.^2.*sind(theta);
    S=sum(sum(F')*pi/180)*pi/90;
    [x,y]=find(e==max(max(e)));
    if y>15&y<25
         D=4*pi/S;
    else
        D=1;
    end
    
%     [x,y]=max(max(e));
%     D=1/(20-D+2*(abs(x)+abs(y)));
end

