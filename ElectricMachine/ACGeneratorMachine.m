clc; clear; close all
% --- PRIMER CASO: GENERADOR OPERANDO SOLO --- %
% --- CODIGO BOJATO, OJEDA --- %
%PARAMETROS DE ENTRADA DEL GENERADOR.
S_nom = 150e6; %Potencia Nominal del generador (en MVA).
V_nom = 13.2e3; %Tensión nominal del generador.
N_pol = 4; %Polos de la maquina.
Ra = 0.001; %Resistencia del inducido.
Xs = 0.7; %Reactancia sincrona.
fp_nom = 0.8; %Factor de potencia.
tfp = 1; %tipo de factor de potencia (1. Inductivo, 2. Capacitivo).
f_nom = 60; %Frecuencia nominal (en Hz).
eff = 82; %Eficiencia en porcentaje.
Sp = 50e6; %Sp en MW/Hz.

%PARAMETROS DE ENTRADA DE LA CARGA.
Pc = 180e6;
Qc = 120e6;

%PARAMETROS DEL BUS INFINITO.
fop = 60;  
vc = 13.2e3; %Tensión de linea

%CURVA DE MAGNETIZACIÓN DE LA MAQUINA (EA VS IF).
Ifd = [0, 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]; %Valores de If.
Eat = [0, 3955.7, 7911.3, 11866.8, 14833.6, 16811.3, 17998.1, 18591.3, 18868.3, 18986.9, 19066.1]; %Valores de Ea.

% --- CALCULOS --- %
% VELOCIDAD DEL GENERADOR.
ngen = 120*f_nom/N_pol;
ngen_op = 120*fop/N_pol;

% CASO DE CONEXIÓN EN Y O DELTA.
isOk = false ;
 while ~isOk
    Conect = input('Ingrese 1. Y, 2. en Delta '); %Conexión del generador (1. En Y, 2. En delta).
    if (Conect == 1)
            isOk = true ;
            vphi = vc/sqrt(3);            
    else if (Conect == 2)
            isOk = true ;
            vphi = vc;
        else 
            warning (' Digite bien ');
        end
    end
 end

%CALCULO DE LA FRECUENCIA Y POTENCIA DEL GENERADOR.
Pgen = (S_nom*abs(fp_nom));
fsc = Pgen/Sp + fop;

% POTENCIA DE LA TURBINA
p_turb = Pgen/(eff/100);

% CALCULO PUNTO DE OPERACIÓN (EA VS IF).
vphi_2 = vphi.*exp(1i*0);
vphi_2m = abs(vphi_2);
vphi_2p = angle(vphi_2);

% --- Esta aprte tiene en cuenta el tipo de factor de potencia nominal del
% generador --
if (tfp == 1)
    Iap = (S_nom/(3*vphi_2)).*exp(-1i*acos(abs(fp_nom))); % CALCULO CORRIENTE DE INDUCIDO IA.
else if (tfp == 2)
        Iap = (S_nom/(3*vphi_2)).*exp(1i*acos(abs(fp_nom)));
    end
end

% --- Conversión de la corriente de inducido si esta en Y o Delta ---
if (Conect == 1)
        isOk = true ;
        Ial = Iap;            
else if (Conect == 2)
        isOk = true ;
        Ial = Iap*sqrt(3);       
    end
end

% --- Calculo de la tensión inducida de fase Eap --- 
Eap = vphi_2 + 1i*Xs*Iap;
Ixs = 1i*Xs.*Iap;
Ixs_m = abs(Ixs);
Ixs_p = angle(Ixs);

% CASO DE CONEXIÓN EN Y O DELTA PARA TENSIÓN INDUCIDA EA.
if (Conect == 1)            
        Eal = Eap*sqrt(3);      
else if (Conect == 2)           
        Eal = Eap;
    end
end

% ---- Esta parte obtiene magnitud y angulo (en radianes) de la corriente
% de inducido de fase (Ia - fase)
Iap_m = abs(Iap);
Iap_p = angle(Iap);
Eal_m = abs(Eal);
Eal_p = angle(Eal);

% -- Calculo de la potencia reactiva de salida del generador. 
Qgen = 3*abs(vphi_2)*Iap_m*sin(-Iap_p);

% EN CASO DE CAMBIAR LA VELOCIDAD DE OPERACIÓN, SE RECALCULA LA CURVA.
Eat_n = Eat.*(ngen_op/ngen);

% GRAFICA DE EA VS IF CON EL PUNTO DE OPERACIÓN
Eax = Eal_m; %Punto de Ea a determinar el If.
vq = interp1(Eat,Ifd,Eax,'spline'); %Interpolación para hallar el If correspondiente al Ea.

%CALCULOS CURVA OPERATIVA DEL GENERADOR
Centro = (-3*(abs(vphi_2))^2/Xs)/1e6;
Dista = (3*abs(Eap)*abs(vphi_2)/Xs)/1e6;
t = 0 : .01 : 2 * pi;
xx = Dista*cos(t);
yy = Dista*sin(t) + Centro;
[theta1,rho1] = cart2pol(xx,yy);
minx = -(S_nom*1.25)/1e6;
maxx = (S_nom*1.25)/1e6;
yturb = linspace(minx,maxx,100);
p_turbx = p_turb/1e6*ones(size(yturb));


