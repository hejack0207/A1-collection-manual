# perf\-diff(1)

perf, 04/24/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

perf-diff - Read perf.data files and display the differential profile

<a name="synopsis"></a>

# Synopsis

```


```
    perf diff [baseline file] [data file1] [[data file2] ... ]

<a name="description"></a>

# Description


This command displays the performance difference amongst two or more perf.data files captured via perf record.

If no parameters are passed it will assume perf.data.old and perf.data.

The differential profile is displayed only for events matching both specified perf.data files.

If no parameters are passed the samples will be sorted by dso and symbol. As the perf.data files could come from different binaries, the symbols addresses could vary. So perf diff is based on the comparison of the files and symbols name.

<a name="options"></a>

# Options


-D, --dump-raw-trace
Dump raw trace in ASCII.

--kallsyms=&lt;file&gt;
kallsyms pathname

-m, --modules
Load module symbols. WARNING: use only with -k and LIVE kernel

-d, --dsos=
Only consider symbols in these dsos. CSV that understands
\m[blue]**file://filename**\m[]
entries. This option will affect the percentage of the Baseline/Delta column. See --percentage for more info.

-C, --comms=
Only consider symbols in these comms. CSV that understands
\m[blue]**file://filename**\m[]
entries. This option will affect the percentage of the Baseline/Delta column. See --percentage for more info.

-S, --symbols=
Only consider these symbols. CSV that understands
\m[blue]**file://filename**\m[]
entries. This option will affect the percentage of the Baseline/Delta column. See --percentage for more info.

-s, --sort=
Sort by key(s): pid, comm, dso, symbol, cpu, parent, srcline. Please see description of --sort in the perf-report man page.

-t, --field-separator=
Use a special separator character and don’t pad with spaces, replacing all occurrences of this separator in symbol names (and other output) with a
_._
character, that thus it’s the only non valid separator.

-v, --verbose
Be verbose, for instance, show the raw counts in addition to the diff.

-q, --quiet
Do not show any message. (Suppress -v)

-f, --force
Don’t do ownership validation.

--symfs=&lt;directory&gt;
Look for files with symbols relative to this directory.

-b, --baseline-only
Show only items with match in baseline.

-c, --compute
Differential computation selection - delta, ratio, wdiff, cycles, delta-abs (default is delta-abs). Default can be changed using diff.compute config option. See COMPARISON METHODS section for more info.

--cycles-hist
Report a histogram and the standard deviation for cycles data. It can help us to judge if the reported cycles data is noisy or not. This option should be used with
_-c cycles_.

-p, --period
Show period values for both compared hist entries.

-F, --formula
Show formula for given computation.

-o, --order
Specify compute sorting column number. 0 means sorting by baseline overhead and 1 (default) means sorting by computed value of column 1 (data from the first file other base baseline). Values more than 1 can be used only if enough data files are provided. The default value can be set using the diff.order config option.

--percentage
Determine how to display the overhead percentage of filtered entries. Filters can be applied by --comms, --dsos and/or --symbols options.

.if n \{.RS 4
.\}
    "relative" means its relative to filtered entries only so that the
    sum of shown entries will be always 100%.  "absolute" means it retains
    the original value before and after the filter is applied.
.if n \{.RE
.\}

--time
Analyze samples within given time window. It supports time percent with multiple time ranges. Time string is
_a%/n,b%/m,..._
or
_a%-b%,c%-%d,..._.

