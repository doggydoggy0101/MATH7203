function test_problem2()
    fprintf('--- problem 2 ---\n');
    
    % chebyshev polynomial t5(x) and its derivatives
    f   = @(x) 16*x.^5 - 20*x.^3 + 5*x;
    df  = @(x) 80*x.^4 - 60*x.^2 + 5;
    d2f = @(x) 320*x.^3 - 120*x;
    
    % analytical roots for testing (n = 5)
    n = 5;
    k = 1:n;
    true_roots = cos((2*k - 1) * pi / (2 * n));
    
    tol = 1e-10;
    max_iter = 100;
    
    computed_roots = zeros(1, n);
    
    fprintf('%-5s %-10s %-10s %-10s\n', 'root', 'computed', 'true', 'error');
    fprintf('%s\n', repmat('-', 1, 40));
    
    for i = 1:n
        % use a starting guess close to the actual root
        x0 = true_roots(i) + 0.1; 
        
        computed_roots(i) = problem2(f, df, d2f, x0, tol, max_iter);
        err = abs(computed_roots(i) - true_roots(i));
        
        fprintf('%-5d %-10.6f %-10.6f %-10.2e\n', i, computed_roots(i), true_roots(i), err);
    end
    fprintf('\n');
    
    % plot 
    x_plot = linspace(-1, 1, 500);
    y_plot = f(x_plot);
    
    fig = figure('name', 'chebyshev', 'color', 'w', 'visible', 'off');
    plot(x_plot, y_plot, 'k-', 'linewidth', 1.5); hold on;
    yline(0, 'r-', 'linewidth', 1);
    
    plot(computed_roots, f(computed_roots), 'bo', 'markerfacecolor', 'b', 'markersize', 6);
    
    xlabel('x');
    ylabel('T5(x)');
    grid on;
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig, fullfile('docs', 'problem2.png'));
    close(fig);
    
    fprintf('plot saved in docs\n');
end