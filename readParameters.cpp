#include <iostream>
#include <string>
#include <netcdfcpp.h>

#define cimg_debug 12

#include "struct_parameter_NetCDF.h"

using namespace std;


int main()
{
  ///file name
  string fi="parameters.nc";//=cimg_option("-p","parameters.nc","comment");
  ///parameters
  int k,m;float alpha;

  ///parameter class
  CParameterNetCDF fp;
  //open file
  int error=fp.loadFile((char *)fi.c_str());
  if(error){std::cerr<<"loadFile return "<< error <<std::endl;return error;}

  float process; string process_name="trapezoid";
  //load process variable
  error=fp.loadVar(process,&process_name);
  if(error){cerr<<"loadVar return "<< error <<endl;return error;}
std::cout<<process_name<<"="<<process<<std::endl;
  ///k
  string attribute_name="k";
  if (error = fp.loadAttribute(attribute_name,k)!=0){
    std::cerr<< "Error while loading "<<process_name<<":"<<attribute_name<<" attribute"<<std::endl;
    return error;
  }
std::cout<<attribute_name<<"="<<k<<std::endl;

  ///m
  attribute_name="m";
  if (error = fp.loadAttribute(attribute_name,m)!=0){
    std::cerr<< "Error while loading "<<process_name<<":"<<attribute_name<<" attribute"<<std::endl;
    return error;
  }
std::cout<<attribute_name<<"="<<m<<std::endl;

  ///alpha
  attribute_name="alpha";
  if (error = fp.loadAttribute(attribute_name,alpha)!=0){
    std::cerr<< "Error while loading "<<process_name<<":"<<attribute_name<<" attribute"<<std::endl;
    return error;
  }
std::cout<<attribute_name<<"="<<alpha<<std::endl;

  return 0;
}

