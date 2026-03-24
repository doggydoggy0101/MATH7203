function test_problem2()
    fprintf('--- problem 2 ---\n');
    
    v = readmatrix('data/helix.csv');
    
    u1 = [1; 0; 1];  % x+z
    u2 = [-1; 0; 1];  % -x+z
    u3 = [0; 1; 0];  % y
    
    v1 = problem2(u1, v);
    v2 = problem2(u2, v);
    v3 = problem2(u3, v);
    
    fig = figure('name', 'helix_projections', 'color', 'w', 'visible', 'off');
    
    plot3(v(1,:), v(2,:), v(3,:), 'color', [0.7 0.7 0.7], 'linewidth', 1.5); hold on;
    
    plot3(v1(1,:), v1(2,:), v1(3,:), 'r-', 'linewidth', 1.2);
    plot3(v2(1,:), v2(2,:), v2(3,:), 'g-', 'linewidth', 1.2);
    plot3(v3(1,:), v3(2,:), v3(3,:), 'b-', 'linewidth', 1.2); 
    
    grid on;
    axis equal;
    xlabel('x'); ylabel('y'); zlabel('z');
    view(-30, 15);
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig, fullfile('docs', 'problem2.png'));
    close(fig);
    
    fprintf('plot saved in docs\n');
end