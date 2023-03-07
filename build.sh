#! /bin/bash
set -ex

: ${GNAT_LLVM_BRANCH:=master}
: ${GCC_BRANCH:=master} # releases/gcc-12}

export Base=$(dirname $(readlink -f $0))/io

export GNAT_LLVM="${Base}/gnat-llvm"
export PATH="${GNAT_LLVM}/llvm-interface/bin:${PATH}"

mkdir -p ${Base}

test -d ${GNAT_LLVM} \
|| git clone --branch=${GNAT_LLVM_BRANCH} --depth=1 https://github.com/AdaCore/gnat-llvm.git ${GNAT_LLVM}

test -d ${GNAT_LLVM}/llvm-interface/gcc \
|| git clone --branch=${GCC_BRANCH} --depth=1 git://gcc.gnu.org/git/gcc.git ${GNAT_LLVM}/llvm-interface/gcc

test -e ${GNAT_LLVM}/llvm-interface/gnat_src \
|| ln -s ./gcc/gcc/ada ${GNAT_LLVM}/llvm-interface/gnat_src

# make -j`nproc` llvm gnatlib-bc

if [ "x$@" != "x" ]; then
  cd ${GNAT_LLVM}
  make -j`nproc` $@
fi
