# probe::softirq\&.exi(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::softirq.exit - Execution of handler for a pending softirq completed

<a name="synopsis"></a>

# Synopsis

```


```
    softirq.exit 

<a name="values"></a>

# Values


_h_
struct softirq_action* for just executed softirq

_action_
pointer to softirq handler that just finished execution

_vec\_nr_
softirq vector number

_vec_
softirq_action vector

<a name="see-alson-"></a>

# See Also\N 

_tapset::irq_(3stap)
