find_library(FastRTPS_LIBRARY NAMES "fastrtps")
find_path(FastRTPS_INCLUDE_DIR NAMES "fastrtps/Domain.h" DOC "The FastRTPS Include path")
message(STATUS "FASTRTPS lib: ${FastRTPS_LIBRARY} ${FastRTPS_INCLUDE_DIR} ")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FastRTPS DEFAULT_MSG FastRTPS_INCLUDE_DIR FastRTPS_LIBRARY)

mark_as_advanced(FastRTPS_INCLUDE_DIR FastRTPS_LIBRARY)

if(FastRTPS_FOUND)
    add_library(FastRTPS::fastrtps INTERFACE IMPORTED)
    target_link_libraries(FastRTPS::fastrtps INTERFACE ${FastRTPS_LIBRARY})
    target_include_directories(FastRTPS::fastrtps INTERFACE ${FastRTPS_INCLUDE_DIR})
endif()
