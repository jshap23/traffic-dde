function [value,isterminal,direction] = crashevent5(t,y,z,parlist)

h1 = y(6);
h2 = y(7);
h3 = y(8);
h4 = y(9);
h5 = y(10);
CD= [abs(h1),abs(h2),abs(h3),abs(h4),abs(h5)];
cardist = min(CD)- .1;
value = [cardist];
isterminal = [1];            % Stop at local minimum
direction = [0];            % [local minimum, local maximum]
