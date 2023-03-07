.PHONY: all image build run sh clean
PROJECT = llvmada
UID   := $(shell id -u)
GID   := $(shell id -g)
GNAT_LLVM_BRANCH = master
# GCC_BRANCH = master

# GNAT_LLVM_BRANCH = master
GCC_BRANCH = releases/gcc-12


COMPOSER = UID=$(UID) GID=$(GID) GNAT_LLVM_BRANCH=$(GNAT_LLVM_BRANCH) GCC_BRANCH=$(GCC_BRANCH) docker compose -p $(PROJECT)

all: image build

image:
	$(COMPOSER) build llvmada

build: io
	$(COMPOSER) run llvmada /build.sh all

run: io
	$(COMPOSER) run llvmada /build.sh all

sh: io
	$(COMPOSER) run llvmada /bin/bash --login

io:
	mkdir -p io

