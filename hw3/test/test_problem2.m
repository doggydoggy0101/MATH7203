function test_problem2()
    fprintf('--- Problem 2 ---\n');
    [n_vals, c_nums, errs, ests] = problem2(21);
    
    f_fig = figure('Name', 'Problem 2', 'Visible', 'off');
    semilogy(n_vals, c_nums, 'ro', 'MarkerFaceColor', 'none', 'DisplayName', 'Condition number'); 
    hold on;
    semilogy(n_vals, errs, 'b*', 'DisplayName', 'Residual'); 
    semilogy(n_vals, ests, 'g+', 'DisplayName', 'Error estimate');
    
    xlabel('Matrix dimension N');
    ylabel('Value');
    legend('Location', 'northwest');
    grid on;
   
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(f_fig, fullfile('docs', 'problem2.png'));
    close(f_fig);
    
    fprintf('plot saved in docs\n\n')
end