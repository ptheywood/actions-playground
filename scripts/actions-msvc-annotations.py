import re
import pathlib
# file_path(line,col): warning code: message [vcxproj]
warningfmt = re.compile("^(.+)\((\d+),(\d+)\): (warning [0-9a-zA-Z]*: .+) ([.+]?)")
# file_path(line,col): error code: message [vcxproj]
errorfmt = re.compile("^(.+)\((\d+),(\d+)\): (error [0-9a-zA-Z]*: .+) ([.+]?)")
# Assumed to be called from the build dir.
repo_root = pathlib.Path("../").resolve()
with open("CMakeBuild.log", "r") as f:
    for line in f.readlines():
        match = warningfmt.match(line.strip())
        if match is not None:
            root_relative_path = pathlib.Path(match.group(1)).resolve().relative_to(repo_root)
            root_relative_path_posix = pathlib.PurePosixPath(root_relative_path)
            print(f"::warning file={root_relative_path_posix},line={match.group(2)},col={match.group(3)}::{root_relative_path}({match.group(2)},{match.group(3)}): {match.group(4)}")
        match = errorfmt.match(line.strip())
        if match is not None:
            root_relative_path = pathlib.Path(match.group(1)).resolve().relative_to(repo_root)
            root_relative_path_posix = pathlib.PurePosixPath(root_relative_path)
            print(f"::error file={root_relative_path_posix},line={match.group(2)},col={match.group(3)}::{root_relative_path}({match.group(2)},{match.group(3)}): {match.group(4)}")
