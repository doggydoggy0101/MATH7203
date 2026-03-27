function test_problem1()
    fprintf('--- problem 1 ---\n');
    
    a_vals = linspace(-10, 10, 200)'; 
    n_vals = 1:15;
    
    error_matrix = zeros(length(n_vals), length(a_vals));
    true_bessel = besseli(0, a_vals);
    
    for idx = 1:length(n_vals)
        n = n_vals(idx);
        integral_vals = problem1(a_vals, n);
        approx_bessel = integral_vals / pi;
        err = abs(approx_bessel - true_bessel);
        error_matrix(idx, :) = log10(err + eps);
    end
    
    % plot
    fig = figure('name', 'gauss_chebyshev_error', 'color', 'w', 'visible', 'off');

    imagesc(a_vals, n_vals, error_matrix);
    set(gca, 'ydir', 'reverse');

    cb = colorbar;
    ylabel(cb, 'log_{10}(error)');
    
    xlabel('a');
    ylabel('intergration order n');
    title('Log10 Chebyshev integral error');

    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig, fullfile('docs', 'problem1.png'));
    close(fig);
    
    fprintf('plot saved in docs\n');
end