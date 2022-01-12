# nvme\-resv\-register(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-resv-register - Register an nvme reservation

<a name="synopsis"></a>

# Synopsis

```


```
    nvme resv-register <device> [--namespace-id=<nsid> | -n <nsid>]
                                  [--crkey=<crkey> | -c <crkey>]
                                  [--nrkey=<nrkey> | -k <nrkey>]
                                  [--rrega=<rrega> | -r <rrega>]
                                  [--cptpl=<cptpl> | -p <cptpl>]
                                  [--iekey | -i]

<a name="description"></a>

# Description


The Reservation Register command is used to register, unregister, or replace a reservation key.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Override the nsid field. If using the admin character device, this parameter is required.

-c &lt;crkey&gt;, --crkey=&lt;crkey&gt;
Current Reservation Key: If the Reservation Register Action is 001b (i.e., Unregister Reservation Key) or 010b (i.e., Replace Reservation Key), then this field contains the current reservation key associated with the host. For all other Reservation Register Action values, this field is reserved. The controller ignores the value of this field when the Ignore Existing Key (IEKEY) bit is set to ‘1’.

-k &lt;nrkey&gt;, --nrkey=&lt;nrkey&gt;
New Reservation Key: If the Reservation Register Action is 000b (i.e., Register Reservation Key) or 010b (i.e., Replace Reservation Key), then this field contains the new reservation key associated with the host. For all other Reservation Register Action values, this field is reserved.

-p &lt;cptpl&gt;, --cptpl=&lt;cptpl&gt;
Change Persist Through Power Loss State: This field allows the Persist Through Power Loss state associated with the namespace to be modified as a side effect of processing this command.
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
No change to PTPL state
T}
T{
1
T}:T{
Reserved
T}
T{
2
T}:T{
Set PTPL state to ‘0’. Reservations are released and registrants are cleared on a power on.
T}
T{
3
T}:T{
Set PTPL state to ‘1’. Reservations and registrants persist across a power loss.
T}
.TE


-a &lt;rrega&gt;, --rrega=&lt;rrega&gt;
Reservation Register Action: This field specifies the registration action that is performed by the command.
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
Register Reservation Key
T}
T{
1
T}:T{
Unregister Reservation Key
T}
T{
2
T}:T{
Replace Reservation Key
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
