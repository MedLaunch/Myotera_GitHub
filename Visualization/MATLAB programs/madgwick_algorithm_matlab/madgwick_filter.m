%addpath('quaternion_library');      % include quaternion library
close all;                          % close all figures
clear;                              % clear all variables
clc;                                % clear the command terminal

%% Load in files to process (acc, gyro, magn)
%load('ExampleData.mat');

sampleRate = 52; %Sample rate (Hz)

acc_file = '../../../datasets/banded_data/up2_90/trial 2/up2_90_wrist_acc2';
gyro_file = '../../../datasets/banded_data/up2_90/trial 2/up2_90_wrist_gyro2';
magn_file = '../../../datasets/banded_data/up2_90/trial 2/up2_90_wrist_magn2';

acc = readmatrix(acc_file);
acc = acc(:,2:4);

gyro = readmatrix(gyro_file);
gyro = gyro(:,2:4);

magn = readmatrix(magn_file);
magn = magn(:,2:4); 

max_time = min([ max(size(acc)) max(size(gyro)) max(size(magn)) ]);
time = (1:max_time)';
dt = 1./sampleRate;
if max(size(acc)) ~= max_time
    acc = acc(1:max_time,:);
end
if max(size(gyro)) ~= max_time
    gyro = gyro(1:max_time,:);
end
if max(size(magn)) ~= max_time
    magn = magn(1:max_time,:);
end

