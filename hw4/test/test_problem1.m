function test_problem1()
    fprintf('--- Problem 1 ---\n');
    try
        [mondrian, s_mondrian, husky, s_husky] = problem1();
    catch ME
        fprintf('[ERROR] %s\n', ME.message);
        return;
    end
    
    % plot figure
    fig_image = figure('Name', 'images', 'Color', 'w', 'Visible', 'off');
    subplot(1, 2, 1);
    imshow(mondrian, []);
    title('Mondrian');
    
    subplot(1, 2, 2);
    imshow(husky, []);
    title('Husky');

    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig_image, fullfile('docs', 'problem1_image.png'));
    close(fig_image);
    
    % plot singular values
    fig_svd = figure('Name', 'singular values', 'Color', 'w', 'Visible', 'off');
    
    subplot(2, 1, 1);
    plot(s_mondrian, 'b-', 'LineWidth', 2, 'DisplayName', 'Mondrian');
    hold on;
    plot(s_husky, 'r-', 'LineWidth', 2, 'DisplayName', 'Husky');
    title('Singular Values (Linear Scale)');
    xlabel('Index off singular value');
    ylabel('Singular value');
    legend;
    grid on;
    
    subplot(2, 1, 2);
    semilogy(s_mondrian, 'b-', 'LineWidth', 2, 'DisplayName', 'Mondrian');
    hold on;
    semilogy(s_husky, 'r-', 'LineWidth', 2, 'DisplayName', 'Husky');
    title('Singular Values (Log Scale)');
    xlabel('Index of singular value');
    ylabel('Singular value');
    legend;
    grid on;

    saveas(fig_svd, fullfile('docs', 'problem1_svd.png'));
    close(fig_svd);
    
    fprintf('plots saved in docs\n')
    
    % debug
    size_m = size(mondrian); 
    size_h = size(husky);
    fprintf('size of Mondrian: (%d, %d)\n', size_m(1), size_m(2));
    fprintf('size of Husky: (%d, %d)\n', size_h(1), size_h(2));

    tol = 1e-7; 
    
    rank_m = sum(s_mondrian > tol);
    rank_h = sum(s_husky > tol);
    fprintf('rank of Mondrian: %d\n', rank_m);
    fprintf('rank of Husky: %d\n\n', rank_h);
end