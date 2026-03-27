function total_area = problem3(pts, tris)
    total_area = 0;
    for i = 1:size(tris, 1)
        p1 = pts(tris(i, 1), :);
        p2 = pts(tris(i, 2), :);
        p3 = pts(tris(i, 3), :);

        u = p2 - p1;
        v = p3 - p1;
        triangle_area = 0.5 * norm(cross(u, v));
        
        total_area = total_area + triangle_area;
    end
end