function orient_box(acc, gyro, mag, sample_rate) 
%Takes input for accelerometer, gyroscope, magnometer (XYZ columns) matrix
%Outputs plot of orientation over time

%Test sample set: 
%Uncomment and run with "orient_box([1 1 1],[1 1 1],[1 1 1],200)"
% ld = load('rpy_9axis.mat');
% acc = ld.sensorData.Acceleration;
% gyro = ld.sensorData.AngularVelocity;
% mag = ld.sensorData.MagneticField;

viewer = HelperOrientationViewer;

%Edittable Parameters
ahrsFilter.GyroscopeNoise          = 0.0002;
ahrsFilter.AccelerometerNoise      = 0.0003;
ahrsFilter.LinearAccelerationNoise = 0.0025;
ahrsFilter.MagnetometerNoise       = 0.1;
ahrsFilter.MagneticDisturbanceNoise = 0.5;
ahrsFilter.MagneticDisturbanceDecayFactor = 0.5;

ifilt = ahrsfilter('SampleRate', sample_rate);

for ii=1:size(acc,1)
    qahrs = ifilt(acc(ii,:), gyro(ii,:), mag(ii,:));
    viewer(qahrs);
    pause(0.01);
    
    % Convert quarternion into Euler angles
    eulfilt(ii,:)= euler(qahrs,'ZYX','frame');
end

% Release the system object
release(ifilt)

%Plotting roll, pitch, yaw over time:
t = 1:size(acc,1);
figure() %Fused Roll Pitch Yaw
subplot(3,1,1)
    plot(t, eulfilt(:,3))
    title('Fused ROLL Data')
    ylabel('Rotation (degrees)')
    xlabel('Time (s)')
    subplot(3,1,2)
    plot(t, eulfilt(:,2))
    title('Fused PITCH Data')
    ylabel('Rotation (degrees)')
    xlabel('Time (s)')
    subplot(3,1,3)
    plot(t, eulfilt(:,1))
    title('Fused YAW Data')
    ylabel('Rotation (degrees)')
    xlabel('Time (s)')