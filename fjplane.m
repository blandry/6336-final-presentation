function [ F, J ] = fjplane( x, x0, u, dt )

m = 1;          % mass of the plane in kg
p = 1.2041;     % air density

Al = 1;         % airfoil area
L = 1.5;        % lift coefficient
kl = (0.5*p*Al*L)/m;

Ad = 0.1;       % area of the wing generating drag
D = 1.5;        % drag coefficient
kd = (0.5*p*Ad*D)/m;

g = -9.8;        % acceleration due to gravity

F = zeros(size(x,1),1);
F(1) = x(1)-(x0(1)+x0(3)*dt);
F(2) = x(2)-(x0(2)+x0(4)*dt);
F(3) = x(3)-(x0(3)-kd*x0(3)^2*dt+u(1)*dt);
F(4) = x(4)-(x0(4)+kl*x0(3)^2*dt+g*dt);
for i=5:4:size(x,1)-3
   F(i) = x(i)-(x(i-4)+x(i-2)*dt);
   F(i+1) = x(i+1)-(x(i-3)+x(i-1)*dt);
   F(i+2) = x(i+2)-(x(i-2)-kd*x(i-2)^2*dt+u(1,(i-1)/4+1)*dt);
   F(i+3) = x(i+3)-(x(i-1)+kl*x(i-2)^2*dt+u(2,(i-1)/4+1)*dt+g*dt);
end

J = zeros(size(x,1));
J(1,1) = 1;
J(2,2) = 1;
J(3,3) = 1;
J(4,4) = 1;
for i=5:4:size(x,1)-3
    J(i,i) = 1;
    J(i,i-4) = -1;
    J(i,i-2) = -dt;
    J(i+1,i+1) = 1;
    J(i+1,i-3) = -1;
    J(i+1,i-1) = -dt;
    J(i+2,i+2) = 1;
    J(i+2,i-2) = -1;
    J(i+2,i-2) = kd*2*x(i-2)*dt;
    J(i+3,i+3) = 1;
    J(i+3,i-1) = -1;
    J(i+3,i-2) = -kl*2*x(i-2)*dt;
end

end

