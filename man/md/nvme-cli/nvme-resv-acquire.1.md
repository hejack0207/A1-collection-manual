# nvme\-resv\-acquire(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-resv-acquire - Acquire an nvme reservation

<a name="synopsis"></a>

# Synopsis

```


```
    nvme resv-acquire <device> [--namespace-id=<nsid> | -n <nsid>]
                                 [--crkey=<crkey> | -c <crkey>]
                                 [--prkey=<prkey> | -p <prkey>]
                                 [--rtype=<rtype> | -t <rtype>]
                                 [--racqa=<racqa> | -a <racqa>]
                                 [--iekey | -i]

<a name="description"></a>

# Description


The Reservation Acquire command is used to acquire a reservation on a namespace, preempt a reservation held on a namespace, and abort a reservation held on a namespace.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Override the nsid field. If using the admin character device, this parameter is required.

-c &lt;crkey&gt;, --crkey=&lt;crkey&gt;
Current Reservation Key: The field specifies the current reservation key associated with the host. If the IEKEY bit is set to ‘1’ in the command, then the CRKEY check succeeds regardless of the value in this field.

-p &lt;prkey&gt;, --prkey=&lt;prkey&gt;
Preempt Reservation Key: If the Reservation Acquire Action is set to 001b (i.e., Preempt) or 010b (i.e., Preempt and Abort), then this field specifies the reservation key to be unregistered from the namespace. For all other Reservation Acquire Action values, this field is reserved.

-t &lt;rtype&gt;, --rtyep=&lt;rtype&gt;
Reservation Type: This field specifies the type of reservation to be created.
.TS
allbox tab(:);
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt
lt lt.
T{
Value
T}:T{
Definition
T}
T{
0h
T}:T{
Reserved
T}
T{
1h
T}:T{
Write Exclusive Reservation
T}
T{
2h
T}:T{
Exclusive Access Reservation
T}
T{
3h
T}:T{
Write Exclusive - Registrants Only Reservation
T}
T{
4h
T}:T{
Exclusive Access - Registrants Only Reservation
T}
T{
5h
T}:T{
Write Exclusive - All Registrants Reservation
T}
T{
6h
T}:T{
Exclusive Access - All Registrants Reservation
T}
T{
07h-FFh
T}:T{
Reserved
T}
.TE


-a &lt;racqa&gt;, --racqa=&lt;racqa&gt;
Reservation Acquire Action: This field specifies the action that is performed by the command.
.TS
allbox tab(:);
lt lt
lt lt
lt lt
lt lt
lt lt.
T{
Value
T}:T{
Definition
T}
T{
0
T}:T{
Acquire
T}
T{
1
T}:T{
Preempt
T}
T{
2
T}:T{
Preempt and Abort
T}
T{
3-7
T}:T{
Reserved
T}
.TE


-i, --iekey
Ignore Existing Key: If this bit is set to a
_1_, then the Current Reservation Key (CRKEY) check is disabled and the command shall succeed regardless of the CRKEY field value.

Indicator option, defaults to
_0_.

<a name="examples"></a>

# Examples


No examples yet

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
