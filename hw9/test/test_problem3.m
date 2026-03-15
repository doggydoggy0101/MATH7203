function test_problem3()
    fprintf('--- problem 3 ---\n');
    
    globals();
    
    c_act = linspace(0, 25, 500)';
    c_raw = zeros(size(c_act));
    c_corr = zeros(size(c_act));
    
    for i = 1:length(c_act)
        v_meas = sensor_response(c_act(i));
        c_raw(i) = volt_to_raw_conc(v_meas);
        c_corr(i) = problem3(c_raw(i), v_meas);
    end
    
    max_err = max(abs(c_corr - c_act));
    fprintf('max deviation after correction: %.4f ppm\n', max_err);
    
    if max_err <= (0.05 * 25)
        fprintf('status: pass (within 5%% specification)\n\n');
    else
        fprintf('status: fail\n\n');
    end
    
    fig = figure('name', 'gas_analyzer_correction', 'color', 'w', 'visible', 'off');
    
    plot(c_act, c_raw, 'r-', 'linewidth', 1.2); hold on;
    plot(c_act, c_corr, 'b-', 'linewidth', 1.2);
    
    xlabel('actual concentration (ppm)');
    ylabel('concentration (ppm)');
    title('corrected vs. actual gas concentration');
    legend('raw conc', 'corrected conc', 'location', 'northwest');
    grid on;
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig, fullfile('docs', 'problem3.png'));
    close(fig);
    
    fprintf('plot saved in docs\n');
end

function c_raw = volt_to_raw_conc(v_meas)
    % local function to convert sensor voltage to uncorrected raw concentration
    global pmr;
    global Vz;
    global Vs;
    
    dv = Vs - Vz;
    c_raw = (pmr / dv) * (v_meas - Vz);
end