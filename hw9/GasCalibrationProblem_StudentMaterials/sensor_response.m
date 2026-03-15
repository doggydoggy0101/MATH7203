function Vmeas = sensor_response(Cact)
  % Given an input gas concentration Cact, this
  % fcn returns the corresponding sensor voltage.
  % This is where the initial error occurs --
  % the output Vmeas is not linearly proportional
  % to the input (measured) Cact.

  global pmr;
  global Vz;
  global Vs;
    
  alpha = Cact/pmr;
  Vlin = (1-alpha)*Vz + alpha*Vs;
  
  % Non-linear response (error)
  c = 1.1e-3;
  Vquad = c*Cact.*(Cact-pmr);
  
  % Total sensor response
  Vmeas = Vlin + Vquad;
  
end
