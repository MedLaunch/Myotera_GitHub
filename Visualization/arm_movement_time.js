/*
--------------------------------------------------- BEGIN JAVASCRIPT TRANSLATION ---------------------------------------------------
*/

/* 
    function computes the proportion of time spent in an "active" state 
    by counting each timestep the sensor has moved past a threshold and returning
    the value of the counter divided by the total number of timesteps.
*/
function arm_movement_time(acc_file, sample_rate)
{
    // remove timestamp information for each entry
    for (entry of data)
    {
        delete entry['acc']['Timestamp'];
    }

    // subtract gravity
    // TODO

    // track activity time
    var active_counter = 0;
    var threshold = 0.0125;

    // Average magnitude of first five timestamps
    var prev_avg = 0;
    for (var i = 0; i < 5; ++i)
    {   
        datum = data[i];

        // for each reading in a timestep
        for (var step = 0; step < datum['acc']['ArrayAcc'].length; ++step)
        {
            accel_data = datum['acc']['ArrayAcc'][step];
            prev_avg += Math.sqrt(accel_data.x**2 + accel_data.y**2 + accel_data.z**2)
        }
    }
    prev_avg /= 5;

    console.log("Previous average: ", prev_avg);

    for (var j = 1; j < data.length - 4; ++j)
    {
        curr_avg = 0;
        for (var k = j; k < j+5; ++k)
        {
            datum = data[k];

            // for each reading in a timestep
            for (var step = 0; step < datum['acc']['ArrayAcc'].length; ++step)
            {
                accel_data = datum['acc']['ArrayAcc'][step];
                curr_avg += Math.sqrt(accel_data.x**2 + accel_data.y**2 + accel_data.z**2)
            }
        }
        curr_avg /= 5;
        console.log("Current average: ", curr_avg);

        if (Math.abs(curr_avg - prev_avg) > threshold)
        {
            ++active_counter;
            console.log("Counted!");
        }

        prev_avg = curr_avg;
    }


    // calculate total time active
    sample_time = 1 / sample_rate;
    total_time = sample_time * Object.keys(data).length;
    total_time_active = active_counter * sample_time;
    percent_active = total_time_active / total_time;

    return percent_active;
}

const fs = require('fs');

let rawdata = fs.readFileSync('data_examples/sample1.json');
let data = JSON.parse(rawdata);

console.log(arm_movement_time(data, 0.05));

/*
--------------------------------------------------- END JAVASCRIPT TRANSLATION ---------------------------------------------------
*/

/*
--------------------------------------------------- ORIGINAL MATLAB CODE BELOW ---------------------------------------------------
function [percent_active] = arm_movement_time(acc_file,sample_rate)
    %% Read in data
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
*/