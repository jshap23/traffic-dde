% Traffic DDE File
% from Bifurcations and multiple traffic jams Orosz et al. 2004
% simulation with 5 cars 
% Josh Shapiro

function ydot = trafficdde5(t,y,Z,params)

%Extract values

v1 = y(1);
v2 = y(2);
v3 = y(3);
v4 = y(4);
v5 = y(5);
h1 = y(6);
h2 = y(7);
h3 = y(8);
h4 = y(9);
h5 = y(10);
x1 = y(11);
x2 = y(12);
x3 = y(13);
x4 = y(14);
x5 = y(15);

%Extract parameters
alpha  = params(1); % sensitivity coefficient
v0 = params(2); % target speed, corresponding to high free-flow speed
L = params(3); % length of track

h1_tau = Z(6);   % This is the lagged state variable - all stored in Z
h2_tau = Z(7); 
h3_tau = Z(8);
h4_tau = Z(9);
h5_tau = Z(10);

if h1_tau <= 1
V1 = 0;
else
V1 = v0* ((h1_tau-1)^3)/(1 + (h1_tau-1)^3) ;
end

if h2_tau <= 1
V2 = 0;
else
V2 = v0* ((h2_tau-1)^3)/(1 + (h2_tau-1)^3) ;
end

if h3_tau <= 1
V3 = 0;
else
V3 = v0* ((h3_tau-1)^3)/(1 + (h3_tau-1)^3) ;
end

if h4_tau <= 1
V4 = 0;
else
V4 = v0* ((h4_tau-1)^3)/(1 + (h4_tau-1)^3) ;
end

if h5_tau <= 1
V5 = 0;
else
V5 = v0* ((h5_tau-1)^3)/(1 + (h5_tau-1)^3) ;
end


% Diffy Q's
v1dot = alpha*(V1-v1);
v2dot = alpha*(V2-v2);
v3dot = alpha*(V3-v3);
v4dot = alpha*(V4-v4);
v5dot = alpha*(V5-v5);
h1dot = v2 - v1;
h2dot = v3 - v2;
h3dot = v4 - v3;
h4dot = v5 - v4;
h5dot = v1 - v5;
x1dot = v1;
x2dot = v2;
x3dot = v3;
x4dot = v4;
x5dot = v5;


ydot = [v1dot;
        v2dot;
        v3dot;
        v4dot;
        v5dot;
        h1dot;
        h2dot;
        h3dot;
        h4dot;
        h5dot;
        x1dot;
        x2dot;
        x3dot;
        x4dot;
        x5dot];
