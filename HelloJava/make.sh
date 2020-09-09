#!/bin/bash

# bare metal java compiling example, intentionally not using standard naming conventions

mkdir -p build

# compile java code and output to build directory

javac code/*.java -d build

cd build

# directly run java class

java hello.MyEntryPoint

# pack java class into jar file

jar -cfe HelloWorld.jar hello.MyEntryPoint .

# run jar file

java -jar HelloWorld.jar

