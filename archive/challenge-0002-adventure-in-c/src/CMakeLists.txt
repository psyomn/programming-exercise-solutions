# Enable debug symbols by default
if(CMAKE_BUILD_TYPE STREQUAL "")
  set(CMAKE_BUILD_TYPE Debug)
else ()
  set(CMAKE_BUILD_TYPE Release)
endif()

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g -Wall")

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -g")
else ()
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -O0")
endif()

# Set version information in a config.h file
set(myproject_VERSION_MAJOR 1)
set(myproject_VERSION_MINOR 0)

include_directories("${PROJECT_BINARY_DIR}")


# Define sources and executable
include_directories(${adventure_SOURCE_DIR}/inc/)
link_directories(${adventure_SOURCE_DIR}/src/)
set(EXECUTABLE_NAME "adventure")
add_executable(${EXECUTABLE_NAME} 
adventure.c
biological.c
game_map.c
game_controller.c
node.c
tprint.c
)

