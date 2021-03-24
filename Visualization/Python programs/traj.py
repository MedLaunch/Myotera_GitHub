import pandas as pd
import numpy as np
from scipy.integrate import cumtrapz
from scipy.signal import butter,filtfilt
from scipy.spatial.transform import Rotation as R
#from numpy import sin,cos,pi
import matplotlib.pyplot as plt
from mpl_toolkits import mplot3d
import json
import pdb
plt.style.use('seaborn')

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

# IF USING DATA FROM MATLAB CHANGE > TO >= ON LINE 53
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
        df = initial.loc[initial.iloc[:,0] >= 0] ###############
        df.reset_index(drop = True, inplace = True)
        timestamps = np.array(df.iloc[:,0])
        df = df.iloc[:,1:]

        print(filename,'processed.')
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
            print(filename,'processed.')
            return timestamps, df
               

# Should also include the filter here.
def band_pass_filt(data):
    '''
    Applies a band pass filter to the accelerometer data to attentuate noise.
    
    Input: Pandas dataframe of accelerometer data in x, y, and z.

    Output: Pandas dataframe of accelerometer data with reduced noise in x, y, and z.
    '''
    dt = 0.01
    # Try to remove noise via Fourier analysis
    # Discrete Fourier Transform sample frequencies
    freq = np.fft.rfftfreq(data.iloc[1].size,d=dt)
    # Compute the Fast Fourier Transform (FFT) of acceleration signals
    fft_x = np.fft.rfft(data.iloc[1,:]) 
    fft_y = np.fft.rfft(data.iloc[2,:]) 
    fft_z = np.fft.rfft(data.iloc[3,:])

    atten_x_fft = np.where(freq < 10,fft_x * 0.1, fft_x) 
    atten_y_fft = np.where(freq < 10,fft_y * 0.1, fft_y) 
    atten_z_fft = np.where((freq > 5) & (freq < 10),fft_z * 0.1, fft_z) 

    data_filt = data.copy(deep = True)

    # Compute inverse of discrete Fourier Transform 
    #pdb.set_trace()
    filt_x = pd.Series(np.fft.irfft(atten_x_fft,n=data_filt.shape[0]), dtype = 'float64', name = 'Filtered X')
    filt_y = pd.Series(np.fft.irfft(atten_y_fft,n=data_filt.shape[0]), dtype = 'float64', name = 'Filtered Y')
    filt_z = pd.Series(np.fft.irfft(atten_z_fft,n=data_filt.shape[0]), dtype = 'float64', name = 'Filtered Z')

    data_filt['Filtered X'] = filt_x 
    data_filt['Filtered Y'] = filt_y
    data_filt['Filtered Z'] = filt_z
    del data_filt['x']
    del data_filt['y']
    del data_filt['z']

    #print(data_filt.head())
    return data_filt

def calibrate_magn(df):

    # hard iron effects
    off_x = max(df.iloc[:,0]) - min(df.iloc[:,0])
    off_y = max(df.iloc[:,1]) - min(df.iloc[:,1])
    off_z = max(df.iloc[:,2]) - min(df.iloc[:,2])

    #soft iron effects
    avg_delt_x = (max(df.iloc[:,0]) - min(df.iloc[:,0])) / 2
    avg_delt_y = (max(df.iloc[:,1]) - min(df.iloc[:,1])) / 2
    avg_delt_z = (max(df.iloc[:,2]) - min(df.iloc[:,2])) / 2
    avg_delt = (avg_delt_x + avg_delt_y + avg_delt_z) / 3

    scale_x = avg_delt / avg_delt_x
    scale_y = avg_delt / avg_delt_y
    scale_z = avg_delt / avg_delt_z

    #correction of both 
    df.iloc[:,0] = (df.iloc[:,0] - off_x) * scale_x
    df.iloc[:,1] = (df.iloc[:,1] - off_y) * scale_y
    df.iloc[:,2] = (df.iloc[:,2] - off_z) * scale_z

    return df


def remove_gravity(acc, orientation):
    '''
    Rotates the gravity vector by the IMU orientation and removes gravity component from 
    accelerometer data at each measurement.

    Input: Acceleration 3xn array (XYZ)
            Orientation 3xn array (ZYX euler angles)

    Output: Numpy arrays for each acceleration component x, y, and z.
    '''
    gravity = np.array([0, 0, -9.81])

