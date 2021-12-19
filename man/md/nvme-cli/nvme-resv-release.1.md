# nvme\-resv\-release(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-resv-release - Release an nvme reservation

<a name="synopsis"></a>

# Synopsis

```


```
    nvme resv-release <device> [--namespace-id=<nsid> | -n <nsid>]
                                 [--crkey=<crkey> | -c <crkey>]
                                 [--rtype=<rtype> | -t <rtype>]
                                 [--rrela=<rrela> | -a <rrela>]
                                 [--iekey | -i]

<a name="description"></a>

# Description


The Reservation Release command is used to release or clear a reservation held on a namespace.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Override the nsid field. If using the admin character device, this parameter is required.

-c &lt;crkey&gt;, --crkey=&lt;crkey&gt;
Current Reservation Key: If the Reservation Register Action is 001b (i.e., Unregister Reservation Key) or 010b (i.e., Replace Reservation Key), then this field contains the current reservation key associated with the host. For all other Reservation Register Action values, this field is reserved. The controller ignores the value of this field when the Ignore Existing Key (IEKEY) bit is set to ‘1’.

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


-a &lt;rrela&gt;, --rrela=&lt;rrela&gt;
Reservation Release Action: This field specifies the registration action that is performed by the command.
.TS
allbox tab(:);
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
Release
T}
T{
1
T}:T{
Clear
T}
T{
2-7
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
