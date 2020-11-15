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
    pdb.set_trace()
    data_filt.iloc[:,1] = np.fft.irfft(atten_x_fft,n=data_filt.shape[0])
    data_filt.iloc[:,2] = np.fft.irfft(atten_y_fft,n=data_filt.shape[0])
    data_filt.iloc[:,3] = np.fft.irfft(atten_z_fft,n=data_filt.shape[0])


    return data_filt


def remove_gravity(acc, orientation):
    '''
    Rotates the gravity vector by the IMU orientation and removes gravity component from 
    accelerometer data at each measurement.

    Input: Acceleration 3xn array (XYZ)
            Orientation 3xn array (ZYX euler angles)

    Output: Numpy arrays for each acceleration component x, y, and z.
    '''
    gravity = np.array([0, 0, -9.81])
    
    for i in range(len(acc)): 
        r = R.from_euler('zyx', orientation[i], degrees=True)
        gravity = r.apply(gravity)
        acc.loc[i] = acc.loc[i] - gravity
    return acc


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
    # data.iloc[:,2] = data.iloc[:,2] - 9.81
    z =cumtrapz(cumtrapz(data.iloc[:,2],dx=dt),dx=dt)

    return x, y, z

<<<<<<< HEAD
def main():
    
    filename = input('''Please enter the name of the file for trajectory construction. \n 
    Accepted file types are .JSON and .CSV: ''')

    mode = find_mode(filename)
    
    time, data = process_data(filename, mode)

    data_filt = band_pass_filt(data)

    orientation = np.ones((len(data_filt),3))
    
    ready_data = remove_gravity(data_filt, orientation)

    x,y,z = accel_to_pos(ready_data)
=======
main():
 #   x,y,z = accel_to_pos(data)
>>>>>>> e124d988daa0e7f10b1910c1d629658ca5f87b5f

    test = remove_gravity(ready_data, orientation)
    print(test)
    
    # Plot 3D Trajectory
    fig,ax = plt.subplots()
    fig.suptitle(['3D Trajectory for ',filename],fontsize=20)
    ax = plt.axes(projection='3d')
    ax.plot3D(x,y,z,c='red',lw=2,label='phone trajectory')
    ax.set_xlabel('X position (m)')
    ax.set_ylabel('Y position (m)')
    ax.set_zlabel('Z position (m)')
    plt.show()

if __name__ == '__main__':
<<<<<<< HEAD
    main()
=======
   main()
>>>>>>> e124d988daa0e7f10b1910c1d629658ca5f87b5f
