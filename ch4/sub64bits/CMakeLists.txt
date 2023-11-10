cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)
project(Sub96Bits C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()
include_directories(${CMAKE_SOURCE_DIR})
add_executable(Sub96Bits
    sub96bits.S
)
target_link_libraries(Sub96Bits pico_stdlib)
