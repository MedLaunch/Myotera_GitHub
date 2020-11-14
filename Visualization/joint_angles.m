

%% Joint angles pseudocode
%%Myotera

%% Init variables
% 
% % Take accelerations for 2 frames of time as a vector
% a1 = ?;
% a2 = ?;
%
%MAYBE
% a1_func = @(s)a1.*s;
% a2_func = @(s)a2.*s;
% 
%MAYBE
% g1 = @(t)integral(a1_func,0,t, 'ArrayValued',true);
% g2 = @(t)integral(a2_func,0,t, 'ArrayValued',true);
%
% Integrate accel vector to convert to velocity vector 
% g1 = cumtrapz(a1);
% g2 = cumtrapz(a2);
% 
% % Input time increment
% delta_t = ?;
% 
% MAYBE
% % Initialize orientation vectors for given times
% o1 = ?;
% o2 = ?;
% 
%
%% Process Data
% 
% % Calculate time derivative angular rates
% g1_prime_num = g1(t-2*delta_t) - 8*g1(t-delta_t) + 8*g1(t+delta_t) - g1(t+2*delta_t);
% g1_prime_denom = 12*delta_t;
% g1 = g1_prime_num / g1_prime_denom;
% 
% g2_prime_num = g2(t-2*delta_t) - 8*g2(t-delta_t) + 8*g2(t+delta_t) - g2(t+2*delta_t);
% g2_prime_denom = 12*delta_t;
% g2 = g2_prime_num / g2_prime_denom;
% 
% % Set stuff
% No idea
% 
% % Get angles prob from orientation or set stuff
% phi_1 = ?;
% phi_2 = ?;
% theta_1 = ?;
% theta_2 = ?;
% 
% % Calculate unit-length direction vectors
% j1 = [cos(phi_1)*cos(theta_1); cos(phi_1)*sin(theta_1); sin(phi_1)];
% j2 = [cos(phi_2)*cos(theta_2); cos(phi_2)*sin(theta_2); sin(phi_2)];
% 
% 
%% Solve for joint angles
%
% eqn = dot(g1,j1) - dot(g2,j2)
% extension_angle = integral(@(t) eqn, 0, t);
%
%% May not be needed
%%Make new value Eta for radial and tangential acceleration
% norm(a1-Eta_g1) - norm(a2-Eta_g2) = 0;
% 
% Eta_g1 = cross(g1,cross(g1,o1)) + cross(g1_prime,o1);
% Eta_g2 = cross(g2,cross(g2,o2)) + cross(g2_prime,o2);


