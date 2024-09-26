#!/usr/bin/env bash

set -e

git clone git@github.com:Fraunhofer-AISEC/hpcfi-svf.git
git clone git@github.com:Fraunhofer-AISEC/hpcfi-llvm-project.git


MY_PATH="$(cd "$(dirname "$0")" ; pwd -P)"
SVF_SRC_DIR=$MY_PATH/hpcfi-svf
LLVM_BUILD_DIR=$MY_PATH/hpcfi-llvm-project/build
LLVM_SRC_DIR=$MY_PATH/hpcfi-llvm-project/llvm


# build llvm without hpcfi
mkdir $LLVM_BUILD_DIR
cd $LLVM_BUILD_DIR
LLVM_CMAKE_OPTIONS="\
  -DCMAKE_BUILD_TYPE=Release \
  -DLLVM_ENABLE_PROJECTS=clang;lld"
cmake -G Ninja $LLVM_SRC_DIR $LLVM_CMAKE_OPTIONS
ninja


# build svf
export LLVM_DIR=$LLVM_BUILD_DIR
export PATH=$LLVM_BUILD_DIR/bin:$PATH
export Z3_DIR=$SVF_SRC_DIR/z3.obj
cd $SVF_SRC_DIR && ./build.sh


# build hpcfi pass
cd $LLVM_BUILD_DIR
LLVM_CMAKE_OPTIONS+=" -DBUILD_HPCFI=ON"
cmake -G Ninja $LLVM_SRC_DIR $LLVM_CMAKE_OPTIONS
ninja