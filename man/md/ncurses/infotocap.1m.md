# infotocap(1M)

""


<a name="name"></a>

# Name

**infotocap** - convert a _terminfo_ description into a _termcap_ description

<a name="synopsis"></a>

# Synopsis

```
infotocap [-vn width]  [-V] [-1] [-w width] file ...
```

<a name="description"></a>

# Description

**infotocap** looks in each given text
_file_ for **terminfo** descriptions.
For each terminfo description found,
an equivalent **termcap** description is written to standard output.
Terminfo **use** capabilities are translated directly to termcap
**tc** capabilities.

* **-v**  
  print out tracing information on standard error as the program runs.
* **-V**  
  print out the version of the program in use on standard error and exit.
* **-1**  
  cause the fields to print out one to a line.
  Otherwise, the fields
  will be printed several to a line to a maximum width of 60 characters.
* **-w**  
  change the output to _width_ characters.

<a name="files"></a>

# Files


* /usr/share/terminfo  
  Compiled terminal description database.

<a name="notes"></a>

# Notes

This utility is actually a link to **tic**, running in _-C_ mode.
You can use other **tic** options such as **-f** and  **-x**.

<a name="see-also"></a>

# See Also

**curses**(3X),
**tic**(1M),
**infocmp**(1M),
**terminfo**(5)

This describes **ncurses**
version 6.1 (patch 20180923).

<a name="author"></a>

# Author

Eric S. Raymond &lt;[esr@snark.thyrsus](mailto:esr@snark.thyrsus).com&gt;
and  
Thomas E. Dickey &lt;[dickey@invisible-island.net](mailto:dickey@invisible-island.net)&gt;
