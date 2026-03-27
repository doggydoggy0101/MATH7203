function test_problem3()
    fprintf('--- problem 3 ---\n');

    s_sphere = stlread('data/sphere.stl');
    pts_sphere = s_sphere.Points;
    tris_sphere = s_sphere.ConnectivityList;
    
    fig1 = figure('name', 'sphere_mesh', 'color', 'w', 'visible', 'off');
    trisurf(tris_sphere, pts_sphere(:,1), pts_sphere(:,2), pts_sphere(:,3), ...
            'facecolor', "#9DC7EC", 'edgecolor', 'none');
    camlight; lighting gouraud; % adds lighting to make 3d shapes visible
    axis equal; grid on;
    title('unit sphere mesh');
    xlabel('x'); ylabel('y'); zlabel('z');
    
    if ~exist('docs', 'dir'), mkdir('docs'); end
    saveas(fig1, fullfile('docs', 'problem3_sphere.png'));
    close(fig1);
    
    area_sphere = problem3(pts_sphere, tris_sphere);
    expected_sphere = 4 * pi; % analytical solution
    err_percent = abs(area_sphere - expected_sphere) / expected_sphere * 100;
    
    fprintf('unit sphere surface area: %.4f\n', area_sphere);
    fprintf('expected area (4*pi):     %.4f\n', expected_sphere);
    fprintf('error:                    %.2f%%\n\n', err_percent);


    s_cow = stlread('data/cow.stl');
    pts_cow = s_cow.Points;
    tris_cow = s_cow.ConnectivityList;

    fig2 = figure('name', 'cow_mesh', 'color', 'w', 'visible', 'off');
    % (-x, z, y)
    trisurf(tris_cow, -pts_cow(:,1), pts_cow(:,3), pts_cow(:,2), ...
            'facecolor', "#9DC7EC", 'edgecolor', 'none');
    camlight; lighting gouraud;
    axis equal; grid on;
    title('cow mesh');
    xlabel('x'); ylabel('y'); zlabel('z');
    
    saveas(fig2, fullfile('docs', 'problem3_cow.png'));
    close(fig2);

    area_cow = problem3(pts_cow, tris_cow);
    fprintf('cow surface area:         %.4f\n\n', area_cow);

    fprintf('plots saved in docs\n');
end