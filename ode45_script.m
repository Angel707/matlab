% VORLAGE Numerisches Loesen von Differentialgleichungen (mit ode45)
% Angelos Drossos
% 19.02.1013
% GPLv2

% Tipp: Immer das komplette Skript ausfuehren (Run-Button / F5)

%% Workspace loeschen, Console loeschen, alle Fenster schliessen
% dient der Sicherheit / um Fehler schnell zu erkennen
clc
clear all
close all

disp('==========  Numerisches Loesen einer DGL (ode45)  =============')

%% Parameters

k1 = -0.1;
k2 = 4;
k3 = 0.8;
k4 = 20;

% Vektor mit Parametern
% (diese Parameter koennten auch einzeln der ode45-Funktion uebergeben werden)
params = [k1 , k2 , k3 , k4];

%% Simulations-Parameter (-Variable)
% Start- und Endpunkt der Simulation ist hier gefordert.
% Hinweis:
%   Es muss sich hierbei nicht immer um die SimulationsZEIT
%   handeln. Es kann ebenso ein SimulationsWEG (x) sein!
%   Der Einfachheit wird die Simulationsvariable Simulationszeit genannt
%   (und in Simulink 'Clock').
 
t_span = [0 , 8*pi];


%% Anfangsbedingung vom System von DGLn 1. Ordnung
% v0 := v( t=0 ) = [ y(0) , y'(0) , ... ] bis zur (n-1)-ten Ableitung
% --> ist die gleiche Form wie der Parameter v in der ode45_dgl1n-Funktion

y0  = - pi / 2; % y(0)
Dy0 = pi / 4;   % y'(0)

v0 = [ y0 , Dy0 ];

%% ODE 45 Funktion
% Funktion ode45_dgl1n enthält das System von DGLn 1. Ordnung
% t_span: 2-dimensionaler Vektor mit Simulations-Startpunkt und -Endpunkt,
%         z.B.: t_span = [0 , 20];
% v0: Vektor mit den Anfangsbedingungen (so wie wir es definiert haben)
%     z.B.: v0 = [ y(0) , y'(0) ] = [ -pi/2 , pi/4 ];
% flag: muss immer vorhanden sein!
%       (falls ereignisgesteuerte Simulation benoetigt wird)
% params: weitere konstante Parameter an ode45_dgl1n "ubergeben
%         (k"onnen auch einzeln "ubergeben werden, z.B.: k1,k2,k3,k4)
% T: Zeitvektor
% V: Matrix mit unseren Werten
%    v1 --> v(:,1) --> y(t_span)
%    v2 --> v(:,2) --> y'(t_span)
%    [so wie in der ode45_dgl1n-Funktion definiert]

% man kann nun mittels 'odeset' auch die Simulation genauer einstellen
flag = odeset('Events',@ode45_event_fkt);
[T, V] = ode45(@ode45_dgl1n, t_span, v0, flag, params);

y = V(:,1);
Dy = V(:,2);

%% PLOTTEN
% Man k"onnte je ein Plot pro Fenster anzeigen oder Subplot verwenden.

% PLOT: v1(t) und v2(t)
% 2,1: Fenster aufteilen in 2 Zeilen, 1 Spalte [2 "ubereinander liegende Plots]
% ,1: w"ahle erstes Element in der Reihe
subplot(2,1,1);


plot(T, y,'g');                        % Plot-Funktion, Alternativ: ezplot
grid;
hold on;                                % behalte die vorher gezeichneten Funktionen (ansonsten werden diese gel"oscht)
plot(T, Dy,'m');                        % Plot-Funktion, Alternativ: ezplot
legend('v1(t) = y(t)','v2(t) = Dy(t)'); % Legende der Funktionen
title('y und Dy ueber die Zeit');       % Titel des (Sub-)Plots
xlabel('t [s]');                        % x-Achsen-Beschriftung
ylabel('y und Dy');                     % y-Achsen-Beschriftung

xlim( [t_span(1) , t_span(2)] );        % x-Achse beschr"anken
%ylim( [0 , 100] );                     % y-Achse beschr"anken


% PLOT: v2(v1)
% 2,1: muss identisch sein wie oben
% ,2: w"ahle zweites Element
subplot(2,1,2);

plot(y, Dy, 'g' );
hold on;
grid;
legend('v2(v1) = Dy(y)');
title('Dy ueber y');
xlabel('y');
ylabel('Dy');
