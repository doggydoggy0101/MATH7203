function [pos, t_local] = problem3(sat_data, guess)    
    c = 0.047;
    x = guess;
    tol = 1e-10;
    max_iter = 100;
    
    for iter = 1:max_iter
        f = zeros(4, 1);
        j = zeros(4, 4);
        
        for i = 1:4
            xi = sat_data(i, 1);
            yi = sat_data(i, 2);
            zi = sat_data(i, 3);
            ti = sat_data(i, 4);
            
            dx = x(1) - xi;
            dy = x(2) - yi;
            dz = x(3) - zi;
            
            dist = sqrt(dx^2 + dy^2 + dz^2);
            
            f(i) = dist - c * (x(4) - ti);
            
            j(i, 1) = dx / dist;
            j(i, 2) = dy / dist;
            j(i, 3) = dz / dist;
            j(i, 4) = -c;
        end
        
        step = - j \ f;
        x = x + step;
        
        if norm(step) < tol
            pos = x(1:3);
            t_local = x(4);
            return;
        end
    end
    error('newton''s method did not converge');
end