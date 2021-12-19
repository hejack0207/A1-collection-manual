# dtrace(1) - Dtrace compatible user application static probe generation tool.



<a name="synopsis"></a>

# Synopsis


```

dtrace -s file [OPTIONS]
```


<a name="description"></a>

# Description


The dtrace command converts probe descriptions defined in _file.d_
into a probe header
file via the **-h** option
or a probe description file via the **-G** option.


<a name="options"></a>

# Options



* **-h**  
  generate a systemtap header file.
  
* **-G**  
  generate a systemtap probe definition object file.
  
* **-o _file_**  
  is the name of the output file.  If the **-G** option is given then
  the output file will be called _file.o_; if the **-h** option is
  given then the output file will be called _file.h_.
  
* **-C**  
  run the cpp preprocessor on the input file when the **-h** option
  is given.
  
* **-I _file_**  
  give this include path to cpp when the **-C** option is given.
  
* **-k**  
  keep temporary files, for example the C language source for the
  **-G** option.
  

<a name="examples"></a>

# Examples


Systemtap is source compatible with dtrace user application static
probe support.
Given a file _test.d_ containing:
.SAMPLE
provider sdt_probes 
{
  probe test_0 (int type);
  probe test_1 (struct astruct node);
};
struct astruct {int a; int b;};
.ESAMPLE
Then the command _"dtrace&nbsp;-s&nbsp;test.d&nbsp;-G"_ will create the
probe definition file _test.o_ and the command _"dtrace&nbsp;-stest.d&nbsp;-h"_ will create the probe header file _test.h_
Subsequently the application can use the generated macros this way:
.SAMPLE
#include "test.h"
 \.\.\.
struct astruct s;
 \.\.\.
SDT_PROBES_TEST_0(value);
 \.\.\.
if (SDT_PROBES_TEST_1_ENABLED())
    SDT_PROBES_TEST_1(expensive_function(s));
.ESAMPLE


<a name="semaphores"></a>

# Semaphores


Semaphores are flag variables used by probes as a way of bypassing
potentially costly processing to prepare arguments for probes that may
not even be active.  They are automatically set/cleared by systemtap
when a relevant script is running, so the argument setup cost is only
paid when necessary.  These semaphore variables are defined within the
the _"test.o"_ object file, which must therefore be linked into an
application.

Sometimes, semaphore variables are not necessary nor helpful.  Skipping
them can simplify the build process, by omitting the extra _"test.o"_
file.  To skip dependence upon semaphore variables, include _"&lt;sys/sdt.h&gt;"_
within the application before _"test.h"_:
.SAMPLE
#include &lt;sys/sdt.h&gt;
#include "test.h"
 \.\.\.
struct astruct s;
 \.\.\.
SDT_PROBES_TEST_0(value);
 \.\.\.
if (SDT_PROBES_TEST_1_ENABLED())
   SDT_PROBES_TEST_1(cheap_function(s));
.ESAMPLE
In this mode, the ENABLED() test is fixed at 1.


<a name="see-also"></a>

# See Also

.nh
    stap(1),
    stappaths(7)
    
    

<a name="bugs"></a>

# Bugs

Use the Bugzilla link of the project web page or our mailing list.
.nh
**http://sourceware.org/systemtap/**, **&lt;systemtap@sourceware.org&gt;**.

_error::reporting_(7stap),
.nh
**https://sourceware.org/systemtap/wiki/HowToReportBugs**
