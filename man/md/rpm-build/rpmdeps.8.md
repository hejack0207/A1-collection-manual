# rpmdeps(8) - Generate RPM Package Dependencies

Red Hat, Inc., 24 October 2002

```


</synopsis>


<synopsis>
rpmdeps {-P|--provides} {-R|--requires} {--rpmfcdebug} FILE ...
```


<a name="description"></a>

# Description


**rpmdeps** generates package dependencies
for the set of _FILE_ arguments.
Each _FILE_ argument is searched for
Elf32/Elf64, script interpreter, or per-script dependencies,
and the dependencies are printed to stdout.

<a name="options"></a>

# Options


* **-P, --provides**  
  Print the provides
* **-R, --requires**  
  Print the requires
* **--recommends**  
  Print the recommends
* **--suggests**  
  Print the suggests
* **--supplements**  
  Print the supplements
* **--enhances**  
  Print the enhances
* **--conflicts**  
  Print the conflicts
* **--obsoletes**  
  Print the obsoletes
* **--alldeps**  
  Print all the dependencies


<a name="see-also"></a>

# See Also


**rpm**(8),

**rpmbuild**(8),

<a name="authors"></a>

# Authors


Jeff Johnson &lt;[jbj@redhat.com](mailto:jbj@redhat.com)&gt;
