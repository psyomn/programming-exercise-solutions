include_directories("${PROJECT_BINARY_DIR}")
include_directories(${anagram_SOURCE_DIR}/src/)
include_directories(${anagram_SOURCE_DIR}/inc/)
set(EXECUTABLE_NAME "anagram")
add_executable(${EXECUTABLE_NAME}
list.c
main.c
)
