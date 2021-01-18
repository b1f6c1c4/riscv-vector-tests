all:

DIR?=../../llvm/release-build/bin
PREFIX?=$(HOME)/x-tools/riscv64-unknown-linux-gnu/bin/riscv64-unknown-linux-gnu
CPPFLAGS=-std=c++20 -ffast-math -O2
CPPFLAGS+=-fpermissive -Wno-pointer-arith -Wno-narrowing -Wno-write-strings
LDFLAGS=-mabi=lp64d -static
TESTS=$(wildcard src/*/)

all: $(patsubst src/%/,build/%,$(TESTS))

build/%.o: src/%/test.S
	@mkdir -p build/
	$(DIR)/clang \
		--target=riscv64-unknown-linux-gnu \
		-menable-experimental-extensions \
		-mcpu=cva6-v \
		-c $^ -o $@

build/%: src/%/main.cpp build/%.o src/%/data.h
	$(PREFIX)-g++ $(CPPFLAGS) $(LDFLAGS) \
		$^ -o $@

.SECONDARY:
