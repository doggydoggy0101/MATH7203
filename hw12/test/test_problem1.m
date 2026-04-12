function test_problem1()
    fprintf('--- problem 1 ---\n');
    
    n = 32;
    
    % test for z in [1.0, 10] 
    z_vals1 = linspace(1, 10, 200)';
    approx1 = problem1(z_vals1, n);
    true1 = gamma(z_vals1);
    err1 = abs(approx1 - true1);
    
    % test for z in [0.1, 1.0] 
    z_vals2 = linspace(0.1, 1, 200)';
    approx2 = problem1(z_vals2, n);
    true2 = gamma(z_vals2);
    err2 = abs(approx2 - true2);
    
    fprintf('max error for z in [1.0, 10]: %e\n', max(err1));
    fprintf('max error for z in [0.1, 1.0]: %e\n\n', max(err2));
end