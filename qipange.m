close all;
clear all;
clc;
width=9933  ;      %pattern�Ŀ�
height=7015 ;          %pattern�ĸ�
img_final=zeros(height,width);
reinforceconner=0       ;%�Ƿ��ǿ�ǵ� 
row=60;                 %pattern�����̸������
col=80 ;              %pattern�����̸������
length=113.4;           %pattern�����̸�Ĵ�С
org_X=(height-row*length)/2;        %pattern�������᷽���λ�ã�Ĭ�Ϸ����м�
org_Y=(width-col*length)/2;             %pattern���ں��᷽���λ�ã�Ĭ�Ϸ����м�
  color1=1;
     color2=color1;
img=zeros(row*length,col*length);
for i=0:(row-1)
    color2=color1;
    for j=0:(col-1)
        if color2==1
        img(i*length+1:(i+1)*length-1,j*length+1:(j+1)*length-1)=color2;
        end
        %���ӵĻ�������ע�͵�
        %
        color2=~color2;
    end
    color1=~color1;
end
img_final(org_X:org_X+row*length-1,org_Y:org_Y+col*length-1)=img;
   img_final=~img_final;
     figure;imshow(img_final);   
     imwrite(img_final, 'cheesBoard.bmp','bmp');