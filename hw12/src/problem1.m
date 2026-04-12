function val = problem1(z, n)
    [t, w] = glagwt(n);
    
    z = z(:)';
    t = t(:);
    w = w(:);
    
    f_val = t .^ (z - 1);
    
    val = w' * f_val;
    val = val(:);
end

function [x, w] = glagwt(n)
    % computes nodes and weights for Gauss-Laguerre quadrature
    
    % build the symmetric tridiagonal jacobi matrix for laguerre polynomials
    a = 2 * (1:n) - 1;
    b = 1:(n-1);
    j_mat = diag(a) + diag(b, 1) + diag(b, -1);
    
    % eigenvalues are the nodes, first row of eigenvectors gives the weights
    [v, d] = eig(j_mat);
    [x, idx] = sort(diag(d));
    v = v(:, idx);
    
    % weights are the square of the first element of the normalized eigenvectors
    w = (v(1, :).^2)';
end