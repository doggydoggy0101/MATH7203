function frac = problem2(n)
    a = 2 * rand(n, 1) - 1;
    b = 2 * rand(n, 1) - 1;
    c = 2 * rand(n, 1) - 1;

    is_spd = (a > 0) & ((a .* c - b.^2) > 0);

    frac = sum(is_spd) / n;
end