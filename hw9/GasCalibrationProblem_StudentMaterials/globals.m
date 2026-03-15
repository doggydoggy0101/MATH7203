function globals()
  
  global pmr;
  global Vz;
  global Vs;
  
  % We assume response is correct at 0 and 25ppm.
  % We assume the allowed input concentration varies 
  % from 0 -- 25ppm.
  pmr = 25;   % Primary Measurement Range
    
  % Linear response of sensor
  Vz = .1;    % zero 0ppm, sensor output = .1V
  Vs = 1.16;  % span 25ppm, sensor output =  1.16V

end
