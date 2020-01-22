LIB_NETCDF= -I../NetCDF/include/ -lnetcdf_c++ -L../NetCDF/lib/ -lnetcdf 
CPP= g++ -O0 -Wall -W 

all: read

read: readParameters.cpp
	$(CPP) readParameters.cpp $(LIB_NETCDF) -o readParameters

ncgen: parameters.cdl
	ncgen parameters.cdl -o parameters.nc && ncdump parameters.nc | grep -e ' ' -e 'k =' -e 'm =' -e 'alpha =' --color

read_run: ncgen
	./readParameters

clear:
	rm -f parameters.nc
	sync

clean: clear
	rm -f readParameters

