# combine(1)

moreutils, 2015-07-13

.if n .ad l
.nh

<a name="name"></a>

# Name

combine - combine sets of lines from two files using boolean operations

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" combine file1 and file2 
 combine file1 not file2 
 combine file1 or file2 
 combine file1 xor file2 
 _ file1 and file2 _ 
 _ file1 not file2 _ 
 _ file1 or file2 _ 
 _ file1 xor file2 _
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
**combine** combines the lines in two files. Depending on the boolean
operation specified, the contents will be combined in different ways:

* and  
  .IX Item "and"
  Outputs lines that are in file1 if they are also present in file2.
* not  
  .IX Item "not"
  Outputs lines that are in file1 but not in file2.
* or  
  .IX Item "or"
  Outputs lines that are in file1 or file2.
* xor  
  .IX Item "xor"
  Outputs lines that are in either file1 or file2, but not in both files.

-\*(R" can be specified for either file to read stdin for that file.

The input files need not be sorted, and the lines are output in the order
they occur in file1 (followed by the order they occur in file2 for the two
or\*(R" operations). Bear in mind that this means that the operations are not
commutative; a and b\*(R" will not necessarily be the same as \*(L"b and a\*(R". To
obtain commutative behavior sort and uniq the result.

Note that this program can be installed as _\*(R" to allow for the syntactic
sugar shown in the latter half of the synopsis (similar to the test/[
command). It is not currently installed as _\*(R" by default, but you can
alias it to that if you like.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**join**\|(1)

<a name="author"></a>

# Author

.IX Header "AUTHOR"
Copyright 2006 by Joey Hess &lt;[id@joeyh.name](mailto:id@joeyh.name)&gt;

Licensed under the \s-1GNU GPL.\s0
