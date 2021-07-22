# swapcontext(2)

Linux 2.6, 2004-March-12


<a name="name"></a>

# Name

swapcontext - Swap out old context with new context

<a name="synopsis"></a>

# "Synopsis"

.HP 21
int&nbsp;**sys\_swapcontext**&nbsp;(struct&nbsp;ucontext&nbsp;_*old\_ctx_, struct&nbsp;ucontext&nbsp;_*new\_ctx_, int&nbsp;_r5_, int&nbsp;_r6_, int&nbsp;_r7_, int&nbsp;_r8_, struct&nbsp;pt_regs&nbsp;_*regs_);


<a name="description"></a>

# "Description"



**swapcontext** swaps out context _old\_ctx_ with new context _new\_ctx_. The _int r#_ values have no place in the system call functionality. The _regs_ value indicates the current user register values from the user stack.


<a name="return-value"></a>

# "Return Value"



**swapcontext** returns 0 on success; otherwise, **swapcontext** returns one of the errors listed in the "Errors" section.


<a name="errors"></a>

# "Errors"



* -EFAULT  
  _swapcontext_ could not verify that the memory area pointed to by _old\_ctx_ or _new\_ctx_ was accessible for the operation.
  
* -SIGSEGV  
  A fault occurred when the context was being copied into the kernel's image of the user's registers. The should only occur in an out-of-memory situation.
  

<a name="see-also"></a>

# "See Also"

**getcontext(2),**
**sigaction(2),**
**sigaltstack(2),**
**sigprocmask(2)**
 


<a name="author"></a>

# Author

Niki Rahimi 
