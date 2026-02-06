function test_problem2()
    fprintf('--- Problem 2 ---\n');

    N = 250;               % Number of nodes
    L = 0.5;               % Length (meters)
    x = linspace(0, L, N); % Position vector
    h = x(2) - x(1);       % Step size (dx)
    
    A_cross = 2.5e-5;      % Cross-sectional area (5mm x 5mm)
    Q_vec = zeros(N, 1);
    [~, idx_source] = min(abs(x - 0.33)); % closest index to 0.33m
    Q_vec(idx_source) = 100;
    
    tol = 1e-3;
    max_iter = 100000; 
    x0 = zeros(N, 1);
    e = ones(N, 1);

    M_base = spdiags([e -2*e e], -1:1, N, N);
    M_base(1, :) = 0; M_base(1, 1) = 1;
    M_base(N, :) = 0; M_base(N, N) = 1;

    % aluminum
    k_Al = 205.0;  % W/(m C)
    T_Al = solve_heat_system(M_base, Q_vec, k_Al, A_cross, h, x0, tol, max_iter);
    max_T_Al = max(T_Al);
    
    fprintf('aluminum (k=%.1f):\n', k_Al);
    fprintf('max temperature: %.2f C\n\n', max_T_Al);

    % cooper
    k_Cu = 413.0; % W/(m C)
    T_Cu = solve_heat_system(M_base, Q_vec, k_Cu, A_cross, h, x0, tol, max_iter);
    max_T_Cu = max(T_Cu);
    
    fprintf('copper (k=%.1f):\n', k_Cu);
    fprintf('max temperature: %.2f C\n', max_T_Cu);

    % plot
    fig = figure('Name', 'Problem 2: Heat Distribution', 'Color', 'w', 'Visible', 'off');
    plot(x, T_Al, 'b-', 'LineWidth', 2, 'DisplayName', 'Aluminum (k=205)');
    hold on;
    plot(x, T_Cu, 'r--', 'LineWidth', 2, 'DisplayName', 'Copper (k=413)');
    
    xlabel('Position (m)');
    ylabel('Temperature (C)');
    title('Gauss-Seidel');
    legend;
    grid on;
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig, fullfile('docs', 'problem2.png'));
    close(fig); 

    fprintf('plots saved in docs\n\n')
end

function T = solve_heat_system(M_base, Q_vec, k, A, h, x0, tol, max_iter)

    scalar_C = - (k * A) / h^2;
    
    A_sys = M_base * scalar_C;
    b_sys = (1/h) * Q_vec;
    
    [T, ~, ~] = problem2(A_sys, b_sys, x0, tol, max_iter);
end