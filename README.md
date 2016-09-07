# Instrumentation Pass for C Programms

You have to have [zlog](https://github.com/HardySimpson/zlog) installed.

Set up Env:

    PROOT=$(pwd)

## Build Pass

    mkdir $PROOT/build
    cd $PROOT/build/
    cmake ../
    cmake --build .

Will output executable pass to `build/InstrumentFunctions/libInstrumentFunctions.so`

## Use pass on Buffer example

Instrument programm in `/buffer.c`:

    cd $PROOT/examples/buffer
    clang -emit-llvm -S buffer.c -o buffer.bc

Outputs llvm bytecode of `buffer.c`.
Instrument it, use `-instrument functionname` for each function to instrument:

    opt -load $PROOT/build/InstrumentFunctions/libInstrumentFunctions.so \
    -instrument_function_calls buffer.bc -instrument process > instrumented_buffer.bc

Link it together

    clang++ instrumented_buffer.bc -o buffer -lzlog -lpthread \
    -L/usr/local/lib -L$PROOT/build/InstrumentFunctions -llogger

To run the programm you have to have a `zlog.conf` file in the folder.
You can use the default conf from `InstrumentFunctions/zlog.conf.default`.

Run it:

    ./buffer

Order Log by timestamp:

    sort -k 3 -k 4 -n traces.1 > traces.2

## Benchmark Instrumentation

Build Instrumented/non instrumented code with optimization level as wanted, example:

    clang++ -O0 main.c -o main_O0

Benchmark it (`dumbbench` from cpan required), e.g. 50 runs or error below 0.0001:

    dumbbench --table=data/instrumented_O0.dat -p 0.0001 -m 50 -- ./instrumented_main_O0
