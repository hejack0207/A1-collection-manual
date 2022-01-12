# rand_drbg(7)

1.1.1l, 2021-09-15

.if n .ad l
.nh

<a name="name"></a>

# Name

RAND_DRBG - the deterministic random bit generator

<a name="synopsis"></a>

# Synopsis

```
.IX Header "SYNOPSIS" .Vb 1  #include <openssl/rand_drbg.h> .Ve
```

<a name="description"></a>

# Description

.IX Header "DESCRIPTION"
The default OpenSSL \s-1RAND\s0 method is based on the \s-1RAND_DRBG\s0 class,
which implements a deterministic random bit generator (\s-1DRBG\s0).
A \s-1DRBG\s0 is a certain type of cryptographically-secure pseudo-random
number generator (\s-1CSPRNG\s0), which is described in
[\s-1NIST SP 800-90A\s0 Rev. 1].

While the \s-1RAND API\s0 is the 'frontend' which is intended to be used by
application developers for obtaining random bytes, the \s-1RAND_DRBG API\s0
serves as the 'backend', connecting the former with the operating
systems's entropy sources and providing access to the \s-1DRBG\s0's
configuration parameters.

<a name="disclaimer"></a>

### Disclaimer

.IX Subsection "Disclaimer"
Unless you have very specific requirements for your random generator,
it is in general not necessary to utilize the \s-1RAND_DRBG API\s0 directly.
The usual way to obtain random bytes is to use **RAND\_bytes**\|(3) or
**RAND\_priv\_bytes**\|(3), see also \s-1**RAND\s0**\|(7).

<a name="typical-use-cases"></a>

### Typical Use Cases

.IX Subsection "Typical Use Cases"
Typical examples for such special use cases are the following:

* ·  
  You want to use your own private \s-1DRBG\s0 instances.
  Multiple \s-1DRBG\s0 instances which are accessed only by a single thread provide
  additional security (because their internal states are independent) and
  better scalability in multithreaded applications (because they don't need
  to be locked).
* ·  
  You need to integrate a previously unsupported entropy source.
* ·  
  You need to change the default settings of the standard OpenSSL \s-1RAND\s0
  implementation to meet specific requirements.

<a name="chaining"></a>

# Chaining

.IX Header "CHAINING"
A \s-1DRBG\s0 instance can be used as the entropy source of another \s-1DRBG\s0 instance,
provided it has itself access to a valid entropy source.
The \s-1DRBG\s0 instance which acts as entropy source is called the _parent_ \s-1DRBG,\s0
the other instance the _child_ \s-1DRBG.\s0

This is called chaining. A chained \s-1DRBG\s0 instance is created by passing
a pointer to the parent \s-1DRBG\s0 as argument to the **RAND\_DRBG\_new()** call.
It is possible to create chains of more than two \s-1DRBG\s0 in a row.

<a name="the-three-shared-drbg-instances"></a>

# The Three Shared Drbg Instances

.IX Header "THE THREE SHARED DRBG INSTANCES"
Currently, there are three shared \s-1DRBG\s0 instances,
the &lt;master&gt;, &lt;public&gt;, and &lt;private&gt; \s-1DRBG.\s0
While the &lt;master&gt; \s-1DRBG\s0 is a single global instance, the &lt;public&gt; and &lt;private&gt;
\s-1DRBG\s0 are created per thread and accessed through thread-local storage.

By default, the functions **RAND\_bytes**\|(3) and **RAND\_priv\_bytes**\|(3) use
the thread-local &lt;public&gt; and &lt;private&gt; \s-1DRBG\s0 instance, respectively.

<a name="the-ltmastergt-s-1drbgs0-instance"></a>

### The &lt;master&gt; \s-1DRBG\s0 instance

.IX Subsection "The &lt;master&gt; DRBG instance"
The &lt;master&gt; \s-1DRBG\s0 is not used directly by the application, only for reseeding
the two other two \s-1DRBG\s0 instances. It reseeds itself by obtaining randomness
either from os entropy sources or by consuming randomness which was added
previously by **RAND\_add**\|(3).

<a name="the-ltpublicgt-s-1drbgs0-instance"></a>

### The &lt;public&gt; \s-1DRBG\s0 instance

.IX Subsection "The &lt;public&gt; DRBG instance"
This instance is used per default by **RAND\_bytes**\|(3).

<a name="the-ltprivategt-s-1drbgs0-instance"></a>

### The &lt;private&gt; \s-1DRBG\s0 instance

.IX Subsection "The &lt;private&gt; DRBG instance"
This instance is used per default by **RAND\_priv\_bytes**\|(3)

<a name="locking"></a>

# Locking

