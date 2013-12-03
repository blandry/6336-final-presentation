function [ x ] = plotcontinuationplane( x0, u, tf, dt )
%CONTINUATIONPLANE Summary of this function goes here
%   Detailed explanation goes here

% initial guess for the plane's response
N = tf/dt;
xinit = zeros(size(x0,1)*N,1);

maxIters = 500;
trajs = zeros(4*N,maxIters);
lambda = 0;
dlambda = 0.1;
for i=1:maxIters
    if (lambda > 1)
        lambda = 1;
    end
    
    % input to the plane
    uiter = lambda*u;
    
    % simulating the plane
    fhand = @(x) fjplane(x,x0,uiter,dt);
    [traj, c] = newtonNd(fhand,xinit);
    trajs(:,i) = traj;
    
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

x = traj;

xtrajs = trajs(1:4:end,1:i);
ytrajs = trajs(2:4:end,1:i);

plot(xtrajs,ytrajs);

end

