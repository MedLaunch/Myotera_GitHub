%INPUTS
% sampleRate = 52; %Sample rate (Hz)
% 
% acc_file = '../../datasets/banded_data/up2_90/trial 2/up2_90_wrist_acc2';
% gyro_file = '../../datasets/banded_data/up2_90/trial 2/up2_90_wrist_gyro2';
% magn_file = '../../datasets/banded_data/up2_90/trial 2/up2_90_wrist_magn2';
% OR
% acc_file = array of acc values (avoid readmatrix coder conflict)

% OUTPUTS
% position x
% position y
% position z

function [pos_x, pos_y, pos_z] = simplified_traj(acc, gyro, magn, sampleRate)
    %% Load in files to process (acc, gyro, magn)
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

    %% Attenuate Noise on acceleration
    freq_x = fft(acc(:,1));
    freq_y = fft(acc(:,2));
    freq_z = fft(acc(:,3));

    %Attenuate frequencies over a certain magnitude
    atten_x = find(abs(freq_x) > 10);
    freq_x(atten_x) = freq_x(atten_x).*0.5;

    atten_y = find(abs(freq_y) > 10);
    freq_y(atten_y) = freq_y(atten_y).*0.5;

    atten_z = find(abs(freq_z) > 10);
    freq_z(atten_z) = freq_z(atten_z).*0.5;

    acc = complex(acc);
    acc(:,1) = ifft(freq_x);
    acc(:,2) = ifft(freq_y);
    acc(:,3) = ifft(freq_z);

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

    %% Obtain Orientation
    decim = 1;
    fuse = ahrsfilter('SampleRate',sampleRate,'DecimationFactor',decim);
    quat = fuse(acc, gyro.*(pi/180), magn.*0.1); %Gyro in rad/s, Magnotemeter in uT instead of mG
    
    %% Zero gravity vector
    g = [0 0 9.81]';
    acc = rotateframe(quat,acc);
    for i = max(size(acc))
        acc(i,:) = acc(i,:) - g';
    end
    acc = rotateframe(-quat,acc);

    %% Obtain position
    pos_x = cumtrapz(cumtrapz(acc(:,1), time.*dt),time.*dt);
    pos_y = cumtrapz(cumtrapz(acc(:,2), time.*dt),time.*dt);
    pos_z = cumtrapz(cumtrapz(acc(:,3), time.*dt),time.*dt);
end