DT=[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17];
% L=[5.67 7.68 7.27 8.23 7.92 9.66 11.18 11.62 9.18 11.47 11.41 10.03 8.66 8.35 6.53 7.20 6.66];%ԭʼ���� H=[1 0];%�۲ⷽ��ϵ��
H=[1 0];%�۲ⷽ��ϵ��
X0=[5.87;0];%��ʼ״̬������ֵ
D0=[1 0;0 1];%��ʼ״̬����Э������
dt=1;%�۲����
for i=1:17
XKk=[1 DT(i);0 1]*X0;
DKk=[1 DT(i);0 1]*D0*[1 DT(i);0 1]'
+[0.5*DT(i)^2;DT(i)]*[0.5*DT(i)^2;DT(i)]';%����һ��Ԥ��ֵ
J=DKk*H'*(H*DKk*H'+dt)^(-1);%�����������
X=XKk+J*(L(i)-H*XKk);%�˲� 
D=(1-J*H)*DKk;
jgXKk(:,i)=XKk;
jgJ(:,i)=J;
jgX(:,i)=X;
X0=X;
D0=D;
end
t=1:17;
plot(t,L,'r-*',t,jgX(1,:),'b--o')