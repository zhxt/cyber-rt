cmake_minimum_required(VERSION 3.5)
project(CyberPyWrapper)

find_package(PythonLibs REQUIRED)

add_library(cyber_py_wrapper py_cyber.cc
    py_parameter.cc
    py_record.cc
    py_time.cc
    py_timer.cc
    )
target_include_directories(cyber_py_wrapper PUBLIC  ${PYTHON_INCLUDE_DIRS})
target_link_libraries(cyber_py_wrapper ${PYTHON_LIBRARIES})

add_library(Cyber::py_wrapper ALIAS cyber_py_wrapper)

add_library(py_wrapper 
    py_cyber.cc
    )
target_include_directories(py_wrapper PUBLIC  ${PYTHON_INCLUDE_DIRS})
target_link_libraries(py_wrapper ${PYTHON_LIBRARIES})

add_library(py_record
    py_record.cc
    )
target_include_directories(py_record PUBLIC  ${PYTHON_INCLUDE_DIRS})
target_link_libraries(py_record ${PYTHON_LIBRARIES})

add_library(py_timer
    py_timer.cc
    )
target_include_directories(py_timer PUBLIC  ${PYTHON_INCLUDE_DIRS})
target_link_libraries(py_timer ${PYTHON_LIBRARIES})

add_library(py_time
    py_time.cc
    )
target_include_directories(py_time PUBLIC  ${PYTHON_INCLUDE_DIRS})
target_link_libraries(py_time ${PYTHON_LIBRARIES})

file(GLOB HEADERS *.h)

install(FILES ${HEADERS}
    DESTINATION ${CYBER_INSTALL_INCLUDE_DIR}/cyber/py_wrapper/
    )

install(TARGETS
    DESTINATION  ${CYBER_INSTALL_LIB_DIR}
    )
