LIB_NETCDF= -I../NetCDF/include/ -lnetcdf_c++ -L../NetCDF/lib/ -lnetcdf 
CPP= g++ -O0 -Wall -W 

all: read

read: readParameters.cpp
	$(CPP) readParameters.cpp $(LIB_NETCDF) -o readParameters

read_run:  
	ncgen parameters.cdl -o parameters.nc && ./readParameters

clear:
	rm -f parameters.nc
	sync

clean: clear
	rm -f readParameters
