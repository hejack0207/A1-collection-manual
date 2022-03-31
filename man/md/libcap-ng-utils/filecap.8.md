# filecap:(8) - a program to see capabilities

Red Hat, Aug 2018

```
filecap [ -a | -d | /dir | /dir/file [cap1 cap2 ...] ]
```

<a name="description"></a>

# Description

**filecap** is a program that prints out a report of programs with file based capabilities. If a file is not in the report or there is no report at all, no capabilities were found. For expedience, the default is to check only the directories in the PATH environmental variable. If the -a command line option is given, then all directories will be checked. If a directory is passed, it will recursively check that directory. If a path to a file is given, it will only check that file. If a file is given followed by capabilities, then the capabilities are written to the file.


<a name="options"></a>

# Options


* **-a**  
  This tells the program to show all capabilities starting from the / directory. Normally the PATH environmental variable is used to show you capabilities on files you are likely to execute.
* **-d**  
  This dumps all capabilities for reference.
  

<a name="examples"></a>

# Examples

    To check file capabilities in $PATH:
    filecap
    
    To check file capabilities of whole system:
    filecap -a
    
    To check file capabilities recursively in a directory:
    filecap /usr
    
    To check file capabilities of a specific program:
    filecap /bin/passwd
    
    To list all possible capabilities:
    filecap -d
    
    To set a file capability on a specific program:
    filecap /bin/ping net_raw net_admin
    
    To remove file capabilities on a specific program:
    filecap /bin/ping none 

<a name="see-also"></a>

# See Also

**pscap**(8),
**netcap**(8),
**capabilities**(7).


<a name="author"></a>

# Author

Steve Grubb
