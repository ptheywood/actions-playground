# Github Actions Playground

![docs](https://github.com/ptheywood/actions-playground/workflows/docs/badge.svg)
![WindowsVisualStudio2019](https://github.com/ptheywood/actions-playground/workflows/WindowsVisualStudio2019/badge.svg)
![Ubuntu1604](https://github.com/ptheywood/actions-playground/workflows/Ubuntu1604/badge.svg)

This repo is just a simple project to mess around with github actions, that is lighter-weight to execute than in [[ptheywood/cuda-cmake-github-actions]] where CUDA is installed during the process... 



## Actions/Workflows

`.github/workflows` contains github action workflows to build/run various parts of the cmake project, on various triggers. This is the main purpose of this repository. 

This include:

+ *Just* documentation
    + `docs.yml`
+ Building all executables and executing tests on various Operating Systems
    + `@todo.yml`
+ *Just* linting via cpplint, with no need for a valid CXX compiler
    + `cpplint.yml` 
+ Linting/Format checking via `clang-tidy`/`clang-format`
    + This might need valid compiler(s) as the compile commands must be generated.
    + `clang.yml`


## Projects

This is structured to mirror a real world use case of a CXX/CUDA library, with example executables, tests and various linter tools.

### CXX library - libHello

A simple static library `libHello` exists with headers in `include` and source files in `src`

### Unit Tests

`tests` contains a suite of unit tests for `libHello`. 

Test source can be found in `test/src`.

Enabled by the cmake option `-DBUILD_TESTS=ON`

### Executable Project - helloExecutable

`helloExecutable` contains a sample executable which makes use of the library `libHello`. 

### Docs

`docs` contains some documentation to form a user guide (i.e. wordy documentation?)

API documentation can also be generated for the library (via `doxygen`)

### Tooling

Various tools are made available (linters etc) which can be configured through cmake to be used.

+ `cpplint`
+ `clang-tidy`
+ `clang-format`


## CMake

Building the p

## pointless change