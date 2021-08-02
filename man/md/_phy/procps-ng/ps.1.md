# ps(1)

procps-ng, 2018-01-13

.na

.nh






.nr ColSize ((\n[.l] - \n[.i]) / 1n - 29)


<a name="name"></a>

# Name

ps - report a snapshot of the current processes.

<a name="synopsis"></a>

# Synopsis

```
ps [options] 
 

```

<a name="description"></a>

# Description

**ps**
displays information about a selection of the active processes.  If you want
a repetitive update of the selection and the displayed information, use
_top_(1)
instead.

This version of
**ps**
accepts several kinds of options:

* * 1  
UNIX options, which may be grouped and must be preceded by a dash.  
* 2  
  BSD options, which may be grouped and must not be used with a dash.
* 3  
  GNU long options, which are preceded by two dashes.

Options of different types may be freely mixed, but conflicts can appear.
There are some synonymous options, which are functionally identical, due to
the many standards and
**ps**
implementations that this
**ps**
is compatible with.

Note that "**ps -aux**" is distinct from "**ps&nbsp;aux**".  The POSIX and
UNIX standards require that "**ps&nbsp;-aux**" print all processes owned by a
user named "x", as well as printing all processes that would be selected by
the
**-a**
option.  If the user named "x" does not exist, this
**ps**
may interpret the command as "**ps&nbsp;aux**" instead and print a warning.
This behavior is intended to aid in transitioning old scripts and habits.  It
is fragile, subject to change, and thus should not be relied upon.

By default,
**ps**
selects all processes with the same effective user ID (euid=EUID) as the
current user and associated with the same terminal as the invoker.  It
displays the process ID (pid=PID), the terminal associated with the process
(tname=TTY), the cumulated CPU time in [DD-]hh:mm:ss format (time=TIME), and
the executable name (ucmd=CMD).  Output is unsorted by default.

The use of BSD-style options will add process state (stat=STAT) to the
default display and show the command args (args=COMMAND) instead of the
executable name.  You can override this with the
**PS_FORMAT**
environment variable. The use of BSD-style options will also change the
process selection to include processes on other terminals (TTYs) that are
owned by you; alternately, this may be described as setting the selection to
be the set of all processes filtered to exclude processes owned by other
users or not on a terminal.  These effects are not considered when options
are described as being "identical" below, so
**-M**
will be considered identical to **Z** and so on.

Except as described below, process selection options are additive.  The
default selection is discarded, and then the selected processes are added to
the set of processes to be displayed.  A process will thus be shown if it
meets any of the given selection criteria.



<a name="examples"></a>

# Examples


* To see every process on the system using standard syntax:  
  **ps&nbsp;-e**  
  **ps&nbsp;-ef**  
  **ps&nbsp;-eF**  
  **ps&nbsp;-ely**
* To see every process on the system using BSD syntax:  
  **ps&nbsp;ax**  
  **ps&nbsp;axu**
* To print a process tree:  
  **ps&nbsp;-ejH**  
  **ps&nbsp;axjf**
* To get info about threads:  
  **ps&nbsp;-eLf**  
  **ps&nbsp;axms**
* To get security info:  
  **ps&nbsp;-eo euser,ruser,suser,fuser,f,comm,label**  
  **ps&nbsp;axZ**  
  **ps&nbsp;-eM**
* To see every process running as root (real&nbsp;&&nbsp;effective&nbsp;ID) in user format:  
  **ps&nbsp;-U&nbsp;root&nbsp;-u&nbsp;root&nbsp;u**
* To see every process with a user-defined format:  
  **ps&nbsp;-eo&nbsp;pid,tid,class,rtprio,ni,pri,psr,pcpu,stat,wchan:14,comm**  
  **ps&nbsp;axo&nbsp;stat,euid,ruid,tty,tpgid,sess,pgrp,ppid,pid,pcpu,comm**  
  **ps&nbsp;-Ao&nbsp;pid,tt,user,fname,tmout,f,wchan**
* Print only the process IDs of syslogd:  
  **ps&nbsp;-C&nbsp;syslogd&nbsp;-o&nbsp;pid=**
* Print only the name of PID 42:  
  **ps&nbsp;-q&nbsp;42&nbsp;-o&nbsp;comm=**




<a name="simple-process-selection"></a>

# Simple Process Selection


* **a**  
  Lift the BSD-style "only yourself" restriction, which is imposed upon the
  set of all processes when some BSD-style (without "-") options are used or
  when the
  **ps**
  personality setting is BSD-like.  The set of processes selected in this
  manner is in addition to the set of processes selected by other means.  An
  alternate description is that this option causes
  **ps**
  to list all processes with a terminal (tty), or to list all processes when
  used together with the
  **x**
  option.
* **-A**  
  Select all processes.  Identical to
  **-e**.
* **-a**  
  Select all processes except both session leaders (see
  _getsid_(2))
  and processes not associated with a terminal.
* **-d**  
  Select all processes except session leaders.
* **--deselect**  
  Select all processes except those that fulfill the specified conditions
  (negates the selection).  Identical to
  **-N**.
* **-e**  
  Select all processes.  Identical to
  **-A**.
  
  
  
  
  
* **g**  
  Really all, even session leaders.  This flag is obsolete and may be
  discontinued in a future release.  It is normally implied by the
  **a**
  flag, and is only useful when operating in the sunos4 personality.
* **-N**  
  Select all processes except those that fulfill the specified conditions
  (negates the selection).  Identical to
  **--deselect**.
* **T**  
  Select all processes associated with this terminal.  Identical to the
  **t**
  option without any argument.
* **r**  
  Restrict the selection to only running processes.
* **x**  
  Lift the BSD-style "must have a tty" restriction, which is imposed upon the
  set of all processes when some BSD-style (without "-") options are used or
  when the
  **ps**
  personality setting is BSD-like.  The set of processes selected in this
  manner is in addition to the set of processes selected by other means.  An
  alternate description is that this option causes
  **ps**
  to list all processes owned by you (same EUID as
  **ps**),
  or to list all processes when used together with the
  **a**
  option.
  


<a name="process-selection-by-list"></a>

# Process Selection by List

These options accept a single argument in the form of a blank-separated or
comma-separated list.  They can be used multiple times.  For example:
**ps&nbsp;-p&nbsp;"1&nbsp;2"&nbsp;-p&nbsp;3,4**

