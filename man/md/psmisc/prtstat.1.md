# prtstat(1) - print statistics of a process

psmisc, 2016-06-18

```
prtstat [-r|--raw] pid
prtstat -V|--version
```

<a name="description"></a>

# Description

**prtstat**
prints the statistics of the specified process.  This information comes
from the
_/proc/PID/stat_
file.

<a name="options"></a>

# Options


* **-r**,**&nbsp;--raw**  
  Print the information in raw format.
* **-V**,**&nbsp;--version**  
  Show the version information for
  **prtstat**.

<a name="files"></a>

# Files


* /proc/&lt;PID&gt;/stat  
  source of the information
  **prtstat**
  uses
