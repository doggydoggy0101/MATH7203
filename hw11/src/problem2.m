function val = problem2(func, n)
    % compute legendre-gauss nodes and weights on [0, 1]
    n = n - 1;
    n1 = n + 1; n2 = n + 2;
    
    xu = linspace(-1, 1, n1)';
    y = cos((2*(0:n)' + 1)*pi/(2*n + 2)) + (0.27/n1)*sin(pi*xu*n/n2);
    
    l = zeros(n1, n2);
    lp = zeros(n1, n2);
    y0 = 2;
    
    while max(abs(y - y0)) > eps
        l(:,1) = 1; lp(:,1) = 0;
        l(:,2) = y; lp(:,2) = 1;
        for k = 2:n1
            l(:,k+1) = ( (2*k-1)*y.*l(:,k) - (k-1)*l(:,k-1) ) / k;
        end
        lp = (n2)*( l(:,n1) - y.*l(:,n2) ) ./ (1 - y.^2);
        y0 = y;
        y = y0 - l(:,n2)./lp;
    end

    a = 0; b = 1;
    x = (a*(1-y) + b*(1+y)) / 2;
    w = (b-a) ./ ((1-y.^2) .* lp.^2) * (n2/n1)^2;


    [x_grid, y_grid] = meshgrid(x, x);
    [wx_grid, wy_grid] = meshgrid(w, w);
    w_2d = wx_grid .* wy_grid;

    f_vals = func(x_grid, y_grid);
    val = sum(w_2d(:) .* f_vals(:));
end