.IX Header "LOCKING"
The &lt;master&gt; \s-1DRBG\s0 is intended to be accessed concurrently for reseeding
by its child \s-1DRBG\s0 instances. The necessary locking is done internally.
It is _not_ thread-safe to access the &lt;master&gt; \s-1DRBG\s0 directly via the
\s-1RAND_DRBG\s0 interface.
The &lt;public&gt; and &lt;private&gt; \s-1DRBG\s0 are thread-local, i.e. there is an
instance of each per thread. So they can safely be accessed without
locking via the \s-1RAND_DRBG\s0 interface.

Pointers to these \s-1DRBG\s0 instances can be obtained using
**RAND\_DRBG\_get0\_master()**,
**RAND\_DRBG\_get0\_public()**, and
**RAND\_DRBG\_get0\_private()**, respectively.
Note that it is not allowed to store a pointer to one of the thread-local
\s-1DRBG\s0 instances in a variable or other memory location where it will be
accessed and used by multiple threads.

All other \s-1DRBG\s0 instances created by an application don't support locking,
because they are intended to be used by a single thread.
Instead of accessing a single \s-1DRBG\s0 instance concurrently from different
threads, it is recommended to instantiate a separate \s-1DRBG\s0 instance per
thread. Using the &lt;master&gt; \s-1DRBG\s0 as entropy source for multiple \s-1DRBG\s0
instances on different threads is thread-safe, because the \s-1DRBG\s0 instance
will lock the &lt;master&gt; \s-1DRBG\s0 automatically for obtaining random input.

<a name="the-overall-picture"></a>

# The Overall Picture

.IX Header "THE OVERALL PICTURE"
The following picture gives an overview over how the \s-1DRBG\s0 instances work
together and are being used.

.Vb 10
               +--------------------+
               | os entropy sources |
               +--------------------+
                        |
                        v           +-----------------------------+
      RAND_add() ==&gt; &lt;master&gt;     &lt;-| shared DRBG (with locking)  |
                      /   \e         +-----------------------------+
                     /     \e              +---------------------------+
              &lt;public&gt;     &lt;private&gt;   &lt;- | per-thread DRBG instances |
                 |             |          +---------------------------+
                 v             v
               RAND_bytes()   RAND_priv_bytes()
                    |               ^
                    |               |
    +------------------+      +------------------------------------+
    | general purpose  |      | used for secrets like session keys |
    | random generator |      | and private keys for certificates  |
    +------------------+      +------------------------------------+
.Ve

The usual way to obtain random bytes is to call RAND_bytes(...) or
RAND_priv_bytes(...). These calls are roughly equivalent to calling
RAND_DRBG_bytes(&lt;public&gt;, ...) and RAND_DRBG_bytes(&lt;private&gt;, ...),
respectively. The method **RAND\_DRBG\_bytes**\|(3) is a convenience method
wrapping the **RAND\_DRBG\_generate**\|(3) function, which serves the actual
request for random data.

<a name="reseeding"></a>

# Reseeding

.IX Header "RESEEDING"
A \s-1DRBG\s0 instance seeds itself automatically, pulling random input from
its entropy source. The entropy source can be either a trusted operating
system entropy source, or another \s-1DRBG\s0 with access to such a source.

Automatic reseeding occurs after a predefined number of generate requests.
The selection of the trusted entropy sources is configured at build
time using the --with-rand-seed option. The following sections explain
the reseeding process in more detail.

<a name="automatic-reseeding"></a>

### Automatic Reseeding

.IX Subsection "Automatic Reseeding"
Before satisfying a generate request (**RAND\_DRBG\_generate**\|(3)), the \s-1DRBG\s0
reseeds itself automatically, if one of the following conditions holds:

- the \s-1DRBG\s0 was not instantiated (=seeded) yet or has been uninstantiated.

- the number of generate requests since the last reseeding exceeds a
certain threshold, the so called _reseed\_interval_.
This behaviour can be disabled by setting the _reseed\_interval_ to 0.

- the time elapsed since the last reseeding exceeds a certain time
interval, the so called _reseed\_time\_interval_.
This can be disabled by setting the _reseed\_time\_interval_ to 0.

- the \s-1DRBG\s0 is in an error state.

**Note**: An error state is entered if the entropy source fails while
the \s-1DRBG\s0 is seeding or reseeding.
The last case ensures that the \s-1DRBG\s0 automatically recovers
from the error as soon as the entropy source is available again.

<a name="manual-reseeding"></a>

### Manual Reseeding

.IX Subsection "Manual Reseeding"
In addition to automatic reseeding, the caller can request an immediate
reseeding of the \s-1DRBG\s0 with fresh entropy by setting the
_prediction resistance_ parameter to 1 when calling **RAND\_DRBG\_generate**\|(3).

The document [\s-1NIST SP 800-90C\s0] describes prediction resistance requests
in detail and imposes strict conditions on the entropy sources that are
approved for providing prediction resistance.
Since the default \s-1DRBG\s0 implementation does not have access to such an approved
entropy source, a request for prediction resistance will currently always fail.
In other words, prediction resistance is currently not supported yet by the \s-1DRBG.\s0

