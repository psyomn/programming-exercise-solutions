cmake_minimum_required(VERSION 2.8)
project(frac)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -O2 -Wall")

include_directories(inc)
add_subdirectory(src)

