import re
import pathlib
# file_path:line: message [category]
warningfmt = re.compile("^(.+):(\d+):  (.+\[[a-zA-Z-_/]+\])")
# Assumed to be called from the build dir.
repo_root = pathlib.Path("../").resolve()
with open("cpplint.log", "r") as f:
    for line in f.readlines():
        res = warningfmt.match(line)
        if res is not None:
            root_relative_path = pathlib.Path(res.group(1)).resolve().relative_to(repo_root)
            print(f"::error file={root_relative_path},line={res.group(2)}::{root_relative_path}:{res.group(2)} {res.group(3)}")
