add_library(InstrumentFunctions MODULE Pass.cpp)
set(CMAKE_CXX_FLAGS "-std=c++11 -Wall -fno-rtti -D__STDC_CONSTANT_MACROS -D__STDC_LIMIT_MACROS -fPIC -I/usr/local/opt/llvm/include")

