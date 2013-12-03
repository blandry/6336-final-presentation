function [x0,convergence] = newtonNd(fhand,x0)
% function newtonNd(fhand,x0,itpause)
% 
% INPUTS:
%   fhand - function handle
%   x0    - initial guess
%   itpause - parameter for plotting
% 
% Use Newton's method to solve the nonlinear function
% defined by function handle fhand with initial guess x0.  
%
% itpause is parameter for plotting and defines the 
% number of Newton steps that are plotted sequentially
% pauses between sub-steps

if nargin<2
    error('Must provide two input arguments.  Type ''help newtonNd'' for details');
end

tolf=1e-10;
tolx=1e-8;
maxIters=500;       % max # of iterations

% Newton loop
for iter=1:maxIters
    [f,J]=fhand(x0);            % evaluate function
    dx=J\(-f);                  % solve linear system
    nf(iter)=norm(f);           % norm of f at step k+1 ignoring the input
    ndx(iter)=norm(dx);         % norm of dx at step k+1 ignoring the input
    x(:,iter)=x0+dx;            % solution x at step k+1
    x0=x(:,iter);               % set value for next guess
    if (nf(iter)<tolf && ndx(iter)<tolx)
        % check for convergence
        fprintf('Newton converged in %d iterations\n',iter);
        break;
    end
end

convergence = 1;
if iter==maxIters, % check for non-convergence
    plot(x(1:4:40,iter),x(2:4:40,iter),x(1:4:40,iter-100),x(2:4:40,iter-100),x(1:4:40,iter-200),x(2:4:40,iter-200),x(1:4:40,iter-300),x(2:4:40,iter-300));
    legend('4','3','2','1');
    fprintf('Non-Convergence after %d iterations!!!\n',iter); 
    convergence = 0;
end