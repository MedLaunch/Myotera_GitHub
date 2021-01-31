
%% Joint angles
% Myotera
%%%%% Avg 5 timestamps up to current

% Run joint_angles("reagan_magn_data","curl_hand","curl_elbow","5")
% Make sure in 'MATLAB programs' folder

% xyz probably flexion/extension-abduction/adduction-axial rotation
% timestamp parameter
function [xyz_joint_angle] = joint_angles(who,wristFolder,upperArmFolder,take)
    %% Read in data
    
    % Sensor 1 data (wrist)
    gyro_filename_1 = "../../datasets/" + who + "/" + wristFolder + "/" + "take" + take + "_gyro.csv";
    gyro_data_1 = readmatrix(gyro_filename_1);
    gyro_data_1 = gyro_data_1(1:4:end,:);

    % Sensor 2 data (upper arm)
    gyro_filename_2 = "../../datasets/" + who + "/" + upperArmFolder + "/" + "take" + take + "_gyro.csv";
    gyro_data_2 = readmatrix(gyro_filename_2);
    gyro_data_2 = gyro_data_2(1:4:end,:);

    % yaw pitch roll (from orientation csv file that orient_box.m creates)
    % Sensor 1 data (wrist)
    orient_box(who,wristFolder,take,false)
    orientation_wrist_csv = "orientation" + "_" + wristFolder + "_take" + take + ".csv";
    orientation_wrist_data = readmatrix(orientation_wrist_csv);

    % Sensor 2 data (upper arm)
    orient_box(who,upperArmFolder,take,false)
    orientation_arm_csv = "orientation" + "_" + upperArmFolder + "_take" + take + ".csv";
    orientation_arm_data = readmatrix(orientation_arm_csv);


    %% Initialize variables
    syms t;

    % Sampling Rate
    delta_t = 1/52;

    g1_minus2 = [gyro_data_1(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* (t-2*delta_t);
    g1_plus2 = [gyro_data_1(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* (t+2*delta_t);
    g1_minus1 = [gyro_data_1(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* (t-delta_t);
    g1_plus1 = [gyro_data_1(:,2) gyro_data_1(:,3) gyro_data_1(:,4)] .* (t+delta_t);

    g2_minus2 = [gyro_data_2(:,2) gyro_data_2(:,3) gyro_data_2(:,4)] .* (t-2*delta_t);
    g2_plus2 = [gyro_data_2(:,2) gyro_data_2(:,3) gyro_data_2(:,4)] .* (t+2*delta_t);
    g2_minus1 = [gyro_data_2(:,2) gyro_data_2(:,3) gyro_data_2(:,4)] .* (t-delta_t);
    g2_plus1 = [gyro_data_2(:,2) gyro_data_2(:,3) gyro_data_2(:,4)] .* (t+delta_t);


    %% Process Data
    % Time Derivative Angular Rates
    g1 = (g1_minus2-8.*g1_minus1+8.*g1_plus1-g1_plus2)./(12.*delta_t);
    g2 = (g2_minus2-8.*g2_minus1+8.*g2_plus1-g2_plus2)./(12.*delta_t);
    
    % Find roll and pitch angles corresponding to phi and theta respectively
    % from orientation data and convert to degrees
    phi_1 = orientation_wrist_data(:,3) * 180 / pi;
    phi_2 = orientation_arm_data(:,3) * 180 / pi;
    theta_1 = orientation_wrist_data(:,2) * 180 / pi;
    theta_2 = orientation_arm_data(:,2) * 180/ pi;

    % Calculate horizontal unit-length direction vectors
    j1 = [cos(phi_1).*cos(theta_1) cos(phi_1).*sin(theta_1) sin(phi_1)];
    j2 = [cos(phi_2).*cos(theta_2) cos(phi_2).*sin(theta_2) sin(phi_2)];

    % Solve for joint angles
    %eqn = dot(g1,j1) - dot(g2,j2);
    %size(j1) => 248 3
    %size(g1) => 62 3
    % ^ same for j2, g2
    % Therefore...
    j1 = j1(1:size(g1),:);
    j2 = j2(1:size(g2),:);
    xyz_joint_angle = dot(g1,j1)-dot(g2,j2);
    
    
end

