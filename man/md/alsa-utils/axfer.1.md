# axfer(1) - command\-line sound recorder and player for sound devices and nodes

alsa\-utils, 28 November 2018

supported by Linux sound subsystem (Advanced Linux Sound Architecture, also
known as ALSA).


<a name="synopsys"></a>

# Synopsys


**axfer**
_subcommand direction options_

subcommand =
**transfer**
|
**list**
|
**version**
|
**help**

direction =
**capture**
|
**playback**

options = ( depends on
_subcommand_
)


<a name="description"></a>

# Description

The
**axfer**
is a command-line recorder and player to transfer audio data frame between
sound devices/nodes and files/stdin/stdout.


<a name="options"></a>

# Options



<a name="subcommand"></a>

### Subcommand



* **transfer**  
  Performs transmission of audio data frame. Its detail is described in
  **axfer-transfer(1)**
  manual.
  
* **list**  
  Dumps lists of available sound devices and nodes. Its detail is described in
  **axfer-list(1)**
  manual.
  
* **version**  
  Prints version of this application (as the same version as alsa-utils package).
  
* **help**  
  Prints a short message about subcommands for users to enter this application.
  

<a name="direction"></a>

### Direction



* **capture**  
  Operates for capture transmission.
  
* **playback**  
  Operates for playback transmission.
  

<a name="exit-status"></a>

# Exit Status


_EXIT_SUCCESS_
(0) if run time successfully finished, else
_EXIT_FAILURE_
(1).


<a name="unit-test"></a>

# Unit Test


This program has unit tests for internal implementation. Please refer to the
manual of
_axfer-transfer_
for details.


<a name="compatibility-to-aplay"></a>

# Compatibility to Aplay


The
_axfer_
is designed to be compatible to aplay(1) as much as possible. In command line,
executions of aplay/arecord files under $PATH runs axfer with compatibility
mode if filesystem has symbolic link from the aplay/arecord to axfer.


.in +4n
.EX
$ ln -s aplay axfer
$ ln -s arecord axfer
.EE
.in



<a name="a-string-to-which-arg0-points"></a>

### A string to which arg[0] points

When args[0] in run time points to string ended with 'aplay', it has the
same meaning of
_playback_
direction. When it points to string ended with 'arecord', it has the same
meaning of
_capture_
direction.


<a name="options-acknowledged-as-list-subcommand"></a>

### Options acknowledged as list subcommand

Options of
_-l_
,
_--list-devices_
,
_-L_
,
_--list-pcms_
are acknowledged as
_list_
subcommand. Without them, the run time performs
_transfer_
subcommand.


<a name="reporting-bugs"></a>

# Reporting Bugs

Report any bugs to mailing list of ALSA community
&lt;alsa-devel@alsa-project.org&gt; where the development and maintenance is
primarily done. Bug tracking service of alsa-utils repository on github.com is
also available.


<a name="see-also"></a>

# See Also

**axfer-transfer(1),**
**axfer-list(1),**
**alsamixer(1),**
**amixer(1)**


<a name="author"></a>

# Author

Takashi Sakamoto &lt;[o-takashi@sakamocchi.jp](mailto:o-takashi@sakamocchi.jp)&gt;
