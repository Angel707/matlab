function [ Dv ] = my_ode45_funktion_fuer_prak_9_aufg_1c ( t, v, parameter )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    %DGL = (parameter(1) * v(4) + parameter(2) * v(3) + parameter(3) * v(2) + 4 * cos(t)) * parameter(5);
    DGL = (12 * v(4) - 11 * v(3) + 3 * v(2) + 4 * cos(t)) * 1/4;
    Dv = [ v(2), v(3), v(4), DGL ]';
                              %  / \
                              %   |
                              %   .... >'< Transponiert den Zeilenvektor in Spaltenvektor vice versa
end

