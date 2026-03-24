function coeffs = problem1(t_celsius, r_ohms)
    % find Steinhart-Hart coefficients

    t_kelvin = t_celsius + 273.15;
    y = 1 ./ t_kelvin;
    ln_r = log(r_ohms);
    x = [ones(size(r_ohms)), ln_r, ln_r.^3];
    coeffs = (x' * x) \ (x' * y);
end