# Instrumentation Pass for LLVM

This is a proof of concept implementation of an LLVM Compilation Pass which instruments function calls.
This works by analysing the LLVM bytecode representation of the program to be instrumented and inserting calls to a log function when certain condition are met.
For now the condition is only that the name of the function matches a given name, but the mechanism should be easily extensible to include other conditions like arity or constructs other than function declarations.

To use this pass you have to have installed a rather recent version of LLVM (`3.7` is tested to work) and you have to know where to find the header files.
For MacOS help you can follow this answer on [Stackoverflow](http://stackoverflow.com/questions/28203937/installing-llvm-libraries-along-with-xcode).
Additionally you need a recent version of `cmake`.

Furthermore you have to have [zlog](https://github.com/HardySimpson/zlog) installed.


# Usage

Set up Env:

    PROOT=$(pwd)

## Build Pass

First you have to build the pass itself so that you can use it.
Luckily there are cmake configurations files distributed with thos repo, so use it:

    mkdir $PROOT/build
    cd $PROOT/build/
    cmake ../
    cmake --build .

This will output the executable pass to `build/InstrumentFunctions/libInstrumentFunctions.so`

## Use pass on Buffer example

Now we want to use the generated pass.
An example program is distributed with this code, of course you can also use it with your own code (Should work with all C and C++ code).
Note that the pass expects a `main` function to exist to initialize the logger, if your code doesn't have a `main` method you have to call the initialize method of the logging library manually.

So let's instrument the programm in `example/buffer/buffer.c`:

    cd $PROOT/examples/buffer
    clang -emit-llvm -S buffer.c -o buffer.bc

This will output the LLVM bytecode of `buffer.c`.
Now instrument it, use `-instrument $functionname` for each function to instrument:

    opt -load $PROOT/build/InstrumentFunctions/libInstrumentFunctions.so \
    -instrument_function_calls buffer.bc -instrument process > instrumented_buffer.bc

It remains to link the modified bytecode with its dependencys and generate the executable:

    clang++ instrumented_buffer.bc -o buffer -lzlog -lpthread \
    -L/usr/local/lib -L$PROOT/build/InstrumentFunctions -llogger

To run the programm you have to have a `zlog.conf` file in the folder.
You can use the default config from `InstrumentFunctions/zlog.conf.default`.

Run it:

    ./buffer

Since the buffer is multithreaded the log messages can be out of order.
To order them by their timestamp do:

    sort -k 3 -k 4 -n traces.1 > traces.2

# Benchmark Instrumentation

To benchmark the overhead added by the instrumentation an example is given.

## Benchmark under different optimization levels

Basically to benchmark you have to to the same steps as under Usage, but change the last step (the one with `clang++`) to use the appropriate optimization level.
Build Instrumented/non instrumented code with optimization level as wanted, example:

    clang++ -O0 main.c -o main_O0

Now you can benchmark it (`dumbbench` Perl programm from cpan required), e.g. 50 runs or error below 0.0001:

    dumbbench --table=data/instrumented_O0.dat -p 0.0001 -m 50 -- ./instrumented_main_O0
