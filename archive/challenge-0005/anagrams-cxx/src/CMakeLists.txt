
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

include_directories(${anagramcxx_SOURCE_DIR}/inc/)

link_directories(${anagramcxx_SOURCE_DIR}/src/)

add_executable(anagramcxx main.cxx)
