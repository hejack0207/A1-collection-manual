#!/usr/bin/env python3
import yaml
import subprocess
from os import path

with open("docs.yaml") as f:

    docs = yaml.safe_load(f)

    for doc in docs:
        repo = doc["repo"]
        branch = doc["branch"]
        basedir = doc["basedir"]

        if not path.exists(basedir):

            subprocess.call(["mkdir", basedir])

            for p in doc["paths"]:
                srcpath = p["srcpath"]
                path = p["path"]
                subprocess.call(["fetch","--repo", repo,"--branch", branch,"--source-path", srcpath, basedir+"/"+path])
