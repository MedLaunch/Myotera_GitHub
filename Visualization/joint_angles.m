
%% Joint angles
% Myotera
%%%%% NEED TO DECIDE HOW OFTEN WE WANT TO AVERAGE DATA (OR MEDIAN)
%%%%% MIGHT WANT TO DIRECTLY READ IN PROCESSED GYROSCOPE DATA DEPENDING ON
%%%%% OTHER PPLS SCRIPTS
%% Read in data

accel_filename = './testing_data/acc_var_ud1.csv'; %../datasets/accel.csv'; %TEMP
accel_data = readmatrix(accel_filename);
accel_data = accel_data(1:4:end,:); % Filter out nan values.
%gyro_filename = 'gyro.csv'; %TEMP
%gyro_data = readmatrix(gyro_filename); % will update as above later.


%% Initialize variables

% Take accelerations for the 2 sensors at 1 timestamp as vectors, already as vectors in accel_data?
%a1 = ?; % wrist
%a2 = ?; % upper arm

%Record timestamp and chosen time increment
delta_t = 1/52; % Assumed sample period (could be something else below -- will need to check later): 
%This depends on the sampling rate
%https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjDk6_4habtAhX3SjABHXkLBLAQFjACegQIAhAC&url=https%3A%2F%2Fwww.movesense.com%2Fproduct%2Fmovesense-sensor%2F&usg=AOvVaw1wvv-0iG_7F0q8W4fa_uVd

g = [accel_data(:,1) accel_data(:,2:end) * delta_t]; % "integration"


% aren't angular rates and velocity different?
%g_prime = /
%{
%% Debug to figure out how to put vector in terms of variable time t
%MAYBE - 
a1_func = @(s)a1.*s;
a2_func = @(s)a2.*s;

MAYBE
g1 = @(t)integral(a1_func,0,t, 'ArrayValued',true);
g2 = @(t)integral(a2_func,0,t, 'ArrayValued',true);

Integrate accel vector to convert to velocity vector 
g1 = cumtrapz(a1);
g2 = cumtrapz(a2);

%% Process Data

% Calculate time derivative angular rates
g1_prime_num = g1(t-2*delta_t) - 8*g1(t-delta_t) + 8*g1(t+delta_t) - g1(t+2*delta_t);
g1_prime_denom = 12*delta_t;
g1 = g1_prime_num / g1_prime_denom;

g2_prime_num = g2(t-2*delta_t) - 8*g2(t-delta_t) + 8*g2(t+delta_t) - g2(t+2*delta_t);
g2_prime_denom = 12*delta_t;
g2 = g2_prime_num / g2_prime_denom;

% Convert gyroscope x,y,z data to get angles from gyroscope
phi_1 = ?;
phi_2 = ?;
theta_1 = ?;
theta_2 = ?;

% Calculate unit-length direction vectors
j1 = [cos(phi_1)*cos(theta_1); cos(phi_1)*sin(theta_1); sin(phi_1)];
j2 = [cos(phi_2)*cos(theta_2); cos(phi_2)*sin(theta_2); sin(phi_2)];

% Solve for joint angles
eqn = dot(g1,j1) - dot(g2,j2);
extension_angle = integral(@(t) eqn, 0, dt);
%}