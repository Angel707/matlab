% VORLAGE Laplace-Transformation und -Ruecktransformation
% Angelos Drossos
% 19.02.1013
% GPLv2

% Tipp: Immer das komplette Skript ausfuehren (Run-Button / F5)

%% Workspace loeschen, Console loeschen, alle Fenster schliessen
% dient der Sicherheit / um Fehler schnell zu erkennen
clc
clear all
close all

disp('==========  Loesen einer DGL mit Laplace-Transformation (laplace, solve, ilaplace)  =============')

%% Symbolische Deklarationen: Variable als 'ohne Wert' deklarieren
% t     -- Zeit (kann sein, dass sich t aus y(t) ergibt)
% y(t)  -- Funktion
% s     -- fuer die Laplacetransformation
syms y(t) s

%% Ableitungen werden mit diff(y, n) definiert [siehe Hilfe]
% y: funktion, die abgeleitet werden soll --> y(t) in syms aufnehmen
% n: Wie oft soll differenziert werden, z.B. diff(y,2) == diff(diff(y))
Dy  = diff(y, 1);  % entspricht y'(t)
D2y = diff(y, 2);  % entspricht y''(t)
D3y = diff(y, 3);  % entspricht y'''(t)
D4y = diff(y, 4);  % entspricht y''''(t)
% Achtung: diff(y(t)) ist erlaubt, kann aber manchmal zum Fehler fuehren!

%% DGL umformen: alle Terme in der DGL nach links schreiben
%     c3 * y'''(t) + c2 * y''(t) + c1 * y'(t) + c0 * y(t) = b(t)
% ==> c3 * y'''(t) + c2 * y''(t) + c1 * y'(t) + c0 * y(t) - b(t) = 0
DGL = 4 * D4y - 12 * D3y + 11 * D2y - 3 * Dy - 4 * cos(t); % in Gedanken: = 0

%% Laplace-Transformation: Zeitbereich (t) -> Laplace-Bereich (s)
% ergibt die Laplace-Gleichung: irgendwas F(s) irgendwas = 0
DGL_S = laplace(DGL, t, s);
DGL_S

% dann noch ein paar symbolische Ersetzungen ausfuehren,
% um f(0), f'(0), etc. einzusetzen...
DGL_S = subs(DGL_S,'y(0)','5');
DGL_S = subs(DGL_S,'D(y)(0)','4');
DGL_S = subs(DGL_S,'D(D(y))(0)','3');
DGL_S = subs(DGL_S,'D(D(D(y)))(0)','2');
DGL_S = subs(DGL_S,'laplace(y(t),t,s)','Y');
DGL_S

% Laplace-Gleichung nach F(s) aufloesen: F(s) = irgendwas
YY = solve(DGL_S,'Y');
YY

%% Lpalace-Ruecktransformation: Laplace-Bereich (s) -> Zeitbereich (t)
y_loes = ilaplace(YY, s, t); % Laplace-Ruecktransformation in den Zeitbereich
y_loes

% wir haben unsere Loesung f(t) erhalten / die DGL ist geloest

%% [PLOT] Funktion y(t) plotten

% symb. Variable muss durch Array von Werten ersetzt werden!
time = 0 : 0.01 : 10;
y_time = subs(y_loes, time)';

% nun plotten
figure('Name','Spezielle Loesung: y(t)','NumberTitle','off');

plot(time, y_time);
hold on;

xlabel('Zeit t [s]');
ylabel('y(t)');

legend('y(t)');

% xlim([0, 20]);
% ylim([0, 20]);