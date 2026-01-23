function [cond_hand, cond_matlab] = problem1(x)
    % Args:
    %   x (vector): Input.
    %
    % Returns:
    %   cond_hand (vector): Condition numbers derived by hand.
    %   cond_matlab (vector): Condition numbers computed by MATLAB.

    cond_hand = zeros(size(x));
    cond_matlab = zeros(size(x));

    for i = 1:length(x)
        xi = x(i);
        
        % hand derive
        lambda1 = 2 - xi;
        lambda2 = 2 + xi/2 - sqrt(xi^2 + 8)/2;
        lambda3 = 2 + xi/2 + sqrt(xi^2 + 8)/2;

        lambdas = abs([lambda1, lambda2, lambda3]);
        min_lam = min(lambdas);
        cond_hand(i) = max(lambdas) / min_lam;

        % MATLAB cond
        K = [2, -1, xi;
            -1,  2, -1;
             xi, -1,  2];
        cond_matlab(i) = cond(K);
    end
end