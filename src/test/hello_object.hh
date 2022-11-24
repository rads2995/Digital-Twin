#ifndef __HELLO_OBJECT_HH__
#define __HELLO_OBJECT_HH__

#include "params/helloObject.hh"
#include "sim/sim_object.hh"

namespace gem5 
{

class HelloObject : public SimObject 
{
    public:
        HelloObject(const HelloObjectParams &p);
};

}  // namespace gem5

#endif // __HELLO_OBJECT_HH__
