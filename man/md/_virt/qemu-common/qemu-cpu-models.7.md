# qemu-cpu-models.7(7)

 , 2019-08-14

.if n .ad l
.nh

<a name="name"></a>

# Name

qemu-cpu-models - QEMU / KVM CPU model configuration

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" \s-1QEMU / KVM CPU\s0 model configuration
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
\s-1QEMU / KVM\s0 virtualization supports two ways to configure \s-1CPU\s0 models

* **Host passthrough**  
  .IX Item "Host passthrough"
  This passes the host \s-1CPU\s0 model features, model, stepping, exactly to the
  guest. Note that \s-1KVM\s0 may filter out some host \s-1CPU\s0 model features if they
  cannot be supported with virtualization. Live migration is unsafe when
  this mode is used as libvirt / \s-1QEMU\s0 cannot guarantee a stable \s-1CPU\s0 is
  exposed to the guest across hosts. This is the recommended \s-1CPU\s0 to use,
  provided live migration is not required.
* **Named model**  
  .IX Item "Named model"
  \s-1QEMU\s0 comes with a number of predefined named \s-1CPU\s0 models, that typically
  refer to specific generations of hardware released by Intel and \s-1AMD.\s0
  These allow the guest VMs to have a degree of isolation from the host \s-1CPU,\s0
  allowing greater flexibility in live migrating between hosts with differing
  hardware.

In both cases, it is possible to optionally add or remove individual \s-1CPU\s0
features, to alter what is presented to the guest by default.

