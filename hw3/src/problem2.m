function [n_values, cond_nums, error_norms, error_estimates] = problem2(max_n)
    % Args:
    %   max_n (int): The maximum matrix dimension to test.
    %
    % Returns:
    %   n_values (vector): Dimension.
    %   cond_nums (vector): Condition numbers.
    %   error_norms (vector): Norm of the difference (x_true - x_calc).
    %   error_estimates(vector): Error estimate (cond * eps).
    warning_state = warning('off', 'MATLAB:nearlySingularMatrix');

    n_values = 2:max_n;
    num_points = length(n_values);
    
    cond_nums = zeros(num_points, 1);
    error_norms = zeros(num_points, 1);
    error_estimates = zeros(num_points, 1);
    
    for k = 1:num_points
        n = n_values(k);
        
        H = hilb(n);
        x0 = ones(n, 1);
        b = H * x0;
        xc = H \ b;
        c_n = cond(H);
        cond_nums(k) = c_n;
        r_n = norm(x0 - xc);
        error_norms(k) = r_n;
        error_estimates(k) = c_n * eps(1);
    end
    
    warning(warning_state);
end