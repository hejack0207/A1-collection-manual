# pam_postgresok(8) - simple check of real UID and corresponding account name

Red Hat Linux, 2003/7/24

```
auth sufficient pam_postgresok.so
```


<a name="description"></a>

# Description

pam_postgresok.so is designed to check that the real UID of the calling
process belongs to the "postgres" user and equal to 26 (the value assigned
to that user on Red Hat Linux systems).


<a name="arguments"></a>

# Arguments


* debug  
  Enable module debugging.  The module will log its progress to syslog.
  

<a name="bugs"></a>

# Bugs

Let's hope not, but if you find any, please report them via the "Bug Track"
link at http://bugzilla.redhat.com/bugzilla/


<a name="files"></a>

# Files

/usr/share/doc/setup-*/uidgid


<a name="author"></a>

# Author

Fernando Nasser &lt;[fnasser@redhat.com](mailto:fnasser@redhat.com)&gt;
