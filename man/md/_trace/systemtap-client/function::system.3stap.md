# function::system(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::system - Issue a command to the system

<a name="synopsis"></a>

# Synopsis

```


```
        system(cmd:string)

<a name="arguments"></a>

# Arguments


_cmd_
the command to issue to the system

<a name="description"></a>

# Description


This function runs a command on the system. The command is started in the background some time after the current probe completes. The command is run with the same UID as the user running the stap or staprun command. The runtime may impose a relatively short length limit on the command string. Exceeding it may print a warning.

<a name="see-alson-"></a>

# See Also\N 

_tapset::system_(3stap)
