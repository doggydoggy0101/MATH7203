function test_problem2()
    fprintf('--- problem 2 ---\n');
    
    % morlet wavelet function
    w = @(x) exp(-(x.^2) / 2) .* cos(2 * x);
    
    x_dense = linspace(-2, 2, 1000);
    y_true = w(x_dense);
    
    %% --- part 1: comparison for n = 9 ---
    n_plot = 9;

    x_eq = linspace(-2, 2, n_plot);
    y_eq = w(x_eq);

    k_vals = 1:n_plot;
    x_cheb = 2 * cos((2 * k_vals - 1) * pi / (2 * n_plot));
    y_cheb = w(x_cheb);

    y_interp_eq = problem2(x_eq, y_eq, x_dense);
    y_interp_cheb = problem2(x_cheb, y_cheb, x_dense);

    fig1 = figure('name', 'interp_comparison', 'color', 'w', 'visible', 'off');
    
    plot(x_dense, y_true, 'k-', 'linewidth', 1.2); hold on;
    plot(x_dense, y_interp_cheb, 'b-', 'linewidth', 1.2);
    plot(x_dense, y_interp_eq, 'g-', 'linewidth', 1.2);
    
    plot(x_cheb, y_cheb, 'bo', 'markersize', 6, 'markerfacecolor', 'none');
    plot(x_eq, y_eq, 'go', 'markersize', 6, 'markerfacecolor', 'none');
    
    xlabel('x');
    ylabel('w(x)');
    title(sprintf('comparison of interpolations for n = %d', n_plot));
    legend('orig fcn', 'chebyshev', 'equidistant', 'location', 'best');
    grid on;
    
    %% --- part 2: rms error vs number of points ---
    n_vals = 2:19;
    rms_eq = zeros(size(n_vals));
    rms_cheb = zeros(size(n_vals));
    
    for idx = 1:length(n_vals)
        n = n_vals(idx);

        xe = linspace(-2, 2, n);
        ye = w(xe);
        yi_e = problem2(xe, ye, x_dense);
        rms_eq(idx) = sqrt(mean((yi_e - y_true).^2));

        kc = 1:n;
        xc = 2 * cos((2 * kc - 1) * pi / (2 * n));
        yc = w(xc);
        yi_c = problem2(xc, yc, x_dense);
        rms_cheb(idx) = sqrt(mean((yi_c - y_true).^2));
    end

    fig2 = figure('name', 'rms_error', 'color', 'w', 'visible', 'off');
    
    semilogy(n_vals, rms_cheb, 'bo', 'markersize', 6, 'markerfacecolor', 'none'); hold on;
    semilogy(n_vals, rms_eq, 'ro', 'markersize', 6, 'markerfacecolor', 'none');
    
    xlabel('number of interpolation points');
    ylabel('rms error');
    title('rms interpolation error vs. number of pts');
    legend('chebyshev', 'equidistant', 'location', 'northeast');
    grid on;

    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig1, fullfile('docs', 'problem2_comparison.png'));
    saveas(fig2, fullfile('docs', 'problem2_rms.png'));
    close(fig1);
    close(fig2);
    
    fprintf('plots saved in docs\n');
end