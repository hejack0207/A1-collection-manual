# function::remote_uri(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::remote_uri - The name of this instance in a remote execution.

<a name="synopsis"></a>

# Synopsis

```


```
        remote_uri:string()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This function returns the remote host used to invoke this particular script execution from a swarm of
“stap --remote”
runs. It may not be unique among the swarm. The function returns an empty string if the script was not launched with
“stap --remote”.

<a name="see-alson-"></a>

# See Also\N 

_tapset::context_(3stap)
