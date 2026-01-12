function sol = log_(x)
    % Args:
    %     x (double): The input.
    %
    % Returns:
    %     sol (double): ln(x).
    assert(x > 0, 'Input must be strictly positive');
    
    sol = 0;
    n = 1;
    term = 1;
    sign = 1;

    % change of variable
    if x <= 1
        u = x - 1;
    else
        u = (x - 1) / x;
    end
        
    while true
        term = term * u;
        current_term = sign * term / n;

        if abs(current_term) < 1e-8 % stopping criteria
            break;
        end
        
        sol = sol + current_term;
        n = n + 1;
        if x <= 1
            sign = -sign; 
        end
    end
end