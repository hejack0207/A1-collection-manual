# probe::softirq\&.ent(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::softirq.entry - Execution of handler for a pending softirq starting

<a name="synopsis"></a>

# Synopsis

```


```
    softirq.entry 

<a name="values"></a>

# Values


_h_
struct softirq_action* for current pending softirq

_action_
pointer to softirq handler just about to execute

_vec\_nr_
softirq vector number

_vec_
softirq_action vector

<a name="see-alson-"></a>

# See Also\N 

_tapset::irq_(3stap)
