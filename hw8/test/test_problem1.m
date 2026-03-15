function test_problem1()
    fprintf('--- problem 1 ---\n');
    
    theta_test = linspace(0, 16*pi, 10000);
    xi_test = zeros(size(theta_test));
    
    for i = 1:length(theta_test)
        xi_test(i) = problem1(theta_test(i));
    end
    
    xi_min = min(xi_test);
    xi_max = max(xi_test);
    xi_range = xi_max - xi_min;
    
    threshold = xi_min + 0.98 * xi_range; 
    
    fprintf('max displacement: %.6f\n', xi_max);
    fprintf('min displacement: %.6f\n', xi_min);
    fprintf('dwell threshold:  %.6f\n\n', threshold);
    
    f_obj = @(th) problem1(th) - threshold;
    
    tol = 1e-8;
    max_iter = 100;
    
    th_left  = my_secant(f_obj, -0.1, -0.4, tol, max_iter);
    th_right = my_secant(f_obj,  0.1,  0.4, tol, max_iter);
    
    dwell_width = th_right - th_left;
    
    fprintf('left root:   %.6f rad\n', th_left);
    fprintf('right root:  %.6f rad\n', th_right);
    fprintf('dwell width: %.6f rad (%.2f degrees)\n\n', dwell_width, dwell_width * 180/pi);
    
    fprintf('sanity check f(th_left)  = %e\n', f_obj(th_left));
    fprintf('sanity check f(th_right) = %e\n\n', f_obj(th_right));
    
    theta_plot = linspace(-pi, pi, 1000);
    xi_plot = zeros(size(theta_plot));
    for i = 1:length(theta_plot)
        xi_plot(i) = problem1(theta_plot(i));
    end
    
    fig = figure('name', 'kinematics', 'color', 'w', 'visible', 'off');
    plot(theta_plot, xi_plot - xi_min, 'b-', 'linewidth', 2); hold on;
    yline(threshold - xi_min, 'r--', '98% threshold', 'linewidth', 1.5);
    
    plot(th_left, problem1(th_left) - xi_min, 'ko', 'markerfacecolor', 'k', 'markersize', 6);
    plot(th_right, problem1(th_right) - xi_min, 'ko', 'markerfacecolor', 'k', 'markersize', 6);
    
    xlabel('Angle \theta_1 (rad)');
    ylabel('Slider position \xi - \xi_{min} (au)');
    grid on;
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig, fullfile('docs', 'problem1.png'));
    close(fig);
    fprintf('plot saved in docs\n');
end

function root = my_secant(f, x0, x1, tol, max_iter)
    for iter = 1:max_iter
        f0 = f(x0);
        f1 = f(x1);
        
        if abs(f1 - f0) < eps
            error('secant method failed: division by zero.');
        end
        
        x2 = x1 - f1 * (x1 - x0) / (f1 - f0);
        
        if abs(x2 - x1) < tol
            root = x2;
            return;
        end
        
        x0 = x1;
        x1 = x2;
    end
    error('secant method did not converge');
end