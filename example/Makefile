LLVM=../hpcfi-llvm-project/build
CLANG=${LLVM}/bin/clang
LIBS=${LLVM}/lib
MLTALIB=${LIBS}/LLVMMLTA.so
HPCFICMPLIB=${LIBS}/LLVMHPCFICmp.so
HPCFIJMPLIB=${LIBS}/LLVMHPCFIJmp.so
SVFLIB=../hpcfi-svf/Release-build/lib/LLVMSvf.so

all:
	$(CLANG) -g -c -O1 -flto -flegacy-pass-manager -Xclang -load -Xclang ${MLTALIB} main.c -o main.o
	$(CLANG) -g -O1 -flto -flegacy-pass-manager -fuse-ld=lld -Wl,-plugin-opt=-load=${SVFLIB},-plugin-opt=-load=${HPCFICMPLIB} main.o -o main