syms x y xa ya
S_nom2 = S_nom/1e6;
[x,y] = solve(x^2 + y^2 == S_nom2^2, x^2 + (y-Centro)^2 == Dista^2);
[xa,ya] = solve(xa^2 + ya^2 == S_nom2^2, xa == p_turb/1e6);
sm1 = sqrt((double(x(1)))^2 + (double(y(1)))^2);
sm2 = sqrt(0 + (Dista+Centro)^2);
sm1_p = atan((double(y(1))/double(x(1))));
sm2_p = atan((Dista+Centro)/0);
sm3 = sqrt((double(xa(1)))^2 + (double(ya(2)))^2);
sm4 = sqrt(0 + (S_nom2)^2);
sm3_p = -atan(double(ya(2))/double(xa(1)));
sm4_p = atan(Inf/S_nom2);

n = 1;
m = 1;
if (tfp == 1)
    ylgen = linspace(-S_nom/1e6,sm2,100);
    while n < length(theta1)
        if ((sm1_p < theta1(n)) && (theta1(n) < sm2_p))        
            smr_m(m) = rho1(n);
            smr_p(m) = theta1(n);
            m = m+1;
        end
        n = n+1;
    end
else if (tfp == 2) 
        n = 1;
        m = 1;
        ylgen = linspace(-S_nom/1e6,-sm2,100);
        while n < length(theta1)
            if (sm2 < rho1(n) && sm1 > rho1(n) && theta1(n) > sm2_p)       
                smr_m(m) = rho1(n);                
                smr_p(m) = theta1(n);
                m = m+1;
            end
            n = n+1;
        end    
    end
end

n = 1;
m = 1;
while n < length(t)
    if ((sm3_p < t(n)) && (t(n) < sm4_p))        
        smr2_m(m) = S_nom2;
        smr2_p(m) = t(n);
        m = m+1;
    end
    n = n+1;
end

figure(1)
plot(Ifd,Eat,'LineWidth',1.5);
hold on 
yL = get(gca,'YLim');
line([vq vq],[0 Eax],'Color','r','LineWidth',2,'LineStyle','--');
xL = get(gca,'XLim');
line([0 vq],[Eax Eax],'Color','r','LineWidth',2,'LineStyle','--');
plot(vq,Eax,'Color','r','Marker','o','MarkerFaceColor','r');
hold off
grid on
xlim([0 10]);
title('Caracteristica Ea vs If a 1800 rpm');

figure(2)
t = 0 : .01 : 2 * pi;
P = polar(t, 20000 * ones(size(t)));
set(P, 'Visible', 'off')
hold on

for m = 0:(2*pi/3):(4*pi/3)
h2 = polar([0+m Eal_p+m] , [vc Eal_m]);
set(h2,'color','b','linewidth',3)
h2b = polar([NaN Eal_p+m],[NaN Eal_m]);
set(h2b,'Marker','o','Color','b','MarkerFaceColor','b');

h1 = polar([0 vphi_2p+m],[0 vc]);
set(h1,'color','r','linewidth',3)
h1b = polar([NaN vphi_2p+m],[NaN vc]);
set(h1b,'Marker','o','Color','r','MarkerFaceColor','r');

h3 = polar([0 Iap_p+m] , [0 Iap_m]);
set(h3,'color','g','linewidth',3,'LineStyle','--')
h3b = polar([NaN Iap_p+m] , [NaN Iap_m]);
set(h3b,'Marker','o','Color','g','MarkerFaceColor','g');

h4 = polar([0 Eal_p+m] , [0 Eal_m]);
set(h4,'color','m','linewidth',3)
h4b = polar([NaN Eal_p+m] , [NaN Eal_m]);
set(h4b,'Marker','o','Color','m','MarkerFaceColor','m','MarkerSize',1.5);
end

hleg1 = legend([h1,h2,h3,h4],'Vl(V)', 'Ia*Xs*j(A)', 'Ia(A)', 'Eal(V)');
set(hleg1,'Location','NorthWestOutside')
set(hleg1,'Interpreter','none')

figure(3)
t = 0 : .01 : 2 * pi;
P = polar(t, S_nom*4/(1e6) * ones(size(t)));
set(P, 'Visible', 'off')
hold on


h5 = polar(t, S_nom/(1e6)*ones(size(t)));
set(h5,'color','b','linewidth',2,'LineStyle','--')
h6 = polar(theta1,rho1); 
set(h6,'color','r','linewidth',2,'LineStyle','--')
h7 = plot(p_turbx,yturb);
set(h7,'color','g','linewidth',2,'LineStyle','--')

h7b = polar(smr_p,smr_m);
h7c = polar(-smr2_p,smr2_m);
h7d = plot(0*ones(size(ylgen)),ylgen);
set([h7b h7c h7d],'color','k','linewidth',3,'LineStyle','-')
h8 = polar(atan(Qgen/Pgen),sqrt(Pgen^2+Qgen^2)/1e6);
set(h8,'Marker','O','Color','m','MarkerFaceColor','m','MarkerSize',8);


% RESULTADOS
disp([' La corriente del inducido Ia tiene una magnitud de ' , num2str(Iap_m), ' V y un angulo de ',num2str(rad2deg(Iap_p)) , ' grados' ]);
disp([' La tensión inducida tiene una magnitud de ' , num2str(Eal_m), ' V y un angulo de ',num2str(rad2deg(Eal_p)) , ' grados a ' , num2str(ngen_op) , ' rpm ']);
disp([' La corriente de campo If deberá ser de ' , num2str(vq) , ' A']);