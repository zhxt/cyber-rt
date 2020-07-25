#!/bin/bash

export LD_LIBRARY_PATH=build/local_depends/lib/

for i in `ls cyber/proto/*.proto`
do
build/local_depends/bin/protoc -I. -Icyber/proto --cpp_out=.  $i
done

for i in `ls cyber/examples/proto/*.proto`
do
build/local_depends/bin/protoc -I. -Icyber/proto --cpp_out=.  $i
done
