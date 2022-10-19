cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
project(example)

# Set source and include folder ###########################################
set(SRC_FOLDER "${CMAKE_CURRENT_LIST_DIR}/src")

# Include universal (posits) ##############################################
include_directories("~/Documents/libs/universal/include")

# Sources
add_executable(log_mult ${SRC_FOLDER}/log_mult.cpp)
set_property(TARGET log_mult PROPERTY CXX_STANDARD 17)

add_executable(log_div ${SRC_FOLDER}/log_div.cpp)
set_property(TARGET log_div PROPERTY CXX_STANDARD 17)

add_executable(log_sqrt ${SRC_FOLDER}/log_sqrt.cpp)
set_property(TARGET log_sqrt PROPERTY CXX_STANDARD 17)
