#!/usr/bin/env ipython
#--------------------
from netCDF4 import Dataset, num2date
import os
import numpy as np
import datetime
import matplotlib.pyplot as plt
#--------------------
def cma(signal, window = 24):
    work = [np.nan]*len(signal)
    for i in range(window//2, len(signal) - window//2):
        work[i] = np.nanmean(signal[i-window//2:i+window//2])
    return work      
    
fname = 'ERA5_1986.nc'

ncin = Dataset(fname)
lon = np.array(ncin.variables['longitude'][:])
lat = np.array(ncin.variables['latitude'][:])
klon = np.squeeze(np.where(lon == 22.25))
klat = np.squeeze(np.where(lat == 59.25))
temp = np.array(ncin.variables['t2m'][:]) - 273.15
time = np.array([datetime.datetime(val.year, val.month, val.day, val.hour, val.minute) for val in num2date(ncin.variables['time'][:], ncin.variables['time'].units)])

fig = plt.figure(figsize=(10,3))
ax = fig.add_subplot(111)
ax.plot(time, temp[:, klat, klon], color='0.5', lw=2.0, label='Raw data')
ax.plot(time, cma(temp[:, klat, klon], 720), 'r-', lw=1., label='Monthly average')
ax.set_xlabel('Time')
ax.set_ylabel('Temperature [$^{\circ}C$]')
ax.set_title(f'Temperature time series at {lat[klat]} N, {lon[klon]} E')
ax.grid()
ax.legend()
fig.savefig('temp_ts_cma.png', bbox_inches='tight')


fig = plt.figure(figsize=(10,5))
ax = fig.add_subplot(111)

u = np.array(ncin.variables['u10'][:])
v = np.array(ncin.variables['v10'][:])
pres = np.array(ncin.variables['msl'][:])
ncin.close()

dlon, dlat = abs(np.mean(np.diff(lon))), abs(np.mean(np.diff(lat)))
dy = dlat*60.*1852.
dx = dlon*60.*1852.*np.cos(lat[klat]*np.pi/180.)

dt = np.mean(np.diff(time)).seconds
kktime = [i for i, val in enumerate(time) if val.month == 7 and val.day == 12]

local_acc = np.zeros(shape=len(kktime))
advec = np.zeros(shape=len(kktime))
coriolis = np.zeros(shape=len(kktime))
pressure = np.zeros(shape=len(kktime))
other = np.zeros(shape=len(kktime))
f = 4*(np.pi/86400)*np.sin(lat[klat]*np.pi/180.)

for i, itime in enumerate(kktime):
    local_acc[i] = (u[itime+1, klat, klon] - u[itime-1, klat, klon])/(2*dt)
    advec[i] = u[itime, klat, klon]*((u[itime, klat, klon+1] - u[itime, klat, 
               klon-1])/(2*dx)) + v[itime, klat, klon]*((v[itime, klat+1, 
               klon] - v[itime, klat-1, klon])/(2*dy)) 
    coriolis[i] = -1.*f*v[itime, klat, klon]
    pressure[i] = -1.*((pres[itime, klat, klon+1] - pres[itime, klat, klon-1])/(2*dx))
    other[i] = local_acc[i] + advec[i] + coriolis[i] - pressure[i]    

ax.plot(time[kktime], local_acc, 'r-', label='Local acceleration: $\\frac{du}{dt}$')
ax.plot(time[kktime], advec, 'k-', label='Acceleration due to advection: $u\\frac{\\partial u}{\\partial x}+ v\\frac{\\partial v}{\\partial y}$')
ax.plot(time[kktime], coriolis, 'b-', label='Acceleration due to Coriolis force: $fv$')
ax.plot(time[kktime], pressure, 'g-', label='Acceleration due to pressure force: $-\\frac{\\partial p}{\\partial x}$')
ax.plot(time[kktime], other, 'k--', label='Other forces')
ax.legend(loc='upper right', bbox_to_anchor=(0.5, 0.3, 0.9, 0.5))
ax.grid()
ax.set_xlabel('Time')
ax.set_ylabel('Force/acceleration [$m \\, s^{-2}$]')
plt.Axes.ticklabel_format(ax, axis='y', style='sci', scilimits=(-4,-3))
fig.savefig('xmoment.png', bbox_inches='tight')

def print_report():
    rtime = time[kktime]
    for acc, name in [(local_acc, 'Local acceleration'), (advec, 'Advection'), (coriolis, 'Coriolis'), (pressure, 'Pressure'), (other, 'Other')]:
        
        abs_mean = np.round(np.nanmean(np.abs(acc)), 7)
        
        if np.nanmean(acc) > 0:
            dire = 'positive'
        elif np.nanmean(acc) < 0:
            dire = 'negative'
        
        acc_max = np.round(np.nanmax(np.abs(acc)), 7)
        max_time = rtime[np.squeeze(np.where(np.abs(acc) == np.nanmax(np.abs(acc))))].strftime('%H:%M')
        
        acc_min = np.round(np.nanmin(np.abs(acc)), 7)
        min_time = rtime[np.squeeze(np.where(np.abs(acc) == np.nanmin(np.abs(acc))))].strftime('%H:%M')
        
        print(f"The average value of {name} was {abs_mean} and mostly in the {dire} direction on the x-axis. Maximum value of {acc_max} occurred at {max_time}. Minimum value of {acc_min} occurred at {min_time}.")
        print('-'*50)
#print_report()
