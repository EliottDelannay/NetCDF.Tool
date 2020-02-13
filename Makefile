LIB_NETCDF= -I/usr/include/ -lnetcdf_c++ -L/usr/lib/aarch64-linux-gnu/ -lnetcdf
CPP= g++ -O0 -Wall -W

all: read version

read: readParameters.cpp
	$(CPP) readParameters.cpp $(LIB_NETCDF) -o readParameters && ./readParameters --help

version:
	./readParameters --version > VERSIONS
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

