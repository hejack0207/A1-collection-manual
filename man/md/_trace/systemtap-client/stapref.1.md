# stapref(1) - systemtap language reference



<a name="synopsis"></a>

# Synopsis


```

stapref
```


<a name="description"></a>

# Description


The reference for the systemtap scripting language.


<a name="language"></a>

# Language

Keywords
.SAMPLE
\[bu] **break**
\[bu] **continue**
\[bu] **delete**
\[bu] **else**
\[bu] **exit**
\[bu] **foreach**
\[bu] **for**
\[bu] **function**
\[bu] **global**
\[bu] **private**
\[bu] **if**
\[bu] **in**
\[bu] **next**
\[bu] **probe**
\[bu] **return**
\[bu] **try/catch**
\[bu] **while**
.ESAMPLE

Data Types and Operators
.SAMPLE
Integers
\[bu] var1 = 5
\[bu] **global** var2 = 10

Strings
\[bu] var1 = "string1"
\[bu] **global** var2 = "string2"

Associative Arrays
\[bu] **global** array1[]
\[bu] **global** array2[SIZE]
\[bu] array[index] = 5

Context Variables
\[bu] **$**var
\[bu] **$**var**$**  _(pretty printed string form)_

Binary numeric operators
\[bu] *** / % + - &lt;&lt; &gt;&gt; &gt;&gt;&gt; & ^ | && ||**

Binary string operators
\[bu] **.** _(string concatenation)_

Numeric assignment operators
\[bu] **= += -= *= /= %= &gt;&gt;= &lt;&lt;= &= ^= |= **

String assignment operators
\[bu] **= .= **

Unary numeric operators
\[bu] **+ - ! ~ ++ -- **

Numeric & string comparison operators
\[bu] **&lt; &gt; &lt;= &gt;= == != **

Regular expression matching operators
\[bu] **=~ !~ **

Ternary operator
\[bu] cond **?** exp1 **:** exp2

Grouping operator
\[bu] **(** expression **)**

Array operators
\[bu] array**[**index**]** _(array read/write)_
\[bu] [index] **\in** array

Aggregation operator
\[bu] var **&lt;&lt;&lt;** value
.ESAMPLE

Statements
.SAMPLE
Jump Statements
\[bu] **continue**
\[bu] **break**
\[bu] **next**  _(early return from a probe)_
\[bu] **return** expression _(from a function)_
\[bu] **try** statement **catch** (message) statement
.ESAMPLE
.SAMPLE
Selection Statements
\[bu] **if** (expression) statement 
\[bu] **else** statement
.ESAMPLE
.SAMPLE
Iteration Statements
\[bu] **foreach** (variable **in** array) statement
\[bu] **foreach** ([var1,var2,...] **in** array) statement
\[bu] **for** (expression; expression; expression) statement
\[bu] **while** (expression) statement
.ESAMPLE
.SAMPLE
Declaration Statements
\[bu] **function** name (variable : type, ...) { statement }
\[bu] **function** name : type (variable : type, ...) { statement }
\[bu] **function** name : type (variable : type, ...) %{ c_statement %}
\[bu] **probe** probepoint { statement }
\[bu] **probe** label = probepoint { statement }
.ESAMPLE

Lexical Structure
.SAMPLE
Comments
\[bu] **#** ... comment
\[bu] **//** ... comment
\[bu] **/*** ... comment ... ***/**
.ESAMPLE
.SAMPLE
Preprocessor
\[bu] **%(** expression **%?** true_tokens **%:** false_tokens **%)**
\[bu] **@define** label (variable, ...) %{ statement %}
.ESAMPLE

Builtin Functions
.SAMPLE
Aggregation Builtin Functions
\[bu] **@avg** (variable)
\[bu] **@count** (variable)
\[bu] **@hist\_linear** (variable, N, N, N)
\[bu] **@hist\_log** (variable)
\[bu] **@max** (variable)
\[bu] **@min** (variable)
\[bu] **@sum** (variable)
.ESAMPLE
.SAMPLE
Output Builtin Functions
\[bu] **print** (variable)
\[bu] **printf** (format:string, variable, ...) 
 &nbsp;where format is of the form: %[flags][width][.precision][length]specifier
\[bu] **printd** (delimiter:string, variable, ...)
\[bu] **printdln** (delimiter:string, variable, ...)
\[bu] **println** ()
\[bu] **sprint**:string (variable)
\[bu] **sprintf**:string (format:string, variable, ...)
.ESAMPLE
.SAMPLE
Variable Access Builtin Functions
\[bu] **@var** ("varname[@src/FILE.c]"[, "module"]) _(static or global)_
\[bu] **@cast** (variable, "type_name"[, "module"])
\[bu] **@defined** (variable)
\[bu] **@probewrite** (variable)
.ESAMPLE

