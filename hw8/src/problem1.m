function xi = problem1(theta1)
    R1 = 1.0;
    R2 = 0.32;
    Rc = 0.37 * R2;
    L  = 1.5;
    
    theta2 = (R1/R2 - 1) * theta1;
    
    Px = (R1 - R2) * cos(theta1) + Rc * cos(theta2);
    Py = (R1 - R2) * sin(theta1) - Rc * sin(theta2);

    xi = Px + sqrt(L^2 - Py^2);
end