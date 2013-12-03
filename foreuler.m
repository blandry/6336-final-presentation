function [ x ] = foreuler( f, df, u, x00, tf, dt )
%FOREULER Summary of this function goes here
%   Detailed explanation goes here

x = x00;
t = 0;
while t<tf
    x = [x,x(:,end)+dt*f(x(:,end),u(:,size(x,2)))];
    t = t + dt;
end

end