Libvirt supports a third way to configure \s-1CPU\s0 models known as Host model\*(R".
This uses the \s-1QEMU\s0 Named model\*(R" feature, automatically picking a \s-1CPU\s0 model
that is similar the host \s-1CPU,\s0 and then adding extra features to approximate
the host model as closely as possible. This does not guarantee the \s-1CPU\s0 family,
stepping, etc will precisely match the host \s-1CPU,\s0 as they would with Host
passthrough, but gives much of the benefit of passthrough, while making
live migration safe.

_Recommendations for \s-1KVM CPU\s0 model configuration on x86 hosts_
.IX Subsection "Recommendations for KVM CPU model configuration on x86 hosts"

The information that follows provides recommendations for configuring
\s-1CPU\s0 models on x86 hosts. The goals are to maximise performance, while
protecting guest \s-1OS\s0 against various \s-1CPU\s0 hardware flaws, and optionally
enabling live migration between hosts with hetergeneous \s-1CPU\s0 models.

Preferred \s-1CPU\s0 models for Intel x86 hosts
.IX Subsection "Preferred CPU models for Intel x86 hosts"

The following \s-1CPU\s0 models are preferred for use on Intel hosts. Administrators /
applications are recommended to use the \s-1CPU\s0 model that matches the generation
of the host CPUs in use. In a deployment with a mixture of host \s-1CPU\s0 models
between machines, if live migration compatibility is required, use the newest
\s-1CPU\s0 model that is compatible across all desired hosts.
.ie n .IP "**\f(CB""Skylake-Server""**" 4
.el .IP "**\f(CBSkylake-Server**" 4
.IX Item "Skylake-Server"
.ie n .IP "**\f(CB""Skylake-Server-IBRS""**" 4
.el .IP "**\f(CBSkylake-Server-IBRS**" 4
.IX Item "Skylake-Server-IBRS"
Intel Xeon Processor (Skylake, 2016)
.ie n .IP "**\f(CB""Skylake-Client""**" 4
.el .IP "**\f(CBSkylake-Client**" 4
.IX Item "Skylake-Client"
.ie n .IP "**\f(CB""Skylake-Client-IBRS""**" 4
.el .IP "**\f(CBSkylake-Client-IBRS**" 4
.IX Item "Skylake-Client-IBRS"
Intel Core Processor (Skylake, 2015)
.ie n .IP "**\f(CB""Broadwell""**" 4
.el .IP "**\f(CBBroadwell**" 4
.IX Item "Broadwell"
.ie n .IP "**\f(CB""Broadwell-IBRS""**" 4
.el .IP "**\f(CBBroadwell-IBRS**" 4
.IX Item "Broadwell-IBRS"
.ie n .IP "**\f(CB""Broadwell-noTSX""**" 4
.el .IP "**\f(CBBroadwell-noTSX**" 4
.IX Item "Broadwell-noTSX"
.ie n .IP "**\f(CB""Broadwell-noTSX-IBRS""**" 4
.el .IP "**\f(CBBroadwell-noTSX-IBRS**" 4
.IX Item "Broadwell-noTSX-IBRS"
Intel Core Processor (Broadwell, 2014)
.ie n .IP "**\f(CB""Haswell""**" 4
.el .IP "**\f(CBHaswell**" 4
.IX Item "Haswell"
.ie n .IP "**\f(CB""Haswell-IBRS""**" 4
.el .IP "**\f(CBHaswell-IBRS**" 4
.IX Item "Haswell-IBRS"
.ie n .IP "**\f(CB""Haswell-noTSX""**" 4
.el .IP "**\f(CBHaswell-noTSX**" 4
.IX Item "Haswell-noTSX"
.ie n .IP "**\f(CB""Haswell-noTSX-IBRS""**" 4
.el .IP "**\f(CBHaswell-noTSX-IBRS**" 4
.IX Item "Haswell-noTSX-IBRS"
Intel Core Processor (Haswell, 2013)
.ie n .IP "**\f(CB""IvyBridge""**" 4
.el .IP "**\f(CBIvyBridge**" 4
.IX Item "IvyBridge"
.ie n .IP "**\f(CB""IvyBridge-IBRS""**" 4
.el .IP "**\f(CBIvyBridge-IBRS**" 4
.IX Item "IvyBridge-IBRS"
Intel Xeon E3-12xx v2 (Ivy Bridge, 2012)
.ie n .IP "**\f(CB""SandyBridge""**" 4
.el .IP "**\f(CBSandyBridge**" 4
.IX Item "SandyBridge"
.ie n .IP "**\f(CB""SandyBridge-IBRS""**" 4
.el .IP "**\f(CBSandyBridge-IBRS**" 4
.IX Item "SandyBridge-IBRS"
Intel Xeon E312xx (Sandy Bridge, 2011)
.ie n .IP "**\f(CB""Westmere""**" 4
.el .IP "**\f(CBWestmere**" 4
.IX Item "Westmere"
.ie n .IP "**\f(CB""Westmere-IBRS""**" 4
.el .IP "**\f(CBWestmere-IBRS**" 4
.IX Item "Westmere-IBRS"
Westmere E56xx/L56xx/X56xx (Nehalem-C, 2010)
.ie n .IP "**\f(CB""Nehalem""**" 4
.el .IP "**\f(CBNehalem**" 4
.IX Item "Nehalem"
.ie n .IP "**\f(CB""Nehalem-IBRS""**" 4
.el .IP "**\f(CBNehalem-IBRS**" 4
.IX Item "Nehalem-IBRS"
Intel Core i7 9xx (Nehalem Class Core i7, 2008)
.ie n .IP "**\f(CB""Penryn""**" 4
.el .IP "**\f(CBPenryn**" 4
.IX Item "Penryn"
Intel Core 2 Duo P9xxx (Penryn Class Core 2, 2007)
.ie n .IP "**\f(CB""Conroe""**" 4
.el .IP "**\f(CBConroe**" 4
.IX Item "Conroe"
Intel Celeron_4x0 (Conroe/Merom Class Core 2, 2006)

Important \s-1CPU\s0 features for Intel x86 hosts
.IX Subsection "Important CPU features for Intel x86 hosts"

The following are important \s-1CPU\s0 features that should be used on Intel x86
hosts, when available in the host \s-1CPU.\s0 Some of them require explicit
configuration to enable, as they are not included by default in some, or all,
of the named \s-1CPU\s0 models listed above. In general all of these features are
included if using Host passthrough\*(R" or \*(L"Host model\*(R".
.ie n .IP "**\f(CB""pcid""**" 4
.el .IP "**\f(CBpcid**" 4
.IX Item "pcid"
Recommended to mitigate the cost of the Meltdown (\s-1CVE-2017-5754\s0) fix
.Sp
Included by default in Haswell, Broadwell & Skylake Intel \s-1CPU\s0 models.
.Sp
Should be explicitly turned on for Westmere, SandyBridge, and IvyBridge
Intel \s-1CPU\s0 models. Note that some desktop/mobile Westmere CPUs cannot
support this feature.
.ie n .IP "**\f(CB""spec-ctrl""**" 4
.el .IP "**\f(CBspec-ctrl**" 4
.IX Item "spec-ctrl"
Required to enable the Spectre (\s-1CVE-2017-5753\s0 and \s-1CVE-2017-5715\s0) fix,
in cases where retpolines are not sufficient.
.Sp
Included by default in Intel \s-1CPU\s0 models with -IBRS suffix.
.Sp
Must be explicitly turned on for Intel \s-1CPU\s0 models without -IBRS suffix.
.Sp
Requires the host \s-1CPU\s0 microcode to support this feature before it
can be used for guest CPUs.
.ie n .IP "**\f(CB""ssbd""**" 4
.el .IP "**\f(CBssbd**" 4
.IX Item "ssbd"
Required to enable the \s-1CVE-2018-3639\s0 fix
.Sp
Not included by default in any Intel \s-1CPU\s0 model.
.Sp
Must be explicitly turned on for all Intel \s-1CPU\s0 models.
.Sp
Requires the host \s-1CPU\s0 microcode to support this feature before it
can be used for guest CPUs.
.ie n .IP "**\f(CB""pdpe1gb""**" 4
.el .IP "**\f(CBpdpe1gb**" 4
.IX Item "pdpe1gb"
Recommended to allow guest \s-1OS\s0 to use 1GB size pages
.Sp
Not included by default in any Intel \s-1CPU\s0 model.
.Sp
Should be explicitly turned on for all Intel \s-1CPU\s0 models.
.Sp
Note that not all \s-1CPU\s0 hardware will support this feature.

Preferred \s-1CPU\s0 models for \s-1AMD\s0 x86 hosts
.IX Subsection "Preferred CPU models for AMD x86 hosts"

The following \s-1CPU\s0 models are preferred for use on Intel hosts. Administrators /
applications are recommended to use the \s-1CPU\s0 model that matches the generation
of the host CPUs in use. In a deployment with a mixture of host \s-1CPU\s0 models
between machines, if live migration compatibility is required, use the newest
\s-1CPU\s0 model that is compatible across all desired hosts.
.ie n .IP "**\f(CB""EPYC""**" 4
.el .IP "**\f(CBEPYC**" 4
.IX Item "EPYC"
.ie n .IP "**\f(CB""EPYC-IBPB""**" 4
.el .IP "**\f(CBEPYC-IBPB**" 4
.IX Item "EPYC-IBPB"
\s-1AMD EPYC\s0 Processor (2017)
.ie n .IP "**\f(CB""Opteron\_G5""**" 4
.el .IP "**\f(CBOpteron\_G5**" 4
.IX Item "Opteron_G5"
\s-1AMD\s0 Opteron 63xx class \s-1CPU\s0 (2012)
.ie n .IP "**\f(CB""Opteron\_G4""**" 4
.el .IP "**\f(CBOpteron\_G4**" 4
.IX Item "Opteron_G4"
\s-1AMD\s0 Opteron 62xx class \s-1CPU\s0 (2011)
.ie n .IP "**\f(CB""Opteron\_G3""**" 4
.el .IP "**\f(CBOpteron\_G3**" 4
.IX Item "Opteron_G3"
\s-1AMD\s0 Opteron 23xx (Gen 3 Class Opteron, 2009)
.ie n .IP "**\f(CB""Opteron\_G2""**" 4
.el .IP "**\f(CBOpteron\_G2**" 4
.IX Item "Opteron_G2"
\s-1AMD\s0 Opteron 22xx (Gen 2 Class Opteron, 2006)
.ie n .IP "**\f(CB""Opteron\_G1""**" 4
.el .IP "**\f(CBOpteron\_G1**" 4
.IX Item "Opteron_G1"
\s-1AMD\s0 Opteron 240 (Gen 1 Class Opteron, 2004)

Important \s-1CPU\s0 features for \s-1AMD\s0 x86 hosts
.IX Subsection "Important CPU features for AMD x86 hosts"

The following are important \s-1CPU\s0 features that should be used on \s-1AMD\s0 x86
hosts, when available in the host \s-1CPU.\s0 Some of them require explicit
configuration to enable, as they are not included by default in some, or all,
of the named \s-1CPU\s0 models listed above. In general all of these features are
included if using Host passthrough\*(R" or \*(L"Host model\*(R".
.ie n .IP "**\f(CB""ibpb""**" 4
.el .IP "**\f(CBibpb**" 4
.IX Item "ibpb"
Required to enable the Spectre (\s-1CVE-2017-5753\s0 and \s-1CVE-2017-5715\s0) fix,
in cases where retpolines are not sufficient.
.Sp
Included by default in \s-1AMD CPU\s0 models with -IBPB suffix.
.Sp
Must be explicitly turned on for \s-1AMD CPU\s0 models without -IBPB suffix.
.Sp
Requires the host \s-1CPU\s0 microcode to support this feature before it
can be used for guest CPUs.
.ie n .IP "**\f(CB""virt-ssbd""**" 4
.el .IP "**\f(CBvirt-ssbd**" 4
.IX Item "virt-ssbd"
Required to enable the \s-1CVE-2018-3639\s0 fix
.Sp
Not included by default in any \s-1AMD CPU\s0 model.
.Sp
Must be explicitly turned on for all \s-1AMD CPU\s0 models.
.Sp
This should be provided to guests, even if amd-ssbd is also
provided, for maximum guest compatibility.
.Sp
Note for some \s-1QEMU /\s0 libvirt versions, this must be force enabled
when when using Host model\*(R", because this is a virtual feature
that doesn't exist in the physical host CPUs.
.ie n .IP "**\f(CB""amd-ssbd""**" 4
.el .IP "**\f(CBamd-ssbd**" 4
.IX Item "amd-ssbd"
Required to enable the \s-1CVE-2018-3639\s0 fix
.Sp
Not included by default in any \s-1AMD CPU\s0 model.
.Sp
Must be explicitly turned on for all \s-1AMD CPU\s0 models.
.Sp
This provides higher performance than virt-ssbd so should be
exposed to guests whenever available in the host. virt-ssbd
should none the less also be exposed for maximum guest
compatability as some kernels only know about virt-ssbd.
.ie n .IP "**\f(CB""amd-no-ssb""**" 4
.el .IP "**\f(CBamd-no-ssb**" 4
.IX Item "amd-no-ssb"
Recommended to indicate the host is not vulnerable \s-1CVE-2018-3639\s0
.Sp
Not included by default in any \s-1AMD CPU\s0 model.
.Sp
Future hardware genarations of \s-1CPU\s0 will not be vulnerable to
\s-1CVE-2018-3639,\s0 and thus the guest should be told not to enable
its mitigations, by exposing amd-no-ssb. This is mutually
exclusive with virt-ssbd and amd-ssbd.
.ie n .IP "**\f(CB""pdpe1gb""**" 4
.el .IP "**\f(CBpdpe1gb**" 4
.IX Item "pdpe1gb"
Recommended to allow guest \s-1OS\s0 to use 1GB size pages
.Sp
Not included by default in any \s-1AMD CPU\s0 model.
.Sp
Should be explicitly turned on for all \s-1AMD CPU\s0 models.
.Sp
Note that not all \s-1CPU\s0 hardware will support this feature.

Default x86 \s-1CPU\s0 models
.IX Subsection "Default x86 CPU models"

The default \s-1QEMU CPU\s0 models are designed such that they can run on all hosts.
If an application does not wish to do perform any host compatibility checks
before launching guests, the default is guaranteed to work.

The default \s-1CPU\s0 models will, however, leave the guest \s-1OS\s0 vulnerable to various
\s-1CPU\s0 hardware flaws, so their use is strongly discouraged. Applications should
follow the earlier guidance to setup a better \s-1CPU\s0 configuration, with host
passthrough recommended if live migration is not needed.
.ie n .IP "**\f(CB""qemu32""**" 4
.el .IP "**\f(CBqemu32**" 4
.IX Item "qemu32"
.ie n .IP "**\f(CB""qemu64""**" 4
.el .IP "**\f(CBqemu64**" 4
.IX Item "qemu64"
\s-1QEMU\s0 Virtual \s-1CPU\s0 version 2.5+ (32 & 64 bit variants)
.Sp
qemu64 is used for x86_64 guests and qemu32 is used for i686 guests, when no
-cpu argument is given to \s-1QEMU,\s0 or no &lt;cpu&gt; is provided in libvirt \s-1XML.\s0

Other non-recommended x86 CPUs
.IX Subsection "Other non-recommended x86 CPUs"

The following CPUs models are compatible with most \s-1AMD\s0 and Intel x86 hosts, but
their usage is discouraged, as they expose a very limited featureset, which
prevents guests having optimal performance.
.ie n .IP "**\f(CB""kvm32""**" 4
.el .IP "**\f(CBkvm32**" 4
.IX Item "kvm32"
.ie n .IP "**\f(CB""kvm64""**" 4
.el .IP "**\f(CBkvm64**" 4
.IX Item "kvm64"
Common \s-1KVM\s0 processor (32 & 64 bit variants)
.Sp
Legacy models just for historical compatibility with ancient \s-1QEMU\s0 versions.

* **\f(CB486**  
  .IX Item "486"
  .ie n .IP "**\f(CB""athlon""**" 4
  .el .IP "**\f(CBathlon**" 4
  .IX Item "athlon"
  .ie n .IP "**\f(CB""phenom""**" 4
  .el .IP "**\f(CBphenom**" 4
  .IX Item "phenom"
  .ie n .IP "**\f(CB""coreduo""**" 4
  .el .IP "**\f(CBcoreduo**" 4
  .IX Item "coreduo"
  .ie n .IP "**\f(CB""core2duo""**" 4
  .el .IP "**\f(CBcore2duo**" 4
  .IX Item "core2duo"
  .ie n .IP "**\f(CB""n270""**" 4
  .el .IP "**\f(CBn270**" 4
  .IX Item "n270"
  .ie n .IP "**\f(CB""pentium""**" 4
  .el .IP "**\f(CBpentium**" 4
  .IX Item "pentium"
  .ie n .IP "**\f(CB""pentium2""**" 4
  .el .IP "**\f(CBpentium2**" 4
  .IX Item "pentium2"
  .ie n .IP "**\f(CB""pentium3""**" 4
  .el .IP "**\f(CBpentium3**" 4
  .IX Item "pentium3"
  Various very old x86 \s-1CPU\s0 models, mostly predating the introduction of
  hardware assisted virtualization, that should thus not be required for
  running virtual machines.

_Syntax for configuring \s-1CPU\s0 models_
.IX Subsection "Syntax for configuring CPU models"

The example below illustrate the approach to configuring the various
\s-1CPU\s0 models / features in \s-1QEMU\s0 and libvirt

\s-1QEMU\s0 command line
.IX Subsection "QEMU command line"

* **Host passthrough**  
  .IX Item "Host passthrough"
  .Vb 1
             $ qemu-system-x86_64 -cpu host
  .Ve
  .Sp
  With feature customization:
  .Sp
  .Vb 1
             $ qemu-system-x86_64 -cpu host,-vmx,...
  .Ve
* **Named \s-1CPU\s0 models**  
  .IX Item "Named CPU models"
  .Vb 1
             $ qemu-system-x86_64 -cpu Westmere
  .Ve
  .Sp
  With feature customization:
  .Sp
  .Vb 1
             $ qemu-system-x86_64 -cpu Westmere,+pcid,...
  .Ve

Libvirt guest \s-1XML\s0
.IX Subsection "Libvirt guest XML"

* **Host passthrough**  
  .IX Item "Host passthrough"
  .Vb 1
             &lt;cpu mode=host-passthrough\*(Aq/&gt;
  .Ve
  .Sp
  With feature customization:
  .Sp
  .Vb 4
             &lt;cpu mode=host-passthrough\*(Aq&gt;
                 &lt;feature name="vmx" policy="disable"/&gt;
                 ...
             &lt;/cpu&gt;
  .Ve
* **Host model**  
  .IX Item "Host model"
  .Vb 1
             &lt;cpu mode=host-model\*(Aq/&gt;
  .Ve
  .Sp
  With feature customization:
  .Sp
  .Vb 4
             &lt;cpu mode=host-model\*(Aq&gt;
                 &lt;feature name="vmx" policy="disable"/&gt;
                 ...
             &lt;/cpu&gt;
  .Ve
* **Named model**  
  .IX Item "Named model"
  .Vb 3
             &lt;cpu mode=custom\*(Aq&gt;
                 &lt;model name="Westmere"/&gt;
             &lt;/cpu&gt;
  .Ve
  .Sp
  With feature customization:
  .Sp
  .Vb 5
             &lt;cpu mode=custom\*(Aq&gt;
                 &lt;model name="Westmere"/&gt;
                 &lt;feature name="pcid" policy="require"/&gt;
                 ...
             &lt;/cpu&gt;
  .Ve

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
The \s-1HTML\s0 documentation of \s-1QEMU\s0 for more precise information and Linux
user mode emulator invocation.

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Daniel P. Berrange
