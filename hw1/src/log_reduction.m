function sol = log_reduction(x)
    % Args:
    %     x (double): The input.
    %
    % Returns:
    %     sol (double): ln(x).
    assert(x > 0, 'Input must be strictly positive');
    
    p2 = 0;
    lg2 = log(2); 
    
    while x > 1.8
        x = x / 2;
        p2 = p2 + lg2;
    end

    % also deal with small values
    while x < 0.7
        x = x * 2;
        p2 = p2 - lg2;
    end
    
    y = log_(x); % series expansion implementation
    sol = y + p2;
end