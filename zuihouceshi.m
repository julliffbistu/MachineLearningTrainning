   
 
a1=[-212.108 -175 -143.977 -112.903 -87.6842  -66.0714  -46.7822  -29.1667 -14.6667 1.62037 16.25 30.3125 42.913 54.7059 67.0833  78.3197 89.04 100.24 107.405 120.346 127.037 136.654 147.409 151.583 151.748 168.636];

A=a1';
t=1/30;
v=(A(4)-A(1))*0.001/(3*t);
for i=1:1:25
D(i)=A(i+1)-A(i);
end
for n=1:1:22
a(n)=(D(n+3)-D(n+2)+D(n+1)-D(n))*0.001/(4*t*t);
end
% a=A(5)-A(4)+A(3)-A(2)
for j=1:1:21
s(j)=(v*t+0.5*a(j)*t*t)*1000-212.108;
t=t+1/30
end

% for k=1:1:28
%     ens(k)=s(k+2)-175;
% end
% ens=s(
t=1:1:30
% plot(t,s,'*','-b')
figure;
hold on;
plot(a1(1,:),'-r');
% plot(s(1,:));
% for m=1:1:21
%     enns(m)=a1(1,1:m)
% end
beee=a1(1,1:21)
figure
% plot(s(1,:)-beee(1,:),'*')