* -_123_  
  Identical to **--pid&nbsp;123**.
* _123_  
  Identical to **--pid&nbsp;123**.
* **-C**_&nbsp;cmdlist_  
  Select by command name.  This selects the processes whose executable name is
  given in
  _cmdlist_.
* **-G**_&nbsp;grplist_  
  Select by real group ID (RGID) or name.  This selects the processes whose
  real group name or ID is in the
  _grplist_
  list.  The real group ID identifies the group of the user who created the
  process, see
  _getgid_(2).
* **-g**_&nbsp;grplist_  
  Select by session OR by effective group name.  Selection by session is
  specified by many standards, but selection by effective group is the logical
  behavior that several other operating systems use.  This
  **ps**
  will select by session when the list is completely numeric (as sessions
  are).  Group ID numbers will work only when some group names are also
  specified.  See the
  **-s**
  and
  **--group**
  options.
* **--Group**_&nbsp;grplist_  
  Select by real group ID (RGID) or name.  Identical to
  **-G**.
* **--group**_&nbsp;grplist_  
  Select by effective group ID (EGID) or name.  This selects the processes
  whose effective group name or ID is in
  _grplist_.
  The effective group ID describes the group whose file access permissions are
  used by the process (see
  _getegid_(2)).
  The
  **-g**
  option is often an alternative to
  **--group**.
* **p**_&nbsp;pidlist_  
  Select by process ID.  Identical to
  **-p**
  and
  **--pid**.
* **-p**_&nbsp;pidlist_  
  Select by PID.  This selects the processes whose process ID numbers appear in
  _pidlist_.
  Identical to
  **p**
  and
  **--pid**.
* **--pid**_&nbsp;pidlist_  
  Select by process&nbsp;ID.  Identical to
  **-p**
  and
  **p**.
* **--ppid**_&nbsp;pidlist_  
  Select by parent process ID.  This selects the processes with a parent
  process&nbsp;ID in
  _pidlist_.
  That is, it selects processes that are children of those listed in
  _pidlist_.
* **q**_&nbsp;pidlist_  
  Select by process ID (quick mode).  Identical to
  **-q**
  and
  **--quick-pid**.
* **-q**_&nbsp;pidlist_  
  Select by PID (quick mode).  This selects the processes whose process ID numbers appear in
  _pidlist_.
  With this option **ps** reads the necessary info only
  for the pids listed in the _pidlist_ and doesn't apply
  additional filtering rules. The order of pids is unsorted
  and preserved. No additional selection options, sorting
  and forest type listings are allowed in this mode.
  Identical to
  **q**
  and
  **--quick-pid**.
* **--quick-pid**_&nbsp;pidlist_  
  Select by process&nbsp;ID (quick mode).  Identical to
  **-q**
  and
  **q**.
* **-s**_&nbsp;sesslist_  
  Select by session ID.  This selects the processes with a session ID specified
  in
  _sesslist_.
* **--sid**_&nbsp;sesslist_  
  Select by session&nbsp;ID.  Identical to
  **-s**.
* **t**_&nbsp;ttylist_  
  Select by tty.  Nearly identical to
  **-t**
  and
  **--tty**,
  but can also
  be used with an empty
  _ttylist_
  to indicate the terminal associated with
  **ps**.
  Using the
  **T**
  option is considered cleaner than using
  **t**
  with an empty
  _ttylist_.
* **-t**_&nbsp;ttylist_  
  Select by tty.  This selects the processes associated with the terminals
  given in
  _ttylist_.
  Terminals (ttys, or screens for text output) can be specified in several
  forms: /dev/ttyS1, ttyS1, S1.  A plain "-" may be used to select processes
  not attached to any terminal.
* **--tty**_&nbsp;ttylist_  
  Select by terminal.  Identical to
  **-t**
  and
  **t**.
* **U**_&nbsp;userlist_  
  Select by effective user ID (EUID) or name.  This selects the processes whose
  effective user name or ID is in
  _userlist_.
  The effective user ID describes the user whose file access permissions are
  used by the process (see
  _geteuid_(2)).
  Identical to
  **-u**
  and
  **--user**.
* **-U**_&nbsp;userlist_  
  Select by real user ID (RUID) or name.  It selects the processes whose real
  user name or ID is in the
  _userlist_
  list.  The real user ID identifies the user who created the process, see
  _getuid_(2).
* **-u**_&nbsp;userlist_  
  Select by effective user ID (EUID) or name.  This selects the processes whose
  effective user name or ID is in
  _userlist_.
  
  The effective user ID describes the user whose file
  access permissions are used by the process (see
  _geteuid_(2)).
  Identical to
  **U**
  and
  **--user**.
* **--User**_&nbsp;userlist_  
  Select by real user ID (RUID) or name.  Identical to
  **-U**.
* **--user**_&nbsp;userlist_  
  Select by effective user ID (EUID) or name.  Identical to
  **-u**
  and
  **U**.
  


<a name="output-format-control"></a>

# Output Format Control

These options are used to choose the information displayed by
**ps**.
The output may differ by personality.


* **-c**  
  Show different scheduler information for the
  **-l**
  option.
* **--context**  
  Display security context format (for SELinux).
* **-f**  
  Do full-format listing. This option can be combined with many other
  UNIX-style options to add additional columns.  It also causes the command
  arguments to be printed.  When used with
  **-L**,
  the NLWP (number of threads) and LWP (thread ID) columns will be added.  See
  the
  **c**
  option, the format keyword
  **args**,
  and the format keyword
  **comm**.
* **-F**  
  Extra full format.  See the
  **-f**
  option, which
  **-F**
  implies.
* **--format**_&nbsp;format_  
  user-defined format.  Identical to
  **-o**
  and
  **o**.
* **j**  
  BSD job control format.
* **-j**  
  Jobs format.
* **l**  
  Display BSD long format.
* **-l**  
  Long format.  The
  **-y**
  option is often useful with this.
* **-M**  
  Add a column of security data.  Identical to
  **Z**
  (for SELinux).
