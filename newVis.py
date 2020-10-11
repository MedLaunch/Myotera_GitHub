import pandas as pd
import numpy as np
from scipy.integrate import cumtrapz
from numpy import sin,cos,pi
import matplotlib.pyplot as plt
from mpl_toolkits import mplot3d
plt.style.use('seaborn')

df = pd.read_csv('Sample9DoF_R_Session1_Shimmer_B663_Calibrated_SD.csv')

accel_LN = np.array([df['Shimmer_B663_Accel_LowNoise_X_CAL m/(s^2)'],
                  df['Shimmer_B663_Accel_LowNoise_Y_CAL m/(s^2)'],
                  df['Shimmer_B663_Accel_LowNoise_Z_CAL m/(s^2)']])

accel_WR = np.array([df['Shimmer_B663_Accel_WideRange_X_CAL m/(s^2)'],
                    df['Shimmer_B663_Accel_WideRange_Y_CAL m/(s^2)'],
                    df['Shimmer_B663_Accel_WideRange_Z_CAL m/(s^2)']])
print(accel_LN)
dt = 0.01
# Double integrate accelerations to find positions
x =cumtrapz(cumtrapz(df['Shimmer_B663_Accel_LowNoise_X_CAL m/(s^2)'],dx=dt),dx=dt)
y =cumtrapz(cumtrapz(df['Shimmer_B663_Accel_LowNoise_Y_CAL m/(s^2)'],dx=dt),dx=dt)
z =cumtrapz(cumtrapz(df['Shimmer_B663_Accel_LowNoise_Z_CAL m/(s^2)'],dx=dt),dx=dt)
# Plot 3D Trajectory
fig3,ax = plt.subplots()
fig3.suptitle('3D Trajectory of phone using Low Noise',fontsize=20)
ax = plt.axes(projection='3d')
ax.plot3D(x,y,z,c='red',lw=5,label='phone trajectory')
ax.set_xlabel('X position (m)')
ax.set_ylabel('Y position (m)')
ax.set_zlabel('Z position (m)')
plt.show()


# Double integrate accelerations to find positions
x =cumtrapz(cumtrapz(df['Shimmer_B663_Accel_WideRange_X_CAL m/(s^2)'],dx=dt),dx=dt)
y =cumtrapz(cumtrapz(df['Shimmer_B663_Accel_WideRange_Y_CAL m/(s^2)'],dx=dt),dx=dt)
z =cumtrapz(cumtrapz(df['Shimmer_B663_Accel_WideRange_Z_CAL m/(s^2)'],dx=dt),dx=dt)
# Plot 3D Trajectory
fig3,ax = plt.subplots()
fig3.suptitle('3D Trajectory of phone using Wide Range',fontsize=20)
ax = plt.axes(projection='3d')
ax.plot3D(x,y,z,c='red',lw=5,label='phone trajectory')
ax.set_xlabel('X position (m)')
ax.set_ylabel('Y position (m)')
ax.set_zlabel('Z position (m)')
plt.show()