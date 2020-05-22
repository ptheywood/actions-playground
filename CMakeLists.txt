cmake_minimum_required(VERSION VERSION 3.10 FATAL_ERROR)

project(helloActions CXX)


# Options
option(BUILD_TESTS "Enable building tests" OFF)

# Settings.
set(default_build_type "Release")
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to '${default_build_type}' as none was specified.")
  set(CMAKE_BUILD_TYPE "${default_build_type}" CACHE STRING "Choose the type of build." FORCE)
  # Set the possible values of build type for cmake-gui
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
    "Debug" "Release")
endif()

if(CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_CONFIGURATION_TYPES Debug Release)
  set(CMAKE_CONFIGURATION_TYPES "${CMAKE_CONFIGURATION_TYPES}" CACHE STRING
    "Reset the configurations to what we need"
    FORCE)
endif()

# Specify using C++11 standard
if(NOT DEFINED CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD 11)
    set(CMAKE_CXX_STANDARD_REQUIRED true)
endif()



# files
set(SRC_INCLUDE
    include/hello.hpp
)

set(SRC
    src/hello.cpp
    src/main.cpp
)

set(ALL_SRC
    ${SRC_INCLUDE}
    ${SRC}
)


# Executable
add_executable(${PROJECT_NAME} ${ALL_SRC})
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/include)

# tests
if(BUILD_TESTS)
    enable_testing()
    # prtend main is a test.
    add_test(
        NAME ${PROJECT_NAME} 
        COMMAND "${PROJECT_NAME}"
        WORKING_DIRECTORY ${PROJECT_DIR}
    )
endif()