tf = 20;
N = 200;
t = linspace(0,tf,N);
dt = t(2)-t(1);

% x = [x,y,dxdt,dydt]
x0 = [0;0;5;0];

% input of the plane - thrust vector [dx/dt;dy/dt]
u = [repmat([1;0],1,N/8),zeros(2,N/4),repmat([1;20],1,N/8),zeros(2,N/2)];

x = foreulerplane(x0,u,tf,dt);

%visualize2D(x);
visualize3D(x);