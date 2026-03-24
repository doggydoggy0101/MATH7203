function test_problem3()
    fprintf('--- problem 3 ---\n');

    % first column is wavelength and the rest are spectra
    ref_data = readmatrix('data/ref_spectra.csv');
    unk_data = readmatrix('data/unknown_mixture_spectrum.csv');
    
    % wavelength and basis functions
    wv = ref_data(:, 1);
    r_matrix = ref_data(:, 2:4);
    
    % unknown spectrum
    s_measured = unk_data(:, 2);

    c_calculated = problem3(r_matrix, s_measured);
    
    fprintf('calculated concentrations:\n');
    fprintf('methane: %.2f%%\n', c_calculated(1) * 100);
    fprintf('ethane:  %.2f%%\n', c_calculated(2) * 100);
    fprintf('propane: %.2f%%\n', c_calculated(3) * 100);

    c_nitrogen = 1.0 - sum(c_calculated);
    fprintf('nitrogen (inert): %.2f%%\n\n', c_nitrogen * 100);
    
    % plot
    fig = figure('name', 'spectroscopy', 'color', 'w', 'visible', 'off');

    s_fitted = r_matrix * c_calculated;
    
    plot(wv, s_measured, 'k-', 'linewidth', 0.8); hold on;
    plot(wv, s_fitted, 'r--', 'linewidth', 1.5);
    
    xlabel('Wavelength (au)');
    ylabel('Absorption (au)');
    title('Measured vs. fitted optical absorption');
    legend('measured mixture', 'fitted regression', 'location', 'northeast');
    grid on;
    
    % save silently
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig, fullfile('docs', 'problem3.png'));
    close(fig);
    
    fprintf('plot saved in docs\n');
end