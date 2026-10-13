% Parámetros del sistema
m1 = 290; m2 = 59; 
b1 = 1000;
k1 = 16182; k2 = 19000;
f = 0; 

% Condiciones iniciales y tiempo
x0 = [0; 0; 0; 0];
tspan = [0 10]; 

% Entradas z(t)
z1 = @(t) 0.05 * sin(0.5 * pi * t);
z2 = @(t) 0.05 * sin(20 * pi * t);

% Sistema de ecuaciones
sistema = @(t, x, z_func) [
    x(3);
    x(4);
    (-k1*x(1) + k1*x(2) - b1*x(3) + b1*x(4) + f) / m1;
    (k1*x(1) - (k1+k2)*x(2) + b1*x(3) - b1*x(4) - f + k2*z_func(t)) / m2
    ];

% Solución
[t1, x1_out] = ode45(@(t,x) sistema(t, x, z1), tspan, x0);
[t2, x2_out] = ode45(@(t,x) sistema(t, x, z2), tspan, x0);

% Gráficas
figure;
subplot(2,1,1); plot(t1, x1_out(:,1), 'b', t1, x1_out(:,2), 'r');
title('Respuesta con z_1(t) = 0.05 sin(0.5\pi t)'); legend('x_1', 'x_2');
subplot(2,1,2); plot(t2, x2_out(:,1), 'b', t2, x2_out(:,2), 'r');
title('Respuesta con z_2(t) = 0.05 sin(20\pi t)'); legend('x_1', 'x_2');