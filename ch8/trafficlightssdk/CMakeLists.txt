cmake_minimum_required(VERSION 3.13)
include(pico_sdk_import.cmake)
project(TrafficLights C CXX ASM)
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)
pico_sdk_init()
include_directories(${CMAKE_SOURCE_DIR})
add_executable(TrafficLights
    trafficlightssdk.S
    sdklink.c
)
target_link_libraries(TrafficLights pico_stdlib)
