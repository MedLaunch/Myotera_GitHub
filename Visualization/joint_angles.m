
%% Joint angles
% Myotera
%%%%% NEED TO DECIDE HOW OFTEN WE WANT TO AVERAGE DATA (OR MEDIAN)

%% Read in data

% Sensor 1 data (wrist)
gyro_filename_1 = '../datasets/reagan_magn_data/curl_motion/20201115T220555Z-180230000179-gyro-stream.csv';
gyro_data_1 = readmatrix(gyro_filename_1);
gyro_data_1 = gyro_data_1(1:4:end,:); % Filter out nan values.

% Sensor 2 data (upper arm)
gyro_filename_2 = '../datasets/reagan_magn_data/curl_motion/20201115T220555Z-180230000179-gyro-stream.csv';
gyro_data_2 = readmatrix(gyro_filename_2);
gyro_data_2 = gyro_data_2(1:4:end,:); % Filter out nan values.

% FIGURE OUT HOW TO RUN orient_box TWICE (MIGHT WANT TO MAKE 2 FILES)
% Sensor 1 data (wrist)
orientation_filename_1 = 'orientation.csv';
orientation_data_1 = readmatrix(orientation_filename_1);

% Sensor 2 data (upper arm)
orientation_filename_2 = 'orientation.csv';
orientation_data_2 = readmatrix(orientation_filename_2);


%% Initialize variables

% Record  time increment% This depends on the sampling rate
% https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjDk6_4habtAhX3SjABHXkLBLAQFjACegQIAhAC&url=https%3A%2F%2Fwww.movesense.com%2Fproduct%2Fmovesense-sensor%2F&usg=AOvVaw1wvv-0iG_7F0q8W4fa_uVd
delta_t = 1/52; % Assumed sample period (could be something else below -- will need to check later): 

% Take accelerations as vectors, already as vectors in accel_data?
%a1 = ?; % wrist
%a2 = ?; % upper arm

% Angular rate vectors for the 2 sensors at 1 timestamp in terms of time
g1 = [gyro_data_1(1,2) gyro_data_1(1,3) gyro_data_1(1,4)] .* t;
g2 = [gyro_data_2(1,2) gyro_data_1(1,3) gyro_data_1(1,4)] .* t;

%% Process Data

% Calculate time derivative angular rates
g1_prime_num = g1(t-2*delta_t) - 8*g1(t-delta_t) + 8*g1(t+delta_t) - g1(t+2*delta_t);
g1_prime_denom = 12*delta_t;
g1 = g1_prime_num / g1_prime_denom;

g2_prime_num = g2(t-2*delta_t) - 8*g2(t-delta_t) + 8*g2(t+delta_t) - g2(t+2*delta_t);
g2_prime_denom = 12*delta_t;
g2 = g2_prime_num / g2_prime_denom;

% Find row and pitch angles corresponding to phi and theta respectively
% from orientation data and convert to degrees (MIGHT WANT TO KEEP RADIANS FOR BOTH)
phi_1 = orientation_data_1(?) * 180 / pi;
phi_2 = orientation_data_2(?) * 180 / pi;
theta_1 = orientation_data_1(?) * 180 / pi;
theta_2 = orientation_data_2(?) * 180 / pi;

% Calculate unit-length direction vectors
j1 = [cos(phi_1)*cos(theta_1); cos(phi_1)*sin(theta_1); sin(phi_1)];
j2 = [cos(phi_2)*cos(theta_2); cos(phi_2)*sin(theta_2); sin(phi_2)];

% Solve for joint angles
eqn = dot(g1,j1) - dot(g2,j2);
extension_angle = integral(@(t) eqn, 0, dt);

