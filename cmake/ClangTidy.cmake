#[=======================================================================[.rst:
ClangTidu.cmake
-------------

Provides macros/functions to enable the use of Clangtidy.

#]=======================================================================]

# Variables
set(ALL_ClangTidy_TARGET "all_clangtidy")

include (CMakeParseArguments)

# Function to register the all_ClangTidy target 
# @todo document.
function(ClangTidy_register_global_target)
    # Define function otions
    set(options TRIGGER_ON_ALL)
    set(oneValueArgs)
    set(multiValueArgs)
    # Parse arguments
    cmake_parse_arguments(ClangTidy_register_global_target "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    # If the all_ target exists, add to it.
    # @todo - better handling of ALL?
    if(NOT TARGET ${ALL_ClangTidy_TARGET})
        add_custom_target(${ALL_ClangTidy_TARGET} ALL)
        if(NOT ClangTidy_register_global_target_TRIGGER_ON_ALL)
            set_target_properties(${ALL_ClangTidy_TARGET} PROPERTIES EXCLUDE_FROM_ALL TRUE)
        endif()
    endif()
endfunction()

# Function to register a target and source files for clang tidy.
# @todo document
function(ClangTidy_register)
    message("ClangTidy implementation incomplete!")
    return()
    # Define function otions
    set(options TRIGGER_ON_ALL)
    set(oneValueArgs TARGET)
    set(multiValueArgs FILES EXCLUDE_REGEX)
    # Parse arguments
    cmake_parse_arguments(ClangTidy_register "${options}" "${oneValueArgs}" "${multiValueArgs}" ${ARGN})

    # Exclude files from the list based on EXCLUDE_REGEX
    if(ClangTidy_register_EXCLUDE_REGEX)
        foreach(exclude_regex IN LISTS ClangTidy_register_EXCLUDE_REGEX)
            list(FILTER ClangTidy_register_FILES EXCLUDE REGEX ${exclude_regex})
        endforeach()
    endif()

    # Set the name of the new target
    set(NEW_ClangTidy_TARGET "clangtidy_${ClangTidy_register_TARGET}")

    if(NOT TARGET ${NEW_ClangTidy_TARGET})
        # Add a custom target which executes clang-tidy using approprite arguments
        add_custom_target(
            "${NEW_ClangTidy_TARGET}"
            ALL
            COMMAND ${ClangTidy_EXECUTABLE}
            ${ClangTidy_register_FILES}
        )

        # Don't trigger it on make all, unless requested
        if(NOT ClangTidy_register_TRIGGER_ON_ALL)
            set_target_properties("${NEW_ClangTidy_TARGET}" PROPERTIES EXCLUDE_FROM_ALL TRUE)
        endif()

        # If the all_ target exists, add to it.
        if(TARGET ${ALL_ClangTidy_TARGET})
            add_dependencies(${ALL_ClangTidy_TARGET} ${NEW_ClangTidy_TARGET})
        endif()
    endif()

endfunction()

# Keep the cache clean?
# @todo