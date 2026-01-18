function y_filtered = gauss_filter_freq(t, y, B)
    % Args:
    %   t (vector): Time.
    %   y (vector): Input noisy signal.
    %   B (float): Cut-off frequency.
    %
    % Returns:
    %   y_filtered (vector): Filtered signal.
    
    dt = t(2) - t(1);
    Fs = 1 / dt;
    N = length(y);
    Y = fft(y);
    Y_shifted = fftshift(Y);
    f = (-N/2 : N/2-1) * (Fs / N);
    
    % Gaussian filter
    W = exp(-(f.^2) / (2 * B^2));

    Y_filtered_shifted = Y_shifted .* W;
    Y_filtered = ifftshift(Y_filtered_shifted);
    y_filtered = ifft(Y_filtered); % complex
    y_filtered = real(y_filtered);
end