* **O**_&nbsp;format_  
  is preloaded
  **o**
  (overloaded).  The BSD
  **O**
  option can act like
  **-O**
  (user-defined output format with some common fields predefined) or can be
  used to specify sort order.  Heuristics are used to determine the behavior of
  this option.  To ensure that the desired behavior is obtained (sorting or
  formatting), specify the option in some other way (e.g.  with
  **-O**
  or
  **--sort**).
  When used as a formatting option, it is identical to
  **-O**,
  with the BSD personality.
* **-O**_&nbsp;format_  
  Like
  **-o**,
  but preloaded with some default columns.  Identical to
  **-o&nbsp;pid,​format,​state,​tname,​time,​command** or
  **-o&nbsp;pid,​format,​tname,​time,​cmd**,
  see
  **-o**
  below.
* **o**_&nbsp;format_  
  Specify user-defined format.  Identical to
  **-o**
  and
  **--format**.
* **-o**_&nbsp;format_  
  User-defined format.
  _format_
  is a single argument in the form of a blank-separated or comma-separated
  list, which offers a way to specify individual output columns.  The
  recognized keywords are described in the
  **STANDARD FORMAT SPECIFIERS**
  section below.  Headers may be renamed
  (**ps -o pid,​ruser=RealUser -o comm=Command**)
  as desired.
  If all column headers are empty
  (**ps -o pid= -o comm=**)
  then the header line will not be output.  Column width will increase as
  needed for wide headers; this may be used to widen up columns such as WCHAN
  (**ps -o pid,​wchan=​WIDE-​WCHAN-​COLUMN -o comm**).
  Explicit width
  control
  (**ps opid,​wchan:42,​cmd**)
  is offered too.  The behavior of
  **ps -o pid=X,​comm=Y**
  varies with personality; output may be one column named "X,​comm=Y" or two
  columns named "X" and "Y".  Use multiple
  **-o**
  options when in doubt.  Use the
  **PS_FORMAT**
  environment variable to specify a default as desired; DefSysV and DefBSD are
  macros that may be used to choose the default UNIX or BSD columns.
* **s**  
  Display signal format.
* **u**  
  Display user-oriented format.
* **v**  
  Display virtual memory format.
* **X**  
  Register format.
* **-y**  
  Do not show flags; show rss in place of addr.  This option can only be used
  with
  **-l**.
* **Z**  
  Add a column of security data.  Identical to
  **-M**
  (for SELinux).
  


<a name="output-modifiers"></a>

# Output Modifiers





* **c**  
  Show the true command name.  This is derived from the name of the executable
  file, rather than from the argv value.  Command arguments and any
  modifications to them are thus not shown.  This option effectively turns the
  **args**
  format keyword into the
  **comm**
  format keyword; it is useful with the
  **-f**
  format option and with the various BSD-style format options, which all
  normally display the command arguments.  See the
  **-f**
  option, the format
  keyword
  **args**,
  and the format keyword
  **comm**.
* **--cols**_&nbsp;n_  
  Set screen width.
* **--columns**_&nbsp;n_  
  Set screen width.
* **--cumulative**  
  Include some dead child process data (as a sum with the parent).
* **e**  
  Show the environment after the command.
* **f**  
  ASCII art process hierarchy (forest).
* **--forest**  
  ASCII art process tree.
* **h**  
  No header.  (or, one header per screen in the BSD personality).  The
  **h**
  option is problematic.  Standard BSD
  **ps**
  uses this option to print a header on each page of output, but older Linux
  **ps**
  uses this option to totally disable the header.  This version of
  **ps**
  follows the Linux usage of not printing the header unless the BSD personality
  has been selected, in which case it prints a header on each page of output.
  Regardless of the current personality, you can use the long options
  **--headers**
  and
  **--no-headers**
  to enable printing headers each page or disable headers entirely,
  respectively.
* **-H**  
  Show process hierarchy (forest).
* **--headers**  
  Repeat header lines, one per page of output.
* **k**_&nbsp;spec_  
  Specify sorting order.  Sorting syntax is
  [**+**|**-**]_key_[,[**+**|**-**]_key_[,...]].
  Choose a multi-letter key from the
  **STANDARD FORMAT SPECIFIERS**
  section.  The "+" is optional since default direction is increasing
  numerical or lexicographic order.  Identical to
  **--sort**.
    * Examples:  
      **ps jaxkuid,-ppid,+pid**  
      **ps axk comm o comm,args**  
      **ps kstart_time -ef**
* **--lines**_&nbsp;n_  
  Set screen height.
* **n**  
  Numeric output for WCHAN and USER (including all types of UID and GID).
* **--no-headers**  
  Print no header line at all.
  **--no-heading**
  is an alias for this option.
* **O**_&nbsp;order_  
  Sorting order (overloaded).
  The BSD
  **O**
  option can act like
  **-O**
  (user-defined output format with some common fields predefined) or can be
  used to specify sort order.  Heuristics are used to determine the behavior of
  this option.  To ensure that the desired behavior is obtained (sorting or
  formatting), specify the option in some other way (e.g.  with
  **-O**
  or
  **--sort**).
* For sorting, obsolete BSD
  **O**
  option syntax is
  **O**[**+**|**-**]_k1_[,[**+**|**-**]_k2_[,...]].
  It orders the processes listing according to the multilevel sort specified by
  the sequence of one-letter short keys
  _k1_,_k2_, ...
  described in the
  **OBSOLETE SORT KEYS**
  section below.  The&nbsp;"+" is currently optional, merely re-iterating the
  default direction on a key, but may help to distinguish an
  **O**
  sort from an
  **O**
  format.  The "-" reverses direction only on the key it precedes.
* **--rows**_&nbsp;n_  
  Set screen height.
* **S**  
  Sum up some information, such as CPU usage, from dead child processes into
  their parent.  This is useful for examining a system where a parent process
  repeatedly forks off short-lived children to do work.
* **--sort**_&nbsp;spec_  
  Specify sorting order.  Sorting syntax is
  [**+**|**-**]_key_[,[**+**|**-**]_key_[,...]].  Choose a
  multi-letter key from the
  **STANDARD FORMAT SPECIFIERS**
  section.  The "+" is optional since default direction is increasing numerical
  or lexicographic order.  Identical to
  **k**.
  For example:
  **ps jax --sort=​uid,​-ppid,​+pid**
* **w**  
  Wide output.  Use this option twice for unlimited width.
* **-w**  
  Wide output.  Use this option twice for unlimited width.
