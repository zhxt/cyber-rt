find_library(Gflags_LIBRARY NAMES "gflags"
    PATHS "${LOCAL_DEPENDS_INSTALL_DIR}/lib"
    NO_DEFAULT_PATH
    )
find_path(Gflags_INCLUDE_DIR NAMES "gflags/gflags.h"
    PATHS "${LOCAL_DEPENDS_INSTALL_DIR}/include"
    NO_DEFAULT_PATH
    DOC "The Gflags Include path")
message(STATUS "Gflags inc: ${Gflags_INCLUDE_DIR} lib: ${Gflags_LIBRARY}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Gflags DEFAULT_MSG Gflags_INCLUDE_DIR Gflags_LIBRARY)

mark_as_advanced(Gflags_INCLUDE_DIR Gflags_LIBRARY)

if(Gflags_FOUND)
    if(NOT TARGET Gflags::gflags)
        add_library(Gflags::gflags INTERFACE IMPORTED)
        target_link_libraries(Gflags::gflags INTERFACE ${Gflags_LIBRARY})
        target_include_directories(Gflags::gflags INTERFACE ${Gflags_INCLUDE_DIR})
    endif()
endif()
