a=[0.313
0.419
0.512
0.535
0.225
0.687
0.578
0.541]
sum=0.4233;

for i=1:1:8
en(i)=(a(i)-sum)^2
end
data=0
for i=1:1:8
   data=data+en(i);
   i=i+1
end

nu=sqrt(data)
