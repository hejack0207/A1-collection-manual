# sysctl.conf(5) - sysctl preload/configuration file

procps-ng, January 2012


<a name="description"></a>

# Description

**sysctl.conf**
is a simple file containing sysctl values to be read in and set by
**sysctl**.
The syntax is simply as follows:

    .ne 7
    # comment
    ; comment
    
    token = value

Note that blank lines are ignored, and whitespace before and after a token or
value is ignored, although a value can contain whitespace within.  Lines which
begin with a # or ; are considered comments and ignored.

<a name="notes"></a>

# Notes

As the
**/etc/sysctl.conf**
file is used to override default kernel parameter values, only a small number of parameters is predefined in the file.
Use
_/sbin/sysctl&nbsp;-a_
or follow
**sysctl**(8)
to list all possible parameters. The description of individual parameters can be found in the kernel documentation.

<a name="example"></a>

# Example


    .ne 7
    # sysctl.conf sample
    #
      kernel.domainname = example.com
    ; this one has a space which will be written to the sysctl!
      kernel.modprobe = /sbin/mod probe


<a name="files"></a>

# Files


* /run/sysctl.d/*.conf  
  .TQ
  /etc/sysctl.d/*.conf
  .TQ
  /usr/local/lib/sysctl.d/*.conf
  .TQ
  /usr/lib/sysctl.d/*.conf
  .TQ
  /lib/sysctl.d/*.conf
  .TQ
  /etc/sysctl.conf
  The paths where
  sysctl
  preload files usually exist.  See also
  sysctl
  option
  _--system_.

<a name="see-also"></a>

# See Also

**sysctl**(8)

<a name="author"></a>

# Author

.UR [staikos@0wned.org](mailto:staikos@0wned.org)
George Staikos
.UE

<a name="reporting-bugs"></a>

# Reporting Bugs

Please send bug reports to
.UR procps@freelists.org
.UE
