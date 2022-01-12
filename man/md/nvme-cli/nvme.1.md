# nvme(1)

NVMe, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nvme - the NVMe storage command line interface utility (nvme-cli)

<a name="synopsis"></a>

# Synopsis

```

 built-in plugin: 

</synopsis>
    nvme <command> <device> [<args>]
<synopsis>

 extension plugins: 

```
    nvme <plugin> <command> <device> [<args>]

<a name="description"></a>

# Description


NVM-Express is a fast, scalable host controller interface designed to address the needs for not only PCI Express based solid state drives, but also NVMe-oF(over fabrics).

This _nvme_ program is a user space utility to provide standards compliant tooling for NVM-Express drives. It was made specifically for Linux as it relies on the IOCTLs defined by the mainline kernel driver.

<a name="nvme-commands"></a>

# Nvme Commands


The utility has sub-commands for all admin and io commands defined in the specification and for displaying controller registers. There is also an option to submit completely arbitrary commands. For a list of commands available, run "nvme help".

<a name="nvme-cli-sub-commands"></a>

# Nvme Cli Sub\-Commands


<a name="main-commands"></a>

### Main commands


**nvme-admin-passthru**(1)
Admin Passthrough Command

**nvme-compare**(1)
IO Compare

**nvme-error-log**(1)
Retrieve error logs

**nvme-flush**(1)
Submit flush

**nvme-dms**(1)
Submit Data Set Management

**nvme-format**(1)
Format namespace(s)

**nvme-fw-activate**(1)
F/W Activate

**nvme-fw-download**(1)
F/W Download

**nvme-fw-log**(1)
Retrieve f/w log

**nvme-get-feature**(1)
Get Features

**nvme-get-log**(1)
Generic Get Log

**nvme-telemetry-log**(1)
Telemetry Host-Initiated Log

**nvme-smart-log**(1)
Retrieve Smart Log

**nvme-endurance-log**(1)
Retrieve endurance Log

**nvme-effects-log**(1)
Retrieve effects Log

**nvme-get-ns-id**(1)
Retrieve namespace identifier

**nvme-help**(1)
NVMe CLI Help

**nvme-id-ctrl**(1)
Identify Controller

**nvme-id-ns**(1)
Identify Namespace

**nvme-create-ns**(1)
Create a new namespace

**nvme-delete-ns**(1)
Delete existing namespace

**nvme-attach-ns**(1)
Attach namespace

**nvme-detach-ns**(1)
Detach namespace

**nvme-io-passthru**(1)
IO Passthrough Command

**nvme-list-ns**(1)
List all nvme namespaces

**nvme-ns-descs**(1)
Identify Namespace Identification Descriptor

**nvme-list**(1)
List all nvme controllers

**nvme-list-ctrl**(1)
List controller in NVMe subsystem

**nvme-read**(1)
Issue IO Read Command

**nvme-write**(1)
Issue IO Write Command

**nvme-write-zeroes**(1)
Issue IO Write Zeroes Command

**nvme-write-uncor**(1)
Issue IO Write Uncorrectable Command

**nvme-resv-acquire**(1)
Acquire Namespace Reservation

**nvme-resv-register**(1)
Register Namespace Reservation

**nvme-resv-release**(1)
Release Namespace Reservation

**nvme-resv-report**(1)
Report Reservation Capabilities

**nvme-security-recv**(1)
Security Receive

**nvme-security-send**(1)
Security Send

**nvme-set-feature**(1)
Set Feature

**nvme-show-regs**(1)
Show NVMe Controller Registers

**nvme-discover**(1)
Send Get Log Page request to Discovery Controller

**nvme-connect-all**(1)
Discover and connect to all NVMe-over-Fabrics subsystems

**nvme-connect**(1)
Connect to an NVMe-over-Fabrics subsystem

**nvme-disconnect**(1)
Disconnect from an NVMe-over-Fabrics subsystem

**nvme-disconnect-all**(1)
Disconnect from all NVMe-over-Fabrics subsystems

**nvme-get-property**(1)
Reads and shows NVMe-over-Fabrics controller property

<a name="further-documentation"></a>

# Further Documentation


See the freely available references on the \m[blue]**Official NVM-Express Site**\m[]\s-2\u[1]\d\s+2.

<a name="authors"></a>

# Authors


This is written and maintained by \m[blue]**Keith Busch**\m[]\s-2\u[2]\d\s+2.

<a name="reporting-bugs"></a>

# Reporting Bugs


Patches and issues may be submitted to the official repository at \m[blue]**https://github.com/linux-nvme/nvme-cli**\m[] or the Linux NVMe mailing list \m[blue]**linux-nvme**\m[]\s-2\u[3]\d\s+2

<a name="nvme"></a>

# Nvme


Part of the nvme suite

<a name="notes"></a>

# Notes


*  1.  
  Official NVM-Express Site
      http://nvmexpress.org
*  2.  
  Keith Busch
      mailto:kbusch@kernel.org
*  3.  
  linux-nvme
      mailto:linux-nvme@lists.infradead.org
