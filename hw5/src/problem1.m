function A_inv = problem1(A)
    [n, m] = size(A);
    if n ~= m
        error('Input matrix must be square.');
    end

    [L, U, P] = lu(A);

    A_inv = zeros(n);
    I = eye(n); 

    for i = 1:n
        e_i = I(:, i);

        b = P * e_i;
        
        y = zeros(n, 1);
        for j = 1:n
            val = b(j) - L(j, 1:j-1) * y(1:j-1);
            y(j) = val / L(j, j);
        end

        n = length(y);
        x = zeros(n, 1);
        for j = n:-1:1
            val = y(j) - U(j, j+1:end) * x(j+1:end);
            x(j) = val / U(j, j);
        end

        A_inv(:, i) = x;
    end
end