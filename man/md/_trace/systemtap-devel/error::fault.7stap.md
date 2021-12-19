# error::fault(7stap) - memory access faults




<a name="description"></a>

# Description


Read or write faults can occur during the operation of a systemtap
script, if the script causes dereferencing of a pointer that turns out
to be invalid.  This can be caused by using context variables that do
not happen to have valid values, or perhaps references to memory that
is unavailable at that moment due to paging.

These fault conditions are benign because they are caught by the
systemtap runtime, which cleanly terminates the script.  If quick
termination is not desired, consider using the
_--skip-badvars_ or _--suppress-handler-errors_ or _-DMAXERRORS=NN_
stap options, or wrapping relevant parts of the probe handlers in a
_try_/_catch_
block.

It may be possible to adjust the target program, to make it more likely
that needed context variables are paged in when systemtap looks for them.
Consider adding some lightweight processing on the key variables, like a
_strlen(foo)_
for a string, or iterating across elements of an array or linked list,
or touching a few bytes of a heap-allocated block.  The idea is to trigger
any page faults in the target program, before systemtap would need to (but can't).

<a name="see-also"></a>

# See Also

.nh
    stap(1),
    error::reporting(7stap)
