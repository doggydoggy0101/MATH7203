function problem3(truck_weight_tons)
    s = sin(deg2rad(45)); 
    c = cos(deg2rad(45)); 

    A = zeros(12, 12);
    A(1,1) = -c;  A(1,2) = -1;  A(1,10) = 1;
    A(2,1) = -s;  A(2,11) = 1;
    A(3,1) = c;   A(3,4) = -1;
    A(4,1) = s;   A(4,3) = 1;
    A(5,2) = 1;   A(5,5) = c;   A(5,6) = -1; 
    A(6,3) = -1;  A(6,5) = -s;
    A(7,4) = 1;   A(7,5) = -c;  A(7,8) = c;
    A(8,5) = s;   A(8,7) = 1;   A(8,8) = -s;
    A(9,6) = 1;   A(9,9) = -1;
    A(10,7) = -1;
    A(11,8) = -c; A(11,9) = 1;
    A(12,8) = s;  A(12,12) = 1;
    A = sparse(A);
    b = zeros(12, 1);
    Tc = truck_weight_tons / 2;
    Te = truck_weight_tons / 2;
    
    b(6) = -Tc;
    b(10) = -Te;
    
    x = A \ b;
    forces = x(1:9);

    fprintf('  %-6s %-10s %-15s\n', 'Beam', 'Force', 'Status');
    fprintf('  %-6s %-10s %-15s\n', '----', '-----', '------');
    
    failed = false;
    for i = 1:9
        f = forces(i);
        status = 'safe';
        
        if f > 7
            status = 'tension fail';
            failed = true;
        elseif f < -14
            status = 'compression fail';
            failed = true;
        end
        fprintf('  %-6d %-10.2f %-15s\n', i, f, status);
    end
    
    if failed
        fprintf('Bridge is not safe with %d ton truck.\n\n', truck_weight_tons);
    else
        fprintf('Bridge is safe with %d ton truck.\n\n', truck_weight_tons);
    end
end