* **--width**_&nbsp;n_  
  Set screen width.
  


<a name="thread-display"></a>

# Thread Display


* **H**  
  Show threads as if they were processes.
* **-L**  
  Show threads, possibly with LWP and NLWP columns.
* **m**  
  Show threads after processes.
* **-m**  
  Show threads after processes.
* **-T**  
  Show threads, possibly with SPID column.
  


<a name="other-information"></a>

# Other Information


* **--help**_&nbsp;section_  
  Print a help message.  The section argument can be one of
  _s_imple,
  _l_ist,
  _o_utput,
  _t_hreads,
  _m_isc or
  _a_ll.
  The argument can be shortened to one of the underlined letters as in: s|l|o|t|m|a.
* **--info**  
  Print debugging info.
* **L**  
  List all format specifiers.
* **V**  
  Print the procps-ng version.
* **-V**  
  Print the procps-ng version.
* **--version**  
  Print the procps-ng version.
  


<a name="notes"></a>

# Notes

This
**ps**
works by reading the virtual files in /proc.  This
**ps**
does not need to be setuid kmem or have any privileges to run.  Do not give
this
**ps**
any special permissions.


CPU usage is currently expressed as the percentage of time spent running
during the entire lifetime of a process.  This is not ideal, and&nbsp;it does not
conform to the standards that
**ps**
otherwise conforms to.  CPU usage is unlikely to add up to exactly 100%.

The SIZE and RSS fields don't count some parts of a process including the
page tables, kernel stack, struct thread_info, and struct task_struct.  This
is usually at least 20 KiB of memory that is always resident.  SIZE is the
virtual size of the process (code+​data+​stack).

Processes marked &lt;defunct&gt; are dead processes (so-called "zombies") that
remain because their parent has not destroyed them properly.  These processes
will be destroyed by
_init_(8)
if the parent process exits.

If the length of the username is greater than the length of the display
column, the username will be truncated. See the -o and -O formatting
options to customize length.

Commands options such as
**ps -aux**
are not recommended as it is a confusion of two different standards.
According to the POSIX and UNIX standards, the above command asks to
display all processes with a TTY (generally the commands users are
running) plus all processes owned by a user named "x".  If that user
doesn't exist, then
**ps**
will assume you really meant "**ps** _aux_".

<a name="process-flags"></a>

# Process Flags

The sum of these values is displayed in the "F" column,
which is provided by the
**flags**
output specifier:

*     * 1  
      forked but didn't exec
    * 4  
      used super-user privileges


<a name="process-state-codes"></a>

# Process State Codes

Here are the different values that the
**s**,**&nbsp;stat**&nbsp;and**&nbsp;state**
output specifiers (header "STAT" or "S") will display to describe the state
of a process:

*     * D  
      uninterruptible sleep (usually IO)
    * I  
      Idle kernel thread
    * R  
      running or runnable (on run queue)
    * S  
      interruptible sleep (waiting for an event to complete)
    * T  
      stopped by job control signal
    * t  
      stopped by debugger during the tracing
    * W  
      paging (not valid since the 2.6.xx kernel)
    * X  
      dead (should never be seen)
    * Z  
      defunct ("zombie") process, terminated but not reaped by its parent

For BSD formats and when the
**stat**
keyword is used, additional characters may be displayed:

*     * &lt;  
      high-priority (not nice to other users)
    * N  
      low-priority (nice to other users)
    * L  
      has pages locked into memory (for real-time and custom IO)
    * s  
      is a session leader
    * l  
      is multi-threaded (using CLONE_THREAD, like NPTL pthreads do)
    * +  
      is in the foreground process group


<a name="obsolete-sort-keys"></a>

# Obsolete Sort Keys

These keys are used by the BSD
**O**
option (when it is used for sorting).  The GNU
**--sort**
option doesn't use these keys, but the specifiers described below in the
**STANDARD FORMAT SPECIFIERS**
section.  Note that the values used in sorting are the internal values
**ps**
uses and not the "cooked" values used in some of the output format fields
(e.g.  sorting on tty will sort into device number, not according to the
terminal name displayed).  Pipe
**ps**
output into the
**sort**(1)
command if you want to sort the cooked values.
.TS
l l lw(3i).
**KEY	LONG	DESCRIPTION**
c	cmd	simple name of executable
C	pcpu	cpu utilization
f	flags	flags as in long format F field
g	pgrp	process group ID
G	tpgid	controlling tty process group ID
j	cutime	cumulative user time
J	cstime	cumulative system time
k	utime	user time
m	min_flt	number of minor page faults
M	maj_flt	number of major page faults
n	cmin_flt	cumulative minor page faults
N	cmaj_flt	cumulative major page faults
o	session	session ID
p	pid	process ID
P	ppid	parent process ID
r	rss	resident set size
R	resident	resident pages
s	size	memory size in kilobytes
S	share	amount of shared pages
t	tty	the device number of the controlling tty
T	start_time	time process was started
U	uid	user ID number
u	user	user name
v	vsize	total VM size in KiB
y	priority	kernel scheduling priority

.TE



<a name="aix-format-descriptors"></a>

# Aix Format Descriptors

This
**ps**
supports AIX format descriptors, which work somewhat like the
formatting codes of
_printf_(1)
and
_printf_(3).
For example, the normal default output can be produced with this:
**ps -eo "%p %y %x %c"**.
The
**NORMAL**
codes are described in the next section.
.TS
l l l.
**CODE	NORMAL	HEADER**
%C	pcpu	%CPU
%G	group	GROUP
%P	ppid	PPID
%U	user	USER
%a	args	COMMAND
%c	comm	COMMAND
%g	rgroup	RGROUP
%n	nice	NI
%p	pid	PID
%r	pgid	PGID
%t	etime	ELAPSED
%u	ruser	RUSER
%x	time	TIME
%y	tty	TTY
%z	vsz	VSZ
.TE

<a name="standard-format-specifiers"></a>

# Standard Format Specifiers

Here are the different keywords that may be used to control the output
format (e.g. with option
**-o**)
or to sort the selected processes with the GNU-style
**--sort**
option.

For example:
**ps -eo pid,​user,​args --sort user**

This version of
**ps**
tries to recognize most of the keywords used in other implementations of
**ps**.

