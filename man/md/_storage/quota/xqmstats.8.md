# xqmstats(8)

"", April 2, 2004

**xqmstats**
- Display XFS quota manager statistics from /proc

<a name="synopsis"></a>

# Synopsis

```
/usr/sbin/xqmstats
```

<a name="description"></a>

# Description

**xqmstat**
queries the kernel for the XFS Quota Manager dquot statistics.
It displays:


* \[bu]  
  Reclaims
* \[bu]  
  Missed reclaims
* \[bu]  
  Dquot dups
* \[bu]  
  Cache misses
* \[bu]  
  Cache hits
* \[bu]  
  Dquot wants
* \[bu]  
  Shake reclaims
* \[bu]  
  Inact reclaims

<a name="options"></a>

# Options

None.

<a name="see-also"></a>

# See Also

**quotastats**(1),
**quota**(1).
