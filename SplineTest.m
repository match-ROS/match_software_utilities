% P1 = [];
% P2 = [];
% P3 = [];
% P4 = [];
% P5 = [];
% P6 = [];

Center = [24.72 12.51];

P1 = Center + [-2.9 1.37];
P2 = Center + [-0.9 1.4];
P3 = Center + [1.31 1.37];
P4 = Center + [3.6 0.58];
P5 = Center + [2.68 -0.6];
P6 = Center + [0.19 -1.2];

T = [0;1;2;3;4;5];

t = 0:0.001:5;

x = [P1(1);P2(1);P3(1);P4(1);P5(1);P6(1)];
y = [P1(2);P2(2);P3(2);P4(2);P5(2);P6(2)];

p = 0.0009;

values = csaps(T,x,p,t);
tx = csaps(T,x);
ty = csaps(T,y);

xx = ppval(tx,t);
yy = ppval(ty,t);



%fnplt(ty)
hold all
%plot(t,yy)
plot(x,y)
plot(xx,yy)
%plot(0,P1(1),'o')

for i = 1:length(xx)-1
    phi(i) = atan2(yy(i+1)-yy(i),xx(i+1)-xx(i));
end
phi = [phi(1),phi];
%plot(diff(phi))

M = [xx;yy;phi;[0,diff(xx)];[0,diff(yy)];[0,diff(phi)]];

filename = 'SplineTest.csv';
csvwrite(filename,transpose(M))