The following user-defined format specifiers may contain
spaces:
**args**,**&nbsp;cmd**,**&nbsp;comm**,**&nbsp;command**,**&nbsp;fname**,**&nbsp;ucmd**,**&nbsp;ucomm**,
**lstart**,**&nbsp;bsdstart**,**&nbsp;start**.

Some keywords may not be available for sorting.








.TS
expand;
lB1 lB1 lBw(\n[ColSize]n)
lB1 l1  l.
CODE	HEADER	DESCRIPTION

%cpu	%CPU	T{
cpu utilization of the process in "##.#" format.  Currently, it is the CPU
time used divided by the time the process has been running (cputime/realtime
ratio), expressed as a percentage.  It will not add up to 100% unless you are
lucky.  (alias
**pcpu**).
T}

%mem	%MEM	T{
ratio of the process's resident set size  to the physical memory on the
machine, expressed as a percentage.  (alias
**pmem**).
T}

args	COMMAND	T{
command with all its arguments as a string. Modifications to the arguments
may be shown.  The output in this column may contain spaces.  A process
marked &lt;defunct&gt; is partly dead, waiting to be fully destroyed by its parent.
Sometimes the process args will be unavailable; when this happens,
**ps**
will instead print the executable name in brackets.  (alias
**cmd**,**&nbsp;command**).
See also the
**comm**
format keyword, the
**-f**
option, and the
**c**
option.  
When specified last, this column will extend to the edge of the display.  If
**ps**
can not determine display width, as when output is redirected (piped) into a
file or another command, the output width is undefined (it may be 80,
unlimited, determined by the
**TERM**
variable, and so on).  The
**COLUMNS**
environment variable or
**--cols**
option may be used to exactly determine the width in this case.  The
**w**
or
**-w**
option may be also be used to adjust width.
T}

blocked	BLOCKED	T{
mask of the blocked signals, see
_signal_(7).
According to the width of the field, a 32 or 64-bit mask in hexadecimal
format is displayed.  (alias
**sig_block**,**&nbsp;sigmask**).
T}

bsdstart	START	T{
time the command started.  If the process was started less than 24 hours ago,
the output format is "&nbsp;HH:MM", else it is " Mmm:SS" (where Mmm is the three
letters of the month).  See also
**lstart**,**&nbsp;start**,**&nbsp;start_time**, and**&nbsp;stime**.
T}

bsdtime	TIME	T{
accumulated cpu time, user + system.  The display format is usually
"MMM:SS", but can be shifted to the right if the process used more than 999
minutes of cpu time.
T}

c	C	T{
processor utilization. Currently, this is the integer value of the percent
usage over the lifetime of the process.  (see
**%cpu**).
T}

caught	CAUGHT	T{
mask of the caught signals, see
_signal_(7).
According to the width of the field, a 32 or 64 bits mask in hexadecimal
format is displayed.  (alias
**sig_catch**,**&nbsp;sigcatch**).
T}

cgname	CGNAME	T{
display name of control groups to which the process belongs.
T}

cgroup	CGROUP	T{
display control groups to which the process belongs.
T}

