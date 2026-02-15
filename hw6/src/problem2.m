function eigs = problem2(A)
    n = size(A, 1);
    max_iter = 1000; 
    tol = 1e-5;   

    D = A;
    for k = 1:max_iter
        OffDiag = abs(D);
        OffDiag(1:n+1:end) = 0; 
        
        [max_val, max_idx] = max(OffDiag(:));
        [p, q] = ind2sub([n, n], max_idx);
        
        if max_val < tol
            break;
        end

        Q = problem1(D, p, q);  % Jacobi rotation from Problem 1
        D = Q' * D * Q;
    end
    
    if k == max_iter
        warning('Jacobi method reached max iterations.');
    end
  
    eigs = diag(D);
end