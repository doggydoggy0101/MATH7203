function test_problem2()
    fprintf('--- problem 2 ---\n');
    
    n_vals = [10, 100, 1000, 10000, 100000, 1000000];
    n_experiments = 50; 
    
    fig = figure('name', 'monte_carlo_spd', 'color', 'w', 'visible', 'off');

    true_frac = 1 / 9;
    semilogx([10, 1000000], [true_frac, true_frac], 'b-', 'linewidth', 2);

    hold on;
    
    for i = 1:length(n_vals)
        n = n_vals(i);
        fracs = zeros(n_experiments, 1);
        
        for j = 1:n_experiments
            fracs(j) = problem2(n);
        end
        semilogx(repmat(n, n_experiments, 1), fracs, 'r.', 'markersize', 8);

        if i == length(n_vals)
            final_best_estimate = mean(fracs);
        end
    end

    fprintf('analytic fraction (1/9):        %.6f\n', true_frac);
    fprintf('monte carlo estimated fraction: %.6f\n', final_best_estimate);
    fprintf('absolute error:                 %e\n\n', abs(final_best_estimate - true_frac));
    
    grid on;
    
    set(gca, 'xscale', 'log');
    
    xlim([10, 1000000]); 
    ylim([0, 0.2]);
    set(gca, 'xtick', n_vals);
    
    xlabel('Number of trials N');
    ylabel('Fraction of space which is SPD');
    title('Monte Carlo computation of SPD fraction');
    legend('Analytic (1/9)', 'Monte Carlo computation', 'location', 'southeast');
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig, fullfile('docs', 'problem2.png'));
    close(fig);
    
    fprintf('plot saved in docs\n');
end