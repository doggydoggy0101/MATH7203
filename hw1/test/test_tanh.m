function test_tanh()
    fprintf('--- Problem 4 ---\n');
    
    x_vals = logspace(-10, 10, 20);
    
    err_naive = zeros(size(x_vals));
    err_improv = zeros(size(x_vals));

    fprintf('%-12s | %-12s | %-12s\n', 'input', 'err_naive', 'err_improv');
    
    for i = 1:length(x_vals)
        x = x_vals(i);
        true_val = tanh(x);
        
        % naive error
        val_naive = tanh_naive(x);
        err_naive(i) = abs(val_naive - true_val) / abs(true_val);
        
        % improve error
        val_improv = tanh_improve(x);
        err_improv(i) = abs(val_improv - true_val) / abs(true_val);

        fprintf('%-12.4e | %-12.4e | %-12.4e\n', x, err_naive(i), err_improv(i));
    end
    fprintf('\n')

    % for plotting, clamp zeros to 1e-20 
    err_naive(err_naive == 0) = 1e-20;
    err_improv(err_improv == 0) = 1e-20;
    
    f = figure('Name', 'Problem 4 plot');    
    loglog(x_vals, err_naive, 'b^-', 'MarkerFaceColor', 'b', 'DisplayName', 'Naive');
    hold on;
    loglog(x_vals, err_improv, 'ro--', 'MarkerFaceColor', 'r', 'DisplayName', 'Improve');
    
    grid on;
    xlabel('Input');
    ylabel('Relative Error');
    legend('Location', 'best');

    if ~exist('docs', 'dir')
        mkdir('docs');
    end
    output_path = fullfile('docs', 'problem4.png');
    saveas(f, output_path);
end