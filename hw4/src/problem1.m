function [mondrian, s_mondrian, husky, s_husky] = problem1()
    % Returns:
    %   mondrian   : Matrix of the Mondrian painting
    %   s_mondrian : Vector of singular values for Mondrian
    %   husky      : Matrix of the Husky photo
    %   s_husky    : Vector of singular values for Husky
    file_mondrian = fullfile('data', 'mondrian_1934.csv');
    file_husky = fullfile('data', 'side_husky.csv');

    mondrian = readmatrix(file_mondrian);
    s_mondrian = svd(mondrian);
    
    husky = readmatrix(file_husky);
    s_husky = svd(husky);
end