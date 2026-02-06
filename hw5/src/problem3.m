function D = problem3(A)
    % Args:
    %   A: NxN Positive Definite matrix.
    %
    % Returns:
    %   D: NxN matrix where columns are A-conjugate.

    [n, m] = size(A);
    if n ~= m
        error('Input matrix must be square.');
    end

    D = zeros(n, n);
    for k = 1:n
        u_k = A(:, k);
        
        d_k = u_k;
        
        for j = 1:k-1
            % Gram-Schmidzt
            d_j = D(:, j);
            numerator = u_k' * A * d_j;
            denominator = d_j' * A * d_j;
            beta = numerator / denominator;
            d_k = d_k - beta * d_j;
        end
        D(:, k) = d_k;
    end
end