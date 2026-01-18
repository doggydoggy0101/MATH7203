function test_fourier_series()
    fprintf('--- Problem 2 ---\n');

    x = linspace(-1, 1, 1000);
    y_true = exp(-abs(x));
    
    b0 = fourier_series(0); 
    
    % series plot
    f1 = figure('Name', 'series', 'Visible', 'off');
    plot(x, y_true, 'k.', 'DisplayName', 'origal function'); 
    hold on;
    
    for m = [0, 1, 5, 20]
        y_approx = (b0 / 2) * ones(size(x));
        for n = 1:m
            bn = fourier_series(n);
            y_approx = y_approx + bn * cos(n * pi * x);
        end
        plot(x, y_approx, 'DisplayName', sprintf('m=%d', m));
    end
    
    legend('Location', 'best');
    grid on;
    ylim([0.3, 1.0]); 
    xlabel('t'); 
    ylabel('y(t)');

    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(f1, fullfile('docs', 'series.png'));
    close(f1); 
    
    % error plot
    m_range = 0:20; 
    rms_errors = zeros(size(m_range));
    
    for k = 1:length(m_range)
        m = m_range(k);
        y_approx = (b0 / 2) * ones(size(x));
        for n = 1:m
            bn = fourier_series(n);
            y_approx = y_approx + bn * cos(n * pi * x);
        end
        err = sqrt(mean((y_true - y_approx).^2));
        rms_errors(k) = err;
    end
    
    f2 = figure('Name', 'error', 'Visible', 'off');
    semilogy(m_range, rms_errors, 'o', 'MarkerFaceColor', 'auto');
    
    hold on;
    for val = [0, 1, 5, 20]
        idx = find(m_range == val);
        text(val + 0.5, rms_errors(idx), sprintf('m=%d', val));
        plot(val, rms_errors(idx), '.', 'MarkerSize', 20);
    end
    
    grid on;
    xlabel('Number of terms in Fourier sum');
    ylabel('RMS Error');

    saveas(f2, fullfile('docs', 'error.png'));
    close(f2);
    fprintf("plot saved in docs\n\n");
end