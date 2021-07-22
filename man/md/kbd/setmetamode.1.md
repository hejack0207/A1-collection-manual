# setmetamode(1) - define the keyboard meta key handling

30 Jan 1994

```
setmetamode [ {meta|bit|metabit | esc|prefix|escprefix} ]
```

<a name="description"></a>

# Description

.IX "setmetamode command" "" "\fLsetmetamode command"  

Without argument,
**setmetamode**
prints the current Meta key mode.
With argument, it sets the Meta key mode as indicated.
The setting before and after the change are reported.

The Meta key mode is specific for each VT (and the VT
corresponding to stdin is used).
One might use
**setmetamode**
in /etc/rc to define the initial state of the Meta key mode,
e.g. by  
.in +5m
INITTY=/dev/tty[1-8]  
for tty in $INITTY; do  
.in +5m
setmetamode escprefix &lt; $tty  
.in -5m
done
.in -5m

<a name="options"></a>

# Options


* esc prefix escprefix  
  The Meta key sends an Escape prefix.
* meta bit metabit  
  The Meta key sets the high order bit of the character.

<a name="see-also"></a>

# See Also

**loadkeys**(1)

