function tune = detect_tune(filename)
    % Args:
    %     filename (string)
    % 
    % Returns 
    %     tune (string)
    freqs = [261.6, 277.2, 293.7, 311.1, 329.6, 349.2, 370.0, 392.0, 415.3, 440.0, 466.2, 493.9];
    notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];
    [y, Fs] = audioread(filename);
    
    % FFT
    L = length(y);
    Y = fft(y);
    
    P2 = abs(Y/L);
    P1 = P2(1:floor(L/2)+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs * (0:(L/2)) / L;
    
    % plot
    f_fig = figure('Name', 'spectrum', 'Visible', 'off');
    plot(f, P1);
    
    xlim([250, 500]); 
    grid on;
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    
    % frequencies
    hold on;
    for i = 1:length(freqs)
        xline(freqs(i), '--r', sprintf('%s (%.1f)', notes{i}, freqs(i)));
    end
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    save_path = fullfile('docs', 'spectrum.png');
    saveas(f_fig, save_path);
    close(f_fig);
    
    % determine which tune
    max_amp = max(P1);
    threshold = 0.2 * max_amp;

    candidate_freqs = [];
    for i = 2:(length(P1)-1)
        if P1(i) >= threshold && P1(i) > P1(i-1) && P1(i) > P1(i+1)
            candidate_freqs = [candidate_freqs, f(i)]; %#ok<AGROW>
        end
    end

    key_freq = min(candidate_freqs);
    [~, idx] = min(abs(freqs - key_freq));
    tune = notes(idx);
end