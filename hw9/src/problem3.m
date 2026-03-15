function c_corr = problem3(c_raw, v_meas)
    c_act_cal = [0.0, 0.1, 0.2, 0.5, 1.0, 2.0, 5.0, 10.0, 20.0, 25.0]';
    c_raw_cal = [0.000000, 0.035401, 0.071321, 0.182193, 0.377358, ...
                 0.806604, 2.405660, 6.108491, 17.405660, 25.000000]';
    
    delta_cal = c_raw_cal - c_act_cal;
    
    % linear interpolator from problem 1
    delta_interp = problem1(c_raw_cal, delta_cal, c_raw);
    
    c_corr = c_raw - delta_interp;
end