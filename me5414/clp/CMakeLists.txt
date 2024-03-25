cmake_minimum_required(VERSION 3.14)
project(myproj VERSION 1.0)

find_package(ZLIB REQUIRED)
find_package(Clp REQUIRED)

add_executable(myapp program.cpp)
target_link_libraries(myapp Coin::Clp)


# find_package(coin-clp REQUIRED)

# add_executable(myapp program.cpp)
# target_link_libraries(myapp coin-clp::coin-clp)