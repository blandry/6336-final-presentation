function [ F J ] = fjplane( xu, x0, xf, N, dt )

x = xu(1:N*4);
u = xu(end-N+1:end,1);

m = 1;          % mass of the plane in kg
p = 1.2041;     % air density

Al = 1;         % airfoil area
L = 1.5;        % lift coefficient
kl = (0.5*p*Al*L)/m;

Ad = 0.1;       % area of the wing generating drag
D = 1.5;        % drag coefficient
kd = (0.5*p*Ad*D)/m;

g = -9.8;        % acceleration due to gravity

F = zeros(size(xu,1),1);

F(1) = x(1)-(x0(1)+x0(3)*dt);
F(2) = x(2)-(x0(2)+x0(4)*dt);
F(3) = x(3)-(x0(3)-kd*x0(3)^2*dt+u(1)*dt);
F(4) = x(4)-(x0(4)+kl*x0(3)^2*dt+g*dt);

for i=5:4:size(x,1)-7
   F(i) = x(i)-(x(i-4)+x(i-2)*dt);
   F(i+1) = x(i+1)-(x(i-3)+x(i-1)*dt);
   F(i+2) = x(i+2)-(x(i-2)-kd*x(i-2)^2*dt+u((i-1)/4+1)*dt);
   F(i+3) = x(i+3)-(x(i-1)+kl*x(i-2)^2*dt+g*dt);
end

xp = x(end-7:end-4);
F(end-N-3) = xf(1)-(xp(1)+xp(3)*dt);
F(end-N-2) = xf(2)-(xp(2)+xp(4)*dt);
F(end-N-1) = xf(3)-(xp(3)-kd*xp(3)^2*dt+u(end)*dt);
F(end-N) = xf(4)-(xp(4)+kl*xp(3)^2*dt+g*dt);

F(end-N+1:end) = 1e-8*u;


J = eye(size(xu,1));

J(3,1+4*N) = -dt;

%for i=5:4:size(x,1)-7
for i=5:4:size(x,1)-3
    
    J(i,i) = 1;
    J(i,i-4) = -1;
    J(i,i-2) = -dt;
    
    J(i+1,i+1) = 1;
    J(i+1,i-3) = -1;
    J(i+1,i-1) = -dt;
    
    J(i+2,i+2) = 1;
    J(i+2,i-2) = -1+kd*2*x(i-2)*dt;
    J(i+2,(i-1)/4+1+4*N) = -dt;
    
    J(i+3,i+3) = 1;
    J(i+3,i-1) = -1;
    J(i+3,i-2) = -kl*2*x(i-2)*dt;
    
end

%J(end-N-3,end-N-3-4) = -1;
%J(end-N-3,end-N-3-4+2) = -dt;

%J(end-N-2,end-N-2-4) = -1;
%J(end-N-2,end-N-2-4+2) = -dt;

%J(end-N-1,end-N-1-4) = -1+kd*2*x(end-1-4)*dt;


for i=4*N+1:5*N
    J(i,i)=1e-8;
end


end

