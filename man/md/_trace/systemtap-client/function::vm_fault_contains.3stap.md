# function::vm_fault_c(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::vm_fault_contains - Test return value for page fault reason

<a name="synopsis"></a>

# Synopsis

```


```
        vm_fault_contains:long(value:long,test:long)

<a name="arguments"></a>

# Arguments


_value_
the fault_type returned by vm.page_fault.return

_test_
the type of fault to test for (VM_FAULT_OOM or similar)

<a name="see-alson-"></a>

# See Also\N 

_tapset::memory_(3stap)
