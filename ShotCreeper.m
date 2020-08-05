
%Authored by Liu Zitao
%All rights reserved.
%The images were collected from Internet. The program is for non profit purpose.
%The use of this application and the content therein, is permitted to learning, non-commercial use.

%Advicer：zxc
%Partial code reference:Lianhan Guo

function  ShotCreeper
clc;clear;close all;
global human direction humanl alphahumanl humanr alphahumanr shot shotcountdown esc
creeperVector = []; % 用来存储苦力怕绘图坐标(左下角），为简单示例，仅存储其x与y
bulletVector = []; % 用来存储子弹绘图坐标(左下角），为简单示例，仅存储其x，y与运动方向
creeperPositionVector = [];% 用来存储敌人中心坐标
bulletPositionVector = [];% 用来存储子弹中心坐标
creeperboomVector = [];% 用来存储爆炸倒计时当中的creeper
 creeperboomCirle=[];%储存爆炸中心

 direction=1;%用于方向判断，0为朝向左，1为朝向右
timer=0;%计时器，用于记录生成creeper的时间，1代表0.1s
creeperSpeed=5;%定义初始苦力怕的移动速度
shotcountdown=20;%初始化装弹倒计时
r=300;%爆炸半径
rectangleX=[0 0 1300 1300];%初始化升级界面矩形
rectangleY=[0 700 700 0];


creeperlimg = ['creeperl.jpg']; %读取图片
humanlimg = ['humanl.jpg'];
humanrimg = ['humanr.jpg'];
hp1img=['hp1.jpg'];
hp2img=['hp2.jpg'];

[creeperl, alphacreeperl] = imageAlpha(creeperlimg);%处理图片
[humanr, alphahumanr] = imageAlpha(humanrimg);
[humanl, alphahumanl] = imageAlpha(humanlimg);
[hp1, alphahp1] = imageAlpha(hp1img);
[hp2, alphahp2] = imageAlpha(hp2img);


h1=figure('KeyPressFcn', @stl_KeyPressFcn,'Position',[400 300 750 400]);%绘制背景
axis([0 600 0 300]); % 定义场景尺寸

%以下为窗口最大化代码，相关代码来自网络，见下方版权声明以及原文链接，下同
%版权声明：本文为CSDN博主「Northan」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
%原文链接：https://blog.csdn.net/am290333566/java/article/details/84581313
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');	% 关闭相关的警告提示（因为调用了非公开接口）
jFrame = get(h1,'JavaFrame');	% 获取底层 Java 结构相关句柄吧
pause(0.1);					% 在 Win 10，Matlab 2017b 环境下不加停顿会报 Java 底层错误。各人根据需要可以进行实验验证
set(jFrame,'Maximized',1);	%设置其最大化为真（0 为假）
pause(0.1);					% 个人实践中发现如果不停顿，窗口可能来不及变化，所获取的窗口大小还是原来的尺寸。各人根据需要可以进行实验验证
warning('on','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');		% 打开相关警告设置


startScreen = imread('开始界面.jpg');
image(0,0,startScreen);%绘制背景
hold on;


[y1,f1]=audioread('music1.mp3');%开始界面音乐
[y2,f2]=audioread('music2.mp3');%游戏背景音乐
[y3,f3]=audioread('gun1.wav');%开枪音效
%[y4,f4]=audioread('boom.mp3');%creeper爆炸音效
[y5,f5]=audioread('shotdown.mp3');%creeper被击中音效
[y6,f6]=audioread('reload.mp3');%装弹音效
[y7,f7]=audioread('count down.mp3');%creeper爆炸与倒计时音效
[y8,f8]=audioread('game over1.mp3');
sound(y1,f1);

begin = 0;
while ~begin
    pause(0.1);
end
close; 
clear sound;
sound(y2,f2);
hold on

h=figure('KeyPressFcn', @stl_KeyPressFcn,'Position',[400 300 750 400]);%绘制背景
axis([0 1300 0 700]); % 定义场景尺寸

%以下为窗口最大化代码
%版权声明：本文为CSDN博主「Northan」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
%原文链接：https://blog.csdn.net/am290333566/java/article/details/84581313
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');	% 关闭相关的警告提示（因为调用了非公开接口）
jFrame = get(h,'JavaFrame');	% 获取底层 Java 结构相关句柄吧
pause(0.1);					% 在 Win 10，Matlab 2017b 环境下不加停顿会报 Java 底层错误。各人根据需要可以进行实验验证
set(jFrame,'Maximized',1);	%设置其最大化为真（0 为假）
pause(0.1);					% 个人实践中发现如果不停顿，窗口可能来不及变化，所获取的窗口大小还是原来的尺寸。各人根据需要可以进行实验验证
warning('on','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');		% 打开相关警告设置

hold on
beijing=imread('背景.png');%读取背景图片
image(0,0,beijing);%绘制背景
human=image(100,135,humanr); %绘制初始人物
set(human, 'AlphaData',alphahumanr); %设置初始人物透明度


hp=100;%初始化生命值
esc=0;%初始化esc键
score=0;%初始化分数
level=1;%初始化关卡
hptimer1=100;%初始化单双数的hp值
hptimer2=100;

textHanle1 = text(55,90,"子弹准备就绪 ",'Color','white','FontSize',20);%设置相关文字句柄
textHanle2 = text(1100,650,"score： " + num2str(score),'Color','white','FontSize',20);
textHanle3 = text(1100,610,"level： " + num2str(level),'Color','white','FontSize',20);
textHanle4 = text(1100,570,"hp： " + num2str(hp),'Color','white','FontSize',20);
%此处显示hp文字信息与左下角血条相重复，仅作调试和展示时使用

hpHandle(1)=image(55,50,hp1);%此处设置血条的图像句柄
hpHandle(2)=image(85,50,hp1);
hpHandle(3)=image(115,50,hp1);
hpHandle(4)=image(145,50,hp1);
hpHandle(5)=image(175,50,hp1);
hpHandle(6)=image(205,50,hp1);

set(hpHandle, 'AlphaData',alphahp1)%将血条周围透明化

rectangleHandle=patch(rectangleX,rectangleY,'k','FaceAlpha',0);%画一个升级界面的有透明度的矩形，且先设置其为完全透明

while 1
    if esc==1%结束程序
        clear sound;
        close;
        return ;  %当按下esc键，清除音乐，关闭窗口，全套操作
    end
    
    if mod(timer,5900)==0 && ~timer==0%循环播放音乐设置
        sound(y2,f2);%590s过后音乐结束，此处使音乐重复播放
    end
    
    if score>=(5+level)*level%升级设置
        level=level+1;
        creeperSpeed=creeperSpeed+2;%每升一级加快creeper的运动速度
    set(rectangleHandle,'FaceAlpha',0.5)
    textlevel=text(560,450,"第"+num2str(level)+"关",'Color','white','FontSize',40);%关卡提示
    textlevel1=text(625,300,"3",'Color','white','FontSize',30);% textlevel1为一个3s的倒计时
    pause(1)
    set(textlevel1,'string',"2");
    pause(1)
    set(textlevel1,'string',"1");
    pause(1)
    delete(textlevel)
    delete(textlevel1)
    set(rectangleHandle,'FaceAlpha',0)%将升级窗口的半透明黑色矩形设置为全透明
    end
    
    if shotcountdown==0%发射倒计时，每3s允许发射一次子弹，与监听键盘函数的空格键相关联
        set(textHanle1,'String',"子弹准备就绪" );
    else
        shotcountdown=shotcountdown-1;
        set(textHanle1,'String',"装弹中： " + num2str(0.1*shotcountdown) + " s");
    end
    if shotcountdown==21
        sound(y6,f6);%播放装弹音效
    end
        

    if mod(timer,50-4*level)==0%当到一定时间时，生成新的creeper，随着关卡数升高生成速率增加
        switch randi([1 4])%随机定一边为creeper的初始边
            case 1%左边
                nX=0;
                nY=rand*700;
            case 2%右边
                nX=1300;
                nY=rand*700;
            case 3%上边
                nX=rand*1300;
                nY=700;
            case 4%下边
                nX=rand*1300;
                nY=0;
        end
        creeperVector = [creeperVector;nX,nY];%设置creeper的向量储存器
        creeperHandle(length(creeperVector(:,1)))=image(nX,nY,creeperl);%画出creeper的图像并设置句柄
        set(creeperHandle(length(creeperVector(:,1))), 'AlphaData',alphacreeperl);%将其周边透明化
    end
    
    humanX = get(human,'XData');%获取玩家的位置
    humanY = get(human,'YData');
    
    if ~isempty(creeperVector)
        for i=1:length(creeperVector(:,1))
            %以下代码为计算creeper和玩家的距离并将其移动，此段代码重新编写意在可以设置creeper的移动速度
            deltal=sqrt((creeperVector(i,1)-humanX)^2+(creeperVector(i,2)-humanY)^2);%计算苦力怕与玩家的距离
            deltat=deltal/creeperSpeed;%计算所需运动时间
            updateX=creeperVector(i,1)+(humanX-creeperVector(i,1))/deltat;
            updateY=creeperVector(i,2)+(humanY-creeperVector(i,2))/deltat;
            creeperVector(i,:)=[updateX,updateY];
            set(creeperHandle(i),'XData',creeperVector(i,1),'YData',creeperVector(i,2)); %更改creeper的位置
        end
       creeperPositionVector = [creeperVector(:,1)+63,creeperVector(:,2)+71.5]; %矫正creeper的位置，并储存至一个新的句柄中
    end
    
    humanX = humanX+67.5;%对之前获取的玩家位置进行修正，设置为中心坐标
    humanY = humanY+71.5;%我不会告诉你们这个数据是我拿着尺子对着屏幕量出来的比例
   
    %手动开枪系统
    stepLengthBullet = 20;
    upDownDistance = 2;
    if shot==1
        sound(y3,f3);%开枪音效
        initialDisplacement = (direction-0.5)*stepLengthBullet;
        bulletVector = [bulletVector; humanX, humanY, initialDisplacement, 1];
        bulletHandle(length(bulletVector(:,1)),1:3)=plot(humanX+initialDisplacement,humanY,'ro',...
           humanX+initialDisplacement,humanY + upDownDistance,'ro', ...
           humanX+initialDisplacement,humanY - upDownDistance,'ro','MarkerFaceColor',[1,1,0]);  
        shot=0;
        shotcountdown=30;%开枪后将装弹倒计时设置为30个0.1s
    end
        
    if ~isempty(bulletVector)
        for i=1:length(bulletVector(:,1))
            if i>length(bulletVector(:,1))
                break;
            end
            initialDisplacement = bulletVector(i,3);
            currentStep = bulletVector(i,4);
            tempBulletX = bulletVector(i,1) + (currentStep+1) * initialDisplacement;
            tempBulletY = bulletVector(i,2);
            
            bulletVector(i,4) = currentStep + 1;
            set(bulletHandle(i,1),'XData',tempBulletX,'YData',tempBulletY);  
            set(bulletHandle(i,2),'XData',tempBulletX,'YData',tempBulletY + upDownDistance*currentStep);  
            set(bulletHandle(i,3),'XData',tempBulletX,'YData',tempBulletY - upDownDistance*currentStep);    
            
            % 当子弹飞出一定范围之后，清空其占用的空间。
            if tempBulletX>1300 || tempBulletX<0 % 当子弹飞出窗口后
                bulletVector(i,:) = [];
                delete(bulletHandle(i,:));
                bulletHandle(i,:) = [];
            end
        end
        
        bulletPositionVector = [bulletVector(:,1)+bulletVector(:,4).*bulletVector(:,3),...
            bulletVector(:,2),...
            bulletVector(:,2)+upDownDistance*bulletVector(:,4),...
            bulletVector(:,2)-upDownDistance*bulletVector(:,4)];
    end
    
    % 以下为计算子弹击中creeper的代码
    hitThresholdx = 34;%定义一个击中距离
    hitThresholdy = 66.7;%由于我们的creeper是矩形，故需要单独从x y两个维度来判断是否击中
    if ~isempty(creeperPositionVector) && ~isempty(bulletPositionVector)
        for j=1:length(bulletPositionVector(:,1))
            for i=1:length(creeperPositionVector(:,1)) % 我们计算所有（三排）子弹与敌人的距离
                tempDist1x = abs(creeperPositionVector(i,1)-bulletPositionVector(j,1)) ;
                tempDist1y = abs(creeperPositionVector(i,2)-bulletPositionVector(j,2));
                tempDist2x = abs(creeperPositionVector(i,1)-bulletPositionVector(j,1));
                tempDist2y = abs(creeperPositionVector(i,2)-bulletPositionVector(j,3));
                tempDist3x = abs(creeperPositionVector(i,1)-bulletPositionVector(j,1));
                tempDist3y = abs(creeperPositionVector(i,2)-bulletPositionVector(j,4));
                
                % 如果某个敌人距离同时小于thresholdx和y，那么就算命中了
                if (tempDist1x<hitThresholdx &&tempDist1y<hitThresholdy)||(tempDist2x<hitThresholdx ...,
                        &&tempDist2y<hitThresholdy)|| (tempDist3x<hitThresholdx && tempDist3y<hitThresholdy)
                   sound(y5,f5);%creeper被击中音效
                    score=score+1;
                    creeperPositionVector(i,:) = [];
                    delete(creeperHandle(i));
                    creeperHandle(i) = [];
                    creeperVector(i,:) = [];
                    break;
                end
            end
        end
    end
    
    %creeper碰到玩家的情况
%此处我们同样需要从xy两个维度进行计算
contactThresholdx=(34+29)/2;%接触的中心距离极限的横坐标
contactThresholdy=(66.7+70)/2;%接触的中心距离极限的纵坐标
%以上两行代码本应移至程序开始的地方，但为了方便展示和理解放在此处
if ~isempty(creeperPositionVector)
     for i=1:length(creeperPositionVector(:,1))
        tempcontactDistx = abs(creeperPositionVector(i,1)-humanX) ;
        tempcontactDisty = abs(creeperPositionVector(i,2)-humanY);
        if(tempcontactDistx<contactThresholdx)&&(tempcontactDisty<contactThresholdy)%当判定为接触时
            
             creeperboomVector=[creeperboomVector;creeperVector(i,:),20];
            %上面一句为储存引爆中的creeper，一二列为储存作画xy坐标，第三列20为倒计时,单位0.1s
            creeperboomHandle(length(creeperboomVector(:,1)))=image(creeperVector(i,1),creeperVector(i,2),creeperl);
            set(creeperboomHandle(length(creeperboomVector(:,1))), 'AlphaData',alphacreeperl);
           %以下为做出爆炸半径为300的圆
            theta=0:2*pi/3600:2*pi;%圆心角
            Circle1=creeperPositionVector(i,1)+r*cos(theta);%圆的横坐标
            Circle2=creeperPositionVector(i,2)+r*sin(theta);%圆的纵坐标
            creeperboomCirle=[creeperboomCirle;creeperPositionVector(i,1),creeperPositionVector(i,2)];%储存爆炸圆心坐标
            %cirleHandle(length(creeperboomCirle(:,1)))=plot(Circle1,Circle2,'r');
             cirlepatchHandle(length(creeperboomCirle(:,1)))=patch(Circle1,Circle2,'r','FaceAlpha',0.1);
           
             sound(y7,f7)%触发倒计时及爆炸音效
            creeperPositionVector(i,:) = [];
            delete(creeperHandle(i));
            creeperHandle(i) = [];
            creeperVector(i,:) = [];
            
            break;
        end
     end
end

if ~isempty(creeperboomVector)%苦力怕爆炸倒计时
    for i=1:length(creeperboomVector(:,1))
        boomtimer=creeperboomVector(i,3);
        switch boomtimer
            case 0%爆炸倒计时为0时，爆炸
                 if( humanX- creeperboomCirle(i,1))^2+(humanY- creeperboomCirle(i,2))^2<=300^2
                     hp=hp-30;
                 end
                
                %delete(cirleHandle(i))
               %cirleHandle(i)=[];
               creeperboomCirle(i,:)= [];
             delete(cirlepatchHandle(i))
               cirlepatchHandle(i)=[];
               creeperboomVector(i,:)= [];
               delete(creeperboomHandle(i));
               creeperboomHandle(i) = [];
               %sound(y4,f4);%爆炸音效
                break;
            %以下代码通过设置苦力怕的可见性以达到闪烁的目的
            case {2,4,6,8,12,16,20}
                set(creeperboomHandle(i), 'Visible', 'off')%在这几个秒数时，设置苦力怕不可见
                creeperboomVector(i,3)=creeperboomVector(i,3)-1;%将倒计时减去0.1s
            case {1,3,5,7,10,14,18}
                set(creeperboomHandle(i), 'Visible', 'on')%在这几个秒数时，设置苦力怕可见
                creeperboomVector(i,3)=creeperboomVector(i,3)-1;%将倒计时减去0.1s
           %通过闪烁秒数的设置，达到越快爆炸闪烁的频率越高
            otherwise
                 creeperboomVector(i,3)=creeperboomVector(i,3)-1;%将倒计时减去0.1s
        end
    end
end             
    
    set(textHanle2,'String',"score： " + num2str(score));%更新得分、等级等信息
    set(textHanle3,'String',"level： " + num2str(level));
    set(textHanle4,'String',"hp： " + num2str(hp));
 
    %以下为hp值小于0时出现游戏结束画面
if hp<=0
      clear sound;
    clc
      close all;
      h2=figure('KeyPressFcn', @stl_KeyPressFcn,'Position',[400 300 750 400]);%绘制背景
      axis([0 500 0 300]); % 定义场景尺寸
      
      %以下为窗口最大化代码
%版权声明：本文为CSDN博主「Northan」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
%原文链接：https://blog.csdn.net/am290333566/java/article/details/84581313
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');	% 关闭相关的警告提示（因为调用了非公开接口）
jFrame = get(h2,'JavaFrame');	% 获取底层 Java 结构相关句柄吧
pause(0.1);					% 在 Win 10，Matlab 2017b 环境下不加停顿会报 Java 底层错误。各人根据需要可以进行实验验证
set(jFrame,'Maximized',1);	%设置其最大化为真（0 为假）
pause(0.1);					% 个人实践中发现如果不停顿，窗口可能来不及变化，所获取的窗口大小还是原来的尺寸。各人根据需要可以进行实验验证
warning('on','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');		% 打开相关警告设置
      
      hold on
      go=imread('game over.jpg');%读取背景图片
      image(0,0,go);%绘制背景
      hold on;
      sound(y8,f8);
     text(260,100,"最终得分:" + num2str(score),'Color','white');
     text(260,80,"最高等级:" + num2str(level),'Color','white');
    begin=0;%按下任意按键即可关闭game over界面，此处借用开始时的begin变量
    while ~begin
        pause(0.1);
    end
close; 
clear sound;
        return ;  
end
    
    pause(0.1)%正常循环中每循环一次暂停0.1s
timer=timer+1;%正常循环中每循环一次计时器加1个0.1s

%以下为一段时间的回血设置
if hp<100
    if mod(timer,100)==0%每10s回血10滴
    hp=hp+10;
    end
end
    
          %以下为更新血条信息
          %hp1为红色血条，hp2为灰色血条
      if hp<20
              delete(hpHandle)
              hpHandle(1)=image(55,30,hp1);
               hpHandle(2)=image(85,30,hp2);
               hpHandle(3)=image(115,30,hp2);
               hpHandle(4)=image(145,30,hp2);
               hpHandle(5)=image(175,30,hp2);
               hpHandle(6)=image(205,30,hp2);
          elseif hp>=20&&hp<40
              delete(hpHandle)
              hpHandle(1)=image(55,30,hp1);
               hpHandle(2)=image(85,30,hp1);
               hpHandle(3)=image(115,30,hp2);
               hpHandle(4)=image(145,30,hp2);
               hpHandle(5)=image(175,30,hp2);
               hpHandle(6)=image(205,30,hp2);
          elseif hp>=20&&hp<40
              delete(hpHandle)
              hpHandle(1)=image(55,30,hp1);
               hpHandle(2)=image(85,30,hp1);
               hpHandle(3)=image(115,30,hp2);
               hpHandle(4)=image(145,30,hp2);
               hpHandle(5)=image(175,30,hp2);
               hpHandle(6)=image(205,30,hp2);
              
          elseif hp>=40&&hp<60
              delete(hpHandle)
              hpHandle(1)=image(55,30,hp1);
               hpHandle(2)=image(85,30,hp1);
               hpHandle(3)=image(115,30,hp1);
               hpHandle(4)=image(145,30,hp2);
               hpHandle(5)=image(175,30,hp2);
               hpHandle(6)=image(205,30,hp2);
               
           elseif hp>=60&&hp<80
              delete(hpHandle)
              hpHandle(1)=image(55,30,hp1);
               hpHandle(2)=image(85,30,hp1);
               hpHandle(3)=image(115,30,hp1);
               hpHandle(4)=image(145,30,hp1);
               hpHandle(5)=image(175,30,hp2);
               hpHandle(6)=image(205,30,hp2);
               
            elseif hp>=80&&hp<100
              delete(hpHandle)
              hpHandle(1)=image(55,30,hp1);
               hpHandle(2)=image(85,30,hp1);
               hpHandle(3)=image(115,30,hp1);
               hpHandle(4)=image(145,30,hp1);
               hpHandle(5)=image(175,30,hp1);
               hpHandle(6)=image(205,30,hp2);
               
           elseif hp==100
              delete(hpHandle)
              hpHandle(1)=image(55,30,hp1);
               hpHandle(2)=image(85,30,hp1);
               hpHandle(3)=image(115,30,hp1);
               hpHandle(4)=image(145,30,hp1);
               hpHandle(5)=image(175,30,hp1);
               hpHandle(6)=image(205,30,hp1);
          end
          %end
      end
 
%end


%global shotcountdown shot  esc  human direction humanl alphahumanl humanr alphahumanr;
    function stl_KeyPressFcn(hObject, ~, ~)
    
    curKey = get(hObject, 'CurrentKey');
    if begin==0
        begin=1;
        return
    end
    switch true % 根据不同的键盘输入，决定具体行为
        
        case strcmp(curKey, 'escape') %游戏中任何收获
            esc=1;
            disp('esc'); 
       
        case strcmp(curKey, 'w')
            Y=get(human,'YData');
            if Y+143<=700
                disp('w');
                Y=get(human,'YData');
                Y=Y+10;
                set(human,'YData',Y); 
            else
                disp('超出上边界')      
            end
            
        case strcmp(curKey, 's')
            Y=get(human,'YData');
            if Y>=0
                disp('s');
                Y=get(human,'YData');
                Y=Y-10;
                set(human,'YData',Y); 
            else
                disp('超出下边界');
            end
        
        case strcmp(curKey, 'space')
            %空格键为开枪，当发射倒计时为0时才允许发射
            if shotcountdown==0
                shot=1;
                disp('发射');
            else
                disp('发射失败，请等待');
            end
        
        case strcmp(curKey, 'a')
            disp('a');
            Y=get(human,'YData');
            X=get(human,'XData');
            if X>=0
                if direction==0
                    X=X-10;
                    set(human,'XData',X);
                else
                    delete(human);
                    human=image(X,Y,humanl); 
                    set(human, 'AlphaData',alphahumanl);
                    direction=0;
                end
            else
                disp('超出左边界');
            end
            
        case strcmp(curKey, 'd')
            disp('d');
            Y=get(human,'YData');
            X=get(human,'XData');
            if X+135<=1300
                if direction==1
                    X=X+10;
                    set(human,'XData',X);
                else
                    delete(human);
                    human=image(X,Y,humanr); 
                    set(human, 'AlphaData',alphahumanr);
                    direction=1;
                end
            else
                disp('超出右边界');
            end
    end
end


%图片处理函数 This part original version author: Lianhan Guo
function [originalImage, originalAlpha] = imageAlpha(name)
    % 输入参数，图像名称
    % 输出参数，图像数据，图像透明度矩阵
    for k = 1:size(name,1)
        originalImage=imread(name(k,:)); %根据图像名称读取图像
        originalAlpha = ones(size(originalImage,1),size(originalImage,2)); % 首先假设整个图像都是不透明的
        for i = 1 : size(originalImage,1)
            for j = 1 :size(originalImage,2)
                % 对图像的每个像素遍历
                if originalImage(i,j,1) > 200 && originalImage(i,j,2) > 200 && originalImage(i,j,3) > 200 %这个判断主要是为了去掉一些不是纯白的部分
                    originalAlpha(i,j) = 0; % 如果这个像素满足以上条件，那么这个位置的透明度就是0，也就是透明的
                    % 显然这个判定方法有很大优化空间
                end
            end
        end
    end
end
end


