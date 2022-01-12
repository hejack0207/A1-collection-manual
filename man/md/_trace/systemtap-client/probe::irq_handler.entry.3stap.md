# probe::irq_handler\&(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::irq_handler.entry - Execution of interrupt handler starting

<a name="synopsis"></a>

# Synopsis

```


```
    irq_handler.entry 

<a name="values"></a>

# Values


_dir_
pointer to the proc/irq/NN/name entry

_action_
struct irqaction* for this interrupt num

_thread\_fn_
interrupt handler function for threaded interrupts

_handler_
interrupt handler function

_irq_
irq number

_flags\_str_
symbolic string representation of IRQ flags

_thread\_flags_
Flags related to thread

_dev\_name_
name of device

_next\_irqaction_
pointer to next irqaction for shared interrupts

_dev\_id_
Cookie to identify device

_thread_
thread pointer for threaded interrupts

_flags_
Flags for IRQ handler

<a name="see-alson-"></a>

# See Also\N 

_tapset::irq_(3stap)
