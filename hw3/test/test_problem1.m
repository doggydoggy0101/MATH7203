function test_problem1()
    fprintf('--- Problem 1 ---\n');

    x = linspace(-3, 4, 500);
    [cond_hand, cond_matlab] = problem1(x);

    f_fig = figure('Name', 'Problem 1', 'Visible', 'off');
    semilogy(x, cond_hand, 'b-', 'DisplayName', 'Hand derived');
    hold on;
    semilogy(x, cond_matlab, 'r--', 'DisplayName', 'Matlab');

    xlabel('x');
    ylabel('Condition Number');
    legend('Location', 'best');
    grid on;
    % ylim([1, 1e5]);

    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(f_fig, fullfile('docs', 'problem1.png'));
    close(f_fig);

    fprintf('plot saved in docs\n\n')
end