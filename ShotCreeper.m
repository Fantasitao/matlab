
%Authored by Liu Zitao
%All rights reserved.
%The images were collected from Internet. The program is for non profit purpose.
%The use of this application and the content therein, is permitted to learning, non-commercial use.

%Advicer��zxc
%Partial code reference:Lianhan Guo

function  ShotCreeper
clc;clear;close all;
global human direction humanl alphahumanl humanr alphahumanr shot shotcountdown esc
creeperVector = []; % �����洢�����»�ͼ����(���½ǣ���Ϊ��ʾ�������洢��x��y
bulletVector = []; % �����洢�ӵ���ͼ����(���½ǣ���Ϊ��ʾ�������洢��x��y���˶�����
creeperPositionVector = [];% �����洢������������
bulletPositionVector = [];% �����洢�ӵ���������
creeperboomVector = [];% �����洢��ը����ʱ���е�creeper
 creeperboomCirle=[];%���汬ը����

 direction=1;%���ڷ����жϣ�0Ϊ������1Ϊ������
timer=0;%��ʱ�������ڼ�¼����creeper��ʱ�䣬1����0.1s
creeperSpeed=5;%�����ʼ�����µ��ƶ��ٶ�
shotcountdown=20;%��ʼ��װ������ʱ
r=300;%��ը�뾶
rectangleX=[0 0 1300 1300];%��ʼ�������������
rectangleY=[0 700 700 0];


creeperlimg = ['creeperl.jpg']; %��ȡͼƬ
humanlimg = ['humanl.jpg'];
humanrimg = ['humanr.jpg'];
hp1img=['hp1.jpg'];
hp2img=['hp2.jpg'];

[creeperl, alphacreeperl] = imageAlpha(creeperlimg);%����ͼƬ
[humanr, alphahumanr] = imageAlpha(humanrimg);
[humanl, alphahumanl] = imageAlpha(humanlimg);
[hp1, alphahp1] = imageAlpha(hp1img);
[hp2, alphahp2] = imageAlpha(hp2img);


h1=figure('KeyPressFcn', @stl_KeyPressFcn,'Position',[400 300 750 400]);%���Ʊ���
axis([0 600 0 300]); % ���峡���ߴ�

%����Ϊ������󻯴��룬��ش����������磬���·���Ȩ�����Լ�ԭ�����ӣ���ͬ
%��Ȩ����������ΪCSDN������Northan����ԭ�����£���ѭ CC 4.0 BY-SA ��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
%ԭ�����ӣ�https://blog.csdn.net/am290333566/java/article/details/84581313
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');	% �ر���صľ�����ʾ����Ϊ�����˷ǹ����ӿڣ�
jFrame = get(h1,'JavaFrame');	% ��ȡ�ײ� Java �ṹ��ؾ����
pause(0.1);					% �� Win 10��Matlab 2017b �����²���ͣ�ٻᱨ Java �ײ���󡣸��˸�����Ҫ���Խ���ʵ����֤
set(jFrame,'Maximized',1);	%���������Ϊ�棨0 Ϊ�٣�
pause(0.1);					% ����ʵ���з��������ͣ�٣����ڿ����������仯������ȡ�Ĵ��ڴ�С����ԭ���ĳߴ硣���˸�����Ҫ���Խ���ʵ����֤
warning('on','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');		% ����ؾ�������


startScreen = imread('��ʼ����.jpg');
image(0,0,startScreen);%���Ʊ���
hold on;


[y1,f1]=audioread('music1.mp3');%��ʼ��������
[y2,f2]=audioread('music2.mp3');%��Ϸ��������
[y3,f3]=audioread('gun1.wav');%��ǹ��Ч
%[y4,f4]=audioread('boom.mp3');%creeper��ը��Ч
[y5,f5]=audioread('shotdown.mp3');%creeper��������Ч
[y6,f6]=audioread('reload.mp3');%װ����Ч
[y7,f7]=audioread('count down.mp3');%creeper��ը�뵹��ʱ��Ч
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

h=figure('KeyPressFcn', @stl_KeyPressFcn,'Position',[400 300 750 400]);%���Ʊ���
axis([0 1300 0 700]); % ���峡���ߴ�

%����Ϊ������󻯴���
%��Ȩ����������ΪCSDN������Northan����ԭ�����£���ѭ CC 4.0 BY-SA ��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
%ԭ�����ӣ�https://blog.csdn.net/am290333566/java/article/details/84581313
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');	% �ر���صľ�����ʾ����Ϊ�����˷ǹ����ӿڣ�
jFrame = get(h,'JavaFrame');	% ��ȡ�ײ� Java �ṹ��ؾ����
pause(0.1);					% �� Win 10��Matlab 2017b �����²���ͣ�ٻᱨ Java �ײ���󡣸��˸�����Ҫ���Խ���ʵ����֤
set(jFrame,'Maximized',1);	%���������Ϊ�棨0 Ϊ�٣�
pause(0.1);					% ����ʵ���з��������ͣ�٣����ڿ����������仯������ȡ�Ĵ��ڴ�С����ԭ���ĳߴ硣���˸�����Ҫ���Խ���ʵ����֤
warning('on','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');		% ����ؾ�������

hold on
beijing=imread('����.png');%��ȡ����ͼƬ
image(0,0,beijing);%���Ʊ���
human=image(100,135,humanr); %���Ƴ�ʼ����
set(human, 'AlphaData',alphahumanr); %���ó�ʼ����͸����


hp=100;%��ʼ������ֵ
esc=0;%��ʼ��esc��
score=0;%��ʼ������
level=1;%��ʼ���ؿ�
hptimer1=100;%��ʼ����˫����hpֵ
hptimer2=100;

textHanle1 = text(55,90,"�ӵ�׼������ ",'Color','white','FontSize',20);%����������־��
textHanle2 = text(1100,650,"score�� " + num2str(score),'Color','white','FontSize',20);
textHanle3 = text(1100,610,"level�� " + num2str(level),'Color','white','FontSize',20);
textHanle4 = text(1100,570,"hp�� " + num2str(hp),'Color','white','FontSize',20);
%�˴���ʾhp������Ϣ�����½�Ѫ�����ظ����������Ժ�չʾʱʹ��

hpHandle(1)=image(55,50,hp1);%�˴�����Ѫ����ͼ����
hpHandle(2)=image(85,50,hp1);
hpHandle(3)=image(115,50,hp1);
hpHandle(4)=image(145,50,hp1);
hpHandle(5)=image(175,50,hp1);
hpHandle(6)=image(205,50,hp1);

set(hpHandle, 'AlphaData',alphahp1)%��Ѫ����Χ͸����

rectangleHandle=patch(rectangleX,rectangleY,'k','FaceAlpha',0);%��һ�������������͸���ȵľ��Σ�����������Ϊ��ȫ͸��

while 1
    if esc==1%��������
        clear sound;
        close;
        return ;  %������esc����������֣��رմ��ڣ�ȫ�ײ���
    end
    
    if mod(timer,5900)==0 && ~timer==0%ѭ��������������
        sound(y2,f2);%590s�������ֽ������˴�ʹ�����ظ�����
    end
    
    if score>=(5+level)*level%��������
        level=level+1;
        creeperSpeed=creeperSpeed+2;%ÿ��һ���ӿ�creeper���˶��ٶ�
    set(rectangleHandle,'FaceAlpha',0.5)
    textlevel=text(560,450,"��"+num2str(level)+"��",'Color','white','FontSize',40);%�ؿ���ʾ
    textlevel1=text(625,300,"3",'Color','white','FontSize',30);% textlevel1Ϊһ��3s�ĵ���ʱ
    pause(1)
    set(textlevel1,'string',"2");
    pause(1)
    set(textlevel1,'string',"1");
    pause(1)
    delete(textlevel)
    delete(textlevel1)
    set(rectangleHandle,'FaceAlpha',0)%���������ڵİ�͸����ɫ��������Ϊȫ͸��
    end
    
    if shotcountdown==0%���䵹��ʱ��ÿ3s������һ���ӵ�����������̺����Ŀո�������
        set(textHanle1,'String',"�ӵ�׼������" );
    else
        shotcountdown=shotcountdown-1;
        set(textHanle1,'String',"װ���У� " + num2str(0.1*shotcountdown) + " s");
    end
    if shotcountdown==21
        sound(y6,f6);%����װ����Ч
    end
        

    if mod(timer,50-4*level)==0%����һ��ʱ��ʱ�������µ�creeper�����Źؿ�������������������
        switch randi([1 4])%�����һ��Ϊcreeper�ĳ�ʼ��
            case 1%���
                nX=0;
                nY=rand*700;
            case 2%�ұ�
                nX=1300;
                nY=rand*700;
            case 3%�ϱ�
                nX=rand*1300;
                nY=700;
            case 4%�±�
                nX=rand*1300;
                nY=0;
        end
        creeperVector = [creeperVector;nX,nY];%����creeper������������
        creeperHandle(length(creeperVector(:,1)))=image(nX,nY,creeperl);%����creeper��ͼ�����þ��
        set(creeperHandle(length(creeperVector(:,1))), 'AlphaData',alphacreeperl);%�����ܱ�͸����
    end
    
    humanX = get(human,'XData');%��ȡ��ҵ�λ��
    humanY = get(human,'YData');
    
    if ~isempty(creeperVector)
        for i=1:length(creeperVector(:,1))
            %���´���Ϊ����creeper����ҵľ��벢�����ƶ����˶δ������±�д���ڿ�������creeper���ƶ��ٶ�
            deltal=sqrt((creeperVector(i,1)-humanX)^2+(creeperVector(i,2)-humanY)^2);%�������������ҵľ���
            deltat=deltal/creeperSpeed;%���������˶�ʱ��
            updateX=creeperVector(i,1)+(humanX-creeperVector(i,1))/deltat;
            updateY=creeperVector(i,2)+(humanY-creeperVector(i,2))/deltat;
            creeperVector(i,:)=[updateX,updateY];
            set(creeperHandle(i),'XData',creeperVector(i,1),'YData',creeperVector(i,2)); %����creeper��λ��
        end
       creeperPositionVector = [creeperVector(:,1)+63,creeperVector(:,2)+71.5]; %����creeper��λ�ã���������һ���µľ����
    end
    
    humanX = humanX+67.5;%��֮ǰ��ȡ�����λ�ý�������������Ϊ��������
    humanY = humanY+71.5;%�Ҳ������������������������ų��Ӷ�����Ļ�������ı���
   
    %�ֶ���ǹϵͳ
    stepLengthBullet = 20;
    upDownDistance = 2;
    if shot==1
        sound(y3,f3);%��ǹ��Ч
        initialDisplacement = (direction-0.5)*stepLengthBullet;
        bulletVector = [bulletVector; humanX, humanY, initialDisplacement, 1];
        bulletHandle(length(bulletVector(:,1)),1:3)=plot(humanX+initialDisplacement,humanY,'ro',...
           humanX+initialDisplacement,humanY + upDownDistance,'ro', ...
           humanX+initialDisplacement,humanY - upDownDistance,'ro','MarkerFaceColor',[1,1,0]);  
        shot=0;
        shotcountdown=30;%��ǹ��װ������ʱ����Ϊ30��0.1s
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
            
            % ���ӵ��ɳ�һ����Χ֮�������ռ�õĿռ䡣
            if tempBulletX>1300 || tempBulletX<0 % ���ӵ��ɳ����ں�
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
    
    % ����Ϊ�����ӵ�����creeper�Ĵ���
    hitThresholdx = 34;%����һ�����о���
    hitThresholdy = 66.7;%�������ǵ�creeper�Ǿ��Σ�����Ҫ������x y����ά�����ж��Ƿ����
    if ~isempty(creeperPositionVector) && ~isempty(bulletPositionVector)
        for j=1:length(bulletPositionVector(:,1))
            for i=1:length(creeperPositionVector(:,1)) % ���Ǽ������У����ţ��ӵ�����˵ľ���
                tempDist1x = abs(creeperPositionVector(i,1)-bulletPositionVector(j,1)) ;
                tempDist1y = abs(creeperPositionVector(i,2)-bulletPositionVector(j,2));
                tempDist2x = abs(creeperPositionVector(i,1)-bulletPositionVector(j,1));
                tempDist2y = abs(creeperPositionVector(i,2)-bulletPositionVector(j,3));
                tempDist3x = abs(creeperPositionVector(i,1)-bulletPositionVector(j,1));
                tempDist3y = abs(creeperPositionVector(i,2)-bulletPositionVector(j,4));
                
                % ���ĳ�����˾���ͬʱС��thresholdx��y����ô����������
                if (tempDist1x<hitThresholdx &&tempDist1y<hitThresholdy)||(tempDist2x<hitThresholdx ...,
                        &&tempDist2y<hitThresholdy)|| (tempDist3x<hitThresholdx && tempDist3y<hitThresholdy)
                   sound(y5,f5);%creeper��������Ч
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
    
    %creeper������ҵ����
%�˴�����ͬ����Ҫ��xy����ά�Ƚ��м���
contactThresholdx=(34+29)/2;%�Ӵ������ľ��뼫�޵ĺ�����
contactThresholdy=(66.7+70)/2;%�Ӵ������ľ��뼫�޵�������
%�������д��뱾Ӧ��������ʼ�ĵط�����Ϊ�˷���չʾ�������ڴ˴�
if ~isempty(creeperPositionVector)
     for i=1:length(creeperPositionVector(:,1))
        tempcontactDistx = abs(creeperPositionVector(i,1)-humanX) ;
        tempcontactDisty = abs(creeperPositionVector(i,2)-humanY);
        if(tempcontactDistx<contactThresholdx)&&(tempcontactDisty<contactThresholdy)%���ж�Ϊ�Ӵ�ʱ
            
             creeperboomVector=[creeperboomVector;creeperVector(i,:),20];
            %����һ��Ϊ���������е�creeper��һ����Ϊ��������xy���꣬������20Ϊ����ʱ,��λ0.1s
            creeperboomHandle(length(creeperboomVector(:,1)))=image(creeperVector(i,1),creeperVector(i,2),creeperl);
            set(creeperboomHandle(length(creeperboomVector(:,1))), 'AlphaData',alphacreeperl);
           %����Ϊ������ը�뾶Ϊ300��Բ
            theta=0:2*pi/3600:2*pi;%Բ�Ľ�
            Circle1=creeperPositionVector(i,1)+r*cos(theta);%Բ�ĺ�����
            Circle2=creeperPositionVector(i,2)+r*sin(theta);%Բ��������
            creeperboomCirle=[creeperboomCirle;creeperPositionVector(i,1),creeperPositionVector(i,2)];%���汬ըԲ������
            %cirleHandle(length(creeperboomCirle(:,1)))=plot(Circle1,Circle2,'r');
             cirlepatchHandle(length(creeperboomCirle(:,1)))=patch(Circle1,Circle2,'r','FaceAlpha',0.1);
           
             sound(y7,f7)%��������ʱ����ը��Ч
            creeperPositionVector(i,:) = [];
            delete(creeperHandle(i));
            creeperHandle(i) = [];
            creeperVector(i,:) = [];
            
            break;
        end
     end
end

if ~isempty(creeperboomVector)%�����±�ը����ʱ
    for i=1:length(creeperboomVector(:,1))
        boomtimer=creeperboomVector(i,3);
        switch boomtimer
            case 0%��ը����ʱΪ0ʱ����ը
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
               %sound(y4,f4);%��ը��Ч
                break;
            %���´���ͨ�����ÿ����µĿɼ����Դﵽ��˸��Ŀ��
            case {2,4,6,8,12,16,20}
                set(creeperboomHandle(i), 'Visible', 'off')%���⼸������ʱ�����ÿ����²��ɼ�
                creeperboomVector(i,3)=creeperboomVector(i,3)-1;%������ʱ��ȥ0.1s
            case {1,3,5,7,10,14,18}
                set(creeperboomHandle(i), 'Visible', 'on')%���⼸������ʱ�����ÿ����¿ɼ�
                creeperboomVector(i,3)=creeperboomVector(i,3)-1;%������ʱ��ȥ0.1s
           %ͨ����˸���������ã��ﵽԽ�챬ը��˸��Ƶ��Խ��
            otherwise
                 creeperboomVector(i,3)=creeperboomVector(i,3)-1;%������ʱ��ȥ0.1s
        end
    end
end             
    
    set(textHanle2,'String',"score�� " + num2str(score));%���µ÷֡��ȼ�����Ϣ
    set(textHanle3,'String',"level�� " + num2str(level));
    set(textHanle4,'String',"hp�� " + num2str(hp));
 
    %����ΪhpֵС��0ʱ������Ϸ��������
if hp<=0
      clear sound;
    clc
      close all;
      h2=figure('KeyPressFcn', @stl_KeyPressFcn,'Position',[400 300 750 400]);%���Ʊ���
      axis([0 500 0 300]); % ���峡���ߴ�
      
      %����Ϊ������󻯴���
%��Ȩ����������ΪCSDN������Northan����ԭ�����£���ѭ CC 4.0 BY-SA ��ȨЭ�飬ת���븽��ԭ�ĳ������Ӽ���������
%ԭ�����ӣ�https://blog.csdn.net/am290333566/java/article/details/84581313
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');	% �ر���صľ�����ʾ����Ϊ�����˷ǹ����ӿڣ�
jFrame = get(h2,'JavaFrame');	% ��ȡ�ײ� Java �ṹ��ؾ����
pause(0.1);					% �� Win 10��Matlab 2017b �����²���ͣ�ٻᱨ Java �ײ���󡣸��˸�����Ҫ���Խ���ʵ����֤
set(jFrame,'Maximized',1);	%���������Ϊ�棨0 Ϊ�٣�
pause(0.1);					% ����ʵ���з��������ͣ�٣����ڿ����������仯������ȡ�Ĵ��ڴ�С����ԭ���ĳߴ硣���˸�����Ҫ���Խ���ʵ����֤
warning('on','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');		% ����ؾ�������
      
      hold on
      go=imread('game over.jpg');%��ȡ����ͼƬ
      image(0,0,go);%���Ʊ���
      hold on;
      sound(y8,f8);
     text(260,100,"���յ÷�:" + num2str(score),'Color','white');
     text(260,80,"��ߵȼ�:" + num2str(level),'Color','white');
    begin=0;%�������ⰴ�����ɹر�game over���棬�˴����ÿ�ʼʱ��begin����
    while ~begin
        pause(0.1);
    end
close; 
clear sound;
        return ;  
end
    
    pause(0.1)%����ѭ����ÿѭ��һ����ͣ0.1s
timer=timer+1;%����ѭ����ÿѭ��һ�μ�ʱ����1��0.1s

%����Ϊһ��ʱ��Ļ�Ѫ����
if hp<100
    if mod(timer,100)==0%ÿ10s��Ѫ10��
    hp=hp+10;
    end
end
    
          %����Ϊ����Ѫ����Ϣ
          %hp1Ϊ��ɫѪ����hp2Ϊ��ɫѪ��
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
    switch true % ���ݲ�ͬ�ļ������룬����������Ϊ
        
        case strcmp(curKey, 'escape') %��Ϸ���κ��ջ�
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
                disp('�����ϱ߽�')      
            end
            
        case strcmp(curKey, 's')
            Y=get(human,'YData');
            if Y>=0
                disp('s');
                Y=get(human,'YData');
                Y=Y-10;
                set(human,'YData',Y); 
            else
                disp('�����±߽�');
            end
        
        case strcmp(curKey, 'space')
            %�ո��Ϊ��ǹ�������䵹��ʱΪ0ʱ��������
            if shotcountdown==0
                shot=1;
                disp('����');
            else
                disp('����ʧ�ܣ���ȴ�');
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
                disp('������߽�');
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
                disp('�����ұ߽�');
            end
    end
end


%ͼƬ������ This part original version author: Lianhan Guo
function [originalImage, originalAlpha] = imageAlpha(name)
    % ���������ͼ������
    % ���������ͼ�����ݣ�ͼ��͸���Ⱦ���
    for k = 1:size(name,1)
        originalImage=imread(name(k,:)); %����ͼ�����ƶ�ȡͼ��
        originalAlpha = ones(size(originalImage,1),size(originalImage,2)); % ���ȼ�������ͼ���ǲ�͸����
        for i = 1 : size(originalImage,1)
            for j = 1 :size(originalImage,2)
                % ��ͼ���ÿ�����ر���
                if originalImage(i,j,1) > 200 && originalImage(i,j,2) > 200 && originalImage(i,j,3) > 200 %����ж���Ҫ��Ϊ��ȥ��һЩ���Ǵ��׵Ĳ���
                    originalAlpha(i,j) = 0; % ��������������������������ô���λ�õ�͸���Ⱦ���0��Ҳ����͸����
                    % ��Ȼ����ж������кܴ��Ż��ռ�
                end
            end
        end
    end
end
end


