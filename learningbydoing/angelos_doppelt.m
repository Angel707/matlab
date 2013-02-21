clc
clear all
close all


k = [5000];

x0 = [1, 2 * 10^5];
y0 = [0, 1 * 10^5];

v0 = [x0(1), x0(2), y0(1), y0(2)];

t = [0, 100 * pi];


[T, v] = ode45(@my_ole_function_angelos_doppelt, t, v0, flag, k);
figure(1)
plot(T, v(:,1), T, v(:,3))
figure(2)

%%
% '.' -- Punkte
% b -- blau
% g -- gruen
% r -- gruen
% - -- verbinden
% + -- Punkte als X markieren
%%
plot(v(:,1), v(:,3),'.')

title('Punktdarstellung der Ergebnisse')
legend('X-Werte', 'Y-Werte')
grid
xlabel('X')
ylabel('Y')
subplot(2,2,2);