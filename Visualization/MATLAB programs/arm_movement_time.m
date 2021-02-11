
%% Arm Movement Time
% Myotera

% Example call is total_time_activity = arm_movement_time('banded_data','up2_90','3',52)
% total_time_activity = arm_movement_time('no_motion','up2_90','3',52)
% total_time_activity = arm_movement_time('semi_constant','up2_90','3',52)

% INPUTS
% where is main folder
% what is action type
% trial is trial number
% sample rate data recored in Hz

function [total_time_activity] = arm_movement_time(where,what,trial,sample_rate)
    %% Read in data
%     acc_directory = "../../datasets/" + where + "/" + what + "/" + "trial " + trial + "/" + what + "_wrist_acc" + trial + ".csv";
         acc_directory = "../../datasets/" + where + "/" + where + "_acc.csv"; % For no_motion
%       acc_directory = "../../datasets/" + where + "/" + what + "_acc.csv"; % For semi_constant
    acc_data = readmatrix(acc_directory);
    
    % Remove timestamp column
    acc_data = acc_data(:,2:4);
    
    % Subtract gravity
    %%%%%%%%%%%%%% TODO
    
    %% Track activity time
    active_counter = 0;
    threshhold = 0.0125; %%%%%%% Need to find this out
    prev_avg = (norm(acc_data(1,:))+norm(acc_data(2,:))+norm(acc_data(3,:)))/3;
    
    for i = 3:(size(acc_data,1)-2)
        cur_avg = (norm(acc_data(i-2,:))+norm(acc_data(i-1,:))+norm(acc_data(i,:))+norm(acc_data(i+1,:))+norm(acc_data(i+2,:)))/5;
        if abs(cur_avg - prev_avg) > threshhold
            active_counter = active_counter + 1;
        end
        prev_avg = cur_avg;
    end
    
    %% Calculate total time active
    sample_rate = 1/sample_rate;
    
    total_time_activity = active_counter * sample_rate;
    
    
end

