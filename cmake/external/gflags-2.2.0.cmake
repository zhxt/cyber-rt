cmake_minimum_required(VERSION 3.5)
project(Gflags VERSION "2.2.0")

set(LOCAL_DEPENDS_INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/local_depends/ )
set(CYBER_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/opt/CyberRT/ )
set(THIRDPARTY_LIBS_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/opt/thirdparty/")

set(GFLAGS_SRC file://${CMAKE_SOURCE_DIR}/tmp/gflags-2.2.0.tar.gz )

find_package(Gflags QUIET)

if(NOT Gflags_FOUND)
  message(STATUS "Gflags not found, going to build it")
  option(BUILD_SHARED_LIBS "Create shared libraries by default" ON)

  if(BUILD_SHARED_LIBS)
    list(APPEND extra_cmake_args -DCMAKE_POSITION_INDEPENDENT_CODE=ON)
  endif()

  if(DEFINED CMAKE_BUILD_TYPE)
    list(APPEND extra_cmake_args -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE})
  endif()

  include(ExternalProject)

  externalproject_add(gflags
  URL ${GFLAGS_SRC}
  #DOWNLOAD_DIR dl
  TIMEOUT 600
  PREFIX external
  UPDATE_COMMAND ""
  CMAKE_ARGS
    -DBUILD_SHARED_LIBS=ON
    -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/local_depends/
    ${extra_cmake_args}
    -Wno-dev
  )

  install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/local_depends/
  DESTINATION ${CMAKE_INSTALL_PREFIX})
else()
    message(STATUS "Found Gflags ver: ${Gflags_VERSION}")
endif()

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${PROJECT_BINARY_DIR}/GflagsConfig-version.cmake"
  COMPATIBILITY AnyNewerVersion)

install(FILES
    #"${PROJECT_BINARY_DIR}/GflagsConfig.cmake"
  "${PROJECT_BINARY_DIR}/GflagsConfig-version.cmake"
  DESTINATION share/${PROJECT_NAME}/cmake)
