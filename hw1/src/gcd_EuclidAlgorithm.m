function sol = gcd_EuclidAlgorithm(x, y)
    % Args:
    %     x (int): The first integer input.
    %     y (int): The second integer input.
    %
    % Returns:
    %     sol (int): The greatest common divisor of x and y.
    
    a = min(x, y);
    b = max(x, y);

    while true
        c = b - a;

        if c == a
            sol = a;
            return;
        end

        temp = a; 
        a = min(temp, c);
        b = max(temp, c);
    end
end