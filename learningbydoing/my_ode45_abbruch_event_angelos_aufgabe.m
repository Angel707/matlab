function [ value, isterminal, direction ] = my_ode45_abbruch_event_angelos_aufgabe( t, v, parameter )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    % abbruch bei: value == 0 && isterminal == 1
    % direction? who cares...
    
    whocares = 12345678;
    
    if(v(3) > 0.95 * 1000)
        value = 0;
        isterminal = 1;
        direction = 0;
    else
        value = whocares;
        isterminal = 0;
        direction = 0;
    end
    
    %direction = 1;
    %isterminal = 1;
    %value = ceil(v(3)) - 0.95 * 1000;
end

