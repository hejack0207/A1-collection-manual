# semodule_expand(8)

Security Enhanced Linux, Nov 2005


<a name="name-"></a>

# Name 

semodule_expand - Expand a SELinux policy module package.


<a name="synopsis"></a>

# Synopsis

```
semodule_expand [-V ] [ -a ] [ -c [version]] basemodpkg outputfile

```

<a name="description"></a>

# Description


semodule_expand is a developer tool for manually expanding
a base policy module package into a kernel binary policy file.
This tool is not necessary for normal operation of SELinux.  In normal
operation, such expanding is performed internally by libsemanage in
response to semodule commands.  Base policy module packages can be
created directly by semodule_package or by semodule_link (when linking
together a set of packages into a single package).


<a name="options"></a>

# Options


* **-V**  
  show version
* **-c [version]**  
  policy version to create
* **-a**  
  Do not check assertions.  This will cause the policy to not check any neverallow rules.
  

<a name="see-also"></a>

# See Also

**checkmodule(8), semodule_package(8), semodule(8), semodule_link(8)**
(8),

<a name="authors"></a>

# Authors

    This manual page was written by Dan Walsh <dwalsh@redhat.com>.
    The program was written by Karl MacMillan <kmacmillan@tresys.com>, Joshua Brindle <jbrindle@tresys.com>
