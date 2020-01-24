LIB_NETCDF= -I../NetCDF/include/ -lnetcdf_c++ -L../NetCDF/lib/ -lnetcdf 
CPP= g++ -O0 -Wall -W 

all: read version

read: readParameters.cpp
	$(CPP) readParameters.cpp $(LIB_NETCDF) -o readParameters && ./readParameters --help

version:
	./readParameters --version > VERSIONS
	grep CDL_PARAMETER_VERSION     struct_parameter_NetCDF.h >> VERSIONS
	grep NETCDF_TYPE_INFO_VERSION  NetCDFinfo.h              >> VERSIONS
	sed -i 's/#define //' VERSIONS
	cat VERSIONS

ncgen: parameters.cdl
	ncgen parameters.cdl -o parameters.nc && ncdump parameters.nc | grep -e ' ' -e 'k =' -e 'm =' -e 'alpha =' --color

read_run: ncgen
	./readParameters -p parameters.nc

clear:
	rm -f parameters.nc
	sync

clean: clear
	rm -f readParameters

