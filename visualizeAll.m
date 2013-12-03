tf = 20;
N = 200;
t = linspace(0,tf,N);
dt = t(2)-t(1);

% x = [x,y,dxdt,dydt]
x0 = [0;0;5;0];

% input of the plane - thrust vector [dx/dt;dy/dt]
u = [repmat([1;0],1,N/8),zeros(2,N/4),repmat([1;20],1,N/8),zeros(2,N/2)];

xforeuler = foreulerplane(x0,u,tf,dt);
xtrap = trapruleplane(x0,u,tf,dt);
xcont = continuationplane(x0,u,tf,dt);

plot(xforeuler(1,:),xforeuler(2,:),'.b',xtrap(1,:),xtrap(2,:),'*r',xcont(1,:),xcont(2,:),'og');
legend('Forward Euler', 'Trapezoidal', 'Continuation/Newton');