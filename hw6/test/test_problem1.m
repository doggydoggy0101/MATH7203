function test_problem1()
    fprintf('--- Problem 1 ---\n');

    rng(42);
    num_tests = 100;

    fprintf('%-10s %-15s %-15s %-10s\n', 'Size', 'Orth Err', 'Zero Res', 'Status');
    fprintf('%s\n', repmat('-', 1, 55));
    
    for k = 1:num_tests
        N = randi([2, 100]);

        A = randn(N);
        A = A + A';

        idx = randperm(N, 2);
        i = idx(1);
        j = idx(2);
        
        try
            Q = problem1(A, i, j);

            orth_err = norm(Q' * Q - eye(N));

            B = Q' * A * Q;
            zero_res = abs(B(i, j));

            tol = 1e-10 * N;
            
            if orth_err < tol && zero_res < tol
                status = 'PASS';
            else
                status = 'FAIL';
            end
            
            fprintf('%-10d %-15.2e %-15.2e %-10s\n', ...
                N, orth_err, zero_res, status);
                
        catch ME
            fprintf('%-10d ERROR: %s\n', N, ME.message);
        end
    end
    fprintf('\n');
end