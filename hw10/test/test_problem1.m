function test_problem1()
    fprintf('--- problem 1 ---\n');
    
    % hw table
    t_c = [-20; -10; 0; 10; 20; 30; 40; 50; 60; 70];
    r_ohms = [1.00e5; 5.50e4; 3.30e4; 2.00e4; 1.20e4; ...
              8.00e3; 4.50e3; 3.50e3; 2.30e3; 1.80e3];

    coeffs = problem1(t_c, r_ohms);
    
    A = coeffs(1);
    B = coeffs(2);
    C = coeffs(3);
    
    fprintf('Steinhart-Hart coefficients:\n');
    fprintf('A = %e\n', A);
    fprintf('B = %e\n', B);
    fprintf('C = %e\n\n', C);

    r_dense = logspace(log10(min(r_ohms)), log10(max(r_ohms)), 500)';
    ln_r_dense = log(r_dense);
    
    t_k_dense = 1 ./ (A + B.*ln_r_dense + C.*(ln_r_dense.^3));
    t_c_dense = t_k_dense - 273.15;
    
    % plot 
    fig = figure('name', 'steinhart_hart', 'color', 'w', 'visible', 'off');

    semilogy(t_c_dense, r_dense, 'b-', 'linewidth', 1); hold on;
    semilogy(t_c, r_ohms, 'ro', 'markersize', 6, 'markerfacecolor', 'none');
    
    xlabel('Temperature (C)');
    ylabel('Thermistor resistance (ohm)');
    title('Temp data fit with Steinhart-Hart law');
    grid on;
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig, fullfile('docs', 'problem1.png'));
    close(fig);
    
    fprintf('plot saved in docs\n');
end