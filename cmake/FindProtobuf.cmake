find_library(Protobuf_LIBRARY NAMES "protobuf"
    PATHS "${LOCAL_DEPENDS_INSTALL_DIR}/lib"
    NO_DEFAULT_PATH
    )
find_path(Protobuf_INCLUDE_DIR NAMES "google/protobuf/stubs/common.h"
    PATHS "${LOCAL_DEPENDS_INSTALL_DIR}/include"
    NO_DEFAULT_PATH
    DOC "The Protobuf Include path")

message(STATUS "Protobuf inc: ${Protobuf_INCLUDE_DIR} lib : ${Protobuf_LIBRARY}")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Protobuf DEFAULT_MSG Protobuf_INCLUDE_DIR Protobuf_LIBRARY)

mark_as_advanced(Protobuf_INCLUDE_DIR Protobuf_LIBRARY)

if(Protobuf_FOUND)
    if (NOT TARGET Protobuf::libprotobuf)
        add_library(Protobuf::libprotobuf INTERFACE IMPORTED)
        target_link_libraries(Protobuf::libprotobuf INTERFACE ${Protobuf_LIBRARY})
        target_include_directories(Protobuf::libprotobuf INTERFACE ${Protobuf_INCLUDE_DIR})
    endif()
endif()
