# cons.saver(8)

Linux, May 16, 2006


<a name="name"></a>

# Name

cons.saver - general-purpose Linux console screen save and restore server

<a name="synopsis"></a>

# Synopsis

    .fam C
    cons.saver TTY
    .fam T

<a name="description"></a>

# Description


* Invoke this helper program with the Ctrl-o key combination to save and restore the user session on the screen.  

<a name="options"></a>

# Options

cons.saver takes only one argument, the _TTY_ _NAME_ from which the system  will save and restore.

<a name="security"></a>

# Security

Cons.saver does not need to be invoked by root.  It only needs read and write access to /dev/vcsa*, which is a priviledged operation.  You should create an unprivileged user, make cons.saver setuid to that user, and assure that all the vcsa* are owned by that user too.

<a name="author"></a>

# Author

Manpage written by Rodrigo Rubira Branco &lt;rrbranco@br.ibm.com&gt;

<a name="see-also"></a>

# See Also

**mc**(1), **mcserv**(8)