%% Plot given inputs
figure('Name', 'Sensor Data');
axis(1) = subplot(3,1,1);
hold on;
plot(time*dt, gyro(:,1), 'r');
plot(time*dt, gyro(:,2), 'g');
plot(time*dt, gyro(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Angular rate (deg/s)');
title('Gyroscope');
hold off;
axis(2) = subplot(3,1,2);
hold on;
plot(time*dt, acc(:,1), 'r');
plot(time*dt, acc(:,2), 'g');
plot(time*dt, acc(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('Accelerometer');
hold off;
axis(3) = subplot(3,1,3);
hold on;
plot(time*dt, magn(:,1), 'r');
plot(time*dt, magn(:,2), 'g');
plot(time*dt, magn(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Flux (mG)');
title('Magnetometer');
hold off;
linkaxes(axis, 'x');

%% Attenuate Noise on acceleration
figure('Name', 'Attenuated Data');
hold on
plot(time*dt, acc(:,1), 'r');
plot(time*dt, acc(:,2), 'g');
plot(time*dt, acc(:,3), 'b');
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('Filtered Accelerometer');

freq_x = fft(acc(:,1));
freq_y = fft(acc(:,2));
freq_z = fft(acc(:,3));

% figure('Name', 'Frequency Content');
% hold on
% plot(time, freq_x, 'r');
% plot(time, freq_y, 'g');
% plot(time, freq_z, 'b');
% legend('X', 'Y', 'Z');
% xlabel('Freq (Hz)');
% ylabel('Magnitude (dB)');
% title('Freq Response');
% 
% %High pass filter
% % freq_x = highpass(freq_x, 10, sampleRate);
% % freq_y = highpass(freq_y, 10, sampleRate);
% % freq_z = highpass(freq_z, 10, sampleRate);
% 
% %Bandpass Filter
% % freq_x = bandpass(freq_x, [10 40], sampleRate);
% % freq_y = bandpass(freq_y, [10 40], sampleRate);
% % freq_z = bandpass(freq_z, [10 40], sampleRate);
% 
%Attenuate frequencies over a certain magnitude
atten_x = find(abs(freq_x) > 10);
freq_x(atten_x) = freq_x(atten_x).*0.5;

atten_y = find(abs(freq_y) > 10);
freq_y(atten_y) = freq_y(atten_y).*0.5;

atten_z = find(abs(freq_z) > 10);
freq_z(atten_z) = freq_z(atten_z).*0.5;
% 
% figure('Name', 'Frequency Content');
% hold on
% plot(time, freq_x, 'r');
% plot(time, freq_y, 'g');
% plot(time, freq_z, 'b');
% legend('X', 'Y', 'Z');
% xlabel('Freq (Hz)');
% ylabel('Magnitude (dB)');
% title('Attenuated Freq Response');

acc(:,1) = ifft(freq_x);
acc(:,2) = ifft(freq_y);
acc(:,3) = ifft(freq_z);

plot(time*dt, acc(:,1), '--r');
plot(time*dt, acc(:,2), '--g');
plot(time*dt, acc(:,3), '--b');
legend('X', 'Y', 'Z', 'X_filt', 'Y_filt', 'Z_filt');

%% Calibrate magnetometer
figure('Name', 'Magnometer Effects');
hold on
plot(time*dt, magn(:,1), 'r');
plot(time*dt, magn(:,2), 'g');
plot(time*dt, magn(:,3), 'b');
xlabel('Time (s)');
ylabel('Flux (mG)');
title('Filtered Magnometer');

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

plot(time*dt, magn(:,1), '--r');
plot(time*dt, magn(:,2), '--g');
plot(time*dt, magn(:,3), '--b');
legend('X', 'Y', 'Z', 'X_filt', 'Y_filt', 'Z_filt');

%% Apply Madgwick filter to obtain orientation
% AHRS = MadgwickAHRS('SamplePeriod', 1/sampleRate, 'Beta', 0.1);
% 
% quaternion = zeros(length(time), 4);
% for t = 1:length(time)
%     AHRS.Update(gyro(t,:) .* (pi/180), acc(t,:) ./ 9.81 , magn(t,:) .* 0.001);	% gyroscope units must be radians, acc units in g?, magn in G?
%     quaternion(t, :) = AHRS.Quaternion;
% end
% 
% orientfile = accfile + "_orient.csv";
% writematrix(quaternion, orientfile);

%% ALT Filter
decim = 1;
fuse = ahrsfilter('SampleRate',sampleRate,'DecimationFactor',decim);
quat = fuse(acc, gyro*(pi/180), magn.*0.1); %Gyro in rad/s, Magnotemeter in uT instead of mG

%% Remove gravity from acc
g = [0 0 9.81]';
% for i = 1:max(size((quaternion)))
%     
%     R = quatern2rotMat(quaternion(i,1:4)); %Rotation matrix
% 
%     pre = [acc(i,1) acc(i,2) acc(i,3)]'; %frame to be rotated
%     trans = R*pre - g; %apply rotation and substract gravity
%     trans = trans'/R; %apply inverse rotation matrix to return to normal frame
%     
%     acc(i,1) = trans(1,1);
%     acc(i,2) = trans(1,2);
%     acc(i,3) = trans(1,3);
% end

acc = rotateframe(quat,acc);
for i = max(size(acc))
    acc(i,:) = acc(i,:) - g';
end
acc = rotateframe(-quat,acc);

figure('name','cal acc');
hold on
plot(time, acc(:,1), 'r');
plot(time, acc(:,2), 'g');
plot(time, acc(:,3), 'b');
legend('X', 'Y', 'Z');
xlabel('Time (s)');
ylabel('Acceleration (m/s)');
title('Zeroed Accelerometer');
hold off

%% Plot processed position
figure('name','pos')
pos_x = cumtrapz(cumtrapz(acc(:,1), time.*dt),time.*dt);
pos_y = cumtrapz(cumtrapz(acc(:,2), time.*dt),time.*dt);
pos_z = cumtrapz(cumtrapz(acc(:,3), time.*dt),time.*dt);
plot3(pos_x,pos_y,pos_z)
xlabel('X')
ylabel('Y')
zlabel('Z')
hold on
plot3(pos_x(1),pos_y(1),pos_z(1),'.')
hold off
grid on

% %% Function definition
% function R = quatern2rotMat(q)
% %QUATERN2ROTMAT Converts a quaternion orientation to a rotation matrix
% %
% %   R = quatern2rotMat(q)
% %
% %   Converts a quaternion orientation to a rotation matrix.
% %
% %   For more information see:
% %   http://www.x-io.co.uk/node/8#quaternions
% %
% %	Date          Author          Notes
% %	27/09/2011    SOH Madgwick    Initial release
% 
%     R(1,1,:) = 2.*q(:,1).^2-1+2.*q(:,2).^2;
%     R(1,2,:) = 2.*(q(:,2).*q(:,3)+q(:,1).*q(:,4));
%     R(1,3,:) = 2.*(q(:,2).*q(:,4)-q(:,1).*q(:,3));
%     R(2,1,:) = 2.*(q(:,2).*q(:,3)-q(:,1).*q(:,4));
%     R(2,2,:) = 2.*q(:,1).^2-1+2.*q(:,3).^2;
%     R(2,3,:) = 2.*(q(:,3).*q(:,4)+q(:,1).*q(:,2));
%     R(3,1,:) = 2.*(q(:,2).*q(:,4)+q(:,1).*q(:,3));
%     R(3,2,:) = 2.*(q(:,3).*q(:,4)-q(:,1).*q(:,2));
%     R(3,3,:) = 2.*q(:,1).^2-1+2.*q(:,4).^2;
% end
% 
% function ab = quaternProd(a, b)
% %QUATERNPROD Calculates the quaternion product
% %
% %   ab = quaternProd(a, b)
% %
% %   Calculates the quaternion product of quaternion a and b.
% %
% %   For more information see:
% %   http://www.x-io.co.uk/node/8#quaternions
% %
% %	Date          Author          Notes
% %	27/09/2011    SOH Madgwick    Initial release
% 
%     ab(:,1) = a(:,1).*b(:,1)-a(:,2).*b(:,2)-a(:,3).*b(:,3)-a(:,4).*b(:,4);
%     ab(:,2) = a(:,1).*b(:,2)+a(:,2).*b(:,1)+a(:,3).*b(:,4)-a(:,4).*b(:,3);
%     ab(:,3) = a(:,1).*b(:,3)-a(:,2).*b(:,4)+a(:,3).*b(:,1)+a(:,4).*b(:,2);
%     ab(:,4) = a(:,1).*b(:,4)+a(:,2).*b(:,3)-a(:,3).*b(:,2)+a(:,4).*b(:,1);
% end
% 
% function qConj = quaternConj(q)
% %QUATERN2ROTMAT Converts a quaternion to its conjugate
% %
% %   qConj = quaternConj(q)
% %
% %   Converts a quaternion to its conjugate.
% %
% %   For more information see:
% %   http://www.x-io.co.uk/node/8#quaternions
% %
% %	Date          Author          Notes
% %	27/09/2011    SOH Madgwick    Initial release
% 
%     qConj = [q(:,1) -q(:,2) -q(:,3) -q(:,4)];
% end
