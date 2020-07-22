find_library(Protobuf_LIBRARY NAMES "protobuf")
find_path(Protobuf_INCLUDE_DIR NAMES "google/protobuf/stubs/common.h" DOC "The Protobuf Include path")
message(STATUS ${Protobuf_LIBRARY} ${Protobuf_INCLUDE_DIR})

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Protobuf DEFAULT_MSG Protobuf_INCLUDE_DIR Protobuf_LIBRARY)

mark_as_advanced(Protobuf_INCLUDE_DIR Protobuf_LIBRARY)

if(Protobuf_FOUND)
    add_library(Protobuf::libprotobuf INTERFACE IMPORTED)
    target_link_libraries(Protobuf::libprotobuf INTERFACE ${Protobuf_LIBRARY})
    target_include_directories(Protobuf::libprotobuf INTERFACE ${Protobuf_INCLUDE_DIR})
endif()
