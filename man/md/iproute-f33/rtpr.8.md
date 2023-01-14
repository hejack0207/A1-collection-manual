# rtpr(8) - replace backslashes with newlines.

18 September, 2015


<a name="description"></a>

# Description

**rtpr**
is a trivial shell script which converts backslashes in standard input to newlines. It's sole purpose is to be fed with input from
**ip**
when executed with it's
**--oneline**
flag.


<a name="examples"></a>

# Examples


* ip --oneline address show | rtpr  
  Undo oneline converted
  **ip-address**
  output.
  

<a name="see-also"></a>

# See Also

**ip**(8)


<a name="authors"></a>

# Authors

Stephen Hemminger &lt;[shemming@brocade.com](mailto:shemming@brocade.com)&gt;
