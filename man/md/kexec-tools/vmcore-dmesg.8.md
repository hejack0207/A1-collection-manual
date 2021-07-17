# vmcore-dmesg(8) - This is just a placeholder until real man page has been written

Sep 7, 2010

```
vmcore-dmesg  vmcore
```

<a name="description"></a>

# Description





**vmcore-dmesg** extracts the dmesg from a vmcore and write it to
standard out.  **vmcore-dmesg** works against either
**/proc/vmcore** in a crash dump capture context or a copy
of **/proc/vmcore** that has been saved for later analysis.  A
single build of **vmcore-dmesg** should work against any linux
vmcore written created on any architecture.






<a name="see-also"></a>

# See Also

kexec(8)

<a name="author"></a>

# Author

vmcore-dmesg was written by Eric Biederman.
