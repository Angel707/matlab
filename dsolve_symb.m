% VORLAGE Symbolisches Loesen einer DGL (dsolve)
% Angelos Drossos
% 19.02.1013
% GPLv2

% Tipp: Immer das komplette Skript ausfuehren (Run-Button / F5)

%% Workspace loeschen, Console loeschen, alle Fenster schliessen
% dient der Sicherheit / um Fehler schnell zu erkennen
clc
clear all
close all

disp('==========  Symbolisches Loesen einer DGL (dsolve)  =============')

%% Symbolische Deklarationen: Variable als 'ohne Wert' deklarieren
% t     -- Zeit (kann sein, dass sich t aus y(t) ergibt)
% y(t)  -- Funktion
syms y(t)


%% Ableitungen werden mit diff(y, n) definiert [siehe Hilfe]
% y: funktion, die abgeleitet werden soll --> y(t) in syms aufnehmen
% n: Wie oft soll differenziert werden, z.B. diff(y,2) == diff(diff(y))
Dy  = diff(y, 1);  % entspricht y'(t)
D2y = diff(y, 2);  % entspricht y''(t)
D3y = diff(y, 3);  % entspricht y'''(t)
D4y = diff(y, 4);  % entspricht y''''(t)
% Achtung: diff(y(t)) ist erlaubt, kann aber manchmal zum Fehler fuehren!


%% Aufbau der DGL in dsolve
% Man kann mit dsolve entweder die allgemeine Loesung einer DGL
% ausgeben lassen oder die spezielle Loesung,
% wenn man die Anfangsbedinungen angibt.
%
% dsolve( DGL, Anfangsbed 1, Anfangsbed 2, ...)
%
% Es gibt die Moeglichkeit, die Ausdruecke DGL und Anfangsbed.
% als Strings anzugeben oder als Gleichung ohne Strings.
% Zweite Variante verlangt '==' fuer das Gleichheitszeichen.
%
% Mit pretty kann man sich eine formatiere Ausgabe des Ergebnisses
% anzeigen und mit simple kann die Ausgabefunktion vereinfacht werden.

%% Allgemeine Loesung in dsolve
% Gebe nur die DGL an, aber keine Anfangsbedinungen.
%    Hier werden weitere Konstanten C1/C2/... angegeben.

Sy = dsolve( Dy == - y + t * exp(t) );

disp('allg. Loesung: y(t) = ')
pretty(Sy);

%% Spezielle Loesung in dsolve
% Gebe sowohl die DGL an als auch die Anfangsbedinungen an.
%    Hier werden dann die Konstanten der allg. Loesung
%    durch die Anfangsbedingungen bestimmt.

% ... bewirkt, dass man den Befehl auf der naechsten Zeile fortsetzen kann

ys = dsolve( Dy == - y + t * exp(t), ...
             y(0) == 5 );
disp('spezielle Loesung: y(t) = ')
pretty(ys);

disp('spezielle Loesung, vereinfacht: y(t) = ')
ys = simple(ys);
pretty(ys);

%% Spezielle Loesung zeichnen
% Hinweis: Allgemeine Funktion ist eine Funktionschar!

% x-Achse: Anfang und Ende fuer den ezplot
t_span = [0 , 10];

figure('Name','Spezielle Loesung: y(t)','NumberTitle','off');
ezplot(ys, t_span);
hold on;

xlabel('Zeit t [s]');
ylabel('y(t)');

legend('y(t)');

xlim(t_span);
% ylim([0, 20]);