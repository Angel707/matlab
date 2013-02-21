% VORLAGE Numerisches Loesen von Differentialgleichungen (mit ode45)
% Angelos Drossos
% 19.02.1013
% GPLv2

function [ value, isterminal, direction  ] = ode45_event_fkt( t, v, params )
%ode45_event_fkt ode45-Event-Funktion.
%   Mit der Event-Funktion kann die Simulation gesteuert werden,
%   insbesondere kann sie gestoppt werden.
%
%   Hinweis:
%   Die Parameter sind die gleichen wie in der ode45-dgl1n-Funktion!
%
%   Wichtig:
%   Die richtige Angabe von direction ist wichtig, denn
%   direction beeinflusst, wann Events auftreten!
%      direction = +1 :  steigende Flaken erzeugen lediglich Events
%      direction = -1 :  fallende  Flaken erzeugen lediglich Events
%      direction =  0 :  steigende und fallende  Flaken erzeugen Events
%    --> die Flanken beziehen sich auf das Verhalten von value!

fkt0 = v(1); % die Abbruchfunktion

% Die Simulation wird gestoppt, wenn (value == 0 && isterminal == 1)!
value = fkt0;   % value berechnet den aktuellen Event-Wert
isterminal = 1; % Soll die Simulation gestoppt werden?
direction = 0;  % siehe (odeset)

end