#    for i in range(len(acc)): 
#        r = R.from_euler('zyx', orientation.loc[i], degrees=True)
#        gravity = r.apply(gravity)
#        acc.loc[i] = acc.loc[i] - gravity

    rotated = pd.DataFrame(columns = ['x','y','z'])

    for i in range(len(orientation)):
        alpha = orientation.iloc[i,0] * np.pi/180
        beta = orientation.iloc[i,1] * np.pi/180
        gamma = orientation.iloc[i,2] * np.pi/180

        # First row of the rotation matrix
        r00 = np.cos(gamma) * np.cos(beta)
        r01 = np.cos(gamma) * np.sin(beta) * np.sin(alpha) - np.sin(gamma) * np.cos(alpha)
        r02 = np.cos(gamma) * np.sin(beta) * np.cos(alpha) + np.sin(gamma) * np.sin(alpha)
        
        # Second row of the rotation matrix
        r10 = np.sin(gamma) * np.cos(beta)
        r11 = np.sin(gamma) * np.sin(beta) * np.sin(alpha) + np.cos(gamma) * np.cos(alpha)
        r12 = np.sin(gamma) * np.sin(beta) * np.cos(alpha) - np.cos(gamma) * np.sin(alpha)
        
        # Third row of the rotation matrix
        r20 = -np.sin(beta)
        r21 = np.cos(beta) * np.sin(alpha)
        r22 = np.cos(beta) * np.cos(alpha)
        
        # 3x3 rotation matrix
        rot_matrix = np.array([[r00, r01, r02],
                            [r10, r11, r12],
                            [r20, r21, r22]])

        acc.iloc[i] = rot_matrix @ acc.iloc[i]

        acc.loc[i] -= gravity

    return acc

'''
calibrate magnetometer data - rotate each axis
take ^ and input to Madgick QUF
output is Quarternion
Convert ^ into 3x3 rotation matrix and invert this matrix
Apply the inverted rotation matrix to linear acceleration data
Use euler angles from MATLAB to rotate gravity
subtract gravity from linear acceleration data
'''

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
    #data.iloc[:,2] = data.iloc[:,2] - 9.81
    z =cumtrapz(cumtrapz(data.iloc[:,2],dx=dt),dx=dt)

    return x, y, z

'''
FILE EXTENSION FOR TESTING:
.\Visualization\Python programs\Initial sample data\acc_ud1.json
'''

def main():
    
    filename = input('''Please enter the name of the file for trajectory construction. \n 
    Accepted file types are .JSON and .CSV: ''')

    mode = find_mode(filename)
    
    time, data = process_data(filename, mode)
    
    data_filt = band_pass_filt(data)

    orientation_filename = input('''Please enter the name of the file with the associated orientation data. \n
    Accepted file types are .JSON and .CSV: ''')
    
    orientation = pd.read_csv(orientation_filename)
    del orientation['timestamp']

    magn_filename = input('''Please enter the name of the file with the associated magnetometer data. \n
    Accepted file types are .JSON and .CSV: ''')

    magn = pd.read_csv(magn_filename)
    del magn['timestamp']

    euler_filename = input('''Please enter the name of the file with the associated euler angle data. \n
    Accepted file types are .JSON and .CSV: ''')

    euler = pd.read_csv(euler_filename)
    del euler['time']

    cal_magn = calibrate_magn(magn)

    ready_data = remove_gravity(data_filt, euler) #data_filt #

    x,y,z = accel_to_pos(ready_data)
    
    key = filename.split("\\")[-1]

    # Plot 3D Trajectory
    fig,ax = plt.subplots()
    fig.suptitle(['3D Trajectory for ',key],fontsize=20)
    ax = plt.axes(projection='3d')
    ax.plot3D(x,y,z,c='red',lw=2,label='phone trajectory')
    ax.plot(x[0],y[0],z[0], markerfacecolor='k', markeredgecolor='k', marker='o', markersize=10)
    ax.plot(x[-1],y[-1],z[-1], markerfacecolor='b', markeredgecolor='k', marker='o', markersize=10)
    ax.set_xlabel('X position (m)')
    ax.set_ylabel('Y position (m)')
    ax.set_zlabel('Z position (m)')
    plt.show()

if __name__ == '__main__':
    main()
