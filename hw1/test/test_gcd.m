function test_gcd()
    fprintf('--- Problem 1 ---\n');

    % divisibility
    x = 54; y = 24;
    sol = gcd_EuclidAlgorithm(x, y);
    fprintf('GCD(%d, %d) = %d\n', x, y, sol);
    assert(mod(x, sol) == 0 && mod(y, sol) == 0, 'Divisibility test failed');
    fprintf('Divisibility test passed\n');

    % coprimality
    x = 105; y = 252;
    sol = gcd_EuclidAlgorithm(x, y);
    fprintf('GCD(%d, %d) = %d\n', x, y, sol);
    assert(gcd(x/sol, y/sol) == 1, 'Coprimality test failed');
    fprintf('Coprimality test passed\n');

    % Fibonacci
    x = 21; y = 34;
    sol = gcd_EuclidAlgorithm(x, y);
    fprintf('GCD(%d, %d) = %d\n', x, y, sol);
    assert(sol == 1, 'Fibonacci test failed');
    fprintf('Fibonacci test passed\n');

    fprintf('\n');
end