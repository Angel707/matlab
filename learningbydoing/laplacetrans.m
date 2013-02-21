clc
clear all
close all

syms y(t) s Y t

Dy = diff(y, 1);
D2y = diff(y, 2);
D3y = diff(y, 3);
D4y = diff(y, 4);

L = laplace(4 * D4y - 12 * D3y + 11 * D2y -3 * Dy, t, s);

% nun die Anfangswerte Substituieren
S1 = subs(L, 'y(0)', '5');
S2 = subs(S1, 'D(y)(0)', '4');
S3 = subs(S2, 'D(D(y))(0)', '3');
S4 = subs(S3, 'D(D(D(y)))(0)', '2');

Rechts = laplace(4 * cos(t), t, s);
% Gleichung ist dann der Form ... = 0
Alles = subs(S4 - Rechts, 'laplace(y(t), t, s)', 'Y');

% Gleichung nach Y loesen
% A)
Loesung = solve(Alles, Y);
%Ruecksransformation
disp('Loesung A')
ilaplace(Loesung, s, t)


disp('Loesung B (allgemeine Loesung)')
dsolve(D4y - (4 * cos(t) + 12 * D3y - 11 * D2y + 3 * Dy )/4)

disp('konkrete Loesung')
dsolve(D4y - (4 * cos(t) + 12 * D3y - 11 * D2y + 3 * Dy )/4, y(0) == 5, Dy(0) == 4, D2y(0) == 3, D3y(0) == 2)
L = dsolve(D4y - (4 * cos(t) + 12 * D3y - 11 * D2y + 3 * Dy )/4, [y(0), Dy(0), D2y(0), D3y(0)] == [5, 4, 3, 2]);
S = simple(L);
pretty(S)
Bild = ezplot(S, [0,6*pi])

pause

disp('Loesung C (ode45)')
% Gleichungssystem in GS 1. Ordnung ueberfuehren:
% c_4 y^{(4)}(t) + c_3 y'''(t) + c_2 y''(t) + c_1 y'(t) + c_0 y(t) = b(t)
% Vektor:
%  /  y(t)   \
% |   y'(t)   | = v = |
% |  y''(t)   |       |
%  \ y'''(t) /         \
%  /  y'(t)   \          /  v_2      \
% |   y''(t)   | = v' = |   v_3       |
% |  y'''(t)   |        |   v_4       |
%  \ y''''(t) /          \  y^(n)(t) /
%

clc
clear all
close all

%ode_v = [diff(y), diff(y,2), diff(y,3)]
zeitspanne = [0, 6 * pi];
%                      y(0),  y'(0),  y''(0),  y'''(0)
anfangsbedingungen = [    5,      4,       3,       2 ];
meineparameterliste = [12, -11,  3, 1234567890987654321, 1/4];
[T, v] = ode45(@my_ode45_funktion_fuer_prak_9_aufg_1c,  zeitspanne, anfangsbedingungen, flag, meineparameterliste);
plot(T, v(:,1));


















