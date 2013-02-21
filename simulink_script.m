% VORLAGE Laplace-Transformation und -Ruecktransformation
% Angelos Drossos
% 20.02.1013
% GPLv2

% Tipp: Immer das komplette Skript ausfuehren (Run-Button / F5)

%% Workspace loeschen, Console loeschen, alle Fenster schliessen
% dient der Sicherheit / um Fehler schnell zu erkennen
clc
clear all
close all

disp('==========  Loesen einer DGL mittels Simulink  =============')


%% Parameters

k1 = -0.1;
k2 = 4;
k3 = 0.8;
k4 = 20;


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


%% Simulieren mit Simulink
% Die Simulink-Datei als String angeben sowie Start- und Endzeitpunk
% angeben.
% Mit dem Simulink-Block 'To Workspace' kann man sich
% die simulierten Variablen ausgeben lassen und weiterverarbeiten
% (z.B. plotten)
% Alternativ kann man auch weitere Einstellungen dem Simulink-Modell
% uebergeben.

sim('simulink_model_vorlage', t_span)
% sim('simulink_model_vorlage', t_span, simset(simget('pendel_model'),'Solver','ode45','MaxStep',0.01));

% Wenn der Block 'To Workspace' verwendet wurde, dann liegen nun
% die im Modell definierten Variablen im Workspace und koennen
% verwendet werden.

% Annahme:
% Es wurde ein 'To Workspace'-Block verwendet mit folgenden Einstellungen:
%        Variablen name: simout_y
%        Save format:    Structure With Time
%        (Rest ist Standard)
% Hinweis: values kann auch eine Matrix sein, 
%          wenn man mit Mux ein Vektor in den Block gibt!

T = simout_y.time;
Y = simout_y.signals.values;

%% [PLOT] Nun plotten, etc.

%subplot(2,1,2)
figure('Name','Simulink: y(t) plotten','NumberTitle','off');

plot(T, Y, 'b')
hold on;

grid;
legend('y(t)');
title('y ueber die Zeit');
xlabel('t');
ylabel('y(t)');
