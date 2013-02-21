%% Aufgabenstellung
% y_1'(t) = - k_1
%%


clc
clear all
close all

k = [0.002, 0.2]
zeitraum = [0, 6]
anfangswerte = [1000, 500, 200]

flag = odeset('Events', @my_ode45_abbruch_event_angelos_aufgabe);

[T, v] = ode45(@my_ode45_funktion_fuer_aufgabe_von_angelos,  ...
            zeitraum,  anfangswerte, ...
            flag, k);
plot(T, v(:,:));