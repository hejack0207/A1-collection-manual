# probe::workqueue\&.i(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::workqueue.insert - Queuing work on a workqueue

<a name="synopsis"></a>

# Synopsis

```


```
    workqueue.insert 

<a name="values"></a>

# Values


_work_
work_struct* being queued

_work\_func_
pointer to handler function

_wq\_thread_
task_struct of the workqueue thread

<a name="see-alson-"></a>

# See Also\N 

_tapset::irq_(3stap)
