
%% Arm Movement Time
% Myotera

% Example call is total_time_activity = arm_movement_time('banded_data','up2_90','3',52)

% INPUTS
% where is main folder
% what is action type
% trial is trial number
% sample rate data recored in Hz

function [total_time_activity] = arm_movement_time(where,what,trial,sample_rate)
    %% Read in data
    acc_directory = "../../datasets/" + where + "/" + what + "/" + "trial " + trial + "/" + what + "_wrist_acc" + trial + ".csv";
    acc_data = readmatrix(acc_directory);
    
    % Remove timestamp column
    acc_data = acc_data(:,2:4);
    
    %% Track activity time
    active_counter = 0;
    threshhold = 0; %%%%%%% Need to find this out
    
    for i = 1:size(acc_data,1)
        if norm(acc_data(i,:)) > threshhold
            active_counter = active_counter + 1;
        end
    end
    
    %% Calculate total time active
    sample_rate = 1/sample_rate;
    
    total_time_activity = active_counter * sample_rate;
    
    
end

