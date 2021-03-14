addpath('quaternion_library');      % include quaternion library
close all;                          % close all figures
clear;                              % clear all variables
clc;                                % clear the command terminal

%load('ExampleData.mat');

accfile = '../../../datasets/banded_data/up2_90/trial 1/up2_90_wrist_acc1';
gyrofile = '../../../datasets/banded_data/up2_90/trial 1/up2_90_wrist_gyro1';
magnfile = '../../../datasets/banded_data/up2_90/trial 1/up2_90_wrist_magn1';

acc = readtable(accfile + ".csv");
acc = acc(:,2:4);
Accelerometer = table2array(acc);

gyro = readtable(gyrofile + ".csv");
gyro = gyro(:,2:4);
Gyroscope = table2array(gyro);

magn = readtable(magnfile + ".csv");
magn = magn(:,2:4);
Magnetometer = 0.001 .* table2array(magn); %convert to G

max_time = max(size(Accelerometer));
time = (1:max_time)';

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
ylabel('Acceleration (m/s^2)');
title('Accelerometer');
hold off;
axis(3) = subplot(3,1,3);
hold on;
plot(time, Magnetometer(:,1), 'r');
plot(time, Magnetometer(:,2), 'g');
plot(time, Magnetometer(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Flux (mG)');
title('Magnetometer');
hold off;
linkaxes(axis, 'x');

AHRS = MadgwickAHRS('SamplePeriod', 1/256, 'Beta', 0.1);

quaternion = zeros(length(time), 4);
for t = 1:length(time)
    AHRS.Update(Gyroscope(t,:) * (pi/180), Accelerometer(t,:) ./ 9.81 , Magnetometer(t,:));	% gyroscope units must be radians
    quaternion(t, :) = AHRS.Quaternion;
end

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

cal_acc = zeros(max(size(Accelerometer)),3);

g = 9.81;
for i = 1:max(size((quaternion)))
    
    R = quatern2rotMat(quaternion(i,1:4));

    pre = [Accelerometer(i,1),Accelerometer(i,2),Accelerometer(i,3)]';
    %trans = R*pre;
    %trans = trans';
    trans = [pre(1)-g.*R(7), pre(2)-g.*R(8), pre(3)-g.*R(9)];
    
    cal_acc(i,1) = trans(1,1);
    cal_acc(i,2) = trans(1,2);
    cal_acc(i,3) = trans(1,3);
end

calfile = accfile + "_cal.csv";
writematrix(cal_acc, calfile);

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
plot(time, Accelerometer(:,1), 'r');
plot(time, Accelerometer(:,2), 'g');
plot(time, Accelerometer(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Acceleration (m/s)');
title('regular Accelerometer');
hold off