.if n \{.RS 4
.\}
    For example:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Select the second 10% time slice to diff:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf diff --time 10%/2
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Select from 0% to 10% time slice to diff:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf diff --time 0%-10%
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Select the first and the second 10% time slices to diff:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf diff --time 10%/1,10%/2
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    Select from 0% to 10% and 30% to 40% slices to diff:
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf diff --time 0%-10%,30%-40%
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    It also supports analyzing samples within a given time window
    <start>,<stop>. Times have the format seconds.nanoseconds. If start*(Aq
    is not given (i.e. time string is ,x.y*(Aq) then analysis starts at
    the beginning of the file. If stop time is not given (i.e. time
    string is x.y,*(Aq) then analysis goes to the end of the file.
    Multiple ranges can be separated by spaces, which requires the argument
    to be quoted e.g. --time "1234.567,1234.789 1235,"
    Time string isa1.b1,c1.d1:a2.b2,c2.d2*(Aq. Use *(Aq:*(Aq to separate timestamps
    for different perf.data files.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    For example, we get the timestamp information from perf script*(Aq.
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf script -i perf.data.old
      mgen 13940 [000]  3946.361400: ...
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf script -i perf.data
      mgen 13940 [000]  3971.150589 ...
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    perf diff --time 3946.361400,:3971.150589,
.if n \{.RE
.\}

.if n \{.RS 4
.\}
    It analyzes the perf.data.old from the timestamp 3946.361400 to
    the end of perf.data.old and analyzes the perf.data from the
    timestamp 3971.150589 to the end of perf.data.
.if n \{.RE
.\}

--cpu
Only diff samples for the list of CPUs provided. Multiple CPUs can be provided as a comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-2. Default is to report samples on all CPUs.

--pid=
Only diff samples for given process ID (comma separated list).

--tid=
Only diff samples for given thread ID (comma separated list).

<a name="comparison"></a>

# Comparison


The comparison is governed by the baseline file. The baseline perf.data file is iterated for samples. All other perf.data files specified on the command line are searched for the baseline sample pair. If the pair is found, specified computation is made and result is displayed.

All samples from non-baseline perf.data files, that do not match any baseline entry, are displayed with empty space within baseline column and possible computation results (delta) in their related column.

Example files samples: - file A with samples f1, f2, f3, f4, f6 - file B with samples f2, f4, f5 - file C with samples f1, f2, f5

Example output: x - computation takes place for pair b - baseline sample percentage

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  perf diff A B C

.if n \{.RS 4
.\}
    baseline/A compute/B compute/C  samples
    ---------------------------------------
    b                    x          f1
    b          x         x          f2
    b                               f3
    b          x                    f4
    b                               f6
               x         x          f5
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  perf diff B A C

.if n \{.RS 4
.\}
    baseline/B compute/A compute/C  samples
    ---------------------------------------
    b          x         x          f2
    b          x                    f4
    b                    x          f5
               x         x          f1
               x                    f3
               x                    f6
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  perf diff C B A

.if n \{.RS 4
.\}
    baseline/C compute/B compute/A  samples
    ---------------------------------------
    b                    x          f1
    b          x         x          f2
    b          x                    f5
                         x          f3
               x         x          f4
                         x          f6
.if n \{.RE
.\}

<a name="comparison-methods"></a>

# Comparison Methods


<a name="delta"></a>

### delta


If specified the _Delta_ column is displayed with value _d_ computed as:

.if n \{.RS 4
.\}
    d = A->period_percent - B->period_percent
.if n \{.RE
.\}

with: - A/B being matching hist entry from data/baseline file specified (or perf.data/perf.data.old) respectively.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  period_percent being the % of the hist entry period value within single data file

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  with filtering by -C, -d and/or -S, period_percent might be changed relative to how entries are filtered. Use --percentage=absolute to prevent such fluctuation.

<a name="delta-abs"></a>

### delta\-abs


Same as delta\` method, but sort the result with the absolute values.

<a name="ratio"></a>

### ratio


If specified the _Ratio_ column is displayed with value _r_ computed as:

.if n \{.RS 4
.\}
    r = A->period / B->period
.if n \{.RE
.\}

with: - A/B being matching hist entry from data/baseline file specified (or perf.data/perf.data.old) respectively.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  period being the hist entry period value

<a name="wdiffweight-bweight-a"></a>

### wdiff:WEIGHT\-B,WEIGHT\-A


If specified the _Weighted diff_ column is displayed with value _d_ computed as:

.if n \{.RS 4
.\}
    d = B->period * WEIGHT-A - A->period * WEIGHT-B
.if n \{.RE
.\}

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  A/B being matching hist entry from data/baseline file specified (or perf.data/perf.data.old) respectively.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  period being the hist entry period value

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  WEIGHT-A/WEIGHT-B being user supplied weights in the the
  _-c_
  option behind
  _:_
  separator like
  _-c wdiff:1,2_.

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  WEIGHT-A being the weight of the data file

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  WEIGHT-B being the weight of the baseline data file

<a name="cycles"></a>

### cycles


If specified the _[Program Block Range] Cycles Diff_ column is displayed. It displays the cycles difference of same program basic block amongst two perf.data. The program basic block is the code between two branches.

_[Program Block Range]_ indicates the range of a program basic block. Source line is reported if it can be found otherwise uses symbol+offset instead.

<a name="see-also"></a>

# See Also


**perf-record**(1), **perf-report**(1)
