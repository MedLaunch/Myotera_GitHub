import pandas as pd
import matplotlib.pyplot as plt

'''Notes
With more datasets, will eventually will want to address arrays/looping.
--essentially reducing code duplication.
'''
'''
1) Examing Data with Pandas.
2) Transform x,y,z acceleration from IMU to an inertial Earth frame.
3) Double Integrate Earth frame accelerations wrt to time to calculate x,y,z positions of phone.
4) 3D Plot of Phone's Trajectory --> Observe motion drift from accelerometer.
5) Perform Fourier analysis of acceleration signals to examine noise spectrum in each accelerometer axis.
6) Create high-pass filter to attenuate low freq noise --> perform inverse Fourier to calculate new accelerations with less noise.
7) Add x,y,z axis vectors to indicate phone's pose. (to 3D Plot)
'''

def mkdir(path):
	'''Creates SubDirectories if Path Does not Exist'''
	from pathlib import Path
	Path(path).mkdir(parents=True, exist_ok=True)


# Read in Data
df_accel = pd.read_csv('mbientdata/accel.csv', parse_dates=['time (-07:00)'], index_col=['elapsed (s)'])
df_magnet = pd.read_csv('mbientdata/magnet.csv', parse_dates=['time (-07:00)'], index_col=['elapsed (s)'])
df_gyro = pd.read_csv('mbientdata/gyro.csv', parse_dates=['time (-07:00)'], index_col=['elapsed (s)'])
# Drop Unecessary Headers for Now (to make plotting easier temporarily)
df_accel.drop(['epoch (ms)','time (-07:00)'], axis=1, inplace=True)
df_magnet.drop(['epoch (ms)','time (-07:00)'], axis=1, inplace=True)
df_gyro.drop(['epoch (ms)','time (-07:00)'], axis=1, inplace=True)



# Basic Plotting and Save Output
p1 = 'output/standardPlot/' # create output directory
mkdir(p1);
df_accel.plot(subplots=True,sharex=True,layout=(3,1))
plt.savefig('output/standardPlot/accel.png');
plt.clf()

df_magnet.plot(subplots=True,sharex=True,layout=(3,1))
plt.savefig('output/standardPlot/magnet.png');
plt.clf()

df_gyro.plot(subplots=True,sharex=True,layout=(3,1))
plt.savefig('output/standardPlot/gyro.png');
plt.clf()



# Transforming X, Y, Z Accelerations
#import pdb; pdb.set_trace()