class	CLS	T{
scheduling class of the process.  (alias
**policy**,**&nbsp;cls**).
Field's possible values are:

* ""  
  -	not reported  
  TS	SCHED_OTHER  
  FF	SCHED_FIFO  
  RR	SCHED_RR  
  B	SCHED_BATCH  
  ISO	SCHED_ISO  
  IDL	SCHED_IDLE  
  DLN	SCHED_DEADLINE  
  ?	unknown value
  T}
  
  cls	CLS	T{
  scheduling class of the process.  (alias
  **policy**,**&nbsp;cls**).
  Field's possible values are:
* ""  
  -	not reported  
  TS	SCHED_OTHER  
  FF	SCHED_FIFO  
  RR	SCHED_RR  
  B	SCHED_BATCH  
  ISO	SCHED_ISO  
  IDL	SCHED_IDLE  
  DLN	SCHED_DEADLINE  
  ?	unknown value
  T}
  
  cmd	CMD	T{
  see
  **args**.
  (alias
  **args**,**&nbsp;command**).
  T}
  
  comm	COMMAND	T{
  command name (only the executable name).  Modifications to the command name
  will not be shown.  A process marked &lt;defunct&gt; is partly dead, waiting to be
  fully destroyed by its parent.  The output in this column may contain spaces.
  (alias
  **ucmd**,**&nbsp;ucomm**).
  See also the
  **args format keyword,**
  the
  **-f**
  option, and the
  **c**
  option.  
  When specified last, this column will extend to the edge of the display.  If
  **ps**
  can not determine display width, as when output is redirected (piped) into a
  file or another command, the output width is undefined (it may be 80,
  unlimited, determined by the
  **TERM**
  variable, and so on).  The
  **COLUMNS**
  environment variable or
  **--cols**
  option may be used to exactly determine the width in this case.  The
  **w**&nbsp;or**&nbsp;-w**
  option may be also be used to adjust width.
  T}
  
  command	COMMAND	T{
  See
  **args**.
  (alias
  **args**,**&nbsp;command**).
  T}
  
  cp	CP	T{
  per-mill (tenths of a percent) CPU usage.  (see
  **%cpu**).
  T}
  
  cputime	TIME	T{
  cumulative CPU time, "[DD-]hh:mm:ss" format.  (alias
  **time**).
  T}
  
  cputimes	TIME	T{
  cumulative CPU time in seconds (alias
  **times**).
  T}
  
  drs	DRS	T{
  data resident set size, the amount of physical memory devoted to other than
  executable code.
  T}
  
  egid	EGID	T{
  effective group ID number of the process as a decimal integer.  (alias
  **gid**).
  T}
  
  egroup	EGROUP	T{
  effective group ID of the process.  This will be the textual group ID, if it
  can be obtained and the field width permits, or a decimal representation
  otherwise.  (alias
  **group**).
  T}
  
  eip	EIP	T{
  instruction pointer.
  T}
  
  esp	ESP	T{
  stack pointer.
  T}
  
  etime	ELAPSED	T{
  elapsed time since the process was started, in the form [[DD-]hh:]mm:ss.
  T}
  
  etimes	ELAPSED	T{
  elapsed time since the process was started, in seconds.
  T}
  
  euid	EUID	T{
  effective user ID (alias
  **uid**).
  T}
  
  euser	EUSER	T{
  effective user name.  This will be the textual user ID, if it can be obtained
  and the field width permits, or a decimal representation otherwise.  The
  **n**
  option can be used to force the decimal representation.  (alias
  **uname**,**&nbsp;**user**).**
  T}
  
  f	F	T{
  flags associated with the process, see the
  **PROCESS FLAGS**
  section.  (alias
  **flag**,**&nbsp;flags**).
  T}
  
  fgid	FGID	T{
  filesystem access group&nbsp;ID.  (alias
  **fsgid**).
  T}
  
  fgroup	FGROUP	T{
  filesystem access group ID.  This will be the textual group ID, if it can
  be obtained and the field width permits, or a decimal representation
  otherwise.  (alias
  **fsgroup**).
  T}
  
  flag	F	T{
  see
  **f**.
  (alias
  **f**,**&nbsp;flags**).
  T}
  
  flags	F	T{
  see
  **f**.
  (alias
  **f**,**&nbsp;flag**).
  T}
  
  fname	COMMAND	T{
  first 8 bytes of the base name of the process's executable file.  The output
  in this column may contain spaces.
  T}
  
  fuid	FUID	T{
  filesystem access user ID.  (alias
  **fsuid**).
  T}
  
  fuser	FUSER	T{
  filesystem access user ID.  This will be the textual user ID, if it can be
  obtained and the field width permits, or a decimal representation otherwise.
  T}
  
  gid	GID	T{
  see
  **egid**.
  (alias
  **egid**).
  T}
  
  group	GROUP	T{
  see
  **egroup**.
  (alias
  **egroup**).
  T}
  
  ignored	IGNORED	T{
  mask of the ignored signals, see
  _signal_(7).
  According to the width of the field, a 32 or 64 bits mask in hexadecimal
  format is displayed.  (alias
  **sig_ignore**,**&nbsp;sigignore**).
  T}
  
  ipcns	IPCNS	T{
  Unique inode number describing the namespace the process belongs to. See namespaces(7).
  T}
  
  label	LABEL	T{
  security label, most commonly used for SELinux context data.  This is for
  the
  _Mandatory Access Control_
  ("MAC") found on high-security systems.
  T}
  
  lstart	STARTED	T{
  time the command started.  See also
  **bsdstart**,**&nbsp;start**,**&nbsp;start_time**, and**&nbsp;stime**.
  T}
  
  lsession	SESSION	T{
  displays the login session identifier of a process,
  if systemd support has been included.
  T}
  
  luid	LUID	T{
  displays Login ID associated with a process.
  T}
  
  lwp	LWP	T{
  light weight process (thread) ID of the dispatchable entity (alias
  **spid**,**&nbsp;tid**).
  See
  **tid**
  for additional information.
  T}
  
  lxc	LXC	T{
  The name of the lxc container within which a task is running.
  If a process is not running inside a container, a dash ('-') will be shown.
  T}
  
  machine	MACHINE	T{
  displays the machine name for processes assigned to VM or container,
  if systemd support has been included.
  T}
  
  maj_flt	MAJFLT	T{
  The number of major page faults that have occurred with this process.
  T}
  
  min_flt	MINFLT	T{
  The number of minor page faults that have occurred with this process.
  T}
  
  mntns	MNTNS	T{
  Unique inode number describing the namespace the process belongs to. See namespaces(7).
  T}
  
  netns	NETNS	T{
  Unique inode number describing the namespace the process belongs to. See namespaces(7).
  T}
  
  ni	NI	T{
  nice value. This ranges from 19 (nicest) to -20 (not nice to others),
  see
  _nice_(1).
  (alias
  **nice**).
  T}
  
  nice	NI	T{
  see
  **ni**.**(alias**
  **ni**).
  T}
  
  nlwp	NLWP	T{
  number of lwps (threads) in the process.  (alias
  **thcount**).
  T}
  
  numa	NUMA	T{
  The node assocated with the most recently used processor.
  A -1 means that NUMA information is unavailable.
  T}
  
  nwchan	WCHAN	T{
  address of the kernel function where the process is sleeping (use
  **wchan**
  if you want the kernel function name).  Running tasks will display a dash
  ('-') in this column.
  T}
  
  ouid	OWNER	T{
  displays the Unix user identifier of the owner of the session of a process,
  if systemd support has been included.
  T}
  
  pcpu	%CPU	T{
  see
  **%cpu**.
  (alias
  **%cpu**).
  T}
  
  pending	PENDING	T{
  mask of the pending signals. See
  _signal_(7).
  Signals pending on the process are distinct from signals pending on
  individual threads.  Use the
  **m**
  option or the
  **-m**
  option to see both.  According to the width of the field, a 32 or 64 bits
  mask in hexadecimal format is displayed.  (alias
  **sig**).
  T}
  
  pgid	PGID	T{
  process group ID or, equivalently, the process ID of the process group
  leader.  (alias
  **pgrp**).
  T}
  
  pgrp	PGRP	T{
  see
  **pgid**.
  (alias
  **pgid**).
  T}
  
  pid	PID	T{
  a number representing the process ID (alias
  **tgid**).
  T}
  
  pidns	PIDNS	T{
  Unique inode number describing the namespace the process belongs to. See namespaces(7).
  T}
  
  pmem	%MEM	T{
  see
  **%mem**.
  (alias
  **%mem**).
  T}
  
  policy	POL	T{
  scheduling class of the process.  (alias
  **class**,**&nbsp;cls**).
  Possible values are:
* ""  
  -	not reported  
  TS	SCHED_OTHER  
  FF	SCHED_FIFO  
  RR	SCHED_RR  
  B	SCHED_BATCH  
  ISO	SCHED_ISO  
  IDL	SCHED_IDLE  
  DLN	SCHED_DEADLINE  
  ?	unknown value
  T}
  
  ppid	PPID	T{
  parent process ID.
  T}
  
  pri	PRI	T{
  priority of the process.  Higher number means lower priority.
  T}
  
  psr	PSR	T{
  processor that process is currently assigned to.
  T}
  
  rgid	RGID	T{
  real group ID.
  T}
  
  rgroup	RGROUP	T{
  real group name.  This will be the textual group ID, if it can be obtained
  and the field width permits, or a decimal representation otherwise.
  T}
  
  rss	RSS	T{
  resident set size, the non-swapped physical memory that a task has used (in
  kiloBytes).  (alias
  **rssize**,**&nbsp;rsz**).
  T}
  
  rssize	RSS	T{
  see
  **rss**.
  (alias
  **rss**,**&nbsp;rsz**).
  T}
  
  rsz	RSZ	T{
  see
  **rss**.
  (alias
  **rss**,**&nbsp;rssize**).
  T}
  
  rtprio	RTPRIO	T{
  realtime priority.
  T}
  
  ruid	RUID	T{
  real user ID.
  T}
  
  ruser	RUSER	T{
  real user ID.  This will be the textual user ID, if it can be obtained and
  the field width permits, or a decimal representation otherwise.
  T}
  
  s	S	T{
  minimal state display (one character).  See section
  **PROCESS STATE CODES**
  for the different values.  See also
  **stat**
  if you want additional information displayed.  (alias
  **state**).
  T}
  
  sched	SCH	T{
  scheduling policy of the process.  The policies SCHED_OTHER (SCHED_NORMAL),
  SCHED_FIFO, SCHED_RR, SCHED_BATCH, SCHED_ISO, SCHED_IDLE and SCHED_DEADLINE are
  respectively displayed as 0, 1, 2, 3, 4, 5 and 6.
  T}
  
  seat	SEAT	T{
  displays the identifier associated with all hardware devices assigned
  to a specific workplace,
  if systemd support has been included.
  T}
  
  sess	SESS	T{
  session ID or, equivalently, the process ID of the session leader.  (alias
  **session**,**&nbsp;sid**).
  T}
  
  sgi_p	P	T{
  processor that the process is currently executing on.  Displays "*" if the
  process is not currently running or runnable.
  T}
  
  sgid	SGID	T{
  saved group ID.  (alias
  **svgid**).
  T}
  
  sgroup	SGROUP	T{
  saved group name.  This will be the textual group ID, if it can be obtained
  and the field width permits, or a decimal representation otherwise.
  T}
  
  sid	SID	T{
  see
  **sess**.
  (alias
  **sess**,**&nbsp;session**).
  T}
  
  sig	PENDING	T{
  see
  **pending**.
  (alias
  **pending**,**&nbsp;sig_pend**).
  T}
  
  sigcatch	CAUGHT	T{
  see
  **caught**.
  (alias
  **caught**,**&nbsp;sig_catch**).
  T}
  
  sigignore	IGNORED	T{
  see
  **ignored**.
  (alias
  **ignored**,**&nbsp;sig_ignore**).
  T}
  
  sigmask	BLOCKED	T{
  see
  **blocked**.
  (alias
  **blocked**,**&nbsp;sig_block**).
  T}
  
  size	SIZE	T{
  approximate amount of swap space that would be required if the process were
  to dirty all writable pages and then be swapped out.  This number is very
  rough!
  T}
  
  slice	SLICE	T{
  displays the slice unit which a process belongs to,
  if systemd support has been included.
  T}
  
  spid	SPID	T{
  see
  **lwp**.
  (alias
  **lwp**,**&nbsp;tid**).
  T}
  
  stackp	STACKP	T{
  address of the bottom (start) of stack for the process.
  T}
  
  start	STARTED	T{
  time the command started.  If the process was started less than 24 hours ago,
  the output format is "HH:MM:SS", else it is "&nbsp;&nbsp;Mmm&nbsp;dd" (where Mmm is a
  three-letter month name).  See also
  **lstart**,**&nbsp;bsdstart**,**&nbsp;start_time**, and**&nbsp;stime**.
  T}
  
  start_time	START	T{
  starting time or date of the process.  Only the year will be displayed if the
  process was not started the same year
  **ps**
  was invoked, or "MmmDD" if it was not started the same day, or "HH:MM"
  otherwise.  See also
  **bsdstart**,**&nbsp;start**,**&nbsp;lstart**, and**&nbsp;stime**.
  T}
  
  stat	STAT	T{
  multi-character process state.  See section
  **PROCESS STATE CODES**
  for the different values meaning.  See also
  **s**&nbsp;and**&nbsp;state**
  if you just want the first character displayed.
  T}
  
  state	S	T{
  see
  **s**. (alias**&nbsp;s**).
  T}
  
  suid	SUID	T{
  saved user ID.  (alias
  **svuid**).
  T}
  
  supgid	SUPGID	T{
  group ids of supplementary groups, if any.  See
  **getgroups**(2).
  T}
  
  supgrp	SUPGRP	T{
  group names of supplementary groups, if any.  See
  **getgroups**(2).
  T}
  
  suser	SUSER	T{
  saved user name.  This will be the textual user ID, if it can be obtained and
  the field width permits, or a decimal representation otherwise.  (alias
  **svuser**).
  T}
  
  svgid	SVGID	T{
  see
  **sgid**.
  (alias
  **sgid**).
  T}
  
  svuid	SVUID	T{
  see
  **suid**.
  (alias
  **suid**).
  T}
  
  sz	SZ	T{
  size in physical pages of the core image of the process.  This includes text,
  data, and stack space.  Device mappings are currently excluded; this is
  subject to change.  See
  **vsz**&nbsp;and**&nbsp;rss**.
  T}
  
  tgid	TGID	T{
  a number representing the thread group to which a task belongs (alias
  **pid**).
  It is the process ID of the thread group leader.
  T}
  
  thcount	THCNT	T{
  see
  **nlwp**.
  (alias
  **nlwp**).
  number of kernel threads owned by the process.
  T}
  
  tid	TID	T{
  the unique number representing a dispatchable entity (alias
  **lwp**,**&nbsp;spid**).
  This value may also appear as: a process ID (pid); a process group ID (pgrp);
  a session ID for the session leader (sid); a thread group ID for the thread
  group leader (tgid); and a tty process group ID for the process group leader
  (tpgid).
  T}
  
  time	TIME	T{
  cumulative CPU&nbsp;time, "[DD-]HH:MM:SS" format.  (alias
  **cputime**).
  T}
  
  times	TIME	T{
  cumulative CPU&nbsp;time in seconds (alias
  **cputimes**).
  T}
  
  tname	TTY	T{
  controlling tty (terminal).  (alias
  **tt**,**&nbsp;tty**).
  T}
  
  tpgid	TPGID	T{
  ID of the foreground process group on the tty (terminal) that the process is
  connected to, or -1 if the process is not connected to a tty.
  T}
  
  trs	TRS	T{
  text resident set size, the amount of physical memory devoted to executable code.
  T}
  
  tt	TT	T{
  controlling tty (terminal).  (alias
  **tname**,**&nbsp;tty**).
  T}
  
  tty	TT	T{
  controlling tty (terminal).  (alias
  **tname**,**&nbsp;tt**).
  T}
  
  ucmd	CMD	T{
  see
  **comm**.
  (alias
  **comm**,**&nbsp;ucomm**).
  T}
  
  ucomm	COMMAND	T{
  see
  **comm**.
  (alias
  **comm**,**&nbsp;ucmd**).
  T}
  
  uid	UID	T{
  see
  **euid**.
  (alias
  **euid**).
  T}
  
  uname	USER	T{
  see
  **euser**.
  (alias
  **euser**,**&nbsp;user**).
  T}
  
  unit	UNIT	T{
  displays unit which a process belongs to,
  if systemd support has been included.
  T}
  
  user	USER	T{
  see
  **euser**.
  (alias
  **euser**,**&nbsp;uname**).
  T}
  
  userns	USERNS	T{
  Unique inode number describing the namespace the process belongs to. See namespaces(7).
  T}
  
  utsns	UTSNS	T{
  Unique inode number describing the namespace the process belongs to. See namespaces(7).
  T}
  
  uunit	UUNIT	T{
  displays user unit which a process belongs to,
  if systemd support has been included.
  T}
  
  vsize	VSZ	T{
  see
  **vsz**.
  (alias
  **vsz**).
  T}
  
  vsz	VSZ	T{
  virtual memory size of the process in KiB (1024-byte units).  Device
  mappings are currently excluded; this is subject to change.  (alias
  **vsize**).
  T}
  
  wchan	WCHAN	T{
  name of the kernel function in which the process is sleeping, a "-" if the
  process is running, or a "*" if the process is multi-threaded and
  **ps**
  is not displaying threads.
  T}
  
  .TE
  



