function NewPop= select(fit,pop)
%SELECT 此处显示有关此函数的摘要
%   此处显示详细说明
    fitvalue=fit./sum(fit);
    fitvalue1=cumsum(fitvalue);
    [px,py]=size(pop);
    newpop=zeros(px,py);
    rns=sort(rand(1,px));%随机转动px次轮盘
    fitin=1;
    newin=1;
    while newin<=px
         if(rns(newin)<fitvalue1(fitin))
             newpop(newin,:)=pop(fitin,:);%如果选中，保留该个体
             newin=newin+1;
         else
             fitin=fitin+1;
         end
    end
    NewPop=newpop;

end

