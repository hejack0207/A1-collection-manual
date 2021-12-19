# function::exit(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::exit - Start shutting down probing script.

<a name="synopsis"></a>

# Synopsis

```


```
        exit()

<a name="arguments"></a>

# Arguments


None

<a name="description"></a>

# Description


This only enqueues a request to start shutting down the script. New probes will not fire (except
“end”
probes), but all currently running ones may complete their work.

<a name="see-alson-"></a>

# See Also\N 

_tapset::logging_(3stap)
