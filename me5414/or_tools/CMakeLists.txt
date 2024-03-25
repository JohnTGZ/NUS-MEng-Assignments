cmake_minimum_required(VERSION 3.14)
project(myproj VERSION 1.0)

find_package(ortools CONFIG REQUIRED)

add_executable(myapp program.cpp)
target_link_libraries(myapp ortools::ortools)