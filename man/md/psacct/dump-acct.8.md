# dump_acct(8) - print an acct/pacct file in human-readable format

Linux accounting system, 2009 December 2

```
dump-acct [-r|--reverse] [-R|--raw] [-n|--num&nbsp;recs] [--byte-swap] [--format] [--ahz&nbsp;freq] [-h|--help] [files]
```


<a name="description"></a>

# Description

The dump-acct command transforms the output **file** from the
accton format to the human-readable format: one record per line.
Each record consists of severald fields which are separated by
character "|" (the meaning of concreate field depends on the
version of kernel package - with which the accton file was created).


<a name="options"></a>

# Options

The following options are supported:

* **-r, --reverse**  
  Print the output in reverse order.
* **-R, --raw**  
  The records will be printed without any parsing.
* **-n, --num NUMRECS**  
  Display only the first NUMRECS number of records.
* **--byteswap**  
  Swap the bytes (relative to your system's native byte order) in --raw output.
* **--format**  
  Set output format with --raw option.
* **--ahz FREQ**  
  Set the AHZ (platform dependent frequency in Hertz) to FREQ.
* **-h, --help**  
  Print a help message and the default location of the process accounting file
  and exit.
  

<a name="see-also"></a>

# See Also

accton (8), lastcomm (1)

