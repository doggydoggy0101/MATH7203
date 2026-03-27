function test_problem2()
    fprintf('--- problem 2 ---\n');
    
    f1 = @(x, y) (x .* y).^0.25;
    f2 = @(x, y) 1 ./ (1 + x + y);

    true_i1 = 16 / 25;
    true_i2 = log(27 / 16);
    
    n_vals = [2, 4, 8, 16, 32];
    err_i1 = zeros(size(n_vals));
    err_i2 = zeros(size(n_vals));
    
    for idx = 1:length(n_vals)
        n = n_vals(idx);

        val1 = problem2(f1, n);
        val2 = problem2(f2, n);

        err_i1(idx) = abs(val1 - true_i1);
        err_i2(idx) = abs(val2 - true_i2);
    end
    
    % plot 
    fig = figure('name', 'gl_error', 'color', 'w', 'visible', 'off');
    
    loglog(n_vals, err_i1, 'ro-', 'linewidth', 1.5, 'markerfacecolor', 'w'); hold on;
    loglog(n_vals, err_i2, 'bo-', 'linewidth', 1.5, 'markerfacecolor', 'w');
    
    grid on;
    xlabel('Order n');
    ylabel('Error');
    title('Error vs Order for 2D Gauss-Legendre quadrature');
    legend('I_1', 'I_2');
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig, fullfile('docs', 'problem2.png'));
    close(fig);
    
    fprintf('plot saved in docs\n');
end