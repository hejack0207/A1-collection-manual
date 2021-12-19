# nvme\-security\-recv(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-security-recv - Security Recv command

<a name="synopsis"></a>

# Synopsis

```


```
    nvme security-recv <device> [--size=<size> | -x <size>]
                        [--secp=<security-protocol> | -p <security-protocol>]
                        [--spsp=<protocol-specific> | -s <protocol-specific>]
                        [--nssf=<nvme-specific> | -N <nvme-specific>]
                        [--al=<allocation-length> | -t <allocation-length>]
                        [--namespace-id=<nsid> | -n <nsid>]
                        [--raw-binary | -b]

<a name="description"></a>

# Description


The Security Receive command transfers the status and data result of one or more Security Send commands that were previously submitted to the controller.

The association between a Security Receive command and previous Security Send commands is dependent on the Security Protocol. The format of the data to be transferred is dependent on the Security Protocol. Refer to SPC-4 for Security Protocol details.

Each Security Receive command returns the appropriate data corresponding to a Security Send command as defined by the rules of the Security Protocol. The Security Receive command data may not be retained if there is a loss of communication between the controller and host, or if a controller reset occurs.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Target a specific namespace for this security command.

-N &lt;nssf&gt;, --nssf=&lt;nssf&gt;
NVMe Security Specific field. If using security protocol EAh assigned for NVMe use, the NVMe security specific field indicates which reply memory buffer target.

-x &lt;size&gt;, --size=&lt;size&gt;
Size of buffer to allocate. One success it will be printed to STDOUT.

-p &lt;security-protocol&gt;, --secp=&lt;security-protocol&gt;
Security Protocol: This field specifies the security protocol as defined in SPC-4. The controller shall fail the command with Invalid Parameter indicated if a reserved value of the Security Protocol is specified.

-s &lt;security-protocol-specific&gt;, --spsp=&lt;security-protocol-specific&gt;
SP Specific: The value of this field is specific to the Security Protocol as defined in SPC-4.

-t &lt;allocation-length&gt;, --al=&lt;allocation-length&gt;
Allocation Length: The value of this field is specific to the Security Protocol as defined in SPC-4.

-b, --raw-binary
Print the raw buffer to stdout. Defaults to print in hex.

<a name="examples"></a>

# Examples


No Examples

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
