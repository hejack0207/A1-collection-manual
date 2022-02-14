# sestatus.conf(5) - The \fBsestatus\fR(8) configuration file.

Security Enhanced Linux, 26-Nov-2011


<a name="description"></a>

# Description

The _sestatus.conf_ file is used by the **sestatus**(8) command with the **-v** option to determine what file and process security contexts should be displayed.

The fully qualified path name of the configuration file is:
_/etc/sestatus.conf_

The file consists of two optional sections as described in the **FILE FORMAT** section. Whether these exist or not, the following will always be displayed:
The current process context  
The init process context  
The controlling terminal file context


<a name="file-format"></a>

# File Format

The format consists of two optional sections as follows:
**[files]**  
_file_name_  
_[file_name]_  
_..._

**[process]**  
_executable_file_name_  
_[executable_file_name]_  
_..._

Where:
**[files]**
The start of the file list block.
_file_name_
One or more fully qualified file names, each on a new line will that will have its context displayed. If the file does not exist, then it is ignored. If the file is a symbolic link, then **sestatus -v** will also display the target file context.

**[process]**
The start of the process list block.
_executable_file_name_
One or more fully qualified executable file names that should it be an active process, have its context displayed. Each entry is on a new line.


<a name="example"></a>

# Example

# /etc/sestatus.conf  
[files]  
/etc/passwd  
/etc/shadow  
/bin/bash  
/bin/login  
/lib/libc.so.6  
/lib/ld-linux.so.2  
/lib/ld.so.1

[process]  
/sbin/mingetty  
/sbin/agetty  
/usr/sbin/sshd


<a name="see-also"></a>

# See Also

**selinux**(8), **sestatus**(8) 
