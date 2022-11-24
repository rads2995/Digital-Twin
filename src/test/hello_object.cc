# include "test/hello_object.hh"

#include <iostream>

namespace gem5
{

HelloObject::HelloObject(const HelloObjectParams &params) : SimObject(params)
{
    std::cout << "Hello world, from a SimObject in gem5!" << std::endl;
}

}  //namspace gem5
