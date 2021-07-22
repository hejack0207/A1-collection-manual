# operator(7) - C operator precedence and order of evaluation

Linux, 2011-09-09


<a name="description"></a>

# Description

This manual page lists C operators and their precedence in evaluation.

.TS
lb lb
l l.
Operator	Associativity
() [] -&gt; .	left to right
! ~ ++ -- + - (type) * & sizeof	right to left
* / %	left to right
+ -	left to right
&lt;&lt; &gt;&gt;	left to right
&lt; &lt;= &gt; &gt;=	left to right
== !=	left to right
&	left to right
^	left to right
|	left to right
&&	left to right
||	left to right
?:	right to left
= += -= *= /= %= &lt;&lt;= &gt;&gt;= &= ^= |=	right to left
,	left to right
.TE

<a name="colophon"></a>

# Colophon

This page is part of release 4.16 of the Linux
_man-pages_
project.
A description of the project,
information about reporting bugs,
and the latest version of this page,
can be found at
https://www.kernel.org/doc/man-pages/.
