# Instrumentation Pass for C Programms

## Build Pass

    cd build/
    cmake ../

Will output executable pass to `build/InstrumentFunctions/libInstrumentFunctions.so`

## Use pass

Instrument programm in `test/buffer.c`:

    clang -emit-llvm -S buffer.c -o buffer.bc

Outputs llvm bytecode of `buffer.c`.
Instrument it:

    opt -load ../build/InstrumentFunctions/libInstrumentFunctions.so -instrument_function_calls buffer.bc > instrumented_buffer.bc

Generate assembly file from instrumented program:

    llc instrumented_buffer.bc

Link it together

    clang++ instrumented_buffer.bc -o instrumented_buffer -lzlog -lpthread -L/usr/local/lib
