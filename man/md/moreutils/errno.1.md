# errno(1)

moreutils, 2012\-06\-05

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

errno - look up errno names and descriptions

<a name="synopsis"></a>

# Synopsis

```
.HP \w'errno&nbsp;'u errno {name-or-code} .HP \w'errno&nbsp;'u errno [-ls] [--list] .HP \w'errno&nbsp;'u errno [-s] [--search] {word} .HP \w'errno&nbsp;'u errno [-S] [--search-all-locales] {word}
```

<a name="description"></a>

# Description


**errno**
looks up errno macro names, errno codes, and the corresponding descriptions. For example, if given
ENOENT
on a Linux system, it prints out the code 2 and the description "No such file or directory". If given the code 2, it prints
ENOENT
and the same description.

<a name="options"></a>

# Options


**-l**, **--list**
List all errno values.

**-s**, **--search**
Search for errors whose description contains all the given words (case-insensitive).

**-S**, **--search-all-locales**
Like
**--search**, but searches all installed locales.

<a name="author"></a>

# Author


Lars Wirzenius

<a name="see-also"></a>

# See Also


**errno**(3)
