# probe::workqueue\&.e(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::workqueue.execute - Executing deferred work

<a name="synopsis"></a>

# Synopsis

```


```
    workqueue.execute 

<a name="values"></a>

# Values


_wq\_thread_
task_struct of the workqueue thread

_work\_func_
pointer to handler function

_work_
work_struct* being executed

<a name="see-alson-"></a>

# See Also\N 

_tapset::irq_(3stap)
