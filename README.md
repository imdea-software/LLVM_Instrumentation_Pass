# Instrumentation Pass for C Programms

Set up Env:

    PROOT=$(pwd)

## Build Pass

    mkdir $PROOT/build
    cd $PROOT/build/
    cmake ../
    cmake --build .

Will output executable pass to `build/InstrumentFunctions/libInstrumentFunctions.so`

## Use pass on BufferExample

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
