# nvme\-security\-send(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-security-send - Security Send command

<a name="synopsis"></a>

# Synopsis

```


```
    nvme security-send <device> [--file=<file> | -f <file>]
                        [--secp=<security-protocol> | -p <security-protocol>]
                        [--spsp=<protocol-specific> | -s <protocol-specific>]
                        [--tl=<transfer-length> | -t <transfer-length>]
                        [--nssf=<nvme-specific> | -N <nvme-specific>]
                        [--namespace-id=<nsid> | -n <nsid>]

<a name="description"></a>

# Description


The Security Send command is used to transfer security protocol data to the controller. The data structure transferred to the controller as part of this command contains security protocol specific commands to be performed by the controller. The data structure transferred may also contain data or parameters associated with the security protocol commands. Status and data that is to be returned to the host for the security protocol commands submitted by a Security Send command are retrieved with the Security Receive command.

The association between a Security Send command and subsequent Security Receive command is Security Protocol field dependent as defined in SPC-4.

<a name="options"></a>

# Options


-n &lt;nsid&gt;, --namespace-id=&lt;nsid&gt;
Target a specific namespace for this security command.

-N &lt;nssf&gt;, --nssf=&lt;nssf&gt;
NVMe Security Specific field. If using security protocol EAh assigned for NVMe use, the NVMe security specific field indicates which reply memory buffer target.

-f &lt;file&gt;, --file=&lt;file&gt;
Path to file used as the security protocol’s payload. Required argument.

-p &lt;security-protocol&gt;, --secp=&lt;security-protocol&gt;
Security Protocol: This field specifies the security protocol as defined in SPC-4. The controller shall fail the command with Invalid Parameter indicated if a reserved value of the Security Protocol is specified.

-s &lt;security-protocol-specific&gt;, --spsp=&lt;security-protocol-specific&gt;
SP Specific: The value of this field is specific to the Security Protocol as defined in SPC-4.

-t &lt;trans-length&gt;, --tl=&lt;trans-length&gt;
Transfer Length: The value of this field is specific to the Security Protocol as defined in SPC-4.

<a name="examples"></a>

# Examples


No Examples

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite
