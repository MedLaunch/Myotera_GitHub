% inputs are acc, gyro and magn xyz matrix
% returns matrix of euler angles 
%DOES NOT WRITE TO A FILE OR PLOT ANYTHING
function eulfilt=orient_test_for_coder(acc,gyro,magn)
sample_rate = 52;

    %create AHRS filter
    ifilt = ahrsfilter('SampleRate', sample_rate);
    
    %Shortest set of data between acc, gyro, mag
    num_meas = min([size(acc,1), size(gyro,1), size(magn,1)]); 
    
    eulfilt = zeros(num_meas, 3);
    for ii=1:num_meas %Shortest set of data between acc, gyro, mag
        
        %Create quaternion
        qahrs = ifilt(acc(ii,:), gyro(ii,:), magn(ii,:));
        
        % Convert quarternion into Euler angles
        eulfilt(ii,:)= euler(qahrs(1,1),'ZYX','frame');
    end
end