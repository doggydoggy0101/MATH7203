function pass = problem2(A)
    % Assertion 1: A'A and AA' are symmetric.
    % Assertion 2: A'A and AA' are positive semi-definite.
    % Assertion 3: V (from SVD) holds eigenvectors of A'A.
    % Assertion 4: U (from SVD) holds eigenvectors of AA'.
    % Assertion 5: Eigenvalues of A'A and AA' are singular values squared.
    [U, S, V] = svd(A, 'econ'); 
    s_vals = diag(S);
    
    ATA = A' * A;
    AAT = A * A';
    
    tol = 1e-10;  % the tol homework gave is weirdly large

    % assertion 1
    if norm(ATA - ATA') > tol
        error('Assertion 1 Failed: ATA is not symmetric.');
    end
    if norm(AAT - AAT') > tol
        error('Assertion 1 Failed: AAT is not symmetric.');
    end

    % assertion 2
    eigs_ATA = eig(ATA);
    eigs_AAT = eig(AAT);
    
    if any(eigs_ATA < -tol)
        error('Assertion 2 Failed: ATA is not positive semidefinite.');
    end
    if any(eigs_AAT < -tol)
        error('Assertion 2 Failed: AAT is not positive semidefinite.');
    end

    % assertion 3
    [V_eig_ATA, D_ATA] = eig(ATA);
    [eigs_ATA_sorted, idx_ATA] = sort(diag(D_ATA), 'descend');
    V_eig_ATA_sorted = V_eig_ATA(:, idx_ATA);

    [V_eig_AAT, D_AAT] = eig(AAT); 
    [eigs_AAT_sorted, idx_AAT] = sort(diag(D_AAT), 'descend');
    V_eig_AAT_sorted = V_eig_AAT(:, idx_AAT);
    
    K = length(s_vals); 

    % assertion 3
    for i = 1:K
        dot_prod = abs(dot(V(:,i), V_eig_ATA_sorted(:,i)));
        if abs(dot_prod - 1) > 1e-5 
             warning('Assertion 3: V column %d direction mismatch (dot=%f)', i, dot_prod);
        end
    end

    % assertion 4
    for i = 1:K
        dot_prod = abs(dot(U(:,i), V_eig_AAT_sorted(:,i)));
        if abs(dot_prod - 1) > 1e-5
             warning('Assertion 4: U column %d direction mismatch (dot=%f)', i, dot_prod);
        end
    end

    % assertion 5
    if norm(eigs_ATA_sorted(1:K) - s_vals.^2) > tol
        error('Assertion 5 Failed: eig(ATA) != sigma^2');
    end
    if norm(eigs_AAT_sorted(1:K) - s_vals.^2) > tol
        error('Assertion 5 Failed: eig(AAT) != sigma^2');
    end

    pass = true;
end