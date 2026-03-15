function yi = problem2(x_nodes, y_nodes, xi)
    n = length(x_nodes);
    yi = zeros(size(xi));
    
    for k = 1:length(xi)
        val = 0;
        for i = 1:n
            % compute the lagrange basis polynomial l_i(x)
            l_i = 1;
            for j = 1:n
                if i ~= j
                    l_i = l_i * (xi(k) - x_nodes(j)) / (x_nodes(i) - x_nodes(j));
                end
            end
            % accumulate the weighted basis
            val = val + y_nodes(i) * l_i;
        end
        yi(k) = val;
    end
end