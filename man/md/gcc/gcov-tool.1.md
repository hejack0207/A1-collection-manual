# gcov-tool(1)

gcc-9, 2019-03-12

.if n .ad l
.nh

<a name="name"></a>

# Name

gcov-tool - offline gcda profile processing tool

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" gcov-tool [-v|--version] [-h|--help] 
 gcov-tool merge [merge-options] directory1 directory2      [-o|--output directory]      [-v|--verbose]      [-w|--weight w1,w2] 
 gcov-tool rewrite [rewrite-options] directory      [-n|--normalize long_long_value]      [-o|--output directory]      [-s|--scale float_or_simple-frac_value]      [-v|--verbose] 
 gcov-tool overlap [overlap-options] directory1 directory2      [-f|--function]      [-F|--fullname]      [-h|--hotonly]      [-o|--object]      [-t|--hot_threshold] float      [-v|--verbose]
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**gcov-tool** is an offline tool to process gcc's gcda profile files.

Current gcov-tool supports the following functionalities:

* *  
  merge two sets of profiles with weights.
* *  
  read one set of profile and rewrite profile contents. One can scale or
  normalize the count values.

Examples of the use cases for this tool are:

* *  
  Collect the profiles for different set of inputs, and use this tool to merge
  them. One can specify the weight to factor in the relative importance of
  each input.
* *  
  Rewrite the profile after removing a subset of the gcda files, while maintaining
  the consistency of the summary and the histogram.
* *  
  It can also be used to debug or libgcov code as the tools shares the majority
  code as the runtime library.

Note that for the merging operation, this profile generated offline may
contain slight different values from the online merged profile. Here are
a list of typical differences:

* *  
  histogram difference: This offline tool recomputes the histogram after merging
  the counters. The resulting histogram, therefore, is precise. The online
  merging does not have this capability  the histogram is merged from two
  histograms and the result is an approximation.
* *  
  summary checksum difference: Summary checksum uses a \s-1CRC32\s0 operation. The value
  depends on the link list order of gcov-info objects. This order is different in
  gcov-tool from that in the online merge. It's expected to have different
  summary checksums. It does not really matter as the compiler does not use this
  checksum anywhere.
* *  
  value profile counter values difference: Some counter values for value profile
  are runtime dependent, like heap addresses. It's normal to see some difference
  in these kind of counters.

<a name="options"></a>

# Options

.IX Header "OPTIONS"

* **-h**  
  .IX Item "-h"
* **--help**  
  .IX Item "--help"
  Display help about using **gcov-tool** (on the standard output), and
  exit without doing any further processing.
* **-v**  
  .IX Item "-v"
* **--version**  
  .IX Item "--version"
  Display the **gcov-tool** version number (on the standard output),
  and exit without doing any further processing.
* **merge**  
  .IX Item "merge"
  Merge two profile directories.
    * **-o** _directory_  
      .IX Item "-o directory"
    * **--output** _directory_  
      .IX Item "--output directory"
      Set the output profile directory. Default output directory name is
      _merged\_profile_.
    * **-v**  
      .IX Item "-v"
    * **--verbose**  
      .IX Item "--verbose"
      Set the verbose mode.
    * **-w** _w1_**,**_w2_  
      .IX Item "-w w1,w2"
    * **--weight** _w1_**,**_w2_  
      .IX Item "--weight w1,w2"
      Set the merge weights of the _directory1_ and _directory2_,
      respectively. The default weights are 1 for both.
* **rewrite**  
  .IX Item "rewrite"
  Read the specified profile directory and rewrite to a new directory.
    * **-n** _long\_long\_value_  
      .IX Item "-n long_long_value"
    * **--normalize &lt;long\_long\_value&gt;**  
      .IX Item "--normalize &lt;long_long_value&gt;"
      Normalize the profile. The specified value is the max counter value
      in the new profile.
    * **-o** _directory_  
      .IX Item "-o directory"
    * **--output** _directory_  
      .IX Item "--output directory"
      Set the output profile directory. Default output name is _rewrite\_profile_.
    * **-s** _float\_or\_simple-frac\_value_  
      .IX Item "-s float_or_simple-frac_value"
    * **--scale** _float\_or\_simple-frac\_value_  
      .IX Item "--scale float_or_simple-frac_value"
      Scale the profile counters. The specified value can be in floating point value,
      or simple fraction value form, such 1, 2, 2/3, and 5/3.
    * **-v**  
      .IX Item "-v"
    * **--verbose**  
      .IX Item "--verbose"
      Set the verbose mode.
* **overlap**  
  .IX Item "overlap"
  Compute the overlap score between the two specified profile directories.
  The overlap score is computed based on the arc profiles. It is defined as
  the sum of min (p1_counter[i] / p1_sum_all, p2_counter[i] / p2_sum_all),
  for all arc counter i, where p1_counter[i] and p2_counter[i] are two
  matched counters and p1_sum_all and p2_sum_all are the sum of counter
  values in profile 1 and profile 2, respectively.
    * **-f**  
      .IX Item "-f"
    * **--function**  
      .IX Item "--function"
      Print function level overlap score.
    * **-F**  
      .IX Item "-F"
    * **--fullname**  
      .IX Item "--fullname"
      Print full gcda filename.
    * **-h**  
      .IX Item "-h"
    * **--hotonly**  
      .IX Item "--hotonly"
      Only print info for hot objects/functions.
    * **-o**  
      .IX Item "-o"
    * **--object**  
      .IX Item "--object"
      Print object level overlap score.
    * **-t** _float_  
      .IX Item "-t float"
    * **--hot_threshold &lt;float&gt;**  
      .IX Item "--hot_threshold &lt;float&gt;"
      Set the threshold for hot counter value.
    * **-v**  
      .IX Item "-v"
    * **--verbose**  
      .IX Item "--verbose"
      Set the verbose mode.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**gpl**\|(7), **gfdl**\|(7), **fsf-funding**\|(7), **gcc**\|(1), **gcov**\|(1) and the Info entry for
_gcc_.

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright (c) 2014-2019 Free Software Foundation, Inc.

Permission is granted to copy, distribute and/or modify this document
under the terms of the \s-1GNU\s0 Free Documentation License, Version 1.3 or
any later version published by the Free Software Foundation; with the
Invariant Sections being \s-1GNU\s0 General Public License\*(R" and \*(L"Funding
Free Software, the Front-Cover texts being (a) (see below), and with
the Back-Cover Texts being (b) (see below).  A copy of the license is
included in the **gfdl**\|(7) man page.

(a) The \s-1FSF\s0's Front-Cover Text is:

.Vb 1
     A GNU Manual
.Ve

(b) The \s-1FSF\s0's Back-Cover Text is:

.Vb 3
     You have freedom to copy and modify this GNU Manual, like GNU
     software.  Copies published by the Free Software Foundation raise
     funds for GNU development.
.Ve
