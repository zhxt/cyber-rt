#!/bin/bash

export LD_LIBRARY_PATH=build/local_depends/lib/

#c++ protobuf
for i in `ls cyber/proto/*.proto`
do
build/local_depends/bin/protoc -I. -Icyber/proto --cpp_out=.  $i
done

for i in `ls cyber/examples/proto/*.proto`
do
build/local_depends/bin/protoc -I. -Icyber/proto --cpp_out=.  $i
done

#python protobuf
for i in `ls cyber/proto/*.proto`
do
build/local_depends/bin/protoc -I. -Icyber/proto --python_out=.  $i
done

for i in `ls cyber/examples/proto/*.proto`
do
build/local_depends/bin/protoc -I. -Icyber/proto --python_out=.  $i
done

if [ ! -d "./py_proto" ]; then
  echo "py_proto directory does not exist, then create it"
  mkdir -p py_proto/cyber/proto
  mkdir -p py_proto/cyber/example/proto
  touch py_proto/cyber/__init__.py
  touch py_proto/cyber/proto/__init__.py
  touch py_proto/cyber/example/__init__.py
  touch py_proto/cyber/example/proto/__init__.py
  mkdir log
else
  echo "py_proto directory  exist, delete and create it"
  rm -rf py_proto
  mkdir -p py_proto/cyber/proto
  mkdir -p py_proto/cyber/example/proto
  touch py_proto/cyber/__init__.py
  touch py_proto/cyber/proto/__init__.py
  touch py_proto/cyber/example/__init__.py
  touch py_proto/cyber/example/proto/__init__.py
  mkdir log
fi

#move protobuf file to destination path
mv `find ./cyber/proto -name "*pb2.py"` ./py_proto/cyber/proto
mv `find ./cyber/examples/proto -name "*pb2.py"` ./py_proto/cyber/example/proto