For the three shared DRBGs (and only for these) there is another way to
reseed them manually:
If **RAND\_add**\|(3) is called with a positive _randomness_ argument
(or **RAND\_seed**\|(3)), then this will immediately reseed the &lt;master&gt; \s-1DRBG.\s0
The &lt;public&gt; and &lt;private&gt; \s-1DRBG\s0 will detect this on their next generate
call and reseed, pulling randomness from &lt;master&gt;.

The last feature has been added to support the common practice used with
previous OpenSSL versions to call **RAND\_add()** before calling **RAND\_bytes()**.

<a name="entropy-input-vs-additional-data"></a>

### Entropy Input vs. Additional Data

.IX Subsection "Entropy Input vs. Additional Data"
The \s-1DRBG\s0 distinguishes two different types of random input: _entropy_,
which comes from a trusted source, and _additional input_',
which can optionally be added by the user and is considered untrusted.
It is possible to add _additional input_ not only during reseeding,
but also for every generate request.
This is in fact done automatically by **RAND\_DRBG\_bytes**\|(3).

<a name="configuring-the-random-seed-source"></a>

### Configuring the Random Seed Source

.IX Subsection "Configuring the Random Seed Source"
In most cases OpenSSL will automatically choose a suitable seed source
for automatically seeding and reseeding its &lt;master&gt; \s-1DRBG.\s0 In some cases
however, it will be necessary to explicitly specify a seed source during
configuration, using the --with-rand-seed option. For more information,
see the \s-1INSTALL\s0 instructions. There are also operating systems where no
seed source is available and automatic reseeding is disabled by default.

The following two sections describe the reseeding process of the master
\s-1DRBG,\s0 depending on whether automatic reseeding is available or not.

<a name="reseeding-the-master-s-1drbgs0-with-automatic-seeding-enabled"></a>

### Reseeding the master \s-1DRBG\s0 with automatic seeding enabled

.IX Subsection "Reseeding the master DRBG with automatic seeding enabled"
Calling **RAND\_poll()** or **RAND\_add()** is not necessary, because the \s-1DRBG\s0
pulls the necessary entropy from its source automatically.
However, both calls are permitted, and do reseed the \s-1RNG.\s0

**RAND\_add()** can be used to add both kinds of random input, depending on the
value of the **randomness** argument:

* randomness == 0:  
  .IX Item "randomness == 0:"
  The random bytes are mixed as additional input into the current state of
  the \s-1DRBG.\s0
  Mixing in additional input is not considered a full reseeding, hence the
  reseed counter is not reset.
* randomness &gt; 0:  
  .IX Item "randomness &gt; 0:"
  The random bytes are used as entropy input for a full reseeding
  (resp. reinstantiation) if the \s-1DRBG\s0 is instantiated
  (resp. uninstantiated or in an error state).
  The number of random bits required for reseeding is determined by the
  security strength of the \s-1DRBG.\s0 Currently it defaults to 256 bits (32 bytes).
  It is possible to provide less randomness than required.
  In this case the missing randomness will be obtained by pulling random input
  from the trusted entropy sources.

<a name="reseeding-the-master-s-1drbgs0-with-automatic-seeding-disabled"></a>

### Reseeding the master \s-1DRBG\s0 with automatic seeding disabled

.IX Subsection "Reseeding the master DRBG with automatic seeding disabled"
Calling **RAND\_poll()** will always fail.

**RAND\_add()** needs to be called for initial seeding and periodic reseeding.
At least 48 bytes (384 bits) of randomness have to be provided, otherwise
the (re-)seeding of the \s-1DRBG\s0 will fail. This corresponds to one and a half
times the security strength of the \s-1DRBG.\s0 The extra half is used for the
nonce during instantiation.

More precisely, the number of bytes needed for seeding depend on the
_security strength_ of the \s-1DRBG,\s0 which is set to 256 by default.

<a name="see-also"></a>

# See Also

.IX Header "SEE ALSO"
**RAND\_DRBG\_bytes**\|(3),
**RAND\_DRBG\_generate**\|(3),
**RAND\_DRBG\_reseed**\|(3),
**RAND\_DRBG\_get0\_master**\|(3),
**RAND\_DRBG\_get0\_public**\|(3),
**RAND\_DRBG\_get0\_private**\|(3),
**RAND\_DRBG\_set\_reseed\_interval**\|(3),
**RAND\_DRBG\_set\_reseed\_time\_interval**\|(3),
**RAND\_DRBG\_set\_reseed\_defaults**\|(3),
\s-1**RAND\s0**\|(7),

<a name="copyright"></a>

# Copyright

.IX Header "COPYRIGHT"
Copyright 2017-2018 The OpenSSL Project Authors. All Rights Reserved.

Licensed under the OpenSSL license (the License\*(R").  You may not use
this file except in compliance with the License.  You can obtain a copy
in the file \s-1LICENSE\s0 in the source distribution or at
&lt;https://www.openssl.org/source/license.html&gt;.
