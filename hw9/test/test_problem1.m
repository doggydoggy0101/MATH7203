function test_problem1()
    fprintf('--- problem 1 ---\n');
    filename = fullfile('data', 'LifeExpectPruned.csv');
    if exist(filename, 'file')
        data = readmatrix(filename);
        x_data = data(:, 1);
        y_data = data(:, 2);
    else
        error('could not find %s. please make sure it is in the data folder.', filename);
    end

    xi_interp = (1960:1:2020)';
    yi_interp = problem1(x_data, y_data, xi_interp);
    
    y_1997 = problem1(x_data, y_data, 1997);
    fprintf('estimated life expectancy in 1997: %.2f years\n\n', y_1997);
    
    fig = figure('name', 'life_expectancy', 'color', 'w', 'visible', 'off');
    
    plot(xi_interp, yi_interp, 'k.', 'markersize', 6); hold on;
    plot(x_data, y_data, 'ro', 'markersize', 7, 'markerfacecolor', 'none', 'linewidth', 1);
    
    xlabel('year');
    ylabel('life expectancy (years)');
    title('life expectancy in the us');
    legend('interpolated values', 'recorded values', 'location', 'northwest');
    grid on;
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig, fullfile('docs', 'problem1.png'));
    close(fig);
    
    fprintf('plot saved in docs\n');
end