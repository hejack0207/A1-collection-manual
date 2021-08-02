# numactl(8) - Control NUMA policy for processes or shared memory 

SuSE Labs, Mar 2004

```
numactl [ --all ] [ --interleave nodes ] [ --preferred node  ] [ --membind nodes ] [  --cpunodebind nodes ] [ --physcpubind cpus ] [ --localalloc ] [--] command {arguments ...}
numactl --show
numactl --hardware
numactl  [ --huge ] [ --offset offset ] [ --shmmode shmmode ] [ --length length ] [ --strict ]
[ --shmid id ] --shm shmkeyfile | --file tmpfsfile
[ --touch ] [ --dump ] [ --dump-nodes ] memory policy
```

<a name="description"></a>

# Description

**numactl**
runs processes with a specific NUMA scheduling or memory placement policy.
The policy is set for command and inherited by all of its children.
In addition it can set persistent policy for shared memory segments or files.

Use -- before command if using command options that could be confused
with numactl options.

_nodes_
may be specified as N,N,N or  N-N or N,N-N or  N-N,N-N and so forth.
Relative
_nodes_
may be specifed as +N,N,N or  +N-N or +N,N-N and so forth. The + indicates that
the node numbers are relative to the process' set of allowed nodes in its
current cpuset.
A !N-N notation indicates the inverse of N-N, in other words all nodes
except N-N.  If used with + notation, specify !+N-N. When
_same_
is specified the previous nodemask specified on the command line is used.
all means all nodes in the current cpuset.

Instead of a number a node can also be:
.TS
tab(|);
l l.
netdev:DEV|The node connected to network device DEV.
file:PATH |The node the block device of PATH.
ip:HOST   |The node of the network device of HOST
block:PATH|The node of block device PATH
pci:[seg:]bus:dev[:func]|The node of a PCI device.
.TE

Note that block resolves the kernel block device names only
for udev names in /dev use
_file:_

* Policy settings are:  
* **--all, -a**  
  Unset default cpuset awareness, so user can use all possible CPUs/nodes
  for following policy settings.
* **--interleave=nodes, -i nodes**  
  Set a memory interleave policy. Memory will be allocated using round robin
  on
  _nodes._
  When memory cannot be allocated on the current interleave target fall back
  to other nodes.
  Multiple nodes may be specified on --interleave, --membind and --cpunodebind.
* **--membind=nodes, -m nodes**  
  Only allocate memory from nodes.  Allocation will fail when there
  is not enough memory available on these nodes.
  _nodes_
  may be specified as noted above.
* **--cpunodebind=nodes, -N nodes**  
  Only execute
  _command_
  on the CPUs of
  _nodes._
  Note that nodes may consist of multiple CPUs.
  _nodes_
  may be specified as noted above.
* **--physcpubind=cpus, -C cpus**  
  Only execute
  _process_
  on
  _cpus._
  This accepts cpu numbers as shown in the
  _processor_
  fields of 
  _/proc/cpuinfo,_
  or relative cpus as in relative to the current cpuset.
  You may specify "all", which means all cpus in the current cpuset.
  Physical
  _cpus_
  may be specified as N,N,N or  N-N or N,N-N or  N-N,N-N and so forth.
  Relative
  _cpus_
  may be specifed as +N,N,N or  +N-N or +N,N-N and so forth. The + indicates that
  the cpu numbers are relative to the process' set of allowed cpus in its
  current cpuset.
  A !N-N notation indicates the inverse of N-N, in other words all cpus
  except N-N.  If used with + notation, specify !+N-N.
* **--localalloc, -l**  
  Try to allocate on the current node of the process, but if memory cannot be allocated there fall back to other nodes.
* **--preferred=node**  
  Preferably allocate memory on 
  _node,_
  but if memory cannot be allocated there fall back to other nodes.
  This option takes only a single node number.
  Relative notation may be used.
* **--show, -s**  
  Show NUMA policy settings of the current process. 
* **--hardware, -H**  
  Show inventory of available nodes on the system.
* Numactl can set up policy for a SYSV shared memory segment or a file in shmfs/hugetlbfs.  
   
  This policy is persistent and will be used by
  all mappings from that shared memory. The order of options matters here.
  The specification must at least include either of 
  _--shm,_
  _--shmid,_
  _--file_
  to specify the shared memory segment or file and a memory policy like described 
  above (
  _--interleave,_
  _--localalloc,_
  _--preferred,_
  _--membind_
  ).
