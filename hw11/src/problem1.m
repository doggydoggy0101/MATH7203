function i_val = problem1(a, n)
    % Gauss-Chebyshev quadrature.
    
    % column vector
    a = a(:); 
    
    i = 1:n;
    t = cos((2*i - 1) * pi / (2 * n));
    w = pi / n;
    f_val = exp(a * t);
    i_val = w * sum(f_val, 2);
end