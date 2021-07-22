# math_error(7) - detecting errors from mathematical functions

Linux, 2017-09-15

    #include <math.h>
    #include <errno.h>
    #include <fenv.h>

<a name="description"></a>

# Description

When an error occurs,
most library functions indicate this fact by returning a special value
(e.g., -1 or NULL).
Because they typically return a floating-point number,
the mathematical functions declared in
_&lt;math.h&gt;_
indicate an error using other mechanisms.
There are two error-reporting mechanisms:
the older one sets
_errno_;
the newer one uses the floating-point exception mechanism (the use of
**feclearexcept**(3)
and
**fetestexcept**(3),
as outlined below)
described in
**fenv**(3).

A portable program that needs to check for an error from a mathematical
function should set
_errno_
to zero, and make the following call

.in +4n
.EX
feclearexcept(FE_ALL_EXCEPT);
.EE
.in

before calling a mathematical function.

Upon return from the mathematical function, if
_errno_
is nonzero, or the following call (see
**fenv**(3))
returns nonzero

.in +4n
.EX
fetestexcept(FE_INVALID | FE_DIVBYZERO | FE_OVERFLOW |
             FE_UNDERFLOW);
.EE
.in










then an error occurred in the mathematical function.

The error conditions that can occur for mathematical functions
are described below.

<a name="domain-error"></a>

### Domain error

A
_domain error_
occurs when a mathematical function is supplied with an argument whose
value falls outside the domain for which the function
is defined (e.g., giving a negative argument to
**log**(3)).
When a domain error occurs,
math functions commonly return a NaN
(though some functions return a different value in this case);
_errno_
is set to
**EDOM**,
and an "invalid"
(**FE_INVALID**)
floating-point exception is raised.

<a name="pole-error"></a>

### Pole error

A
_pole error_
occurs when the mathematical result of a function is an exact infinity
(e.g., the logarithm of 0 is negative infinity).
When a pole error occurs,
the function returns the (signed) value
**HUGE_VAL**,
**HUGE_VALF**,
or
**HUGE_VALL**,
depending on whether the function result type is
_double_,
_float_,
or
_long double_.
The sign of the result is that which is mathematically correct for
the function.
_errno_
is set to
**ERANGE**,
and a "divide-by-zero"
(**FE_DIVBYZERO**)
floating-point exception is raised.

<a name="range-error"></a>

### Range error

A
_range error_
occurs when the magnitude of the function result means that it
cannot be represented in the result type of the function.
The return value of the function depends on whether the range error
was an overflow or an underflow.

A floating result
_overflows_
if the result is finite,
but is too large to represented in the result type.
When an overflow occurs,
the function returns the value
**HUGE_VAL**,
**HUGE_VALF**,
or
**HUGE_VALL**,
depending on whether the function result type is
_double_,
_float_,
or
_long double_.
_errno_
is set to
**ERANGE**,
and an "overflow"
(**FE_OVERFLOW**)
floating-point exception is raised.

A floating result
_underflows_
if the result is too small to be represented in the result type.
If an underflow occurs,
a mathematical function typically returns 0.0
(C99 says a function shall return "an implementation-defined value
whose magnitude is no greater than the smallest normalized
positive number in the specified type").
_errno_
may be set to
**ERANGE**,
and an "overflow"
(**FE_UNDERFLOW**)
floating-point exception may be raised.

Some functions deliver a range error if the supplied argument value,
or the correct function result, would be
_subnormal_.
A subnormal value is one that is nonzero,
but with a magnitude that is so small that
it can't be presented in normalized form
(i.e., with a 1 in the most significant bit of the significand).
The representation of a subnormal number will contain one
or more leading zeros in the significand.

<a name="notes"></a>

# Notes

The
_math_errhandling_
identifier specified by C99 and POSIX.1 is not supported by glibc.

This identifier is supposed to indicate which of the two
error-notification mechanisms
(_errno_,
exceptions retrievable via
**fettestexcept**(3))
is in use.
The standards require that at least one be in use,
but permit both to be available.
The current (version 2.8) situation under glibc is messy.
Most (but not all) functions raise exceptions on errors.
Some also set
_errno_.
A few functions set
_errno_,
but don't raise an exception.
A very few functions do neither.
See the individual manual pages for details.

To avoid the complexities of using
_errno_
and
**fetestexcept**(3)
for error checking,
it is often advised that one should instead check for bad argument
values before each call.

For example, the following code ensures that
**log**(3)'s
argument is not a NaN and is not zero (a pole error) or
less than zero (a domain error):

.in +4n
.EX
double x, r;

if (isnan(x) || islessequal(x, 0)) {
    /* Deal with NaN / pole error / domain error */
}

r = log(x);
.EE
.in

The discussion on this page does not apply to the complex
mathematical functions (i.e., those declared by
_&lt;complex.h&gt;_),
which in general are not required to return errors by C99
and POSIX.1.

The
**gcc**(1)
_-fno-math-errno_
option causes the executable to employ implementations of some
mathematical functions that are faster than the standard
implementations, but do not set
_errno_
on error.
(The
**gcc**(1)
_-ffast-math_
option also enables
_-fno-math-errno_.)
An error can still be tested for using
**fetestexcept**(3).

<a name="see-also"></a>

# See Also

**gcc**(1),
**errno**(3),
**fenv**(3),
**fpclassify**(3),
**INFINITY**(3),
**isgreater**(3),
**matherr**(3),
**nan**(3)

_info libc_

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
