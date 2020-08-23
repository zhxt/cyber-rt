###  CyberRT Lite

Build [Apollo CyberRT](https://github.com/ApolloAuto/apollo.git ) with CMake

How to build

1. prepare dependencies

```
cd cyber-rt
wget http://apolloauto.club/mirror/cyberdeps.tgz
tar zxvf cyberdeps.tgz

ls tmp/
FastRTPS_1.5.0.patch  Fast-RTPS-1.5.0.tar.gz  gflags-2.2.0.tar.gz  glog-0.3.5.tar.gz  protobuf-3.3.0.tar.gz
```

2. build dependencies

```
mkdir build
cd build
cmake ..
make
```

3. build cyber-rt lite

```
cmake ..
scripts/genprotosrc.sh 
make

```

4. run examples

```
cyber-rt/build$ cyber/examples/cyber_example_talker
cyber-rt/build$ cyber/examples/cyber_example_listener
```

Note:

This is a Pre-Alpha version , not fully tested, functions may not work well, All contributes are welcome!


TODO:

1. make a cmake Macro or Funtion to generate proto source

