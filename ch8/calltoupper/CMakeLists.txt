cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)
project(CallToUpper C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()
include_directories(${CMAKE_SOURCE_DIR})
add_executable(CallToUpper
    toupperfunc.S
    uppertst.c
)
pico_enable_stdio_uart(CallToUpper 1)
pico_enable_stdio_usb(CallToUpper 0)
target_link_libraries(CallToUpper pico_stdlib)
