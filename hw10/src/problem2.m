function p_v = problem2(u, v)
    i_mat = eye(3);
    p_r = i_mat - (u * u') / (u' * u);
    p_v = p_r * v;
end