#include "llvm/Pass.h"
#include "llvm/IR/Function.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
    struct InstrumentFunctions : public FunctionPass {

        static char ID;
        InstrumentFunctions() : FunctionPass(ID) {}

        bool runOnFunction(Function &F) override {
            errs() << "Hello: ";
            errs().write_escaped(F.getName()) << "\n";
            return false;
        }
    }; // end of struct
}  // end of anonymous namespace

char InstrumentFunctions::ID = 0;

static RegisterPass<InstrumentFunctions> X("instrument_function_calls",
        "Instrument Function Calls Pass",
        true /* Only looks at CFG */,
        true /* Analysis Pass */);
