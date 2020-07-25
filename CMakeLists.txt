cmake_minimum_required(VERSION 3.5)

set(CMAKE_ASM_CREATE_SHARED_LIBRARY "ld <CMAKE_SHARED_LIBRARY_CREATE_ASM_FLAGS>
<CMAKE_SHARED_LIBRARY_SONAME_ASM_FLAG><TARGET_SONAME> <LINK_FLAGS> -o <TARGET> <OBJECTS> <LINK_LIBRARIES>")

set(CMAKE_CXX_STANDARD 11)
option(BUILD_SHARED_LIBS "build as shared library" ON)

set(CYBER_ROOT ${PROJECT_SOURCE_DIR})
set(CYBER_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/opt/CyberRT/)
set(CYBER_INSTALL_BIN_DIR ${CMAKE_INSTALL_PREFIX}/opt/CyberRT/bin)
set(CYBER_INSTALL_LIB_DIR ${CMAKE_INSTALL_PREFIX}/opt/CyberRT/lib)
set(CYBER_INSTALL_INCLUDE_DIR ${CMAKE_INSTALL_PREFIX}/opt/CyberRT/include)
set(LOCAL_DEPENDS_INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/local_depends )


set(CMAKE_PREFIX_PATH ${CMAKE_CURRENT_BINARY_DIR}/local_depends)

if (${CMAKE_VERSION} VERSION_LESS "3.15.0")
  set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake "${CMAKE_MODULE_PATH}")
else (${CMAKE_VERSION} VERSION_LESS "3.15.0")
  list(PREPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
endif()

message(STATUS "CMake Prefix Path: ${CMAKE_PREFIX_PATH}")
message(STATUS "CMake Module Path: ${CMAKE_MODULE_PATH}")

include(cmake/external/glog-0.3.5.cmake)
include(cmake/external/gflags-2.2.0.cmake)
include(cmake/external/Fast-RTSP-1.5.0.cmake)
include(cmake/external/protobuf-3.3.0.cmake)

project(Cyber VERSION 1.0.0 LANGUAGES C CXX ASM)

if (EXISTS "${CMAKE_CURRENT_BINARY_DIR}/local_depends/lib")

  message(STATUS "Build cyber")
  find_package(FastRTPS 1.5.0 REQUIRED)
  find_package(Glog REQUIRED)
  find_package(Gflags REQUIRED)
  find_package(Protobuf REQUIRED)

  include_directories(
    PUBLIC
    ${PROJECT_SOURCE_DIR}/
    ${CMAKE_CURRENT_BINARY_DIR}/local_depends/include/
  )

add_subdirectory(cyber/base)
add_subdirectory(cyber/blocker)
add_subdirectory(cyber/class_loader)
add_subdirectory(cyber/common)
add_subdirectory(cyber/component)
add_subdirectory(cyber/croutine)
add_subdirectory(cyber/event)
add_subdirectory(cyber/io)
add_subdirectory(cyber/logger)
add_subdirectory(cyber/message)
add_subdirectory(cyber/node)
add_subdirectory(cyber/parameter)
add_subdirectory(cyber/record)
add_subdirectory(cyber/proto)
add_subdirectory(cyber/scheduler)
add_subdirectory(cyber/sysmo)
add_subdirectory(cyber/service_discovery)
add_subdirectory(cyber/task)
add_subdirectory(cyber/time)
add_subdirectory(cyber/timer)
add_subdirectory(cyber/transport)
add_subdirectory(cyber)
add_subdirectory(cyber/py_wrapper)

add_subdirectory(cyber/mainboard)
add_subdirectory(cyber/examples)
add_subdirectory(cyber/tools/cyber_monitor)
add_subdirectory(cyber/tools/cyber_channel)

endif()

configure_file(CyberConfig.cmake.in
    "${PROJECT_BINARY_DIR}/CyberConfig.cmake" @ONLY)

include(CMakePackageConfigHelpers)
write_basic_package_version_file(
    "${PROJECT_BINARY_DIR}/CyberConfig-version.cmake"
  COMPATIBILITY AnyNewerVersion)

install(FILES
    "${PROJECT_BINARY_DIR}/CyberConfig.cmake"
    "${PROJECT_BINARY_DIR}/CyberConfig-version.cmake"
  DESTINATION share/${PROJECT_NAME}/cmake)
