function [ Dv ] = my_ole_function_angelos_doppelt( t, v, k )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

    %%
    % v = [x, x', y, y'];
    % v' = [v(2), x'', v(4), y''];
    %%
    
    x = v(1);
    xd = v(2);
    y = v(3);
    yd = v(4);
        
    xd2 = k(1) * x / (x^2 + y^2)^3;
    yd2 = k(1) * y / (x^2 + y^2)^3;
    
    Dv = [xd, xd2, yd, yd2]';

end

