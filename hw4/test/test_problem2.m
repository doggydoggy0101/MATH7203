function test_problem2()
    fprintf('--- Problem 2 ---\n');
    rng(42);
    num_tests = 100;

    fprintf('%-12s %-10s\n', 'Size (N, M)', 'Status');
    fprintf('%s\n', repmat('-', 1, 20));

    for k = 1:num_tests
        N = randi([2, 25]);
        M = randi([2, 25]);
        
        A = randn(N, M);
        if problem2(A)
            status = 'PASS';
        else
            status = 'FAIL';
        end
        fprintf('(%2d, %2d)     %-10s\n', N, M, status);
    end
    fprintf('\n');
end