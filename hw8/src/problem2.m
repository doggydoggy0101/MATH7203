function root = problem2(f, df, d2f, x0, tol, max_iter)
    x = x0;
    
    for iter = 1:max_iter
        fx = f(x);
        dfx = df(x);
        d2fx = d2f(x);
        
        denominator = 2 * dfx^2 - fx * d2fx;
        
        if abs(denominator) < eps
            error('halley''s method failed: denominator near zero');
        end

        dx = - (2 * fx * dfx) / denominator;
        x = x + dx;
        
        if abs(dx) < tol
            root = x;
            return;
        end
    end
    
    error('halley''s method did not converge');
end