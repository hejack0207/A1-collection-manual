# function::qsq_print(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

function::qsq_print - Prints a line of statistics for the given queue

<a name="synopsis"></a>

# Synopsis

```


```
        qsq_print(qname:string)

<a name="arguments"></a>

# Arguments


_qname_
queue name

<a name="description"></a>

# Description


This function prints a line containing the following

<a name="statistics-for-the-given-queue"></a>

# Statistics for the Given Queue


the queue name, the average rate of requests per second, the average wait queue length, the average time on the wait queue, the average time to service a request, the percentage of time the wait queue was used, and the percentage of time request was being serviced.

<a name="see-alson-"></a>

# See Also\N 

_tapset::queue_stats_(3stap)
