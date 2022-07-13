# mkpasswd-expect(1) - generate new password, optionally apply it to a user

22 August 1994

```
mkpasswd-expect .I [ args ] [ user ]
```

<a name="introduction"></a>

# Introduction

**mkpasswd-expect**
generates passwords and can apply them automatically to users.
mkpasswd-expect is based on the code from Chapter 23 of the O'Reilly book
"Exploring Expect".

<a name="usage"></a>

# Usage

With no arguments,
**mkpasswd-expect**
returns a new password.

	mkpasswd-expect

With a user name,
**mkpasswd-expect**
assigns a new password to the user.

	mkpasswd-expect don

The passwords are randomly generated according to the flags below.


<a name="flags"></a>

# Flags

The
**-l**
flag defines the length of the password.  The default is 9.  
The following example creates a 20 character password.

	mkpasswd-expect -l 20

The
**-d**
flag defines the number of digits that must be in the password.
The default is 2.  The following example creates a password with
3 digits.

	mkpasswd-expect -d 3

The
**-c**
flag defines the minimum number of lowercase alphabetic characters that must be in the password.
The default is 2.

The
**-C**
flag defines the number of uppercase alphabetic characters that must be in the password.
The default is 2.

The
**-s**
flag defines the number of special characters that must be in the password.
The default is 1.

The
**-p**
flag names a program to set the password.
By default, /etc/yppasswd is used if present, otherwise /bin/passwd is used.

The
**-2**
flag causes characters to be chosen so that they alternate between
right and left hands (qwerty-style), making it harder for anyone
watching passwords being entered.  This can also make it easier for
a password-guessing program.

The
**-v**
flag causes the password-setting interaction to be visible.
By default, it is suppressed.


<a name="example"></a>

# Example

The following example creates a 15-character password
that contains 3 digits and 5 uppercase characters.

	mkpasswd-expect -l 15 -d 3 -C 5


<a name="see-also"></a>

# See Also

.I
"Exploring Expect: A Tcl-Based Toolkit for Automating Interactive Programs"
by Don Libes,
O'Reilly and Associates, January 1995.

<a name="author"></a>

# Author

Don Libes, National Institute of Standards and Technology

**mkpasswd-expect**
is in the public domain.
NIST and I would
appreciate credit if this program or parts of it are used.


