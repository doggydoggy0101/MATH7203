function Q = problem1(A, i, j)
    % we use i < j (homework uses j < i)
    aii = A(i, i);
    aij = A(i, j);
    ajj = A(j, j);
    
    % hand derived r
    r = (ajj - aii) / aij;
    
    temp = sqrt(r^2 + 4);
    t1 = (-r + temp) / 2;
    t2 = (-r - temp) / 2;

    % chose smaller magnitude
    if abs(t1) < abs(t2)
        t = t1;
    else
        t = t2;
    end

    c = 1 / sqrt(1 + t^2);
    s = c * t;
    
    n = size(A, 1);
    Q = eye(n);
    Q(i, i) = c;
    Q(i, j) = s;
    Q(j, i) = -s;
    Q(j, j) = c;
end