* **--huge**  
  When creating a SYSV shared memory segment use huge pages.
  Only valid before --shmid or --shm
* **--offset**  
  Specify offset into the shared memory segment. Default 0. 
  Valid units are 
  _m_
  (for MB), 
  _g_
  (for GB), 
  _k_
  (for KB),
  otherwise it specifies bytes.
* **--strict**  
  Give an error when a page in the policied area in the shared memory
  segment already was faulted in with a conflicting policy. Default
  is to silently ignore this.
* **--shmmode shmmode**  
  Only valid before --shmid or --shm
  When creating a shared memory segment set it to numeric mode 
  _shmmode._
* **--length length**  
  Apply policy to 
  _length_
  range in the shared memory segment or make 
  the segment length long
  Default is to use the remaining length 
  Required when a shared memory segment is created and specifies the length
  of the new segment then. Valid units are 
  _m_
  (for MB), 
  _g_
  (for GB), 
  _k_
  (for KB),
  otherwise it specifies bytes.
* **--shmid id**  
  Create or use an shared memory segment with numeric ID 
  _id_
* **--shm shmkeyfile**  
  Create or use an shared memory segment, with the ID generated
  using 
  _ftok(3)_
  from shmkeyfile
* **--file tmpfsfile**  
  Set policy for a file in tmpfs or hugetlbfs
* **--touch**  
  Touch pages to enforce policy early. Default is to not touch them, the policy
  is applied when an applications maps and accesses a page.
* **--dump**  
  Dump policy in the specified range.
* **--dump-nodes**  
  Dump all nodes of the specific range (very verbose!)
* Valid node specifiers  
  .TS
  tab(:);
  l l. 
  all:All nodes
  number:Node number
  number1{,number2}:Node number1 and Node number2
  number1-number2:Nodes from number1 to number2
  ! nodes:Invert selection of the following specification.
  .TE

<a name="examples"></a>

# Examples

numactl --physcpubind=+0-4,8-12 myapplic arguments
Run myapplic on cpus 0-4 and 8-12 of the current cpuset.

numactl --interleave=all bigdatabase arguments
Run big database with its memory interleaved on all CPUs.

numactl --cpunodebind=0 --membind=0,1 process
Run process on node 0 with memory allocated on node 0 and 1.

numactl --cpunodebind=0 --membind=0,1 -- process -l
Run process as above, but with an option (-l) that would be confused with
a numactl option.

numactl --cpunodebind=netdev:eth0 --membind=netdev:eth0 network-server
Run network-server on the node of network device eth0 with its memory
also in the same node.

numactl --preferred=1 numactl --show
Set preferred node 1 and show the resulting state.

numactl --interleave=all --shm /tmp/shmkey 
Interleave all of the sysv shared memory region specified by
/tmp/shmkey over all nodes.

Place a tmpfs file on 2 nodes:
  numactl --membind=2 dd if=/dev/zero of=/dev/shm/A bs=1M count=1024
  numactl --membind=3 dd if=/dev/zero of=/dev/shm/A seek=1024 bs=1M count=1024


numactl --localalloc /dev/shm/file
Reset the policy for the shared memory file 
_file_
to the default localalloc policy.

<a name="notes"></a>

# Notes

Requires an NUMA policy aware kernel.

Command is not executed using a shell. If you want to use shell metacharacters
in the child use sh -c as wrapper.

Setting policy for a hugetlbfs file does currently not work because
it cannot be extended by truncate.

Shared memory segments larger than numactl's address space cannot 
be completely policied. This could be a problem on 32bit architectures.
Changing it piece by piece may work.

The old
_--cpubind_
which accepts node numbers, not cpu numbers, is deprecated
and replaced with the new 
_--cpunodebind_
and 
_--physcpubind_
options.


<a name="files"></a>

# Files

_/proc/cpuinfo_
for the listing of active CPUs. See 
_proc(5)_
for details.

_/sys/devices/system/node/node*/numastat_
for NUMA memory hit statistics.


<a name="copyright"></a>

# Copyright

Copyright 2002,2004 Andi Kleen, SuSE Labs.
numactl and the demo programs are under the GNU General Public License, v.2


<a name="see-also"></a>

# See Also

_set_mempolicy(2)_
,
_get_mempolicy(2)_
,
_mbind(2)_
,
_sched_setaffinity(2)_
, 
_sched_getaffinity(2)_
,
_proc(5)_
, 
_ftok(3)_
,
_shmat(2)_
,
_migratepages(8)_

