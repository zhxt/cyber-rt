cmake_minimum_required(VERSION 3.5)
project(protobuf VERSION "3.3.0")

set(LOCAL_DEPENDS_INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/local_depends/ )
set(CYBER_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/opt/CyberRT/ )
set(THIRDPARTY_LIBS_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/opt/thirdparty/")

set(PROTOBUF_SRC file:///${CMAKE_SOURCE_DIR}/tmp/protobuf-3.3.0.tar.gz )

find_package(protobuf QUIET)

if(NOT protobuf_FOUND)
  option(BUILD_SHARED_LIBS "Create shared libraries by default" ON)

  if(BUILD_SHARED_LIBS)
    list(APPEND extra_cmake_args -DCMAKE_POSITION_INDEPENDENT_CODE=ON)
  endif()

  if(DEFINED CMAKE_BUILD_TYPE)
    list(APPEND extra_cmake_args -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE})
  endif()

  include(ExternalProject)

  externalproject_add(protobuf
  URL ${PROTOBUF_SRC}
  #DOWNLOAD_DIR dl
  TIMEOUT 600
  PREFIX external
  UPDATE_COMMAND ""
  #BUILD_IN_SOURCE true
  #CONFIGURE_COMMAND  ./configure --prefix=/
  BUILD_COMMAND make
  SOURCE_SUBDIR cmake #${SOURCE_DIR}
  INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/local_depends/
  CMAKE_ARGS
  -Dprotobuf_BUILD_SHARED_LIBS=ON
  -Dprotobuf_BUILD_TESTS=OFF
  -Dprotobuf_MODULE_COMPATIBLE=ON
  -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>

  #[==[
  CMAKE_CACHE_ARGS
    -Dprotobuf_BUILD_TESTS:BOOL=OFF
    -Dprotobuf_WITH_ZLIB:BOOL=OFF
    -Dprotobuf_MSVC_STATIC_RUNTIME:BOOL=OFF
    -DCMAKE_INSTALL_PREFIX:PATH=${CMAKE_CURRENT_BINARY_DIR}/protobuf
  #]==]
  INSTALL_COMMAND make install
  )

  #install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/local_depends/
  #DESTINATION ${CMAKE_INSTALL_PREFIX})
else()
	message(STATUS "Found protobuf ${protobuf_VERSION}")
endif()


include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${PROJECT_BINARY_DIR}/protobufConfig-version.cmake"
  COMPATIBILITY AnyNewerVersion)

#install(FILES
    #"${PROJECT_BINARY_DIR}/protobufConfig.cmake"
    #"${PROJECT_BINARY_DIR}/protobufConfig-version.cmake"
    #DESTINATION share/${PROJECT_NAME}/cmake)