<a name="environment-variables"></a>

# Environment Variables

The following environment variables could affect
**ps**:

* **COLUMNS**  
  Override default display width.
* **LINES**  
  Override default display height.
* **PS_PERSONALITY**  
  Set to one of posix, old, linux, bsd, sun, digital...  (see section
  **PERSONALITY**
  below).
* **CMD_ENV**  
  Set to one of posix, old, linux, bsd, sun, digital...  (see section
  **PERSONALITY**
  below).
* **I_WANT_A_BROKEN_PS**  
  Force obsolete command line interpretation.
* **LC_TIME**  
  Date format.
* **PS_COLORS**  
  Not currently supported.
* **PS_FORMAT**  
  Default output format override. You may set this to a format
  string of the type used for the
  **-o**
  option.
  The
  **DefSysV**
  and
  **DefBSD**
  values are particularly useful.
* **POSIXLY_CORRECT**  
  Don't find excuses to ignore bad "features".
* **POSIX2**  
  When set to "on", acts as
  **POSIXLY_CORRECT**.
* **UNIX95**  
  Don't find excuses to ignore bad "features".
* **_XPG**  
  Cancel **CMD\_ENV**=_irix_ non-standard behavior.

In general, it is a bad idea to set these variables.  The one exception is
**CMD_ENV**
or
**PS_PERSONALITY**,
which could be set to Linux for normal systems.  Without that setting,
**ps**
follows the useless and bad parts of the Unix98 standard.


