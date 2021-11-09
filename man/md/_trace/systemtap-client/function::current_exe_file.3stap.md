# function::current_ex(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::current_exe_file - get the file struct pointer for the current tasks executable file

<a name="synopsis"></a>

# Synopsis

```


```
        current_exe_file:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the file struct pointer for the current tasks executable file. Note that the file struct pointer isn\*(Aqt locked on return. The return value of this function can be passed to
**fullpath\_struct\_file**
to get the path from the file struct.
