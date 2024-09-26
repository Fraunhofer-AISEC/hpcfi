# README

This project is not maintained. It has been published as part of the following RAID '24 paper:

> Florian Kasten, Philipp Zieris, and Julian Horsch. 2024. Integrating Static Analyses for High-Precision Control-Flow Integrity. In The 27th International Symposium on Research in Attacks, Intrusions and Defenses (RAID 2024), September 30–October 02, 2024, Padua, Italy. ACM, New York, NY, USA, 16 pages. https://doi.org/10.1145/3678890.3678920

Note that these repositories present a prototype implementation and are not to be used in production.

## Introduction

High-Precision Control-Flow Integrity (HPCFI) is a precise control-flow integrity mechanism implemented using LLVM compiler passes. This repository contains the build files necessary to setup the [HPCFI compiler passes](https://github.com/Fraunhofer-AISEC/hpcfi-llvm-project/) and [a modified SVF](https://github.com/Fraunhofer-AISEC/hpcfi-svf/), which can then be used to compile a program with HPCFI.


## Setup

Running `build.sh` will clone and build the [HPCFI compiler passes](https://github.com/Fraunhofer-AISEC/hpcfi-llvm-project/) and [SVF](https://github.com/Fraunhofer-AISEC/hpcfi-svf/). The source code for HPCFI can then be found in `hpcfi-llvm-project/llvm/lib/Transforms/HPCFI`.


## Compiling Programs with HPCFI

To compile programs using HPCFI, use the `clang` compiler inside `hpcfi-llvm-project/build/bin/clang`.
During compilation, MLTA metadata must be added to the compiled object files using the MLTA compiler pass. Additionally, all files must be compiled to LLVM IR. For instance, to compile a file main.c, use:
```sh
hpcfi-llvm-project/build/bin/clang -g -c -O1 -flto -flegacy-pass-manager -Xclang -load -Xclang hpcfi-llvm-project/build/lib/LLVMMLTA.so main.c -o main.o
```
During linking, load the SVF library and decide whether to instrument using JMP checks (`LLVMHPCFIJmp.so`) or CMP checks (`LLVMHPCFICmp.so`) and load the corresponding compiler pass, e.g.:
```sh
hpcfi-llvm-project/build/bin/clang -g -O1 -flto -flegacy-pass-manager -fuse-ld=lld -Wl,-plugin-opt=-load=hpcfi-svf/Release-build/lib/LLVMSvf.so,-plugin-opt=-load=hpcfi-llvm-project/build/lib/LLVMHPCFICmp.so main.o -o main
```
To compile an example program using HPCFI, see `./example`.
