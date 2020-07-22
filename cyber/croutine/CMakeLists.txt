cmake_minimum_required(VERSION 3.5)

project(CyberCroutine)

add_compile_options(-mcx16)
add_library(cyber_routine_context detail/routine_context.cc detail/swap_x86_64.S)

add_library(cyber_croutine croutine.cc)
target_link_libraries(cyber_croutine
    Cyber::event
    Cyber::routine_context)

add_library(Cyber::croutine ALIAS cyber_croutine)
add_library(Cyber::routine_context ALIAS cyber_routine_context)

file(GLOB HEADERS *.h)

install(FILES ${HEADERS}
    DESTINATION ${CYBER_INSTALL_INCLUDE_DIR}/cyber/croutine/
    )

install(TARGETS
    cyber_croutine
    cyber_routine_context
    DESTINATION  ${CYBER_INSTALL_LIB_DIR}
    )
