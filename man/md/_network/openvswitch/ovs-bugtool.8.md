# ovs\-bugtool(8)

Open vSwitch, 2.10.1


<a name="name"></a>

# Name

ovs-bugtool - Open vSwitch bug reporting utility

<a name="synopsis"></a>

# Synopsis

```
ovs-bugtool
```

<a name="description"></a>

# Description

Generates a debug bundle with useful information about Open vSwitch on this
system and places it in **/var/log/ovs-bugtool**.

<a name="collection-options"></a>

# Collection Options


These options influence what categories of data **ovs-bugtool**
collects.

* **--entries=list**  
  Collect the capabilities specified in the comma-separated _list_.
* **--all**  
  Collect all available capabilities.
* **--ovs**  
  In addition to Open vSwitch configuration and status,
  **ovs-bugtool** can collect a variety of relevant system
  information.  This option limits collection to Open vSwitch-specific
  categories.
* **--log-days=days**  
  Include the logs with last modification time in the previous _days_ days
  in the debug bundle. The number of log files included has a big impact on the
  eventual bundle size. The default value is 20 days.
* **-y**  
  .IQ "**--yestoall**"
  Answer yes to all prompts.
* **--capabilities**  
  Writes the categories that **ovs-bugtool** can collect on stdout in
  XML, then exits.

<a name="output-options"></a>

# Output Options


These options influence the format and destination of
**ovs-bugtool** output.

* **--output=filetype**  
  Generates a debug bundle with the specified file type.  Options include
  **tar**, **tar.gz**, **tar.bz2**, and **zip**.
* **--outfile=file**  
  Write output to _file_.  Mutually exclusive with **--outfd**.
* **--outfd=fd**  
  Write output to file descriptor _fd_.  This option must be used
  with **--output=tar**.
* **--unlimited**  
  Do not exclude files which are too large. Also skip checking free disk space.
  By default up to 90 percent of the free disk space can be used.
* **--debug**  
  Print verbose debugging output.

<a name="other-options"></a>

# Other Options


* **-s**  
  .IQ "**--silent**"
  Suppress most output to stdout.
* **--help**  
  Print a summary of **ovs-bugtool** usage to stdout, then exit.

<a name="examples"></a>

# Examples


Here's a collection of some commonly useful options:

**ovs-bugtool -y -s --output=tar.gz --outfile=/var/log/bugtool-report.tgz**

<a name="bugs"></a>

# Bugs

**ovs-bugtool** makes many assumptions about file locations and the
availability of system utilities.  It has been tested on Debian and
Red Hat and derived distributions.  On other distributions it is
likely to be less useful.
