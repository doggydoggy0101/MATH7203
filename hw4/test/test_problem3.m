function test_problem3()
    fprintf('--- Problem 3 ---\n');

    rng(42);
    num_tests = 100;

    fprintf('%-10s %-15s %-15s %-10s\n', 'Size (N)', 'Residual', 'Tolerance', 'Status');
    fprintf('%s\n', repmat('-', 1, 50));

    for k = 1:num_tests
        N = randi([2, 25]);

        A = randn(N, N);
        b = randn(N, 1);

        [~, U] = lu(A);
        x_calc = problem3(U, b);

        b_recon = U * x_calc;
        residual = norm(b - b_recon);

        tol = eps(1) * cond(U);
        if residual < tol
            status = 'PASS';
        else
            status = 'FAIL';
        end

        fprintf('%-10d %-15.2e %-15.2e %-10s\n', ...
            N, residual, tol, status);
    end
    fprintf('\n');
end