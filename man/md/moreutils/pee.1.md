# pee(1)

moreutils, 2006\-03\-14

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

pee - tee standard input to pipes

<a name="synopsis"></a>

# Synopsis

```
.HP \w'pee&nbsp;'u pee [["command"]]
```

<a name="description"></a>

# Description


**pee**
is like
**tee**
but for pipes. Each command is run and fed a copy of the standard input. The output of all commands is sent to stdout.

Note that while this is similar to
**tee**, a copy of the input is not sent to stdout, like tee does. If that is desired, use
**pee cat ...**

<a name="see-also"></a>

# See Also


**tee**(1)

<a name="author"></a>

# Author


Miek Gieben
