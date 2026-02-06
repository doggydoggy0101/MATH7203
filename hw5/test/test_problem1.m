function test_problem1()
    fprintf('--- Problem 1 ---\n');

    rng(42);
    num_tests = 100;

    fprintf('%-10s %-15s %-15s %-10s\n', 'Size', 'Error', 'Residual', 'Status');
    fprintf('%s\n', repmat('-', 1, 50));
    
    for k = 1:num_tests
        N = randi([2, 100]);
        
        A = randn(N) + eye(N) * N; 
        
        try
            A_inv = problem1(A);
            A_inv_matlab = inv(A);
            err_diff = norm(A_inv - A_inv_matlab);
            res_identity = norm(A * A_inv - eye(N));
            
            tol = 1e-10 * N;
            
            if err_diff < tol && res_identity < tol
                status = 'PASS';
            else
                status = 'FAIL';
            end
            
            fprintf('%-10d %-15.2e %-15.2e %-10s\n', ...
                N, err_diff, res_identity, status);
                
        catch ME
            fprintf('%-10d ERROR: %s\n', N, ME.message);
        end
    end
    fprintf('\n');
end