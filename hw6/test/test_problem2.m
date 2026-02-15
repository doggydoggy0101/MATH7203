function test_problem2()
    fprintf('--- Problem 2 ---\n');

    rng(42);
    num_tests = 100;

    fprintf('%-10s %-15s %-10s\n', 'Size', 'Error', 'Status');
    fprintf('%s\n', repmat('-', 1, 35));
    
    for k = 1:num_tests
        N = randi([3, 20]);
        A = randn(N);
        A = A + A';
        
        try
            eigvals = problem2(A);
            
            eigvals_matlab = eig(A);
            
            eigvals = sort(eigvals);
            eigvals_matlab = sort(eigvals_matlab);
            
            err = norm(eigvals - eigvals_matlab);
            
            tol = 1e-8 * N;
            
            if err < tol
                status = 'PASS';
            else
                status = 'FAIL';
            end
            
            fprintf('%-10d %-15.2e %-10s\n', ...
                N, err, status);
                
        catch ME
            fprintf('%-10d ERROR: %s\n', N, ME.message);
        end
    end
    fprintf('\n');
end