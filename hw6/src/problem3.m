function [singular_values, projected_data] = problem3(filename)
    % Args:
    %   filename: Path to file
    %
    % Returns:
    %   singular_values: Vector of singular values
    %   projected_data: The data projected onto the principal components
    if ~isfile(filename)
        error('File "%s" not found.', filename);
    end
    X = readmatrix(filename);
   
    mu = mean(X, 2);
    X_centered = X - mu;
    
    % pca
    [U, S, ~] = svd(X_centered, 'econ');
    singular_values = diag(S);
    projected_data = U' * X_centered;
end