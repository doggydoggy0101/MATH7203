function c = problem3(r_matrix, s_measured)
    c = (r_matrix' * r_matrix) \ (r_matrix' * s_measured);
end