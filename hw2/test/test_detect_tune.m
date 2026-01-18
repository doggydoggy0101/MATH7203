function test_detect_tune()
    fprintf('--- Problem 1 ---\n');
    
    file_path = fullfile('docs', 'twinkle.wav');
    tune = detect_tune(file_path);
    
    fprintf('Detected note: ' + tune + '\n');
    
    % spectrogram
    [y, Fs] = audioread(file_path);
    f_spec = figure('Name', 'spectrogram', 'Visible', 'off');
    spectrogram(y, 4096, 2048, 4096, Fs, 'yaxis');
    ylim([0, 1]);

    freqs = [261.6, 277.2, 293.7, 311.1, 329.6, 349.2, 370.0, 392.0, 415.3, 440.0, 466.2, 493.9];
    notes = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"];
    hold on;
    yline(freqs(notes == tune)/1000, '--r', sprintf('%s (%.1f)', tune, freqs(notes == tune)));

    saveas(f_spec, fullfile('docs', 'spectrogram.png'));
    close(f_spec);
    fprintf("plot saved in docs\n\n");
end