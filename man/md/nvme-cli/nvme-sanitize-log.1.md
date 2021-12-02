# nvme\-sanitize\-log(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme-sanitize-log - Send NVMe sanitize-log Command, return result

<a name="synopsis"></a>

# Synopsis

```


```
    nvme sanitize-log <device> [--output-format=<fmt> | -o <fmt>]
                                 [--human-readable | -H]
                                 [--raw-binary | -b]

<a name="description"></a>

# Description


Retrieves the NVMe Sanitize log page from an NVMe device and provides the status of sanitize command.

The &lt;device&gt; parameter is mandatory NVMe character device (ex: /dev/nvme0).

Expected status and description :-
.TS
allbox tab(:);
ltB ltB.
T{
Status Code
T}:T{
Description
T}
.T&
lt lt
lt lt
lt lt
lt lt
lt lt.
T{

0x0000
T}:T{

NVM subsystem has never been sanitized.
T}
T{

0x0001
T}:T{

The most recent sanitize operation completed successfully.
T}
T{

0x0002
T}:T{

A sanitize operation is currently in progress.
T}
T{

0x0003
T}:T{

The most recent sanitize operation failed.
T}
T{

0x0100
T}:T{

Global Data Erased bit If set to 1 then non-volatile storage in the NVM subsystem has not been written to: a) since being manufactured and the NVM subsystem has never been sanitized; or b) since the most recent successful sanitize operation. If cleared to 0, then non-volatile storage in the NVM subsystem has been written to: a) since being manufactured and the NVM subsystem has never been sanitized; or b) since the most recent successful sanitize operation of the NVM subsystem.
T}
.TE


Sanitize Progress - percentage complete

On success it returns 0, error code otherwise.

<a name="options"></a>

# Options


-o &lt;format&gt;, --output-format=&lt;format&gt;
Set the reporting format to
_normal_,
_json_, or
_binary_. Only one output format can be used at a time.

-H, --human-readable
This option will parse and format many of the bit fields into human-readable formats.

-b, --raw-binary
Print the raw buffer to stdout. Structure is not parsed by program. This overrides the vendor specific and human readable options.

<a name="examples"></a>

# Examples


.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  Has the program issue Sanitize-log Command :

.if n \{.RS 4
.\}
    # nvme sanitize-log /dev/nvme0
.if n \{.RE
.\}

<a name="nvme"></a>

# Nvme


Part of the nvme-user suite.
