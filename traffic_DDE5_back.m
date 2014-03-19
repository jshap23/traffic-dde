% Delay Traffic Model DDE
% Josh Shapiro


t0 = 0;   % initial time
tf = 1; % final time in days
timerange = linspace(t0, tf, 50);

tau = 1; % time delay

%Parameters
alpha  = 6; %sitivity coefficient
v0 = 50; % target speed, corresponding to high free-flow speed of drivers
L = 4*pi;  % length of track

parlist = [alpha, v0, L];


% Initial Conditions
v1o = 7;
v2o = 5;
v3o = 1;
v4o = 15;
v5o = 15;
h1o = L/5;
h2o = L/5;
h3o = L/5;
h4o = L/5;
h5o = L - h4o - h3o - h2o - h1o;
x1o = 10;
x2o = x1o + h1o;
x3o = x2o + h2o;
x4o = x3o + h3o;
x5o = x4o + h4o;

% Steady State Initial values 
%v1o = 10;
%h1o = L/2;
%v1o = v0*(h1o-1)^3/(1+(h1o-1)^3);
%v2o = v1o; 
%x1o = 0;
%x2o = x1o + h1o;
% y0 = [v1o,  v2o,  h1o, x1o, x2o]; 


%Call ODE solver
% [tout,yout] = dde23(@trafficdde, tau, @trafficddeHIST, y,timerange, [], parlist);
%[tout,yout] = dde23(@trafficdde, tau, timerange, [], parlist);
% sol = dde23(@trafficdde,y0,timerange,[],parlist);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SYNTAX:
% sol = dde23(@function_name, lag,@history_function,[t0,tfinal],options,par);
%
% The "history_function" gives the state variables for time t0-lag to time
% t0.  If you want these to be constant, you can replace this function with
% initial values (constants).  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%options = ddeset('MaxStep',1e-4) % steady state
options = ddeset('MaxStep',1e-4,'Events',@crashevent5)
sol = dde23(@trafficdde5,tau,[v1o,v2o,v3o,v4o,v5o,h1o,h2o,h3o,h4o,h5o,x1o,x2o,x3o,x4o,x5o],[t0 tf],options,parlist);

R = L/(2*pi);
theta1 = sol.y(11,:)./R;
theta2 = sol.y(12,:)./R;
theta3 = sol.y(13,:)./R;
theta4 = sol.y(14,:)./R;
theta5 = sol.y(15,:)./R;

fig1 = figure;
A = moviein(length(sol.x),fig1);

for i= 1:length(sol.x)/100
plot(R*cos(theta1(i*100)),R*sin(theta1(i*100)),'bo','MarkerFacecolor','b','MarkerSize',8);
hold on;
axis([-1.2*R 1.2*R -1.2*R 1.2*R]);
axis('square');
plot(R*cos(theta2(i*100)),R*sin(theta2(i*100)),'ro','MarkerFacecolor','r','MarkerSize',8);
plot(R*cos(theta3(i*100)),R*sin(theta3(i*100)),'go','MarkerFacecolor','g','MarkerSize',8);
plot(R*cos(theta4(i*100)),R*sin(theta4(i*100)),'mo','MarkerFacecolor','m','MarkerSize',8);
plot(R*cos(theta5(i*100)),R*sin(theta5(i*100)),'ko','MarkerFacecolor','k','MarkerSize',8);
drawnow;
%pause(.00001)
A(:,i) = getframe(fig1);
hold off;
end

% Random movie commands
% movie2avi(M, 'traffic.avi');
% movie(A, 2,3)

%Plot output
%figure;
%plot(sol.x,sol.y(1,:),'b',sol.x,sol.y(2,:),'r',sol.x,sol.y(3,:),sol.x,sol.y(4,:),'k',sol.x,sol.y(5,:),'m',sol.x,sol.y(6,:),'y');
%xlabel('Time');
%ylabel('Rate of Change');
%legend('Velocity Car1','Velocity Car2','Headway');
%TT = sprintf('Traffic Parameters: alpha =%0.3g,tau = %0.3g, alpha,tau);
%title(TT);
