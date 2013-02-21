% VORLAGE Numerisches Loesen von Differentialgleichungen (mit ode45)
% Angelos Drossos
% 19.02.1013
% GPLv2

function [ Diff_v ] = ode45_dgl1n( t, v, params )
%ode45_dgl1n ode45-DGL-Funktion.
%    Funktion, die man der ode45-Funktion uebergibt
%    und die DGL in Form von eines Systems von DGLn erster Ordnung angibt.
%
%    t: Simulationsvariable (meistens die Zeit)
%    v: Werte zum Zeitpunkt 't'
%           v1 --> y(t)
%           v2 --> y'(t)
%
% klein t: aktueller Simulationszeitpunkt
% groﬂ T:  alle Simulationszeitpunkte als Vektor (siehe ode45_skript.m)
%
% Hinweis:
%     Events koennen in einer extra Funktion abgehandelt werden.
%             (ist hier allerdings auch moeglich, aber nicht so schoen.)
%     Hinter v koennen Parameter uebergeben werden (es muss nicht nur ein Parameter sein).
%     Der Ausgabeparameter muss ein Spaltenvektor sein!
%
% Hinweis, wenn wir keine DGL (n)-ter Ordnung haben:
%     Wenn wir bereits ein System von DGLn 1. Ordnung haben,
%     dann muessen wir hier nicht viel machen.
%     Dann lediglich deren Ableitungen angeben. (??)

%% UEbergebene Parameter extrahieren (der Lesbarkeit halber)
k1 = params(1);
k2 = params(2);
k3 = params(3);
k4 = params(4);

%% [Schritt 1] v-Vektor definieren
% Mit anderen Worten: Eine DGL (n)-ter Ordnung muss
% in ein System von Differentialgleichungen 1. Ordnung ueberfuehrt werden.
% Dazu definiere einfach:
%  v     = [  y(t)  y'(t)  y''(t)  y'''(t) ] bis zur (n-1). Ableitung
%        = [  v(1)  v(2)   v(3)    v(4)    ]
% Die untere Zeile gibt an, wie man in Matlab auf die Elemente zugreift.
y   = v(1);
Dy  = v(2);
%D2y = v(3);
%D3y = v(4);

%% [Schritt 2] Die DGL (n)-ter Ordnung umformen
% Forme die DGL (n)-ter Ordnung so um, dass
%       y^{(n)}(t) = ...
% da steht, also die hoechste Ableitung links und ALLES andere nach rechts.
% 
% Beispiel:  DGL ist
%      8 y''''(t) - 12 y'''(t) + 11 y''(t) - 3 y'(t) = 9 cos(t)
% Hoechste Ableitung ist y''''(t), also n = 4.
% Nach der Umformung ergibt sich:
%      DGL := y''''(t) = ( 9 cos(t) + 12 y'''(t) - 11 y''(t) + 3 y'(t)  ) / 8
%
% Die Aufgabe besteht nun darin, y und ihre Ableitungen in der DGL
% durch Elemente des v-Vektors zu ersetzen.
%      DGL := y''''(t) = ( 9 cos(t) + 12 v(4) - 11 v(3) + 3 v(2)  ) / 8
%
DGL = ( -2 * k1 * Dy - k2 * y + k3 * cos(k4 * t) ) / 1;
D2y = DGL;

%% [Schritt 3] v-Vektor einmal ableiten
% v-Vektor abgeleitet ergibt Diff_v. Also:
% Diff_v =        [ y'(t)  y''(t)  y'''(t) y''''(t) ]
%        =        [ v(2)   v(3)    v(4)    DGL      ]
% Auch hier werden die Ableitungen mithilfe des v-Vektors beschrieben.
% Bei der hoechsten Ableitung muss man dann die umgeformte DGL einsetzen.
%
% Beispiel:
% y''''(t) = Diff_v(4) = ( 4 cos(t) + 12 y'''(t) - 11 y''(t) + 3 y'(t) ) / 4
%                      = ( 4 cos(t) + 12 v(4)    - 11 v(3)   + 3 v(2)  ) / 4

Diff_v = [ Dy D2y ];

Diff_v = Diff_v'; %  Ausgabe muss ein Spaltenvektor sein

end

