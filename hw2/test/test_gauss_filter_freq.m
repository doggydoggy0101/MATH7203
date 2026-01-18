function test_gauss_filter_freq()
    fprintf('--- Problem 3 ---\n');
    rng(42);
    
    duration = 2;   
    Fs = 100;  
    t = 0 : 1/Fs : duration - 1/Fs;
    
    freq_sig = 2;  
    amp_sig = 1;  
    
    y_clean = amp_sig * sin(2 * pi * freq_sig * t);
    
    % noise
    noise_mag = 0.2;
    y_noise = noise_mag * randn(size(t));
    y_noisy = y_clean + y_noise;
    
    % filter
    cutoff_freq = 4; % 4 Hz
    y_filtered = gauss_filter_freq(t, y_noisy, cutoff_freq);
    
    % plot
    f = figure('Name', 'filter', 'Visible', 'off');
    plot(t, y_noisy, 'b-', 'DisplayName', 'Noisy input data');
    hold on;

    plot(t, y_filtered, 'g-o', 'DisplayName', 'Frequency domain filtering');
    
    xlabel('time');
    ylabel('signal');
    legend('Location', 'best');
    grid on;
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(f, fullfile('docs', 'filter.png'));
    close(f);
    fprintf('plot saved in docs\n\n');
end