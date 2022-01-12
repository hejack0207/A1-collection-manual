# autrace:(8) - a program similar to strace

Red Hat, Jan 2007

```
autrace program [-r] [program-args]...
```

<a name="description"></a>

# Description

**autrace** is a program that will add the audit rules to trace a process similar to strace. It will then execute the _program_ passing _arguments_ to it. The resulting audit information will be in the audit logs if the audit daemon is running or syslog. This command deletes all audit rules prior to executing the target program and after executing it. As a safety precaution, it will not run unless all rules are deleted with
**auditctl**
prior to use.

<a name="options"></a>

# Options


* **-r**  
  Limit syscalls collected to ones needed for analyzing resource usage. This could help people doing threat modeling. This saves space in logs.

<a name="examples"></a>

# Examples

The following illustrates a typical session:

    autrace /bin/ls /tmp
    ausearch --start recent -p 2442 -i 

and for resource usage mode:

    autrace -r /bin/ls
    ausearch --start recent -p 2450 --raw | aureport --file --summary
    ausearch --start recent -p 2450 --raw | aureport --host --summary


<a name="see-also"></a>

# See Also

**ausearch**(8),
**auditctl**(8).


<a name="author"></a>

# Author

Steve Grubb
