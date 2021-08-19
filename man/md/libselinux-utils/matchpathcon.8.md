# matchpathcon(8) - get the default SELinux security context for the specified path from the file contexts configuration

dwalsh@redhat.com, 21 April 2005


<a name="synopsis"></a>

# Synopsis

```
matchpathcon [-V] [-N] [-n] [-m type] [-f file_contexts_file] [-p prefix] [-P policy_root_path] filepath...
```

<a name="description"></a>

# Description

**matchpathcon**
queries the system policy and outputs the default security context associated with the filepath.

**Note:**
Identical paths can have different security contexts, depending on the file
type (regular file, directory, link file, char file ...).

**matchpathcon**
will also take the file type into consideration in determining the default security context if the file exists.  If the file does not exist, no file type matching will occur.

<a name="options"></a>

# Options


* **-m**_ type_  
  Force file type for the lookup.
  Valid types are
  **file**, **dir**, **pipe**, **chr_file**, **blk_file**, 
  **lnk_file**, **sock_file**.
* **-n**  
  Do not display path.
* **-N**  
  Do not use translations.
* **-f**_ file_context_file_  
  Use alternate file_context file
* **-p**_ prefix_  
  Use prefix to speed translations
* **-P**_ policy_root_path_  
  Use alternate policy root path
* **-V**  
  Verify file context on disk matches defaults

<a name="author"></a>

# Author

This manual page was written by Dan Walsh &lt;[dwalsh@redhat.com](mailto:dwalsh@redhat.com)&gt;.

<a name="see-also"></a>

# See Also

**selinux**(8), 
**matchpathcon**(3)
