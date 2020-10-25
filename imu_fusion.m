clear;
close all;
clc;
hold off;

%Read in data:
IMUReadings = readtable('Sample9DoF_R_Session1_Shimmer_B663_Calibrated_SD.csv', 'HeaderLines',2);  % skips the first three rows of data
accelReadings = table2array(IMUReadings(1:end-1, 5:7));
gyroReadings = table2array(IMUReadings(1:end-1, 8:10));
magReadings = table2array(IMUReadings(1:end-1, 11:13));
samp_quat = table2array(IMUReadings(1:end-1, 14:17)); %Sample set fusion
fuse_out0 = quaternion(samp_quat(:,1),samp_quat(:,2),samp_quat(:,3),samp_quat(:,4));

%Processing parameters:
Fs = 512; %sample rate (Hz)
decim = 1; %Decimation factor
time = (0:decim:size(accelReadings,1)-1)/Fs; %Time vector for plotting

%Sensor fusion:
fuse = ahrsfilter('SampleRate',Fs,'DecimationFactor',decim); %AHRS 
fuse2 = complementaryFilter('SampleRate', Fs); %Complementary
fuse_out = fuse(accelReadings,gyroReadings,magReadings);
fuse_out2 = fuse2(accelReadings,gyroReadings,magReadings);
eulard_out0 = eulerd(fuse_out0,'XYZ','frame');
eulard_out = eulerd(fuse_out,'ZYX','frame');
eulard_out2 = eulerd(fuse_out2,'ZYX','frame');

%Plotting:
figure(1) %Fused Data
plot(time,eulard_out)
title('Fused Orientation Estimate')
legend('z-axis', 'y-axis', 'x-axis')
ylabel('Rotation (degrees)')
xlabel('Time (s)')

figure(2) %Fused XYZ
subplot(3,1,1)
    plot(time, eulard_out(:,3))
    title('Fused X Data')
    ylabel('Rotation (degrees)')
    xlabel('Time (s)')
    subplot(3,1,2)
    plot(time, eulard_out(:,2))
    title('Fused Y Data')
    ylabel('Rotation (degrees)')
    xlabel('Time (s)')
    subplot(3,1,3)
    plot(time, eulard_out(:,1))
    title('Fused Z Data')
    ylabel('Rotation (degrees)')
    xlabel('Time (s)')

figure(3) %Accel Data
hold on
plot(time, accelReadings(:,3), time, accelReadings(:,2), time, accelReadings(:,1))
title('Accel Data')
legend('z-axis', 'y-axis', 'x-axis')
ylabel('Accel (m/s^2)')
xlabel('Time (s)')

figure(4) %Accel XYZ
subplot(3,1,1)
    plot(time, accelReadings(:,1))
    title('Accel X Data')
    ylabel('Accel (m/s^2)')
    xlabel('Time (s)')
    subplot(3,1,2)
    plot(time, accelReadings(:,2))
    title('Accel Y Data')
    ylabel('Accel (m/s^2)')
    xlabel('Time (s)')
    subplot(3,1,3)
    plot(time, accelReadings(:,3))
    title('Accel Z Data')
    ylabel('Accel (m/s^2)')
    xlabel('Time (s)')

figure(5) %Gyro Data
hold on
plot(time, gyroReadings(:,3), time, gyroReadings(:,2), time, gyroReadings(:,1))
title('Gyro Data')
legend('z-axis', 'y-axis', 'x-axis')
ylabel('Rotation (deg)')
xlabel('Time (s)')

figure(6) %Gyro XYZ
subplot(3,1,1)
    plot(time, gyroReadings(:,1))
    title('Gyro X Data')
    ylabel('Rotation (deg)')
    xlabel('Time (s)')
    subplot(3,1,2)
    plot(time, gyroReadings(:,2))
    title('Gyro Y Data')
    ylabel('Rotation (deg)')
    xlabel('Time (s)')
    subplot(3,1,3)
    plot(time, gyroReadings(:,3))
    title('Gyro Z Data')
    ylabel('Rotation (deg)')
    xlabel('Time (s)')

figure(7) %Mag Data
hold on
plot(time, magReadings(:,3), time, magReadings(:,2), time, magReadings(:,1))
title('Mag Data')
legend('z-axis', 'y-axis', 'x-axis')
ylabel('M-field (local flux)')
xlabel('Time (s)')

figure(8) %Mag XYZ
subplot(3,1,1)
    plot(time, magReadings(:,1))
    title('Mag X Data')
    ylabel('M-field (local flux)')
    xlabel('Time (s)')
    subplot(3,1,2)
    plot(time, magReadings(:,2))
    title('Mag Y Data')
    ylabel('M-field (local flux)')
    xlabel('Time (s)')
    subplot(3,1,3)
    plot(time, magReadings(:,3))
    title('Mag Z Data')
    ylabel('M-field (local flux)')
    xlabel('Time (s)')
    
figure(9) %Fused Data Comp
plot(time,eulard_out)
title('Fused Orientation Estimate Comp')
legend('z-axis', 'y-axis', 'x-axis')
ylabel('Rotation (degrees)')
xlabel('Time (s)')

figure(10) %Fused XYZ Comp
subplot(3,1,1)
    plot(time, eulard_out(:,3))
    title('Fused X Data Comp')
    ylabel('Rotation (degrees)')
    xlabel('Time (s)')
    subplot(3,1,2)
    plot(time, eulard_out(:,2))
    title('Fused Y Data Comp')
    ylabel('Rotation (degrees)')
    xlabel('Time (s)')
    subplot(3,1,3)
    plot(time, eulard_out(:,1))
    title('Fused Z Data Comp')
    ylabel('Rotation (degrees)')
    xlabel('Time (s)')
    
figure(11) %Fused Data Comp
plot(time,eulard_out0)
title('Fused Orientation Estimate Samp')
legend('z-axis', 'y-axis', 'x-axis')
ylabel('Rotation (degrees)')
xlabel('Time (s)')

figure(12) %Fused XYZ Comp
subplot(3,1,1)
    plot(time, eulard_out0(:,3))
    title('Fused X Data Samp')
    ylabel('Rotation (degrees)')
    xlabel('Time (s)')
    subplot(3,1,2)
    plot(time, eulard_out0(:,2))
    title('Fused Y Data Samp')
    ylabel('Rotation (degrees)')
    xlabel('Time (s)')
    subplot(3,1,3)
    plot(time, eulard_out0(:,1))
    title('Fused Z Data Samp')
    ylabel('Rotation (degrees)')
    xlabel('Time (s)')
    
    figure(13)
    plot3(eulard_out(:,3),eulard_out(:,2),eulard_out(:,1))
