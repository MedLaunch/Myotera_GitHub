
%% Joint angles
% Myotera
%%%%

% Run extension_angle = joint_angles("reagan_magn_data","curl_hand","curl_elbow","5")
% Make sure in 'MATLAB programs' folder

% TODO: 
% timestamp parameter
% Avg 5 timestamps up to current

% where is the initial folder
% what is the dataset
% trial is the trial number
function [extension_angle] = joint_angles(where,what,trial)
    %% Read in data
    
    % Sensor 1 data (wrist)
    gyro_filename_wrist = "../../datasets/" + where + "/" + what + "/" + "trial " + trial + "/" + what + "_wrist_gyro" + trial + ".csv";
    gyro_data_wrist = readmatrix(gyro_filename_wrist);
    gyro_data_wrist = gyro_data_wrist(1:4:end,:);

    % Sensor 2 data (bicep)
    gyro_filename_bicep = "../../datasets/" + where + "/" + what + "/" + "trial " + trial + "/" + what + "_bicep_gyro" + trial + ".csv";
    gyro_data_bicep = readmatrix(gyro_filename_bicep);
    gyro_data_bicep = gyro_data_bicep(1:4:end,:);

    % yaw pitch roll (from orientation csv file that orient_box.m creates)
    % Sensor 1 data (wrist)
    orient_box(where,what,trial,"wrist",false)
    orientation_wrist_csv = "orientation" + "_" + what + "_take" + trial + ".csv";
    orientation_wrist_data = readmatrix(orientation_wrist_csv);

    % Sensor 2 data (bicep)
    orient_box(where,what,trial,"bicep",false)
    orientation_arm_csv = "orientation" + "_" + what + "_take" + trial + ".csv";
    orientation_arm_data = readmatrix(orientation_arm_csv);


    %% Initialize variables
    syms t;

    % Sampling Rate
    delta_t = 1/52;

    g1_minus2 = [gyro_data_wrist(:,2) gyro_data_wrist(:,3) gyro_data_wrist(:,4)] .* (t-2*delta_t);
    g1_plus2 = [gyro_data_wrist(:,2) gyro_data_wrist(:,3) gyro_data_wrist(:,4)] .* (t+2*delta_t);
    g1_minus1 = [gyro_data_wrist(:,2) gyro_data_wrist(:,3) gyro_data_wrist(:,4)] .* (t-delta_t);
    g1_plus1 = [gyro_data_wrist(:,2) gyro_data_wrist(:,3) gyro_data_wrist(:,4)] .* (t+delta_t);

    g2_minus2 = [gyro_data_bicep(:,2) gyro_data_bicep(:,3) gyro_data_bicep(:,4)] .* (t-2*delta_t);
    g2_plus2 = [gyro_data_bicep(:,2) gyro_data_bicep(:,3) gyro_data_bicep(:,4)] .* (t+2*delta_t);
    g2_minus1 = [gyro_data_bicep(:,2) gyro_data_bicep(:,3) gyro_data_bicep(:,4)] .* (t-delta_t);
    g2_plus1 = [gyro_data_bicep(:,2) gyro_data_bicep(:,3) gyro_data_bicep(:,4)] .* (t+delta_t);


    %% Process Data
    % Time Derivative Angular Rates
    g1 = (g1_minus2-8.*g1_minus1+8.*g1_plus1-g1_plus2)./(12.*delta_t);
    g2 = (g2_minus2-8.*g2_minus1+8.*g2_plus1-g2_plus2)./(12.*delta_t);
    
    % Find roll and pitch angles corresponding to phi and theta respectively
    % from orientation data and convert to degrees
    phi_1 = orientation_wrist_data(:,3);
    phi_2 = orientation_arm_data(:,3);
    theta_1 = orientation_wrist_data(:,2);
    theta_2 = orientation_arm_data(:,2);

    % Calculate horizontal unit-length direction vectors
    j1 = [cos(phi_1).*cos(theta_1) cos(phi_1).*sin(theta_1) sin(phi_1)];
    j2 = [cos(phi_2).*cos(theta_2) cos(phi_2).*sin(theta_2) sin(phi_2)];
    
    % Adjust vectors to be the same length
    vec_lengths = [size(g1,1), size(g2,1),size(j1,1),size(j2,1)];
    min_len = min(vec_lengths);
    j1 = j1(1:min_len,:);
    j2 = j2(1:min_len,:);
    g1 = g1(1:min_len,:);
    g2 = g2(1:min_len,:);
    
    % Solve for joint angles
    extension_angle = dot(g1,j1,2)-dot(g2,j2,2);
    
    
end

