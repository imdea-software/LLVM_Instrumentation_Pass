#include <set>
#include <string>
#include "llvm/Pass.h"
#include "llvm/IR/Constants.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Instruction.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"

using namespace llvm;

namespace {
    struct InstrumentFunctions : public ModulePass {
        // name of instrumentation functions
        const char *LOG_FUNCTION_STR = "log_function_call";
        const char *LOG_VARIABLE_STR = "log_variable_change";
        const char *LOG_INIT_STR= "init";
        const char *LOG_TEST_STR= "log_test";

        static char ID;

        std::set<std::string> funcsToInst;

        InstrumentFunctions() : ModulePass(ID) {
            funcsToInst.insert("process");
        }

        bool runOnModule(Module &M) override {
            declare_log_functions(M);
            for (Module::iterator mi = M.begin(); mi != M.end(); ++mi) {
                Function &f = *mi;
                instrumentFunction(M, f);
            }
            return true;
        }

        void instrumentFunction(Module &M, Function &f) {
            // Check if function declaration matches a function in funcsToInst.
            LLVMContext &C = M.getContext();
            std::string fname = f.getName();
            /* errs().write_escaped(fname) << "\n"; */
            if (funcsToInst.count(fname) != 0) {
                BasicBlock &entry_block = f.getEntryBlock();

                Function *log_function = M.getFunction(LOG_TEST_STR);
                assert(log_function && "load pre function declaration not found");

                CallInst* call_inst = CallInst::Create(log_function, "", entry_block.getFirstNonPHI());
            }
        }



        void declare_log_functions(Module &m) {
            LLVMContext &C = m.getContext();
            // void type
            Type *voidTy = Type::getVoidTy(C);

            // 64 bit integer
            Type *IntTy64 = Type::getInt64Ty(C);

            Type *StringType = Type::getInt8PtrTy(C);

            bool isVarArg = false;

            std::vector<Type*> variable_change_params;
            variable_change_params.push_back(StringType);
            variable_change_params.push_back(IntTy64);
            FunctionType *variable_change_type = FunctionType::get(voidTy, variable_change_params, isVarArg);

            std::vector<Type*> function_call_params;
            function_call_params.push_back(StringType);
            FunctionType *function_call_type = FunctionType::get(voidTy, function_call_params, isVarArg);

            FunctionType *init_type = FunctionType::get(IntTy64, isVarArg);
            FunctionType *log_test_type = FunctionType::get(voidTy, isVarArg);
            //
            // insert functions to module
            m.getOrInsertFunction(LOG_FUNCTION_STR, function_call_type);
            m.getOrInsertFunction(LOG_VARIABLE_STR, variable_change_type);
            m.getOrInsertFunction(LOG_INIT_STR, init_type);
            m.getOrInsertFunction(LOG_TEST_STR, log_test_type);
        }
    }; // end of struct
}  // end of anonymous namespace

char InstrumentFunctions::ID = 0;

static RegisterPass<InstrumentFunctions> X("instrument_function_calls",
        "Instrument Function Calls Pass",
        false /* Modifies CFG */,
        false /* Non Analysis Pass */);
