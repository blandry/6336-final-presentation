function [ x ] = traprule( f, df, u, x00, tf, dt )
%TRAPRULE Summary of this function goes here
%   Detailed explanation goes here

x = x00;
t = 0;
while t<(tf-dt+1e-12)
    % Newton loop
    maxIters=500;
    tolf=1e-10;
    tolx=1e-8;
    x0=x(:,end);
    gamma=x(:,end)+(dt/2)*f(x(:,end),u(:,size(x,2)));
    for iter=1:maxIters
        J=eye(size(x0,1))-(dt/2)*df(x0,u(:,size(x,2)+1));
        F=x0-(dt/2)*f(x0,u(:,size(x,2)+1))-gamma;
        dx=J\(-F);                  % solve linear system
        nf=norm(F);           % norm of f at step k+1
        ndx=norm(dx);         % norm of dx at step k+1
        if (nf<tolf && ndx<tolx)
            % check for convergence
            break;
        end
        if iter==maxIters
            error('Newton non-convergence');
        end
        x0=x0+dx;               % set value for next guess
    end
    x = [x,x0];
    t = t + dt;
end

end