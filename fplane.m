function [ f ] = fplane( x,u )
%FPLANE Summary of this function goes here
%   Detailed explanation goes here

m = 1;          % mass of the plane in kg
p = 1.2041;     % air density

Al = 1;         % airfoil area
L = 1.5;        % lift coefficient
kl = (0.5*p*Al*L)/m;

Ad = 0.1;       % area of the wing generating drag
D = 1.5;        % drag coefficient
kd = (0.5*p*Ad*D)/m;

g = -9.8;        % acceleration due to gravity

f=zeros(size(x,1),1);
f(1,1)=x(3);
f(2,1)=x(4);
f(3,1)=-kd*x(3)^2+u(1);
f(4,1)=kl*x(3)^2+g+u(2);

end

