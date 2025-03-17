cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)
project(WhichFloor C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()
include_directories(${CMAKE_SOURCE_DIR})
add_executable(WhichFloor
    whichFloor.S
)
pico_enable_stdio_uart(WhichFloor 1)
pico_enable_stdio_usb(WhichFloor 0)
target_link_libraries(WhichFloor pico_stdlib)
