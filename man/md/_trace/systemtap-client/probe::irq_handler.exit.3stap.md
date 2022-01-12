# probe::irq_handler\&(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::irq_handler.exit - Execution of interrupt handler completed

<a name="synopsis"></a>

# Synopsis

```


```
    irq_handler.exit 

<a name="values"></a>

# Values


_irq_
interrupt number

_thread\_flags_
Flags related to thread

_flags\_str_
symbolic string representation of IRQ flags

_dir_
pointer to the proc/irq/NN/name entry

_action_
struct irqaction*

_handler_
interrupt handler function that was executed

_thread\_fn_
interrupt handler function for threaded interrupts

_ret_
return value of the handler

_flags_
flags for IRQ handler

_thread_
thread pointer for threaded interrupts

_dev\_name_
name of device

_next\_irqaction_
pointer to next irqaction for shared interrupts

_dev\_id_
Cookie to identify device

<a name="see-alson-"></a>

# See Also\N 

_tapset::irq_(3stap)
