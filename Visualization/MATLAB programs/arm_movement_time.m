%% Arm Movement Time
% Myotera

% Example call is total_time_activity = arm_movement_time('banded_data','up2_90','3',52)
% total_time_activity = arm_movement_time('no_motion','up2_90','3',52)
% total_time_activity = arm_movement_time('semi_constant','up2_90','3',52)

% INPUTS
%acc_directory is acceleration file to analyze
% where is main folder
% what is action type
% trial is trial number
% sample rate data recored in Hz

function [percent_active] = arm_movement_time(acc_file,sample_rate)
    %% Read in data
    acc_file = "../../datasets/matt_data/walk_to_no_thai";
%     acc_file = "../../datasets/short_walk2/short_walk2_acc_stream";
     %acc_directory = "../../datasets/" + where + "/" + what + "/" + "trial " + trial + "/" + what + "_wrist_acc" + trial + ".csv";
        % acc_directory = "../../datasets/" + where + "/" + where + "_acc.csv"; % For no_motion
%       acc_directory = "../../datasets/" + where + "/" + what + "_acc.csv"; % For semi_constant
    acc_data = readmatrix(acc_file);
    
    % Remove timestamp column
    acc_data = acc_data(:,2:4);
    
    % Subtract gravity
    %%%%%%%%%%%%%% TODO
    %Don't think it's necesarry, needs to be tested with walking data with
    %little to no arm movement
    
    %% Track activity time
    active_counter = 0; %Number of arm movements
    threshhold = 0.0125; %%%%%%% Need to find this out
    %Average magnitude of first 5 timestamps
    prev_avg = ( norm(acc_data(1,:)) + norm(acc_data(2,:)) + norm(acc_data(3,:)) + norm(acc_data(4,:)) + norm(acc_data(5,:))) / 5;
    
    final = max(size(acc_data)) - 4;
    for i = 2:final %Sweep frame of average over the entire dataset
        cur_avg = ( norm(acc_data(i,:)) + norm(acc_data(i+1,:)) + norm(acc_data(i+2,:)) + norm(acc_data(i+3,:)) + norm(acc_data(i+4,:)) ) / 5;
        if abs(cur_avg - prev_avg) > threshhold
            active_counter = active_counter + 1;
        end
        prev_avg = cur_avg;
    end
    
    %% Calculate total time active
    sample_time = 1/sample_rate;
    total_time = sample_time * max(size(acc_data));
    total_time_activity = active_counter * sample_time;
    percent_active = total_time_activity / total_time;
end

