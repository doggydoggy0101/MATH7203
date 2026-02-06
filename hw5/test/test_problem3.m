function test_problem3()
    fprintf('--- Problem 3 ---\n');
    
    rng(42);
    num_tests = 100;

    fprintf('%-10s %-15s %-10s\n', 'Size', 'Error', 'Status');
    fprintf('%s\n', repmat('-', 1, 35));
    
    for k = 1:num_tests
        N = randi([2, 100]);
        
        % positive definite matrix
        M = randn(N, N);
        A = M * M' + eye(N);
        
        try
            D = problem3(A);
            G = D' * A * D;
            
            off_diagonal_matrix = G - diag(diag(G));
            max_error = max(max(abs(off_diagonal_matrix)));

            tol = 1e-6 * N; 
            if max_error < tol
                status = 'PASS';
            else
                status = 'FAIL';
            end
            
            fprintf('%-10d %-15.2e %-10s\n', ...
                N, max_error, status);
                
        catch ME
            fprintf('Size %2d: ERROR (%s)\n', N, ME.message);
        end
    end
    fprintf('\n');
end