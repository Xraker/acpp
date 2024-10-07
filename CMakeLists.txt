cmake_minimum_required(VERSION 3.30)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

set(CMAKE_CXX_COMPILER "clang++")

if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
  add_compile_options(-Wall -Wextra -Wsign-conversion)
endif()

set(CMAKE_BUILD_TYPE Debug)
project(learncppcom VERSION 1.0 LANGUAGES CXX)
add_executable(execute learncpp.cpp) 

set_property(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} PROPERTY VS_STARTUP_PROJECT execute)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(PREDEFINED_TARGETS_FOLDER "CustomTargets")

#cmake -B buildMake -G "Unix Makefiles" ; cmake -B buildVS -G 'Visual Studio 17 2022' ; cd buildMake ; make ; cd ..

#w/o cmake
#Remove-Item execute.exe ; cd buildClangpp; clang++ -std=c++23 -Wall -Wextra -Wsign-conversion -g -o execute.exe ../learncpp.cpp; Copy-Item "execute.exe" -Destination "../"; cd ..

