# rtas(2)


<a name="name"></a>

# Name

rtas - Allows userspace to call RTAS (Run Time Abstraction Services)

<a name="synopsis"></a>

# "Synopsis"

.HP 17
int&nbsp;**ppc\_rtas**&nbsp;(struct rtas_args&nbsp;_*uargs_);


<a name="description"></a>

# "Description"

**ppc\_rtas** enables userspace manipulation of the RunTime Abstraction Services (RTAS). RTAS provides for a portable method of access and setting system information. For example, you could gather information on various system sensors and set poweron values. RTAS is accessed via the /proc entry called "rtas". Manipulations on RTAS are implemented via command line arguments on /proc/rtas. 
The values for _uargs_ vary greatly. 
For more information, see the _view/arch/ppcKconfig_ file.


<a name="return-value"></a>

# "Return Value"



**rtas** returns 0 on success; otherwise it returns one of the errors listed in the "Errors" section.


<a name="errors"></a>

# "Errors"



* -EPERM  
  User does not have CAP_SYS_ADMIN capabilities.
  
* -EFAULT  
  Problem copying _uargs_ values to/from user space.
  
* -EINVAL  
  Either number of _uargs_ passed in too large or size of _uargs_ array too large.
  

<a name="author"></a>

# Author

Niki Rahimi. 
