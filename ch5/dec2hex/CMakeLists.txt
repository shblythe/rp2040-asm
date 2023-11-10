cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)
project(Dec2Hex C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()
include_directories(${CMAKE_SOURCE_DIR})
add_executable(Dec2Hex
    dec2hex.S
)
target_link_libraries(Dec2Hex pico_stdlib)
