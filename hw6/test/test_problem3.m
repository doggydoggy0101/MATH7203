function test_problem3()
    fprintf('--- Problem 3 ---\n');
    
    filename = fullfile('docs', 'Datafile.csv');
    [s_vals, Y] = problem3(filename);
    
    fig1 = figure('Name', 'pca', 'Color', 'w');
    plot(s_vals, '-o', 'LineWidth', 2, 'MarkerFaceColor', 'b');
    xlabel('Principal Component Index');
    ylabel('Singular Value');
    grid on;

    fig2 = figure('Name', 'object', 'Color', 'w');
    
    scatter3(Y(1, :), Y(2, :), Y(3, :), 20, 'filled', ...
             'MarkerFaceColor', 'b', 'MarkerFaceAlpha', 0.6);
    
    axis equal; 
    grid on;

    rotate3d on;
    view(3);

    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig1, fullfile('docs', 'problem3_pca.png'));
    saveas(fig2, fullfile('docs', 'problem3_object.png'));
    close(fig1);
    close(fig2);
    fprintf('plots saved in docs\n')
end