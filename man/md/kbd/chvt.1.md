# chvt(1) - change foreground virtual terminal

26 January 1997

```
chvt N
```

<a name="description"></a>

# Description

The command
**chvt**
_N_
makes
_/dev/ttyN_
the foreground terminal.
(The corresponding screen is created if it did not exist yet.
To get rid of unused VTs,
use
**deallocvt**(1).)
The key combination
(Ctrl-)LeftAlt-F_N_
(with
_N_
in the range 1-12) usually has a similar effect.
