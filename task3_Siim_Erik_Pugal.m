clear
load('BalticSea_mask.mat','lonf','latf','maskl','depth') % landmask for baltic sea: download it from www.tiny.cc/BS_landmask

ncf='ERA5_1986.nc';
%ncdisp(ncf) % for studying the data
%msl(t, lat, long)
%time = t0 + (1:24)
%lat - 2
%long - 2
%central differencing method
time = ncread(ncf,'time');
lon=ncread(ncf,'longitude');
lat=ncread(ncf,'latitude');
u10m=permute(ncread(ncf,'u10'),[3 2 1]);
v10m=permute(ncread(ncf,'v10'),[3 2 1]);
mslm=permute(ncread(ncf,'msl'),[3 2 1]); %mean sealevel preassure

figure(88);clf; hold on;set(gcf,'color','w')
contour(lonf,latf,maskl,[1 1],'edgecolor',[1 1 1]*0.5)  % landmask
contour(lon,lat,squeeze(mslm(1,:,:)),[999:1010]*1e2,'edgecolor','r');

windspeed=sqrt( squeeze(u10m(1,:,:)).^2 + squeeze(v10m(1,:,:)).^2);
pc=pcolor(lon,lat,windspeed);
pc.FaceAlpha=0.5;  caxis([5 15])
quiver(lon,lat,squeeze(u10m(1,:,:)),squeeze(v10m(1,:,:)))

axis([21.5    23.5    58.5  60.5])
xlabel('Longitude [^oE]')
ylabel('Latitude [^oN]')
cb=colorbar;   
set(get(cb,'label'),'string','Windspeed [m s^{-1}]')
%%




%%

%{
Source:
           C:\Users\siime\OneDrive\Dokumendid\MATLAB\ERA5_1986.nc
Format:
           64bit
Global Attributes:
           Conventions = 'CF-1.6'
           history     = '2021-09-26 13:19:42 GMT by grib_to_netcdf-2.20.0: /opt/ecmwf/mars-client/bin/grib_to_netcdf -S param -o /cache/data2/adaptor.mars.internal-1632662268.3382964-29089-18-9faa5793-b2c4-43f9-af9a-e843247236ea.nc /cache/tmp/9faa5793-b2c4-43f9-af9a-e843247236ea-adaptor.mars.internal-1632660745.7879057-29089-22-tmp.grib'
Dimensions:
           longitude = 5
           latitude  = 5
           time      = 8760
Variables:
    longitude
           Size:       5x1
           Dimensions: longitude
           Datatype:   single
           Attributes:
                       units     = 'degrees_east'
                       long_name = 'longitude'
    latitude 
           Size:       5x1
           Dimensions: latitude
           Datatype:   single
           Attributes:
                       units     = 'degrees_north'
                       long_name = 'latitude'
    time     
           Size:       8760x1
           Dimensions: time
           Datatype:   int32
           Attributes:
                       units     = 'hours since 1900-01-01 00:00:00.0'
                       long_name = 'time'
                       calendar  = 'gregorian'
    u10      
           Size:       5x5x8760
           Dimensions: longitude,latitude,time
           Datatype:   int16
           Attributes:
                       scale_factor  = 0.00058519
                       add_offset    = 2.1673
                       _FillValue    = -32767
                       missing_value = -32767
                       units         = 'm s**-1'
                       long_name     = '10 metre U wind component'
    v10      
           Size:       5x5x8760
           Dimensions: longitude,latitude,time
           Datatype:   int16
           Attributes:
                       scale_factor  = 0.00052455
                       add_offset    = -0.32232
                       _FillValue    = -32767
                       missing_value = -32767
                       units         = 'm s**-1'
                       long_name     = '10 metre V wind component'
    t2m      
           Size:       5x5x8760
           Dimensions: longitude,latitude,time
           Datatype:   int16
           Attributes:
                       scale_factor  = 0.00067111
                       add_offset    = 276.1352
                       _FillValue    = -32767
                       missing_value = -32767
                       units         = 'K'
                       long_name     = '2 metre temperature'
    msl      
           Size:       5x5x8760
           Dimensions: longitude,latitude,time
           Datatype:   int16
           Attributes:
                       scale_factor  = 0.10732
                       add_offset    = 100960.5401
                       _FillValue    = -32767
                       missing_value = -32767
                       units         = 'Pa'
                       long_name     = 'Mean sea level pressure'
                       standard_name = 'air_pressure_at_mean_sea_level'
%}
