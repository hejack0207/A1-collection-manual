# sefcontext_compile(8) - compile file context regular expression files

dwalsh@redhat.com, 12 Aug 2015


<a name="synopsis"></a>

# Synopsis

```
sefcontext_compile [-o outputfile] [-p policyfile] inputfile
```

<a name="description"></a>

# Description

**sefcontext_compile**
is used to compile file context regular expressions into
**pcre**(3)
format.

The compiled file is used by libselinux file labeling functions.

By default
**sefcontext_compile**
writes the compiled pcre file with the
**.bin**
suffix appended (e.g. inputfile**.bin**).

<a name="options"></a>

# Options


* **-o**  
  Specify an
  _outputfile_
  that must be a fully qualified file name as the
  **.bin**
  suffix is not automatically added.
* **-p**  
  Specify a binary
  _policyfile_
  that will be used to validate the context entries in the
  _inputfile_  
  If an invalid context is found the pcre formatted file will not be written and
  an error will be returned.
  

<a name="return-value"></a>

# Return Value

On error -1 is returned.  On success 0 is returned.


<a name="examples"></a>

# Examples

**Example 1:**  
sefcontext_compile /etc/selinux/targeted/contexts/files/file_contexts

Results in the following file being generated:
/etc/selinux/targeted/contexts/files/file_contexts.bin

**Example 2:**  
sefcontext_compile -o new_fc.bin /etc/selinux/targeted/contexts/files/file_contexts

Results in the following file being generated in the cwd:
new_fc.bin

<a name="author"></a>

# Author

Dan Walsh, &lt;[dwalsh@redhat.com](mailto:dwalsh@redhat.com)&gt;

<a name="see-also"></a>

# See Also

**selinux**(8),
**semanage**(8),
