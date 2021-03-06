clear all;
clc;
%天线相关参数 
a=1:1:180;
b=2:2:360;
[theta,phi]=meshgrid(a,b);
trans_val=zeros(length(a),length(b));%一个过渡值存着最优个体
degree=[0,90,180,270];%单元分布角度
d_busbar=[0,8,16,24];%单元分布层数
R=20;%底面圆半径
bottom_corner=atand(2);%曲面底角
%定义拟合函数
% req_e=sin(4*pi.*cos(theta/180*pi))./sin(0.4*pi.*(cosd(theta)-1));
% req_e=cos(6*theta).*(theta<pi/12);
% req_fun=req_e./max(max(req_e));
%算法相关参数 
num=16;%天线单元数目
popsize=50;%种群个体数目
generations=500;%进化代数  
P_cross=0.8;%交叉概率,越大收敛越快  
P_variation=0.05;%变异概率
alpha=0.5;%适应度函数参数，越小变化越快
chromlength=7*num;%相位基因长度, 每个单元的相位用 7 位二进制数表示
I_chromlength=7*num;%激励幅度基因长度, 每个单元的相位用 7 位二进制数表示
pop=round(rand(popsize,chromlength));%随机产生初始化种群，popsize*chromlength
Ipop=round(rand(popsize,I_chromlength));
trans_phase=zeros(1,num);%一个过渡值存着最优个体对应的激励相位
trans_im=zeros(1,num);%一个过渡值存着最优个体对应的激励相位
fits=zeros(1,popsize);%定义种群适应度矩阵
gene=0;
%定义适应度初始值
fitness=0;
t=fitness;
et=unit_fun(theta,phi,degree,bottom_corner);  %获取每个位置单元贴片的全局方向图函数
while(gene<generations)
%将二进制基因转化为十进制基因
BB=bin_dec(popsize,num,pop);
BB1=bin_dec(popsize,num,Ipop);
I_im=roundn(BB1/(2^7-1),-2);
I_phi=roundn(BB*(2*pi/(2^7-1)),-2);%求出每个个体的激励相位
%适应度计算
for pop1=0:popsize-1
%     rec_fun=f(theta,phi,pop1+1,I_phi,et,I_im);%得到的方向图函数
    rec_fun=f(theta,phi,et,degree,d_busbar,R,bottom_corner,pop1+1,I_phi,I_im);%获取总的方向图函数
%     fitness=fit(req_fun,rec_fun);
    fitness=para(theta,rec_fun);
    fits(pop1+1)=fitness;
    if t<fitness %保留最优解
       t=fitness;
       trans_val=rec_fun;
       trans_phase=BB(pop1+1:pop1+1,:);
       trans_im=BB1(pop1+1:pop1+1,:);
    end
end
%选择算子
pop=Roulette(fits,pop);%生成新的种群
Ipop=Roulette(fits,Ipop);
%交叉与变异
pop=Cross(P_cross,pop);%交叉
Ipop=Cross(P_cross,Ipop);
pop=variate(P_variation,pop);%变异
Ipop=variate(P_variation,Ipop);
%交叉概率与变异概率的变化
P_cross=P_cross-0.4/generations;
P_variation=P_variation+0.4/generations;
%下一代
gene=gene+1;
end
%画图函数，具象化
    [x,y]=find(trans_val==1);
    [~,m]=min(abs(trans_val(x:x,1:y)-0.707));
    [~,n]=min(abs(trans_val(x:x,y:180)-0.707));
    BWhp=y-m+n;
    X=trans_val.*sind(theta).*cosd(phi);
    Y=trans_val.*sind(theta).*sind(phi);
    Z=trans_val.*cosd(theta);
    mesh(X,Y,Z);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    title({['主波瓣指向\theta=',num2str(y),'\circ',';半功率波瓣宽度BWhp=',num2str(BWhp),'\circ.']});
    









