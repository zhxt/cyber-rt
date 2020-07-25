find_library(Glog_LIBRARY NAMES "glog")
find_path(Glog_INCLUDE_DIR NAMES "glog/config.h" DOC "The Glog Include path")
message(STATUS "Glog lib: ${Glog_LIBRARY} ${Glog_INCLUDE_DIR} ")

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Glog DEFAULT_MSG Glog_INCLUDE_DIR Glog_LIBRARY)

mark_as_advanced(Glog_INCLUDE_DIR Glog_LIBRARY)

if(Glog_FOUND)
    add_library(Glog::glog INTERFACE IMPORTED)
    target_link_libraries(Glog::glog INTERFACE ${Glog_LIBRARY})
    target_include_directories(Glog::glog INTERFACE ${Glog_INCLUDE_DIR})
endif()
