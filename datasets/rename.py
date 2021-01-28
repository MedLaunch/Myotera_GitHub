from os import rename, mkdir
from sys import argv

# <name of motion>_<Wrist or bicep sensors>_<accel, gyro, or magn><trial num>

def main(args):
    num_args = 9
    if len(args) != num_args:
        print('Usage: <accel.csv wrist> <gyro.csv wrist> <magn.csv wrist>')
        print('       <accel.csv bicep> <gyro.csv bicep> <magn.csv bicep>')
        print('       <name of motion> <trial number>')
        print('       <name for the folder>')
        exit(1)

    sensor_names = ['accel', 'gyro', 'magn']
        
    motion_name = 6
    trial_num = 7
    
    folder_name = 8

    # Move files into the folder
    mkdir(args[folder_name])

    for i in range(3):
        filename_wrist = f'{args[folder_name]}/{args[motion_name]}_wrist_{sensor_names[i]}{args[trial_num]}'
        filename_bicep = f'{args[folder_name]}/{args[motion_name]}_bicep_{sensor_names[i]}{args[trial_num]}'
        rename(args[i], filename_wrist)
        rename(args[i + 3], filename_bicep)
    

if __name__ == "__main__":
    main(argv[1:])
