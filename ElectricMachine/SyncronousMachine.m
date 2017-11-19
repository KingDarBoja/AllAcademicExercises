clc; clear; close all;
% Archivo M para crear una gr�fica de la curva par-velocidad del
% motor de inducci�n-
% Primero, inicializar los valores requeridos en el programa.

r1 = 0.641; % Resistencia del estator
x1 = 1.106; % Reactancia del estator
r2 = 0.332; % Resistencia del rotor
x2 = 0.464; % Reactancia del rotor
xm = 26.3; % Reactancia de la rama de magnetizaci�n
v_linea = 460; % Tensi�n de linea 
v_fase = v_linea / sqrt(3); % Voltaje de fase para conexi�n en Y.
f_op = 60; % Frecuencia sincrona (Hz)
n_pol = 4; % Numero de polos.
s_des = 0.022; % Deslizamiento deseado.
P_ROT = 1100; % Perdidas del rotor (miscelaneas)

% Calcular la velocidad sincrona del motor.
n_sync = 120*f_op/n_pol; % Velocidad s�ncrona (r/min)
w_sync = n_sync*2*pi/60; % Velocidad s�ncrona (rad/s)
% Calcular el voltaje e impedancia de thevenin para calcular deslizamiento max.
v_th = v_fase * ( xm / sqrt(r1^2 + (x1 + xm)^2) );
z_th = ((1i*xm) * (r1 + 1i*x1)) / (r1 + 1i* (x1 + xm));
r_th = real (z_th);
x_th = imag(z_th);
% Ahora calcular la caracter�stica par-velocidad para muchos
% deslizamientos entre 0 y 1. N�tese que el primer valor de
% deslizamiento ser� 0.001 en lugar de 0 exactamente para evitar
% problemas con la divisi�n entre 0.
s = (0:1:50) / 50; % Deslizamiento
s(1) = 0.001;
nm = (1 - s) * n_sync; % Velocidad mec�nica (r/min)

nm_d = (1-s_des)*n_sync;
wm_d = nm_d*2*pi/60; % Velocidad mec�nica (rad/s)

z2 = r2/s_des + 1i*x2;
zf = 1/(1/(1i*xm) + 1/(z2));
z_tot = r1 + 1i*x1 + zf;
I_1 = v_fase/z_tot;
I_1m = abs(I_1);
I_1p = rad2deg(angle(I_1));
I_2 = v_th /(z_th + 1i*x2 + r2/s_des);
I_2m = abs(I_2);
I_2p = rad2deg(angle(I_2));
I_M = I_1 - I_2;
I_Mm = abs(I_M);
% Calculo Potencias (salidas)
P_ENT = sqrt(3)*v_linea*I_1m*cos(angle(I_1));
P_PCE = 3*I_1m^2*r1;
P_NUC = 3*I_Mm^2/xm;
P_EH = 3*I_2m^2*(r2/s_des);
t_ind_d = P_EH/w_sync;
P_CONV = t_ind_d*wm_d;
P_SAL = P_CONV - P_ROT;
t_car_d = P_SAL/wm_d;
n_eff = (P_SAL/P_ENT)*100;

% Calcular el par para la resistencia del rotor original
for ii = 1:51
t_ind1(ii) = (3 * v_th^2 * r2 / s(ii)) / ...
(w_sync * (r_th + r2/s(ii))^2 + (x_th + x2)^2) ;
end

% Hacer la gr�fi ca de la curva par-velocidad
plot(nm,t_ind1, 'Color', 'k', 'LineWidth',2.0);
xlabel('\bf\itn_{m}')
ylabel('\bf\tau_{ind}');
title ('\bf Caracter�stica par-velocidad de un motor de inducci�n');
grid on;
hold off;