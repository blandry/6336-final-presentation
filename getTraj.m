tf = 10;
N = 10;
t = linspace(0,tf,N);
dt = t(2)-t(1);

% x = [x,y,dxdt,dydt]

% initial state
x00 = [0;0;2;0];

% response if plane stays passive
x0 = trapruleplane(x00,zeros(1,N),tf,dt);

% desired final state
xf = x0(:,end);

% initial guess for newton is known solution
xinit = [reshape(x0,[],1);zeros(N,1)];

maxIters = 500;
lambda = 0;
dlambda = 0.1;
for i=1:maxIters
    if (lambda > 1)
        lambda = 1;
    end
    
    % uses continuation to change goal state progressively
    xfiter = lambda*xf + (1-lambda)*x0(:,end);
    
    % simulating the plane
    fhand = @(x) fjplane(x,x00,xfiter,N,dt);
    [traj, c] = newtonNd(fhand,xinit);
    
    if (lambda==1)
        break;
    end
    
    if c
        dlambda = dlambda*2.0;
        lambda = lambda + dlambda;
    else
        dlambda = dlambda/2.0;
        lambda = lambda - dlambda;
    end
    
    xinit = traj;
    
end

xtraj = traj(1:4:N*4);
ytraj = traj(2:4:N*4);
u = traj(end-N+1:end);

plot(xtraj, ytraj, '.:');