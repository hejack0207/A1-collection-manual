# probe::vm\&.pagefaul(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::vm.pagefault.return - Indicates what type of fault occurred

<a name="synopsis"></a>

# Synopsis

```


```
    vm.pagefault.return 

<a name="values"></a>

# Values


_name_
name of the probe point

_fault\_type_
returns either 0 (VM_FAULT_OOM) for out of memory faults, 2 (VM_FAULT_MINOR) for minor faults, 3 (VM_FAULT_MAJOR) for major faults, or 1 (VM_FAULT_SIGBUS) if the fault was neither OOM, minor fault, nor major fault.

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
