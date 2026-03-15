function test_problem3()
    fprintf('--- problem 3 ---\n');
    
    % satellite data: [x, y, z, t0]
    sat_data = [
         1.2000,  2.3000,  0.2000,  9.9999;
        -0.5000,  1.5000,  1.8000, 13.0681;
        -1.7000,  0.8000,  1.3000,  2.0251;
         1.7000,  1.4000, -0.5000, 10.5317
    ];
    
    % initial guess: [x; y; z; time]
    guess = [0; 0; 1; 50]; 
    
    [pos, t_local] = problem3(sat_data, guess);
    
    fprintf('computed position (x, y, z): %.4f, %.4f, %.4f\n', pos(1), pos(2), pos(3));
    fprintf('computed local time:         %.4f\n', t_local);
    fprintf('distance from earth center:  %.6f (should be approx 1.0)\n\n', norm(pos));
    
    fig = figure('name', 'gps_system', 'color', 'w', 'visible', 'off');
    
    % earth
    [ex, ey, ez] = sphere(50);
    surf(ex, ey, ez, 'facecolor', '#add8e6', 'edgecolor', 'none', 'facealpha', 0.5);
    hold on;
    
    % satellites
    scatter3(sat_data(:,1), sat_data(:,2), sat_data(:,3), 60, 'ro', 'filled');
    for i = 1:4
        text(sat_data(i,1)+0.1, sat_data(i,2)+0.1, sat_data(i,3)+0.1, sprintf('sat %d', i));
    end
    
    % computed position
    scatter3(pos(1), pos(2), pos(3), 80, 'ko', 'filled');
    text(pos(1)+0.1, pos(2)+0.1, pos(3)+0.1, 'your position', 'fontweight', 'bold');
    
    axis equal;
    grid on;
    xlabel('x'); ylabel('y'); zlabel('z');
    title('gps satellite positioning');
    view(3);
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig, fullfile('docs', 'problem3.png'));
    close(fig);
    
    fprintf('plot saved in docs\n');
end