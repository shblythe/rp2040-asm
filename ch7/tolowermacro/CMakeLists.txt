cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)
project(ToLower C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()
include_directories(${CMAKE_SOURCE_DIR})
add_executable(ToLower
    main.S
)
pico_enable_stdio_uart(ToLower 1)
pico_enable_stdio_usb(ToLower 0)
target_link_libraries(ToLower pico_stdlib)
