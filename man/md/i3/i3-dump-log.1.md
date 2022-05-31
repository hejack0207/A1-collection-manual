# i3\-dump\-log(1)

i3 4\&.18\&.1, 04/23/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

i3-dump-log - dumps the i3 SHM log

<a name="synopsis"></a>

# Synopsis

```

 i3-dump-log [-s <socketpath>] [-f]
```

<a name="description"></a>

# Description


Debug versions of i3 automatically use 1% of your RAM (but 25 MiB max) to store full debug log output. This is extremely helpful for bugreports and figuring out what is going on, without permanently logging to a file.

With i3-dump-log, you can dump the SHM log to stdout.

The -f flag works like tail -f, i.e. the process does not terminate after dumping the log, but prints new lines as they appear.

<a name="example"></a>

# Example


i3-dump-log | gzip -9 &gt; /tmp/i3-log.gz

<a name="see-also"></a>

# See Also


i3(1)

<a name="author"></a>

# Author


Michael Stapelberg and contributors
