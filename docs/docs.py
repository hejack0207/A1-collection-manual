#!/usr/bin/env python3
import yaml
import subprocess
from os import path

with open("docs.yaml") as f:

    docs = yaml.safe_load(f)
    ret = 0

    for doc in docs:
        repo = doc["repo"]
        branch = doc["branch"]
        basedir = doc["basedir"]

        print("repo:%s,branch:%s,basedir:%s" % (repo, branch, basedir))
        try:
            if not path.exists(basedir):

                subprocess.call(["mkdir", basedir])

                for p in doc["paths"]:
                    srcpath = p["srcpath"]
                    tpath = p["path"]
                    subprocess.check_call(["fetch","--repo", repo,"--branch", branch,"--source-path", srcpath, basedir+"/"+tpath])
        except:
            subprocess.call(["rm","-rf",basedir])
            ret = 1

exit(ret)
