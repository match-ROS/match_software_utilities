%% Kubischer Spline durch Punkte
% Die Vorgabe der Punkte erfolgt über "/clicked_pose" in rviz

%% config
v_max = 0.5; % Maximalgeschwindigkeit in m/sek 
freq = 100; % Frequenz der Interpolation - muss mit ROS Einstellungen übereinsstimmen

%% Main

T = 1:length(x_pose);

t = 0:0.001:T(end);

tx = csaps(T,x_pose);
ty = csaps(T,y_pose);

xx = ppval(tx,t);
yy = ppval(ty,t);

v = (sqrt(diff(xx).^2+diff(yy).^2));  
s_ges = sum(v);  % Gesamtlänge der Strecke
t_ges = s_ges / v_max;

%% Interpolation auf Zielgeschwindigkeit anpassen
t_new = 1:(T(end)-1)/(t_ges*freq):T(end);

xx = ppval(tx,t_new);
yy = ppval(ty,t_new);

hold all
plot(x_pose,y_pose,'o')
plot(xx,yy)


%% 
phi = [];

for i = 1:length(xx)-1
    phi(i) = atan2(yy(i+1)-yy(i),xx(i+1)-xx(i));
end
phi = [phi(1),phi];

M = [xx;yy;phi;[0,diff(xx)];[0,diff(yy)];[0,diff(phi)]];

filename = 'SplineTest.csv';
csvwrite(filename,transpose(M))
