# shadow(3)

shadow\-utils 4\&.8\&.1, 07/29/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

shadow, getspnam - encrypted password file routines

<a name="syntax"></a>

# Syntax

```

 #include <shadow.h> 
 struct spwd *getspent(); 
 struct spwd *getspnam(char *name); 
 void setspent(); 
 void endspent(); 
 struct spwd *fgetspent(FILE *fp); 
 struct spwd *sgetspent(char *cp); 
 int putspent(struct spwd *p, FILE *fp); 
 int lckpwdf(); 
 int ulckpwdf();
```

<a name="description"></a>

# Description


_shadow_
manipulates the contents of the shadow password file,
/etc/shadow. The structure in the
_#include_
file is:

.if n \{.RS 4
.\}
    struct spwd {
          char		*sp_namp; /* user login name */
          char		*sp_pwdp; /* encrypted password */
          long int		sp_lstchg; /* last password change */
          long int		sp_min; /* days until change allowed. */
          long int		sp_max; /* days before change required */
          long int		sp_warn; /* days warning for expiration */
          long int		sp_inact; /* days before account inactive */
          long int		sp_expire; /* date when account expires */
          unsigned long int	sp_flag; /* reserved for future use */
    }
        
.if n \{.RE
.\}

The meanings of each field are:

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  sp_namp - pointer to null-terminated user name

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  sp_pwdp - pointer to null-terminated password

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  sp_lstchg - days since Jan 1, 1970 password was last changed

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  sp_min - days before which password may not be changed

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  sp_max - days after which password must be changed

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  sp_warn - days before password is to expire that user is warned of pending password expiration

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  sp_inact - days after password expires that account is considered inactive and disabled

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  sp_expire - days since Jan 1, 1970 when account will be disabled

.ie n \{\h'-04'·\h'+03'\c
.\}
.el \{.sp -1

* ·  
  .\}
  sp_flag - reserved for future use

<a name="description"></a>

# Description


_getspent_,
_getspname_,
_fgetspent_, and
_sgetspent_
each return a pointer to a
_struct spwd_.
_getspent_
returns the next entry from the file, and
_fgetspent_
returns the next entry from the given stream, which is assumed to be a file of the proper format.
_sgetspent_
returns a pointer to a
_struct spwd_
using the provided string as input.
_getspnam_
searches from the current position in the file for an entry matching
_name_.

_setspent_
and
_endspent_
may be used to begin and end, respectively, access to the shadow password file.

The
_lckpwdf_
and
_ulckpwdf_
routines should be used to insure exclusive access to the
/etc/shadow
file.
_lckpwdf_
attempts to acquire a lock using
_pw\_lock_
for up to 15 seconds. It continues by attempting to acquire a second lock using
_spw\_lock_
for the remainder of the initial 15 seconds. Should either attempt fail after a total of 15 seconds,
_lckpwdf_
returns -1. When both locks are acquired 0 is returned.

<a name="diagnostics"></a>

# Diagnostics


Routines return NULL if no more entries are available or if an error occurs during processing. Routines which have
_int_
as the return value return 0 for success and -1 for failure.

<a name="caveats"></a>

# Caveats


These routines may only be used by the superuser as access to the shadow password file is restricted.

<a name="files"></a>

# Files


/etc/shadow
Secure user account information.

<a name="see-also"></a>

# See Also


**getpwent**(3),
**shadow**(5).
