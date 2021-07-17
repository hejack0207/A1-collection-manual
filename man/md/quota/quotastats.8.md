# quotastats(8)

"", April 2, 2004

**quotastats**
- Program to query quota statistics

<a name="synopsis"></a>

# Synopsis

```
/usr/sbin/quotastats
```

<a name="description"></a>

# Description

**quotastats**
queries the kernel for quota statistics.
It displays:


* \[bu]  
  Supported kernel quota version
* \[bu]  
  Number of dquot lookups
* \[bu]  
  Number of dquot drops
* \[bu]  
  Number of dquot reads
* \[bu]  
  Number of dquot writes
* \[bu]  
  Number of quotafile syncs
* \[bu]  
  Number of dquot cache hits
* \[bu]  
  Number of allocated dquots
* \[bu]  
  Number of free dquots
* \[bu]  
  Number of in use dquot entries (user/group)

<a name="options"></a>

# Options

None.

<a name="see-also"></a>

# See Also

**quota**(1).
