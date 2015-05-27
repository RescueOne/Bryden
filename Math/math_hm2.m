% ==================
% === HM 1.2 Q 4 ===
% ==================

X = [0 0.5 1];
Y = [1 2 4];

plotspline2(X,Y, 'r')

title('Spline Plot');
xlabel('X');
ylabel('Y');

hold off 
pause

% ==================
% === HM 1.2 Q 5 ===
% ==================

n_vector = [];
cond_of_S = [];
for n = 2:20
	X = linspace(0,1,n);
	S = splinemat2(X);
	n_vector(n) = n;
	cond_of_S(n) = cond(S);
end

plot(n_vector, cond_of_S, 'r')

title('Result of cond(S) as n increases')
xlabel('n');
ylabel('S');

hold off
pause

% ==================
% === HM 1.3 Q 3 ===
% ==================

% For N=4
A = [-1 1 0 0 0; 1 -1.625 1 0 0; 0 1 -1.5 1 0; 0 0 1 -1.375 1; 0 0 0 0 1];
b = [ 0.5 0 0 0 -1]';
F = A\b;
plot([1 1.5 2 2.5 3], F, 'b')
hold on

% for N= 50
n = 50;
deltaX = (3 - 1)/n;

% Creating the L matrix
L = FDgenerate(n);
L(1,1) = -1;
L(1,2) = 1;
L(n+1,n+1) = 1;

% Creating the Q matrix
Q = diag([0 linspace(1+deltaX,3-deltaX,n-1) 0]);

% Adding L and Q
A = L + (deltaX)^2 * Q;

% Creating the b matrix
b = [deltaX zeros(1,n-1) -1]';

% Solving
F = A\b;
plot([1 linspace(1+deltaX,3-deltaX,n-1) 3], F, 'r')

legend('n=4', 'n=50')
title('F found with finite difference');
xlabel('x');
ylabel('F');

hold off
pause

% ==================
% === HM 1.3 Q 4 ===
% ==================

[X T]=heat(50);
% plot the solution and the analytic solution
plot(X,T,'bo', X,(1-e^2+e.^(1-X)-e.^(1+X))./(1-e^2),'r-');

title('Modified Heat at N=50')
legend('numerical solution', 'analytic solution');
xlabel('x');
ylabel('T');

hold off
pause

% ==================
% === HM 1.3 Q 5 ===
% ==================

x_find = -0.5;
true_x = 1 - sinh(0.5) / sinh(1);
error = [];
[X T]=heat(4);
error(1) = log( true_x - T(find(X==x_find)) );
[X T]=heat(40);
error(2) = log( true_x - T(find(X==x_find)) );
[X T]=heat(400);
error(3) = log( true_x - T(find(X==x_find)) );

plot([log(4) log(40) log(400)], error, 'm')

title('log-log plot of the error when N is larger')
xlabel('log of N value');
ylabel('log of error');

hold off
pause

