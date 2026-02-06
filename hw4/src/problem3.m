function x = problem3(U, b)
    % Args:
    %   U: N x N upper triangular matrix
    %   b: N x 1 column vector
    %
    % Returns:
    %   x: N x 1 solution vector
    [n, m] = size(U);
    if n ~= m
        error('Matrix U must be square.');
    end
    if length(b) ~= n
        error('Vector b must match matrix dimensions.');
    end

    x = zeros(n, 1);
    for i = n:-1:1
        sum_val = 0;
        for j = i+1:n
            sum_val = sum_val + U(i, j) * x(j);
        end
        if U(i, i) == 0
            warning('Matrix is singular (zero on diagonal).');
        end
        x(i) = (b(i) - sum_val) / U(i, i);
    end
end