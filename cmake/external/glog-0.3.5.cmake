cmake_minimum_required(VERSION 3.5)
project(glog VERSION "0.3.5")

find_package(glog QUIET)

set(GLOG_SRC file:///${CMAKE_SOURCE_DIR}/tmp/glog-0.3.5.tar.gz )

#if(NOT glog_FOUND)
#  message(STATUS "glog not found")
  option(BUILD_SHARED_LIBS "Create shared libraries by default" ON)

  if(BUILD_SHARED_LIBS)
    list(APPEND extra_cmake_args -DCMAKE_POSITION_INDEPENDENT_CODE=ON)
  endif()

  if(DEFINED CMAKE_BUILD_TYPE)
    list(APPEND extra_cmake_args -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE})
  endif()

  include(ExternalProject)

  externalproject_add(glog
  URL ${GLOG_SRC}
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
#else()
#	message(STATUS "Found glog ${glog_VERSION} ${glog_INCLUDE_DIR}" )
#endif()

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
  "${PROJECT_BINARY_DIR}/glogConfig-version.cmake"
  COMPATIBILITY AnyNewerVersion)

install(FILES
    #"${PROJECT_BINARY_DIR}/glogConfig.cmake"
  "${PROJECT_BINARY_DIR}/glogConfig-version.cmake"
  DESTINATION share/${PROJECT_NAME}/cmake)
