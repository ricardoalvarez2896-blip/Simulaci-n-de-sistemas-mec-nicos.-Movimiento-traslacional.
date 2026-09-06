function simulacion_suspension()
% Parámetros del sistema (Tabla 1)
m1 = 290;    % kg
m2 = 59;     % kg
b1 = 1000;   % Ns/m
k1 = 16182;  % N/m
k2 = 19000;  % N/m

% Matrices de Espacio de Estados
A = [ 0,          0,         1,        0;
    0,          0,         0,        1;
    -k1/m1,    k1/m1,    -b1/m1,   b1/m1;
    k1/m2, -(k1+k2)/m2,  b1/m2,  -b1/m2 ];

B = [  0,       0;
    0,       0;
    1/m1,      0;
    -1/m2,   k2/m2 ];

tspan = [0 10];
x0 = [0; 0; 0; 0]; % Condiciones iniciales en cero

% Simulación 1: z1(t) = 0.05*sin(0.5*pi*t)
[t1, x1_sim] = ode45(@(t, x) sys_ode(t, x, A, B, @(t) 0.05*sin(0.5*pi*t)), tspan, x0);

% Simulación 2: z2(t) = 0.05*sin(20*pi*t)
[t2, x2_sim] = ode45(@(t, x) sys_ode(t, x, A, B, @(t) 0.05*sin(20*pi*t)), tspan, x0);

% Gráficas
figure;
subplot(2,1,1);
plot(t1, x1_sim(:,1), 'b', t1, x1_sim(:,2), 'r');
title('Respuesta con z_1(t) = 0.05 sin(0.5\pi t)');
xlabel('Tiempo [s]'); ylabel('Desplazamiento [m]');
legend('x_1 (Carrocería)', 'x_2 (Rueda)'); grid on;

subplot(2,1,2);
plot(t2, x2_sim(:,1), 'b', t2, x2_sim(:,2), 'r');
title('Respuesta con z_2(t) = 0.05 sin(20\pi t)');
xlabel('Tiempo [s]'); ylabel('Desplazamiento [m]');
legend('x_1 (Carrocería)', 'x_2 (Rueda)'); grid on;
end

function dxdt = sys_ode(t, x, A, B, z_func)
f = 0; % Entrada de fuerza del actuador
z = z_func(t);
u = [f; z];
dxdt = A * x + B * u;
end