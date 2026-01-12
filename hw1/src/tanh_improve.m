function sol = tanh_improve(x)
    ax = abs(x);
    if ax < 1e-3 
        sol = x - (x^3)/3; % first order Taylor series
    elseif ax < 1e3
        sol = tanh_naive(x); % naive implementation
    else
        sol = sign(x); % asymptotes to 1/-1
    end
end