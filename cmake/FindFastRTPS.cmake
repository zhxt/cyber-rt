find_library(FastRTPS_LIBRARY NAMES "fastrtps"
    PATHS "${LOCAL_DEPENDS_INSTALL_DIR}/lib"
    NO_DEFAULT_PATH
    )
find_path(FastRTPS_INCLUDE_DIR NAMES "fastrtps/Domain.h"
    PATHS "${LOCAL_DEPENDS_INSTALL_DIR}/include"
    NO_DEFAULT_PATH
    DOC "The FastRTPS Include path")
message(STATUS "FastRTPS inc: ${FastRTPS_INCLUDE_DIR} lib: ${FastRTPS_LIBRARY} ")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FastRTPS DEFAULT_MSG FastRTPS_INCLUDE_DIR FastRTPS_LIBRARY)

mark_as_advanced(FastRTPS_INCLUDE_DIR FastRTPS_LIBRARY)

if(FastRTPS_FOUND)
    if(NOT TARGET FastRTPS::fastrtps)
        add_library(FastRTPS::fastrtps INTERFACE IMPORTED)
        target_link_libraries(FastRTPS::fastrtps INTERFACE ${FastRTPS_LIBRARY})
        target_include_directories(FastRTPS::fastrtps INTERFACE ${FastRTPS_INCLUDE_DIR})
    endif()
endif()
