# function::remote_id(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::remote_id - The index of this instance in a remote execution.

<a name="synopsis"></a>

# Synopsis

```


```
        remote_id:long()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns a number 0..N, which is the unique index of this particular script execution from a swarm of
“stap --remote A --remote B ...”
runs, and is the same number
“stap --remote-prefix”
would print. The function returns -1 if the script was not launched with
“stap --remote”, or if the remote staprun/stapsh are older than version 1.7.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
