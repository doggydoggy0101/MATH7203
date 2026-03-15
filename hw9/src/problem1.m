function yi = problem1(x, y, xi)    
    yi = zeros(size(xi));
    n = length(x);
    
    for k = 1:length(xi)
        x_val = xi(k);
        
        % clamping
        if x_val <= x(1)
            yi(k) = y(1);
            continue;
        elseif x_val >= x(n)
            yi(k) = y(n);
            continue;
        end
        
        % interpolate
        for i = 1:(n - 1)
            if x_val >= x(i) && x_val <= x(i+1)
                t = (x_val - x(i)) / (x(i+1) - x(i));
                yi(k) = y(i) + t * (y(i+1) - y(i));
                break;
            end
        end
    end
end