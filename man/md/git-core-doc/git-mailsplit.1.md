# git\-mailsplit(1)

Git 2\&.21\&.3, 04/20/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

git-mailsplit - Simple UNIX mbox splitter program

<a name="synopsis"></a>

# Synopsis

```


</synopsis>
    git mailsplit [-b] [-f<nn>] [-d<prec>] [--keep-cr] [--mboxrd]
                    -o<directory> [--] [(<mbox>|<Maildir>)...]
<synopsis>


```

<a name="description"></a>

# Description


Splits a mbox file or a Maildir into a list of files: "0001" "0002" .. in the specified directory so you can process them further from there.
.if n \{.sp
.\}
.it 1 an-trap
.nr an-no-space-flag 1
.nr an-break-flag 1  
.ps +1
**Important**
.ps -1  

Maildir splitting relies upon filenames being sorted to output patches in the correct order.


<a name="options"></a>

# Options


&lt;mbox&gt;
Mbox file to split. If not given, the mbox is read from the standard input.

&lt;Maildir&gt;
Root of the Maildir to split. This directory should contain the cur, tmp and new subdirectories.

-o&lt;directory&gt;
Directory in which to place the individual messages.

-b
If any file doesn’t begin with a From line, assume it is a single mail message instead of signaling error.

-d&lt;prec&gt;
Instead of the default 4 digits with leading zeros, different precision can be specified for the generated filenames.

-f&lt;nn&gt;
Skip the first &lt;nn&gt; numbers, for example if -f3 is specified, start the numbering with 0004.

--keep-cr
Do not remove
**\er**
from lines ending with
**\er\en**.

--mboxrd
Input is of the "mboxrd" format and "^&gt;+From " line escaping is reversed.

<a name="git"></a>

# Git


Part of the **git**(1) suite
