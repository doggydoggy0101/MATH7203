function [x, iter, res_hist] = problem2(A, b, x0, tol, max_iter)
    % Gauss-Seidel solver.
    
    n = length(b);
    x = x0;
    res_hist = zeros(max_iter, 1); % Pre-allocate for speed
    
    D = diag(A);
    
    for k = 1:max_iter
        r = b - A*x;
        res_norm = norm(r);
        res_hist(k) = res_norm;
        
        if res_norm < tol
            iter = k - 1;
            res_hist = res_hist(1:iter); % Trim
            return;
        end
        
        % Gauss-Seidel Update
        for i = 1:n
            sigma = A(i, :) * x - D(i) * x(i);
            x(i) = (b(i) - sigma) / D(i);
        end
    end
    
    iter = max_iter;
    warning('Did not converge!');
end