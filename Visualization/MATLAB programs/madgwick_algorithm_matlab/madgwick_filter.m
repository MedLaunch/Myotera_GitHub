addpath('quaternion_library');      % include quaternion library
close all;                          % close all figures
clear;                              % clear all variables
clc;                                % clear the command terminal

%% Load in files to process (acc, gyro, magn)
%load('ExampleData.mat');

sampleRate = 256; %Sample rate (Hz)

accfile = '../../../datasets/banded_data/up2_90/trial 1/up2_90_wrist_acc1';
gyrofile = '../../../datasets/banded_data/up2_90/trial 1/up2_90_wrist_gyro1';
magnfile = '../../../datasets/banded_data/up2_90/trial 1/up2_90_wrist_magn1';

acc = readtable(accfile + ".csv");
acc = table2array(acc(:,2:4));

gyro = readtable(gyrofile + ".csv");
gyro = table2array(gyro(:,2:4));

magn = readtable(magnfile + ".csv");
magn = table2array(magn(:,2:4)) .* 0.001; %convert to G

max_time = max(size(acc));
time = (1:max_time)';
dt = 1./sampleRate;

%% Plot given inputs
figure('Name', 'Sensor Data');
axis(1) = subplot(3,1,1);
hold on;
plot(time, gyro(:,1), 'r');
plot(time, gyro(:,2), 'g');
plot(time, gyro(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Angular rate (deg/s)');
title('Gyroscope');
hold off;
axis(2) = subplot(3,1,2);
hold on;
plot(time, acc(:,1), 'r');
plot(time, acc(:,2), 'g');
plot(time, acc(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('Accelerometer');
hold off;
axis(3) = subplot(3,1,3);
hold on;
plot(time, magn(:,1), 'r');
plot(time, magn(:,2), 'g');
plot(time, magn(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Flux (mG)');
title('Magnetometer');
hold off;
linkaxes(axis, 'x');

%% Band pass filter on acceleration
freq_x = fft(acc(:,1));
freq_y = fft(acc(:,2));
freq_z = fft(acc(:,3));

filt_x = bandpass(freq_x,[100 300],sampleRate);
filt_y = bandpass(freq_y,[100 300],sampleRate);
filt_z = bandpass(freq_z,[100 300],sampleRate);

acc(:,1) = ifft(filt_x);
acc(:,2) = ifft(filt_y);
acc(:,3) = ifft(filt_z);

figure('Name', 'Bandpass');
hold on
plot(time, acc(:,1), 'r');
plot(time, acc(:,2), 'g');
plot(time, acc(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('Filtered Accelerometer');
%% Calibrate magnetometer
%hard iron effects
off_x = max(magn(:,1)) - min(magn(:,1));
off_y = max(magn(:,2)) - min(magn(:,2));
off_z = max(magn(:,3)) - min(magn(:,3));
   
%soft iron effects
avg_delt_x = off_x ./ 2;
avg_delt_y = off_y ./ 2;
avg_delt_z = off_z ./ 2;
avg_delt = (avg_delt_x + avg_delt_y + avg_delt_z) ./ 3;

scale_x = avg_delt ./ avg_delt_x;
scale_y = avg_delt ./ avg_delt_y;
scale_z = avg_delt ./ avg_delt_z;

%correction of both 
magn(:,1) = (magn(:,1) - off_x) * scale_x;
magn(:,2) = (magn(:,2) - off_y) * scale_y;
magn(:,3) = (magn(:,3) - off_z) * scale_z;

%% Apply Madgwick filter to obtain orientation
AHRS = MadgwickAHRS('SamplePeriod', 1/sampleRate, 'Beta', 0.1);

quaternion = zeros(length(time), 4);
for t = 1:length(time)
    AHRS.Update(gyro(t,:) * (pi/180), acc(t,:) ./ 9.81 , magn(t,:));	% gyroscope units must be radians, acc units in g?
    quaternion(t, :) = AHRS.Quaternion;
end

%% Remove gravity from acc
cal_acc = zeros(max(size(acc)),3);

g = 9.81;
for i = 1:max(size((quaternion)))
    
    R = quatern2rotMat(quaternion(i,1:4));

    pre = [acc(i,1),acc(i,2),acc(i,3)]';
    trans = R*pre;
    trans = trans';
    %trans = [pre(1)-g.*R(7), pre(2)-g.*R(8), pre(3)-g.*R(9)];
    
    cal_acc(i,1) = trans(1,1);
    cal_acc(i,2) = trans(1,2);
    cal_acc(i,3) = trans(1,3);
end

% calfile = accfile + "_cal.csv";
% writematrix(cal_acc, calfile);

%% Plot calibrated vs uncalibrated acc
figure('name','cal acc');
hold on
plot(time, cal_acc(:,1), 'r');
plot(time, cal_acc(:,2), 'g');
plot(time, cal_acc(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Acceleration (m/s)');
title('Calibrated Accelerometer');
hold off

figure('name','reg acc');
hold on
plot(time, acc(:,1), 'r');
plot(time, acc(:,2), 'g');
plot(time, acc(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Acceleration (m/s)');
title('regular Accelerometer');
hold off

%% Plot processed vs unprocessed position
figure('name','reg pos')
pos_x = cumtrapz(cumtrapz(acc(:,1), time.*1/sampleRate),time.*1/sampleRate);
pos_y = cumtrapz(cumtrapz(acc(:,2), time.*1/sampleRate),time.*1/sampleRate);
pos_z = cumtrapz(cumtrapz(acc(:,3), time.*1/sampleRate),time.*1/sampleRate);
plot3(pos_x,pos_y,pos_z)

figure('name','cal pos')
pos_x = cumtrapz(cumtrapz(cal_acc(:,1), time.*1/sampleRate),time.*1/sampleRate);
pos_y = cumtrapz(cumtrapz(cal_acc(:,2), time.*1/sampleRate),time.*1/sampleRate);
pos_z = cumtrapz(cumtrapz(cal_acc(:,3), time.*1/sampleRate),time.*1/sampleRate);
plot3(pos_x,pos_y,pos_z)