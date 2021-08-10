# ownership(8) - Compaq ownership tag retriever

dmidecode, February 2005

```
ownership [OPTIONS]
```


<a name="description"></a>

# Description

**ownership**
retrieves and prints the "ownership tag" that can be set on Compaq
computers. Contrary to all other programs of the
**dmidecode**
package,
**ownership**
doesn't print any version information, nor labels, but only the raw
ownership tag. This should help its integration in scripts.


<a name="options"></a>

# Options


* **-d**, **--dev-mem FILE**  
  Read memory from device **FILE** (default: **/dev/mem**)
* **-h**, **--help**  
  Display usage information and exit
* **-V**, **--version**  
  Display the version and exit
  

<a name="files"></a>

# Files

_/dev/mem_


<a name="author"></a>

# Author

Jean Delvare


<a name="see-also"></a>

# See Also

**biosdecode**(8),
**dmidecode**(8),
**mem**(4),
**vpddecode**(8)
