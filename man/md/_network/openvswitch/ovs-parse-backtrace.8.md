# ovs\-parse\-backtrace(8)

Open vSwitch, October 2012


<a name="name"></a>

# Name

ovs-parse-backtrace - parses ovs-appctl backtrace output

<a name="synopsis"></a>

# Synopsis

```
ovs-appctl backtrace | ovs-parse-backtrace [binary] 
 ovs-parse-backtrace [binary] < backtrace
```

<a name="description"></a>

# Description

In some configurations, many Open vSwitch daemons can produce a series of
backtraces using the **ovs-appctl backtrace** command.  Users can analyze
these backtraces to figure out what the given Open vSwitch daemon may be
spending most of its time doing.  **ovs-parse-backtrace** makes this output
easier to interpret.

The **ovs-appctl backtrace** output must be supplied on standard input.  The
binary that produced the output should be supplied as the sole non-option
argument.  For best results, the binary should have debug symbols.

<a name="options"></a>

# Options


* **--help**  
  Prints a usage message and exits.

**--version**
Prints the version and exits.