<a name="personality"></a>

# Personality

.TS
l	l.
390	like the OS/390 OpenEdition **ps**
aix	like AIX **ps**
bsd	like FreeBSD **ps** (totally non-standard)
compaq	like Digital Unix **ps**
debian	like the old Debian **ps**
digital	like Tru64 (was Digital&nbsp;Unix, was OSF/1) **ps**
gnu	like the old Debian **ps**
hp	like HP-UX **ps**
hpux	like HP-UX **ps**
irix	like Irix **ps**
linux	***** **recommended** *****
old	like the original Linux **ps** (totally non-standard)
os390	like OS/390 Open Edition **ps**
posix	standard
s390	like OS/390 Open Edition **ps**
sco	like SCO **ps**
sgi	like Irix **ps**
solaris2	like Solaris 2+ (SunOS 5) **ps**
sunos4	like SunOS 4 (Solaris 1) **ps** (totally non-standard)
svr4	standard
sysv	standard
tru64	like Tru64 (was Digital Unix, was OSF/1) **ps**
unix	standard
unix95	standard
unix98	standard
.TE



<a name="see-also"></a>

# See Also

**pgrep**(1),
**pstree**(1),
**top**(1),
**proc**(5).



<a name="standards"></a>

# Standards

This
**ps**
conforms to:


* 1  
  Version 2 of the Single Unix Specification
* 2  
  The Open Group Technical Standard Base Specifications, Issue&nbsp;6
* 3  
  IEEE Std 1003.1, 2004&nbsp;Edition
* 4  
  X/Open System Interfaces Extension [UP&nbsp;XSI]
* 5  
  ISO/IEC 9945:2003


<a name="author"></a>

# Author

**ps**
was originally written by
.UR lankeste@​fwi.​uva.​nl
Branko Lankester
.UE .
.UR johnsonm@​redhat.​com
Michael K. Johnson
.UE
re-wrote it significantly to use the proc filesystem, changing a few things
in the process.
.UR mjshield@​nyx.​cs.​du.​edu
Michael Shields
.UE
added the pid-list feature.
.UR cblake@​bbn.​com
Charles Blake
.UE
added multi-level sorting, the dirent-style library, the device
name-to-number mmaped database, the approximate binary search directly on
System.map, and many code and documentation cleanups.  David Mossberger-Tang
wrote the generic BFD support for psupdate.
.UR albert@​users.​sf.​net
Albert Cahalan
.UE
rewrote ps for full Unix98 and BSD support, along with some ugly hacks for
obsolete and foreign syntax.

Please send bug reports to
.UR procps@​freelists.​org
.UE .
No subscription is required or suggested.
