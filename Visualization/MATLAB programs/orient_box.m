
% MAKE SURE IN 'MATLAB programs' FOLDER

function []=orient_box(where,what,trial,which,plot)
    sample_rate = 52;
    %Read in 9-DOF data
    %accfile = '../../datasets/reagan_magn_data/curl_motion/20201115T220555Z-180230000179-acc-stream.csv';
    accfile = "../../datasets/" + where + "/" + what + "/" + "trial " + trial + "/" + what + "_" + which + "_acc" + trial + ".csv";
    opts = detectImportOptions(accfile);
    opts.SelectedVariableNames = [2:4]; 
    acc = readmatrix(accfile, opts);

    %gyrofile = '../../datasets/reagan_magn_data/curl_motion/20201115T220555Z-180230000179-gyro-stream.csv';
    gyrofile = "../../datasets/" + where + "/" + what + "/" + "trial " + trial + "/" + what + "_" + which + "_gyro" + trial + ".csv";
    opts = detectImportOptions(gyrofile);
    opts.SelectedVariableNames = [2:4]; 
    gyro = readmatrix(gyrofile, opts);

    %magnfile = '../../datasets/reagan_magn_data/curl_motion/20201115T220555Z-180230000179-magn-stream.csv';
    magnfile = "../../datasets/" + where + "/" + what + "/" + "trial " + trial + "/" + what + "_" + which + "_magn" + trial + ".csv";
    opts = detectImportOptions(magnfile);
    opts.SelectedVariableNames = [2:4]; 
    magn = readmatrix(magnfile, opts);

    if(plot)
        viewer = HelperOrientationViewer;
    end

    %Edittable Parameters
    % ahrsFilter.GyroscopeNoise          = 0.0002;
    % ahrsFilter.AccelerometerNoise      = 0.0003;
    % ahrsFilter.LinearAccelerationNoise = 0.0025;
    % ahrsFilter.MagnetometerNoise       = 0.1;
    % ahrsFilter.MagneticDisturbanceNoise = 0.5;
    % ahrsFilter.MagneticDisturbanceDecayFactor = 0.5;

    ifilt = ahrsfilter('SampleRate', sample_rate);

    num_meas = min([size(acc,1), size(gyro,1), size(magn,1)]); %Shortest set of data between acc, gyro, mag
    for ii=1:num_meas %Shortest set of data between acc, gyro, mag
        qahrs = ifilt(acc(ii,:), gyro(ii,:), magn(ii,:));
        if(plot)
            viewer(qahrs);
        end
        pause(0.01);

        % Convert quarternion into Euler angles
        eulfilt(ii,:)= euler(qahrs,'ZYX','frame');
    end

    % qahrs = ifilt(acc(1:num_meas,:), gyro(1:num_meas,:), magn(1:num_meas,:));
    % eulfilt = euler(qahrs,'ZYX','frame');
    % viewer(qahrs);
    storePath = "orientation" + "_" + what + "_" + which + "_trial" + trial + ".csv";
    writematrix(eulfilt,storePath)
    
    if(plot)
        % Release the system object
        release(ifilt)

        %Plotting roll, pitch, yaw over time:
        t = 1:num_meas;
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
    end
    
end
    
    