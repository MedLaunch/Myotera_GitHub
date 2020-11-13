import pandas as pd
import numpy as np
from scipy.integrate import cumtrapz
from numpy import sin,cos,pi
import matplotlib.pyplot as plt
from mpl_toolkits import mplot3d
import json
plt.style.use('seaborn')

filename = input('''Please enter the name of the file for trajectory construction. \n 
Accepted file types are .JSON and .CSV: ''')

def find_mode(filename):
    '''
    Determines processing mode.

    Input: Filename, a string containing the name of the file

    Output: Mode, an integer which determines how to process the file
    '''
    mode = 0
    end = filename.split('.')[-1]

    accept = ['csv','json','CSV','JSON']
    if end not in accept:
        raise ValueError('Please enter a .CSV or .JSON file.')

    if end == 'CSV' or end == 'csv':
        mode = 1
    elif end == 'JSON' or end == 'json':
        mode = 2

    return mode

mode = find_mode(filename)

def process_data(filename, mode):
    '''
    Extracts data from .csv or .json file based on the mode, and returns timepoints and a dataframe.

    Input: Name of data file and the mode for processing

    Output: The timepoints in a numpy array and the processed Linear Acceleration Data in a Pandas dataframe. 
    '''
    # Initialize lists for adding data
    timestamps = []
    xF = []
    yF = []
    zF = []

    if mode == 1: # CSV
        # CSV
        initial = pd.read_csv(filename)
        df = initial.loc[initial.iloc[:,0] > 0]
        df.reset_index(drop = True, inplace = True)
        timestamps = np.array(df.iloc[:,0])
        df = df.iloc[:,1:]

        return timestamps, df

    elif mode == 2: # JSON
        acc = []
        with open(filename,'r') as f:
            for line in f:
                acc.append(json.loads(line))
            for entry in acc:
                stamp = entry.get('acc').get('Timestamp')

                x_F = entry.get('acc').get('ArrayAcc')[0].get('x')
                y_F = entry.get('acc').get('ArrayAcc')[0].get('y')
                z_F = entry.get('acc').get('ArrayAcc')[0].get('z')

                timestamps.append(stamp)
 
                xF.append(x_F)
                yF.append(y_F)
                zF.append(z_F)

            fused_signals = np.array([xF, yF, zF])
            timestamps = np.array(timestamps).T
            df = pd.DataFrame(fused_signals.T,columns = ['x','y','z'])

            return timestamps, df

time, data = process_data(filename, mode)                

# Should also include the filter here.

def accel_to_pos(data):
    '''
    Double 'integrates' the accelerometer data.

    Input: Linear acceleration pandas dataframe.

    Output: Numpy arrays for each position component x, y, and z.
    '''

    dt = 0.01
    # Double integrate accelerations to find positions
    x =cumtrapz(cumtrapz(data.iloc[:,0],dx=dt),dx=dt)
    y =cumtrapz(cumtrapz(data.iloc[:,1],dx=dt),dx=dt)
    data.iloc[:,2] = data.iloc[:,2] - 9.81
    z =cumtrapz(cumtrapz(data.iloc[:,2],dx=dt),dx=dt)

    return x, y, z

x,y,z = accel_to_pos(data)

# Plot 3D Trajectory
fig,ax = plt.subplots()
fig.suptitle(['3D Trajectory for ',filename],fontsize=20)
ax = plt.axes(projection='3d')
ax.plot3D(x,y,z,c='red',lw=2,label='phone trajectory')
ax.set_xlabel('X position (m)')
ax.set_ylabel('Y position (m)')
ax.set_zlabel('Z position (m)')
plt.show()
