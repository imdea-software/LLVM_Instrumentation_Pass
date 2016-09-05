cmake_minimum_required(VERSION 3.4.3)

set(LLVM_ROOT "/usr/local/opt/llvm" CACHE PATH "Root of LLVM install.")
list(APPEND CMAKE_PREFIX_PATH "${LLVM_ROOT}/share/llvm/cmake")

find_package(LLVM REQUIRED CONFIG)

list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(HandleLLVMOptions) # load additional config
include(AddLLVM) # used to add our own modules

add_definitions(${LLVM_DEFINITIONS})
include_directories(${LLVM_INCLUDE_DIRS})

add_subdirectory(InstrumentFunctions)