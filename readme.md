# Github Actions Playground

![docs](https://github.com/ptheywood/actions-playground/workflows/docs/badge.svg)
![WindowsVisualStudio2019](https://github.com/ptheywood/actions-playground/workflows/WindowsVisualStudio2019/badge.svg)
![Ubuntu1604](https://github.com/ptheywood/actions-playground/workflows/Ubuntu1604/badge.svg)

This repo is just a simple project to mess around with github actions, that is lighter-weight to execute than in [[ptheywood/cuda-cmake-github-actions]] where CUDA is installed during the process... 

Includes a helloWorld CMake application, as cmake is likely going to be my main point of contact with github actions.


### pr_comment 

Runs when the keyword !FullCI is mentioned in a comment on a PR. 

Uses the github  api to register a status for the relevant commit.

@todo - switch to [Checks](https://developer.github.com/v3/checks/) once out of beta? - this allows `conclusion`s of `neutral`, `skipped` rather than just `success` or `failure`.