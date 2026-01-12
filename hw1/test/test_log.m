function test_log()
    fprintf('--- Problem 2 ---\n');
    
    test_vals = logspace(-2, 2, 10); 
    fprintf('%-10s | %-10s | %-10s | %-10s | %s\n', ...
            'input', 'log_impl', 'log_matlab', 'rel_err', 'rt_err');

    for x = test_vals
        y_impl = log_(x);
        y_true = log(x);
        
        % relative error test
        rel_tol = 1e-5 * max(1, x);
        rel_err = abs(y_impl - y_true);
        assert(rel_err < rel_tol, 'Relative error test failed');

        % round trip test
        rt_tol = 1e-2;
        rt_err = abs(exp(y_impl) - x);
        assert(rt_err < rt_tol, 'Round trip test failed');

        fprintf('%-10.4f | %-10.4f | %-10.4f | %-10.1e | %s\n', ...
                x, y_impl, y_true, rel_err, rt_err);
    end
    fprintf('All tests passed\n\n');

    x = 1e4;
    y_impl = log_(x);
    y_true = log(x);
    
    rel_err = abs(y_impl - y_true);
    rt_err = abs(exp(y_impl) - x);
    fprintf('%-10.4f | %-10.4f | %-10.4f | %-10.1e | %s\n', ...
            x, y_impl, y_true, rel_err, rt_err);
    fprintf('\n');
end