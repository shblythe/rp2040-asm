cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)
project(Add96Bits C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()
include_directories(${CMAKE_SOURCE_DIR})
add_executable(Add96Bits
    add96bits.S
)
pico_enable_stdio_uart(Add96Bits 1)
pico_enable_stdio_usb(Add96Bits 0)
pico_add_extra_outputs(Add96Bits)
target_link_libraries(Add96Bits pico_stdlib)

