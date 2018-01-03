clear all    
    
% ��ʼ������    
delta_t=1;   %����ʱ��    
t=0:delta_t:50;    
N = length(t); % ���еĳ���    
sz = [2,N];    % �ź��迪�ٵ��ڴ�ռ��С  2��*N��  2:Ϊ״̬������ά��n    
g=0.76;          %���ٶ�ֵ   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
v=2.64
x=v*t+1/2*g*t.^2;      %ʵ����ʵλ��    
z = x + sqrt(10).*randn(1,N); % ����ʱ�������������    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
Q =[0 0;0 9e-1]; %���轨����ģ��  ��������������ٶ��� ��СΪn*n���� n=״̬������ά��    
R = 10;    % λ�ò���������ƣ����Ըı���������ͬЧ��  m*m      m=z(i)��ά��    
    
A=[1 delta_t;0 1];  % n*n    
B=[1/2*delta_t^2;delta_t];    
H=[1,0];            % m*n    
    
n=size(Q);  %nΪһ��1*2������  QΪ����    
m=size(R);    
    
% ����ռ�    
xhat=zeros(sz);       % x�ĺ������    
P=zeros(n);           % ���鷽�����  n*n    
xhatminus=zeros(sz);  % x���������    
Pminus=zeros(n);      % n*n    
K=zeros(n(1),m(1));   % Kalman����  n*m    
I=eye(n);    
    
% ���Ƶĳ�ʼֵ��ΪĬ�ϵ�0����P=[0 0;0 0],xhat=0    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%EKF����  
for k = 5:N           %���賵���Ѿ��˶�5��delta_T�ˣ����ǲſ�ʼ����    
    % ʱ����¹���    
    xhatminus(:,k) = A*xhat(:,k-1)+B*g;    
    Pminus= A*P*A'+Q;    
        
    % �������¹���    
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
legend('���������Ĳ���', '�������', '��ֵ');    
xlabel('Iteration');   
  
%% Estimate error(�������)  
x_error = x-xhat(1,:);  
  
%% Graph 2  
figure(2)   
plot(t,x_error(1,:)),grid on;  
title('λ�����')  
xlabel('ʱ�� [sec]')  
ylabel('λ�þ�������� [m]')  
hold off;  
  
%% Graph 3  
figure(3)  
plot(t,xhat(2,:),'r'),grid on;  
title('ʵ���ٶ� ')  
legend('ʵ���ٶ�')  
xlabel('ʱ�� [sec]')  
ylabel('�ٶ� [m/sec]')  
hold off;  