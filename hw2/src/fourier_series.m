function coef = fourier_series(n)
    % Args:
    %     n (int): Coefficient index.
    %
    % Returns:
    %     coef (double): Coefficient.
    if n == 0
        coef = 2 * (1 - exp(-1));
    else
        coef = 2 * (1 - exp(-1) * (-1)^n) / (1 + (n * pi)^2);
    end
end