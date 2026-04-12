function test_problem3()
    fprintf('--- problem 3 ---\n');
    
    n_points = 1000; 
    d_vals = [2, 4, 8, 16, 32, 64, 128, 256, 512];
    
    % preallocate 
    min_vals = zeros(size(d_vals));
    mean_vals = zeros(size(d_vals));
    max_vals = zeros(size(d_vals));
    theory_vals = zeros(size(d_vals));
    
    fprintf('computing distances for dimensions...\n');
    
    for i = 1:length(d_vals)
        d = d_vals(i);
        fprintf('d = %d\n', d);
        [min_vals(i), mean_vals(i), max_vals(i), theory_vals(i)] = problem3(n_points, d);
    end
    
    % plot
    fig = figure('name', 'curse_of_dimensionality', 'color', 'w', 'visible', 'off');
    
    loglog(d_vals, theory_vals, 'k--', 'linewidth', 1.5); hold on;
    loglog(d_vals, max_vals, 'ro-', 'linewidth', 1.5, 'markerfacecolor', 'w');
    loglog(d_vals, mean_vals, 'g^-', 'linewidth', 1.5, 'markerfacecolor', 'w');
    loglog(d_vals, min_vals, 'bs-', 'linewidth', 1.5, 'markerfacecolor', 'w');
    
    grid on;
    
    set(gca, 'xtick', d_vals);
    
    xlabel('dimension (D)');
    ylabel('distance');
    title('pairwise distances vs. dimension (curse of dimensionality)');
    legend('theoretical max (\surdd)', 'max distance', 'mean distance', 'min distance', 'location', 'northwest');
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig, fullfile('docs', 'problem3.png'));
    close(fig);
    
    fprintf('plot saved in docs\n');
end