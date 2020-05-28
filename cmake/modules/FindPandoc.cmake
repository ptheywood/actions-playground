#[=======================================================================[.rst:
FindPandoc
-----------

Finds the pandoc static code checker for c++ (https://github.com/pandoc/pandoc).

Imported Targets
^^^^^^^^^^^^^^^^

This module provides the following targets, if found:
``Pandoc::pandoc``
  The pandoc tool

Result Variables
^^^^^^^^^^^^^^^^

This will define the following variables:

``Pandoc_FOUND``
  True if the system has pandoc installed 
``Pandoc_VERSION``
  The version of pandoc which was found
``Pandoc_EXECUTABLE``
  The fully qualified path to the pandoc executbale which was found


Cache Variables
^^^^^^^^^^^^^^^

The following cache variable smay also be set:

#]=======================================================================]


# Search for the pandoc executable
find_program(
    Pandoc_EXECUTABLE
    NAMES pandoc
    # PATHS
    DOC "pandoc document converter (https://pandoc.org/)"
)
mark_as_advanced(Pandoc_EXECUTABLE)

# If we found the executable, find more info
if(Pandoc_EXECUTABLE)
    # Extract the version number from pandoc --version
    execute_process(
        COMMAND "${Pandoc_EXECUTABLE}" --version
        OUTPUT_VARIABLE Pandoc_VERSION_STDOUT
        RESULT_VARIABLE Pandoc_version_result
    )
    if(Pandoc_version_result)
        # If non-zero return code, otput a warning
        message(WARNING "Unable to determine pandoc version: ${Pandoc_version_result}")
    else()
        # Extract the version string from the version stdout via regex + substr
        string(
            REGEX MATCH 
            "pandoc ([0-9]+\.[0-9]+\.[0-9]+(\.[0-9]+)?)"
            Pandoc_VERSION
            "${Pandoc_VERSION_STDOUT}"
        )
        string(
            SUBSTRING 
            "${Pandoc_VERSION}" 
            8 
            -1 
            Pandoc_VERSION
        )
    endif()

    # Create an imported target
    if(NOT TARGET Pandoc::pandoc)
        add_executable(Pandoc::pandoc IMPORTED GLOBAL)
        set_target_properties(Pandoc::pandoc PROPERTIES
            IMPORTED_LOCATION "${Pandoc_EXECUTABLE}"
        )
    endif()
endif()

# Register the package.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(
    Pandoc
    REQUIRED_VARS 
        Pandoc_EXECUTABLE
    VERSION_VAR 
        Pandoc_VERSION
)
