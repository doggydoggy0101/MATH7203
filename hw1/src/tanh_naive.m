function sol = tanh_naive(x)    
    e_pos = exp(x);
    e_neg = exp(-x);
    sol = (e_pos - e_neg) / (e_pos + e_neg);
end