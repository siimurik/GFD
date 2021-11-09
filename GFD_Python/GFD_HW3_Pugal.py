import netCDF4 as nc
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.dates as mdates

fn = "ERA5_1986.nc"
ds = nc.Dataset(fn)

time = ds['time']
dtime = nc.num2date(time[:], time.units)
lon = ds['longitude'][:]
lat = ds['latitude'][:]
u10 = ds['u10'][:]
v10 = ds['v10'][:]
t2m = ds['t2m'][:]
msl = ds['msl'][:]

#>>np.squeeze(x)[()]
#1234

lon_in = np.squeeze(np.where(lon == 22.75))[()]
lat_in = np.squeeze(np.where(lat == 59.75))[()]

delta_t = np.arange(5000,5500)

lat_val = lat[lat_in]
lon_val = lon[lon_in]
dy = 0.25*60.*1852.
dx = 0.25*60.*1852.*np.cos(lat_val*np.pi/180.)

dt = 3600
f = 4*(np.pi/86400)*np.sin(lat_val*np.pi/180.)

dudt = np.zeros(len(delta_t))
c    = np.zeros(len(delta_t))
dpdx = np.zeros(len(delta_t))

for i, itime in enumerate(delta_t):
    dudt[i] = ( u10[(itime+1),lat_in,lon_in] - u10[(itime-1),lat_in,lon_in] )/(2.0*dt)
    c[i]    = -f*v10[itime, lat_in, lon_in]
    dpdx[i] = ( msl[itime,lat_in,(lon_in+1)] - msl[itime,lat_in,(lon_in-1)] )/(2.0*dy)
    
    #print(i, '\t', itime)

#print(u10.shape)
# (8760, 5, 5)
#print(u10[4000:4010,0:4,1:4])

fig = plt.figure(figsize=(10,5))
ax = fig.add_subplot(111)

ax.plot(time[delta_t], dudt, 'r-', label='Local acceleration: $\\frac{du}{dt}$')
ax.plot(time[delta_t], c,    'b-', label='Acceleration due to Coriolis force: $fv$')
ax.plot(time[delta_t], dpdx, 'g-', label='Acceleration due to pressure force: $-\\frac{\\partial p}{\\partial x}$')
ax.xaxis.set_major_formatter(mdates.DateFormatter('%m-%d'))
ax.grid()
ax.legend(loc='lower left', prop={'size': 6})
fig.savefig('HW3_plot.png', dpi = 300)
plt.show()
