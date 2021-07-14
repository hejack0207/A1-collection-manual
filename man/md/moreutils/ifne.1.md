# ifne(1)

moreutils, 2008\-05\-01

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

ifne - Run command if the standard input is not empty

<a name="synopsis"></a>

# Synopsis

```
.HP \w'ifne&nbsp;[-n]&nbsp;command&nbsp;'u ifne [-n] command
```

<a name="description"></a>

# Description


**ifne**
runs the following command if and only if the standard input is not empty.

<a name="options"></a>

# Options


**-n**
Reverse operation. Run the command if the standard input is empty.

Note that if the standard input is not empty, it is passed through ifne in this case.

<a name="example"></a>

# Example

.HP \w'**find&nbsp;.&nbsp;-name&nbsp;core&nbsp;|&nbsp;ifne&nbsp;mail&nbsp;-s&nbsp;"Core&nbsp;files&nbsp;found"&nbsp;root**&nbsp;'u
**find . -name core | ifne mail -s "Core files found" root**

<a name="author"></a>

# Author


Copyright 2008 by Javier Merino &lt;[cibervicho@gmail.com](mailto:cibervicho@gmail.com)&gt;

Licensed under the GNU GPL
