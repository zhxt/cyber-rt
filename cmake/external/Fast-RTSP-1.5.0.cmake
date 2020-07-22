cmake_minimum_required(VERSION 3.5)
project(fastrtps VERSION "1.5.0")

set(LOCAL_DEPENDS_INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/local_depends/ )
set(CYBER_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/opt/CyberRT/ )
set(THIRDPARTY_LIBS_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/opt/thirdparty/")


set(FASTRTPS_SRC file:///${CMAKE_SOURCE_DIR}/tmp/Fast-RTPS-1.5.0.tar.gz )

####
#find_package(fastrtps QUIET)

#if(NOT fastrtps_FOUND)
  message(STATUS "fastrtps not found")
  option(BUILD_SHARED_LIBS "Create shared libraries by default" ON)

  if(BUILD_SHARED_LIBS)
    # Library will be statically created with PIC code
    list(APPEND extra_cmake_args -DCMAKE_POSITION_INDEPENDENT_CODE=ON)
  endif()

  if(DEFINED CMAKE_BUILD_TYPE)
    list(APPEND extra_cmake_args -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE})
  endif()

  include(ExternalProject)

  set(PATCH_COMMAND_STR PATCH_COMMAND patch -p1 < ${CMAKE_SOURCE_DIR}/tmp/FastRTPS_1.5.0.patch)

  externalproject_add(fastrtps
      #GIT_REPOSITORY https://github.com/eProsima/Fast-RTPS.git
      #GIT_TAG origin/release/1.5.0
  URL ${FASTRTPS_SRC}
  #DOWNLOAD_DIR dl
  PREFIX external
  TIMEOUT 600
  UPDATE_COMMAND ""
  CMAKE_ARGS
    -DEPROSIMA_BUILD=OFF
    -DEPROSIMA_BUILD_TESTS=OFF
    -DPERFORMANCE_TESTS=OFF
    -DBUILD_DOCUMENTATION=OFF
    -DCOMPILE_EXAMPLES=OFF
    -DBUILD_TESTING=OFF
    -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/local_depends/
    ${extra_cmake_args}
    -Wno-dev
    ${PATCH_COMMAND_STR}
  )

  install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/local_depends/
  DESTINATION ${CMAKE_INSTALL_PREFIX})
#else()
  #message(STATUS "Found fastrtps ${fastrtps_VERSION}")
#endif()


include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    "${PROJECT_BINARY_DIR}/fastrtpsConfig-version.cmake"
  COMPATIBILITY AnyNewerVersion)

#install(FILES
#  "${PROJECT_BINARY_DIR}/fastrtpsConfig.cmake"
#  "${PROJECT_BINARY_DIR}/fastrtpsConfig-version.cmake"
#  DESTINATION share/${PROJECT_NAME}/cmake)

ExternalProject_Get_Property(fastrtps install_dir)
message(STATUS "${fastrtps_VERSION} ${install_dir} ")

