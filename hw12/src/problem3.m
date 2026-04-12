function [d_min, d_mean, d_max, d_theory] = problem3(n, d)
    x = rand(n, d);

    dists = pdist(x);

    d_min = min(dists);
    d_mean = mean(dists);
    d_max = max(dists);

    d_theory = sqrt(d);
end