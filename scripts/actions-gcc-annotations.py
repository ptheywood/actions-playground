import re
import pathlib
# file_path:line:col: warning: message [category]
warningfmt = re.compile("^(.+):(\d+):(\d+): warning: (.+(\[[a-zA-Z-_/]+\])?)")
# file_path:line:col: error: message
errorfmt = re.compile("^(.+):(\d+):(\d+): error: (.+)")
# Assumed to be called from the build dir.
repo_root = pathlib.Path("../").resolve()
with open("CMakeBuild.log", "r") as f:
    for line in f.readlines():
        match = warningfmt.match(line)
        if match is not None:
            root_relative_path = pathlib.Path(match.group(1)).resolve().relative_to(repo_root)
            print(f"::warning file={root_relative_path},line={match.group(2)},col={match.group(3)}::{root_relative_path}:{match.group(2)}:{match.group(3)}: {match.group(4)}")
        match = errorfmt.match(line)
        if match is not None:
            root_relative_path = pathlib.Path(match.group(1)).resolve().relative_to(repo_root)
            print(f"::error file={root_relative_path},line={match.group(2)},col={match.group(3)}::{root_relative_path}:{match.group(2)}:{match.group(3)}: {match.group(4)}")
