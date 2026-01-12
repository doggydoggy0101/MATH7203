function test_log_reduction()

    fprintf('--- Problem 3 ---\n');
    
    test_vals = logspace(-6, 6, 10); 
    fprintf('%-12s | %-10s | %-10s | %-10s | %s\n', ...
            'input', 'log_reduct', 'log_matlab', 'rel_err', 'rt_err');

    for x = test_vals
        y_impl = log_reduction(x);
        y_true = log(x);
        
        % relative error test
        rel_tol = 1e-5 * max(1, x);
        rel_err = abs(y_impl - y_true);
        assert(rel_err < rel_tol, 'Relative error test failed');

        % round trip test
        rt_tol = 1e-2;
        rt_err = abs(exp(y_impl) - x);
        assert(rt_err < rt_tol, 'Round trip test failed');

        fprintf('%-12.4f | %-10.4f | %-10.4f | %-10.1e | %s\n', ...
                x, y_impl, y_true, rel_err, rt_err);
    end
    fprintf('All tests passed\n\n');
end
