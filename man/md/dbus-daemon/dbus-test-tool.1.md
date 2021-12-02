# dbus\-test\-tool(1)

D\-Bus 1\&.12\&.20, 07/27/2020

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

dbus-test-tool - D-Bus traffic generator and test tool

<a name="synopsis"></a>

# Synopsis

```
.HP \w'dbus-test-tool&nbsp;'u dbus-test-tool black-hole [--session | --system] [--name=NAME] [--no-read] .HP \w'dbus-test-tool&nbsp;'u dbus-test-tool echo [--session | --system] [--name=NAME] [--sleep-ms=MS] .HP \w'dbus-test-tool&nbsp;'u dbus-test-tool spam [--session | --system] [--dest=NAME] [--count=N] [--flood] [--ignore-errors] [--messages-per-conn=N] [--no-reply] [--queue=N] [--seed=SEED] [--string | --bytes | --empty] [--payload=S | --stdin | --message-stdin | --random-size]
```

<a name="description"></a>

# Description


**dbus-test-tool**
is a multi-purpose tool for debugging and profiling D-Bus.

**dbus-test-tool black-hole**
connects to D-Bus, optionally requests a name, then does not reply to messages. It normally reads and discards messages from its D-Bus socket, but can be configured to sleep forever without reading.

**dbus-test-tool echo**
connects to D-Bus, optionally requests a name, then sends back an empty reply to every method call, after an optional delay.

**dbus-test-tool spam**
connects to D-Bus and makes repeated method calls, normally named
com.example.Spam.

<a name="options"></a>

# Options


<a name="common-options"></a>

### Common options


**--session**
Connect to the session bus. This is the default.

**--system**
Connect to the system bus.

<a name="black-hole-mode"></a>

### black\-hole mode


**--name=**_NAME_
Before proceeding, request ownership of the well-known bus name
_NAME_, for example
com.example.NoReply. By default, no name is requested, and the tool can only be addressed by a unique bus name such as
:1.23.

**--no-read**
Do not read from the D-Bus socket.

<a name="echo-mode"></a>

### echo mode


**--name=**_NAME_
Before proceeding, request ownership of the well-known bus name
_NAME_, for example
com.example.Echo. By default, no name is requested, and the tool can only be addressed by a unique bus name such as
:1.23.

**--sleep-ms=**_MS_
Block for
_MS_
milliseconds before replying to a method call.

<a name="spam-mode"></a>

### spam mode


**--dest=**_NAME_
Send method calls to the well-known or unique bus name
_NAME_. The default is the dbus-daemon,
org.freedesktop.DBus.

**--count=**_N_
Send
_N_
method calls in total. The default is 1.

**--queue=**_N_
Send
_N_
method calls before waiting for any replies, then send one new call per reply received, keeping
_N_
method calls "in flight" at all times until the number of messages specified with the
**--count**
option have been sent. The default is 1, unless
**--flood**
is used.

**--flood**
Send all messages without waiting for a reply, equivalent to
**--queue**
with an arbitrarily large
_N_.

**--no-reply**
Set the "no reply desired" flag on the messages. This implies
**--flood**, since it disables the replies that would be used for a finite
**--queue**
length.

**--messages-per-conn=**_N_
If given, send
_N_
method calls on the same connection, then disconnect and reconnect. The default is to use the same connection for all method calls.

**--string**
The payload of each message is a UTF-8 string. This is the default. The actual string used is given by the
**--payload**
or
**--stdin**
option, defaulting to "hello, world!".

**--bytes**
The payload of each message is a byte-array. The actual bytes used are given by the
**--payload**
or
**--stdin**
option, defaulting to the ASCII encoding of "hello, world!".

**--empty**
The messages have no payload.

**--payload=**_S_
Use
_S_
as the
**--string**
or
**--bytes**
in the messages. The default is "hello, world!".

**--stdin**
Read from standard input until end-of-file is reached, and use that as the
**--string**
or
**--bytes**
in the messages.

**--message-stdin**
Read a complete binary D-Bus method call message from standard input, and use that for each method call.

**--random-size**
Read whitespace-separated ASCII decimal numbers from standard input, choose one at random for each message, and send a message whose payload is a string of that length.

**--seed=**_SEED_
Use
_SEED_
as the seed for the pseudorandom number generator, to have somewhat repeatable sequences of random messages.

<a name="bugs"></a>

# Bugs


Please send bug reports to the D-Bus bug tracker or mailing list. See
\m[blue]**http://www.freedesktop.org/software/dbus/**\m[].

<a name="see-also"></a>

# See Also


**dbus-send**(1)

<a name="copyright"></a>

# Copyright
  
Copyright © 2015 Collabora Ltd.  

This man page is distributed under the same terms as dbus-test-tool (GPL-2+). There is NO WARRANTY, to the extent permitted by law.

