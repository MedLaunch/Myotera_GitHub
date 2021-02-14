% ExampleScript.m
%
% This script demonstrates use of the MadgwickAHRS and MahonyAHRS algorithm
% classes with example data. ExampleData.mat contains calibrated gyroscope,
% accelerometer and magnetometer data logged from an AHRS device (x-IMU)
% while it was sequentially rotated from 0 degrees, to +90 degree and then
% to -90 degrees around the X, Y and Z axis.  The script first plots the
% example sensor data, then processes the data through the algorithm and
% plots the output as Euler angles.
%
% Note that the Euler angle plot shows erratic behaviour in phi and psi
% when theta approaches ±90 degrees. This due to a singularity in the Euler
% angle sequence known as 'Gimbal lock'.  This issue does not exist for a
% quaternion or rotation matrix representation.
%
% Date          Author          Notes
% 28/09/2011    SOH Madgwick    Initial release
% 13/04/2012    SOH Madgwick    deg2rad function no longer used
% 06/11/2012    Seb Madgwick    radian to degrees calculation corrected

%% SOURCE LINK

% https://x-io.co.uk/open-source-imu-and-ahrs-algorithms/


%% Start of script

addpath('quaternion_library');      % include quaternion library
close all;                          % close all figures
%clear;                              % clear all variables
%clc;                                % clear the command terminal

%% Import and plot sensor data

%load('ExampleData.mat'); 
acc = readtable('down2_180_wrist_acc1.csv');
acc= acc(:,2:4);
Accelerometer = table2array(acc);

gyro = readtable('down2_180_wrist_gyro1.csv');
gyro = gyro(:,2:4);
Gyroscope = table2array(gyro);

magn = readtable('down2_180_wrist_magn1.csv');
magn = magn(:,2:4);
Magnetometer = table2array(magn);

time = [1:height(Accelerometer)]';

figure('Name', 'Sensor Data');
axis(1) = subplot(3,1,1);
hold on;
plot(time, Gyroscope(:,1), 'r');
plot(time, Gyroscope(:,2), 'g');
plot(time, Gyroscope(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Angular rate (deg/s)');
title('Gyroscope');
hold off;
axis(2) = subplot(3,1,2);
hold on;
plot(time, Accelerometer(:,1), 'r');
plot(time, Accelerometer(:,2), 'g');
plot(time, Accelerometer(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Acceleration (g)');
title('Accelerometer');
hold off;
axis(3) = subplot(3,1,3);
hold on;
plot(time, Magnetometer(:,1), 'r');
plot(time, Magnetometer(:,2), 'g');
plot(time, Magnetometer(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Flux (G)');
title('Magnetometer');
hold off;
linkaxes(axis, 'x');

%% Process sensor data through algorithm

AHRS = MadgwickAHRS('SamplePeriod', 1/256, 'Beta', 0.1);
% AHRS = MahonyAHRS('SamplePeriod', 1/256, 'Kp', 0.5);

quaternion = zeros(length(time), 4);
for t = 1:length(time)
    AHRS.Update(Gyroscope(t,:) * (pi/180), Accelerometer(t,:), Magnetometer(t,:));	% gyroscope units must be radians
    quaternion(t, :) = AHRS.Quaternion;
end

%% Plot algorithm output as Euler angles
% The first and third Euler angles in the sequence (phi and psi) become
% unreliable when the middle angles of the sequence (theta) approaches ±90
% degrees. This problem commonly referred to as Gimbal Lock.
% See: http://en.wikipedia.org/wiki/Gimbal_lock

euler = quatern2euler(quaternConj(quaternion)) * (180/pi);	% use conjugate for sensor frame relative to Earth and convert to degrees.

figure('Name', 'Euler Angles');
hold on;
plot(time, euler(:,1), 'r');
plot(time, euler(:,2), 'g');
plot(time, euler(:,3), 'b');
title('Euler angles');
xlabel('Time (s)');
ylabel('Angle (deg)');
legend('\phi', '\theta', '\psi');
hold off;

%% Convert quaternions to rotation matrix.
cal_acc = zeros(height(Accelerometer),3);

for i = 1:height(quaternion)
    
    R = to_rotation_mat(quaternion(i,1), quaternion(i,2), quaternion(i,3), quaternion(i,4));
    
    pre = [Accelerometer(i,1),Accelerometer(i,2),Accelerometer(i,3)]';
    trans = R*pre;
    trans = trans';
    
    cal_acc(i,1) = trans(1,1);
    cal_acc(i,2) = trans(1,2);
    cal_acc(i,3) = trans(1,3);
    
end
figure('name','cal acc');
hold on
plot(time, cal_acc(:,1), 'r');
plot(time, cal_acc(:,2), 'g');
plot(time, cal_acc(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Acceleration (g)');
title('Calibrated Accelerometer');
hold off

figure('name','reg acc');
hold on
plot(time, Accelerometer(:,1), 'r');
plot(time, Accelerometer(:,2), 'g');
plot(time, Accelerometer(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Acceleration (g)');
title('regular Accelerometer');
hold off

%% End of script
%%
function [rot] = to_rotation_mat(q_r, q_i, q_j, q_k)

% https://en.wikipedia.org/wiki/Quaternions_and_spatial_rotation#Quaternion-derived_rotation_matrix

s = sqrt((q_i .^2) + (q_j .^2) + (q_k .^2));

rot = zeros(3,3);

e1_1 = (1 - 2 .*s .*(q_j .^2 + q_k .^2));
e1_2 = (2 .* s .*(q_i .* q_j - q_k .* q_r));
e1_3 = (2 .* s .*(q_i .* q_k + q_j .* q_r));

e2_1 = (2 .* s .*(q_i .* q_j + q_k .* q_r));
e2_2 = (1 - 2 .*s .*(q_i .^2 + q_k .^2));
e2_3 = (2 .* s .*(q_j .* q_k - q_i .* q_r));

e3_1 = (2 .* s .*(q_i .* q_k - q_j .* q_r));
e3_2 = (2 .* s .*(q_j .* q_k + q_i .* q_r));
e3_3 = (1 - 2 .*s .*(q_i .^2 + q_j .^2));

rot(1,1) = e1_1;
rot(1,2) = e1_2;
rot(1,2) = e1_3;
rot(2,1) = e2_1;
rot(2,2) = e2_2;
rot(2,3) = e2_3;
rot(3,1) = e3_1;
rot(3,2) = e3_2;
rot(3,3) = e3_3;


end
