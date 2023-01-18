cmake_minimum_required(VERSION 3.0 FATAL_ERROR)
project(example)

# Set source and include folder ###########################################
set(SRC_FOLDER "${CMAKE_CURRENT_LIST_DIR}/src")

# Include universal (posits) ##############################################
include_directories("~/Documents/libs/universal/include")

# Implement Parallelism
option (USE_Posit "Use Posit format" OFF)
option (LOG_APPROX "Use Logarithmic approximate Posit arithmetic" OFF)
if(NOT USE_Posit)
    FIND_PACKAGE(OpenMP)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fopenmp")
else()
    add_compile_definitions(USE_Posit)
    if(LOG_APPROX)
        add_compile_definitions(LOG_APPROX)
    endif()
endif()

# Sources
add_executable(knn ${SRC_FOLDER}/knn.cpp)
set_property(TARGET knn PROPERTY CXX_STANDARD 17)
