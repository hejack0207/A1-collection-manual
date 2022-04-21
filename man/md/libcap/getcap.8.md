# getcap(8) - examine file capabilities

11 September 2018

```
getcap [-v] [-n] [-r] [-h] filename [ ... ]
```

<a name="description"></a>

# Description

**getcap**
displays the name and capabilities of each specified

<a name="options"></a>

# Options


* **-h**  
  prints quick usage.
* **-n**  
  prints any non-zero namespace rootid value found to be associated with
  a file's capabilities.
* **-r**  
  enables recursive search.
* **-v**  
  enables to display all searched entries, even if it has no file-capabilities.
* _filename_  
  One file per line.

<a name="see-also"></a>

# See Also

**cap_get_file**(3),
**cap_to_text**(3),
**setcap**(8)