Probepoints
.SAMPLE
Some of the more commonly used probepoints
\[bu] kernel.function(PATTERN) kernel.function(PATTERN).call
\[bu] kernel.function(PATTERN).return
\[bu] kernel.FUNCTION (PATTERN).return.maxactive(VALUE)
\[bu] kernel.FUNCTION (PATTERN).inline
\[bu] kernel.FUNCTION (PATTERN).label(LPATTERN)
\[bu] module(MPATTERN).FUNCTION (PATTERN)
\[bu] module(MPATTERN).FUNCTION (PATTERN).call
\[bu] module(MPATTERN).FUNCTION (PATTERN).return.maxactive(VALUE)
\[bu] module(MPATTERN).FUNCTION (PATTERN).inline
\[bu] kernel.statement(PATTERN)
\[bu] kernel.statement(ADDRESS).absolute
\[bu] module(MPATTERN).statement(PATTERN)
\[bu] kprobe.FUNCTION (FUNCTION)
\[bu] kprobe.FUNCTION (FUNCTION).return
\[bu] kprobe.module(NAME).FUNCTION (FUNCTION)
\[bu] kprobe.module(NAME).FUNCTION (FUNCTION).return
\[bu] kprobe.statement(ADDRESS).absolute
\[bu] process.begin process("PATH").begin
\[bu] process(PID).begin process.thread.begin
\[bu] process("PATH").thread.begin
\[bu] process(PID).thread.begin
\[bu] process.end
\[bu] process("PATH").end
\[bu] process(PID).end
\[bu] process.thread.end
\[bu] process("PATH").thread.end
\[bu] process(PID).thread.end
\[bu] process("PATH").syscall
\[bu] process(PID).syscall
\[bu] process.syscall.return
\[bu] process("PATH").syscall.return
\[bu] process(PID).syscall.return
\[bu] process("PATH").FUNCTION ("NAME")
\[bu] process("PATH").statement("*@FILE.c:123")
\[bu] process("PATH").FUNCTION ("*").return
\[bu] process("PATH").FUNCTION ("myfun").label("foo")
\[bu] process("PATH").mark("LABEL")
\[bu] java("PNAME").class("CLASSNAME").method("PATTERN")
\[bu] java("PNAME").class("CLASSNAME").method("PATTERN").return
\[bu] java(PID).class("CLASSNAME").method("PATTERN")
\[bu] java(PID).class("CLASSNAME").method("PATTERN").return
\[bu] python2.module("MODULENAME").function("PATTERN")
\[bu] python2.module("MODULENAME").function("PATTERN").return
\[bu] python3.module("MODULENAME").function("PATTERN")
\[bu] python3.module("MODULENAME").function("PATTERN").return
.ESAMPLE

Tapset Functions
.SAMPLE
Some of the more commonly used tapset functions
\[bu] addr:long ()
\[bu] backtrace:string ()
\[bu] caller:string ()
\[bu] caller_addr:long ()
\[bu] cmdline_arg:string (N:long)
\[bu] cmdline_args:string (N:long,m:long,delim:string)
\[bu] cmdline_str:string ()
\[bu] env_var:string (name:string)
\[bu] execname:string ()
\[bu] int_arg:long (N:long)
\[bu] isinstr:long(s1:string,s2:string)
\[bu] long_arg:long (N:long)
\[bu] modname:string ()
\[bu] module_name:string ()
\[bu] pid:long ()
\[bu] pn:string ()
\[bu] pointer_arg:string (N:long)
\[bu] pp:string ()
\[bu] print_backtrace ()
\[bu] probefunc:string ()
\[bu] register:long(name:string)
\[bu] str_replace:string(prnt_str:string,srch_str:string,rplc_str:string)
\[bu] stringat:long(str:string,pos:long)
\[bu] strlen:long(str:string)
\[bu] strtol:long(str:string,base:long)
\[bu] substr:string(str:string,start:long,length:long)
\[bu] user_long:long(addr:long)
\[bu] user_string:string(addr:long)
.ESAMPLE


<a name="see-also"></a>

# See Also

.nh
    stap(1)
    

<a name="bugs"></a>

# Bugs

Use the Bugzilla link of the project web page or our mailing list.
.nh
**http://sourceware.org/systemtap/**,**&lt;systemtap@sourceware.org&gt;**.
