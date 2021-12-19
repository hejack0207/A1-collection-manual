# probe::signal\&.send(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::signal.send.return - Signal being sent to a process completed (deprecated in SystemTap 2.1)

<a name="synopsis"></a>

# Synopsis

```


```
    signal.send.return 

<a name="values"></a>

# Values


_send2queue_
Indicates whether the sent signal was sent to an existing sigqueue

_retstr_
The return value to either __group_send_sig_info, specific_send_sig_info, or send_sigqueue

_name_
The name of the function used to send out the signal

_shared_
Indicates whether the sent signal is shared by the thread group.

<a name="context"></a>

# Context


The signals sender. (correct?)

<a name="description"></a>

# Description


Possible __group_send_sig_info and specific_send_sig_info return values are as follows;

0 -- The signal is successfully sent to a process, which means that, (1) the signal was ignored by the receiving process, (2) this is a non-RT signal and the system already has one queued, and (3) the signal was successfully added to the sigqueue of the receiving process.

-EAGAIN -- The sigqueue of the receiving process is overflowing, the signal was RT, and the signal was sent by a user using something other than
**kill**.

Possible send_group_sigqueue and send_sigqueue return values are as follows;

0 -- The signal was either successfully added into the sigqueue of the receiving process, or a SI_TIMER entry is already queued (in which case, the overrun count will be simply incremented).

1 -- The signal was ignored by the receiving process.

-1 -- (send_sigqueue only) The task was marked exiting, allowing * posix_timer_event to redirect it to the group leader.

<a name="see-alson-"></a>

# See Also\N 

_tapset::signal_(3stap)
