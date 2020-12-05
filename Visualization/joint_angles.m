
%% Joint angles
% Myotera
%%%%% NEED TO DECIDE HOW OFTEN WE WANT TO AVERAGE DATA (OR MEDIAN)

function [] = joint_angles(who,wristFolder,upperArmFolder,take)
    %% Read in data
    %function []=(wristCSV, upperArmCSV,)
    % Sensor 1 data (wrist)
    %gyro_filename_1 = '../datasets/reagan_magn_data/curl_motion/20201115T220555Z-180230000179-gyro-stream.csv';
    gyro_filename_1 = "../datasets/" + who +"/" + wristFolder + "/" + "take" +take+ "_gyro.csv";
    gyro_data_1 = readmatrix(gyro_filename_1);
    gyro_data_1 = gyro_data_1(1:4:end,:); % Filter out nan values.

    % Sensor 2 data (upper arm)
    %gyro_filename_2 = '../datasets/reagan_magn_data/curl_motion/20201115T220555Z-180230000179-gyro-stream.csv';
    gyro_filename_2 = "../datasets/" + who +"/" + upperArmFolder + "/" + "take" +take+ "_gyro.csv";
    gyro_data_2 = readmatrix(gyro_filename_2);
    gyro_data_2 = gyro_data_2(1:4:end,:); % Filter out nan values.

    % FIGURE OUT HOW TO RUN orient_box TWICE (MIGHT WANT TO MAKE 2 FILES)
    % yaw pitch roll (orientation.csv)
    % Sensor 1 data (wrist)
    orientation_filename_1 = "orientation"+"_"+wristFolder+"_take" + take + ".csv";
    orientation_data_1 = readmatrix(orientation_filename_1);

    % Sensor 2 data (upper arm)
    orientation_filename_2 = "orientation"+"_"+upperArmFolder+"_take" + take + ".csv";
    orientation_data_2 = readmatrix(orientation_filename_2);


    %% Initialize variables
    syms t;

    % Sampling Rate
    delta_t = 1/52;

    % Angular rate vectors for the 2 sensors at 1 timestamp in terms of time
    % g1_test = [gyro_data_1(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* t;
    %g2 = [gyro_data_2(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* t;

    g1_minus2 = [gyro_data_1(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* (t-2*delta_t);
    g1_plus2 = [gyro_data_1(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* (t+2*delta_t);
    g1_minus1 = [gyro_data_1(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* (t-delta_t);
    g1_plus1 = [gyro_data_1(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* (t+delta_t);

    g2_minus2 = [gyro_data_1(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* (t-2*delta_t);
    g2_plus2 = [gyro_data_1(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* (t+2*delta_t);
    g2_minus1 = [gyro_data_1(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* (t-delta_t);
    g2_plus1 = [gyro_data_1(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* (t+delta_t);


    %% Process Data
    % Time Derivative Angular Rates
    g1 = (g1_minus2-8.*g1_minus1+8.*g1_plus1-g1_plus2)./(12.*delta_t);
    g2 = (g2_minus2-8.*g2_minus1+8.*g2_plus1-g2_plus2)./(12.*delta_t);
    %g1 = (g1(t-2*delta_t) - 8*g1(t-delta_t) + 8*g1(t+delta_t) - g1(t+2*delta_t)) / (12*delta_t);
    %g2 = (g2(t-2*delta_t) - 8*g2(t-delta_t) + 8*g2(t+delta_t) - g2(t+2*delta_t)) / (12*delta_t);

    % use MATLAB Taylor or PolyFit functions perhaps?
    % https://www.mathworks.com/help/matlab/ref/polyfit.html
    % https://www.mathworks.com/matlabcentral/answers/418776-by-using-syntax-taylor-in-matlab-find-the-third-order-approximation-of-log-x-using-base-point-at

    % Find roll and pitch angles corresponding to phi and theta respectively
    % from orientation data and convert to degrees (MIGHT WANT TO KEEP RADIANS FOR BOTH)
    phi_1 = orientation_data_1(:,3) * 180 / pi;
    phi_2 = orientation_data_2(:,3) * 180 / pi;
    theta_1 = orientation_data_1(:,2) * 180 / pi;
    theta_2 = orientation_data_2(:,2) * 180/ pi;

    % Calculate unit-length direction vectors
    j1 = [cos(phi_1).*cos(theta_1) cos(phi_1).*sin(theta_1) sin(phi_1)]; % made into horizontal vectors
    j2 = [cos(phi_2).*cos(theta_2) cos(phi_2).*sin(theta_2) sin(phi_2)]; % here as well.

    % Solve for joint angles
    %eqn = dot(g1,j1) - dot(g2,j2);
    %size(j1) => 248 3
    %size(g1) => 62 3
    % ^ same for j2, g2
    % Therefore...
    j1 = j1(1:size(g1),:);
    j2 = j2(1:size(g2),:);
    %eqn = dot(g1,j1)-dot(g2,j2); This also didn't work... since matrices?
    eqn = sum(g1.*j1, 2)-sum(g2.*j2,2); % alternative method, does same thing as above line.

    % Attempting calculation row by row
    %extension_angle = integral(@(t) eqn, 0, delta_t);
    % https://www.mathworks.com/help/matlab/math/integration-of-numeric-data.html
    % is this what we're trying to do? ^
    
end

