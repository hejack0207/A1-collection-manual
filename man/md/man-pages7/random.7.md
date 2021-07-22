# random(7) - overview of interfaces for obtaining randomness

Linux, 2017-03-13


<a name="description"></a>

# Description

The kernel random-number generator relies on entropy gathered from
device drivers and other sources of environmental noise to seed
a cryptographically secure pseudorandom number generator (CSPRNG).
It is designed for security, rather than speed.

The following interfaces provide access to output from the kernel CSPRNG:

* *  
  The
  _/dev/urandom_
  and
  _/dev/random_
  devices, both described in
  **random**(4).
  These devices have been present on Linux since early times,
  and are also available on many other systems.
* *  
  The Linux-specific
  **getrandom**(2)
  system call, available since Linux 3.17.
  This system call provides access either to the same source as
  _/dev/urandom_
  (called the
  _urandom_
  source in this page)
  or to the same source as
  _/dev/random_
  (called the
  _random_
  source in this page).
  The default is the
  _urandom_
  source; the
  _random_
  source is selected by specifying the
  **GRND_RANDOM**
  flag to the system call.
  (The
  **getentropy**(3)
  function provides a slightly more portable interface on top of
  **getrandom**(2).)
  

<a name="initialization-of-the-entropy-pool"></a>

### Initialization of the entropy pool

The kernel collects bits of entropy from the environment.
When a sufficient number of random bits has been collected, the
entropy pool is considered to be initialized.

<a name="choice-of-random-source"></a>

### Choice of random source

Unless you are doing long-term key generation (and most likely not even
then), you probably shouldn't be reading from the
_/dev/random_
device or employing
**getrandom**(2)
with the
**GRND_RANDOM**
flag.
Instead, either read from the
_/dev/urandom_
device or employ
**getrandom**(2)
without the
**GRND_RANDOM**
flag.
The cryptographic algorithms used for the
_urandom_
source are quite conservative, and so should be sufficient for all purposes.

The disadvantage of
**GRND_RANDOM**
and reads from
_/dev/random_
is that the operation can block for an indefinite period of time.
Furthermore, dealing with the partially fulfilled
requests that can occur when using
**GRND_RANDOM**
or when reading from
_/dev/random_
increases code complexity.


<a name="monte-carlo-and-other-probabilistic-sampling-applications"></a>

### Monte Carlo and other probabilistic sampling applications

Using these interfaces to provide large quantities of data for
Monte Carlo simulations or other programs/algorithms which are
doing probabilistic sampling will be slow.
Furthermore, it is unnecessary, because such applications do not
need cryptographically secure random numbers.
Instead, use the interfaces described in this page to obtain
a small amount of data to seed a user-space pseudorandom
number generator for use by such applications.


<a name="comparison-between-getrandom-devurandom-and-devrandom"></a>

### Comparison between getrandom, /dev/urandom, and /dev/random

The following table summarizes the behavior of the various
interfaces that can be used to obtain randomness.
**GRND_NONBLOCK**
is a flag that can be used to control the blocking behavior of
**getrandom**(2).
The final column of the table considers the case that can occur
in early boot time when the entropy pool is not yet initialized.
.TS
allbox;
lbw13 lbw12 lbw14 lbw18
l l l l.
Interface	Pool	T{
Blocking
behavior
T}	T{
Behavior when pool is not yet ready
T}
T{
_/dev/random_
T}	T{
Blocking pool
T}	T{
If entropy too low, blocks until there is enough entropy again
T}	T{
Blocks until enough entropy gathered
T}
T{
_/dev/urandom_
T}	T{
CSPRNG output
T}	T{
Never blocks
T}	T{
Returns output from uninitialized CSPRNG (may be low entropy and unsuitable for cryptography)
T}
T{
**getrandom**()
T}	T{
Same as
_/dev/urandom_
T}	T{
Does not block once is pool ready
T}	T{
Blocks until pool ready
T}
T{
**getrandom**()
**GRND_RANDOM**
T}	T{
Same as
_/dev/random_
T}	T{
If entropy too low, blocks until there is enough entropy again
T}	T{
Blocks until pool ready
T}
T{
**getrandom**()
**GRND_NONBLOCK**
T}	T{
Same as
_/dev/urandom_
T}	T{
Does not block once is pool ready
T}	T{
**EAGAIN**
T}
T{
**getrandom**()
**GRND_RANDOM**
+
**GRND_NONBLOCK**
T}	T{
Same as
_/dev/random_
T}	T{
**EAGAIN**
if not enough entropy available
T}	T{
**EAGAIN**
T}
.TE


<a name="generating-cryptographic-keys"></a>

### Generating cryptographic keys

The amount of seed material required to generate a cryptographic key
equals the effective key size of the key.
For example, a 3072-bit RSA
or Diffie-Hellman private key has an effective key size of 128 bits
(it requires about 2^128 operations to break) so a key generator
needs only 128 bits (16 bytes) of seed material from
_/dev/random_.

While some safety margin above that minimum is reasonable, as a guard
against flaws in the CSPRNG algorithm, no cryptographic primitive
available today can hope to promise more than 256 bits of security,
so if any program reads more than 256 bits (32 bytes) from the kernel
random pool per invocation, or per reasonable reseed interval (not less
than one minute), that should be taken as a sign that its cryptography is
_not_
skillfully implemented.


<a name="see-also"></a>

# See Also

**getrandom**(2),
**getauxval**(3),
**getentropy**(3),
**random**(4),
**urandom**(4),
**signal**(7)

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
