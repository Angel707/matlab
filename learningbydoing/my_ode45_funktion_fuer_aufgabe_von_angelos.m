function [ Dv ] = my_ode45_funktion_fuer_aufgabe_von_angelos( t, v, k )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    y1d = -k(1) * v(1) * v(2);
    y2d = k(1) * v(1) * v(2) -k(2) * v(2);
    y3d = k(2) * v(2);
    
    Dv = [y1d, y2d, y3d]';
end

