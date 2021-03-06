clear all    
    
% 初始化参数    
delta_t=1;   %采样时间    
t=0:delta_t:50;    
N = length(t); % 序列的长度    
sz = [2,N];    % 信号需开辟的内存空间大小  2行*N列  2:为状态向量的维数n    
g=0.76;          %加速度值   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
v=2.64
x=v*t+1/2*g*t.^2;      %实际真实位置    
z = x + sqrt(10).*randn(1,N); % 测量时加入测量白噪声    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
Q =[0 0;0 9e-1]; %假设建立的模型  噪声方差叠加在速度上 大小为n*n方阵 n=状态向量的维数    
R = 10;    % 位置测量方差估计，可以改变它来看不同效果  m*m      m=z(i)的维数    
    
A=[1 delta_t;0 1];  % n*n    
B=[1/2*delta_t^2;delta_t];    
H=[1,0];            % m*n    
    
n=size(Q);  %n为一个1*2的向量  Q为方阵    
m=size(R);    
    
% 分配空间    
xhat=zeros(sz);       % x的后验估计    
P=zeros(n);           % 后验方差估计  n*n    
xhatminus=zeros(sz);  % x的先验估计    
Pminus=zeros(n);      % n*n    
K=zeros(n(1),m(1));   % Kalman增益  n*m    
I=eye(n);    
    
% 估计的初始值都为默认的0，即P=[0 0;0 0],xhat=0    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%EKF过程  
for k = 5:N           %假设车子已经运动5个delta_T了，我们才开始估计    
    % 时间更新过程    
    xhatminus(:,k) = A*xhat(:,k-1)+B*g;    
    Pminus= A*P*A'+Q;    
        
    % 测量更新过程    
    K = Pminus*H'*inv( H*Pminus*H'+R );    
    xhat(:,k) = xhatminus(:,k)+K*(z(k)-H*xhatminus(:,k));    
    P = (I-K*H)*Pminus;    
end    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
figure(1)    
plot(t,z);    
hold on    
plot(t,xhat(1,:),'r-')    
plot(t,x(1,:),'g-');    
legend('含有噪声的测量', '后验估计', '真值');    
xlabel('Iteration');   
  
%% Estimate error(估计误差)  
x_error = x-xhat(1,:);  
  
%% Graph 2  
figure(2)   
plot(t,x_error(1,:)),grid on;  
title('位置误差')  
xlabel('时间 [sec]')  
ylabel('位置均方根误差 [m]')  
hold off;  
  
%% Graph 3  
figure(3)  
plot(t,xhat(2,:),'r'),grid on;  
title('实际速度 ')  
legend('实际速度')  
xlabel('时间 [sec]')  
ylabel('速度 [m/sec]')  
hold off;  