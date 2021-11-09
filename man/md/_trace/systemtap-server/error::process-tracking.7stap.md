# warning::process-tracking(7stap) - process-tracking facilities are not available



<a name="description"></a>

# Description

These errors and warnings occur when the kernel systemtap is running on
lacks support for user-space process tracking facilities.


<a name="compile-time-error"></a>

### COMPILE-TIME ERROR

The error
.SAMPLE
ERROR: user-space process-tracking facilities not available
.ESAMPLE
occurs when the script contains a uprobes probe point that the current
kernel does not support.


<a name="runtime-warnings"></a>

### RUNTIME WARNINGS


The warning,
.SAMPLE
WARNING: process-tracking facilities are not available in this kernel
.ESAMPLE
and the related message,
.SAMPLE
WARNING: cannot track target in process '...'
.ESAMPLE 
both occur at runtime when running on a kernel (generally an older
version) that has neither utrace functionality nor an acceptable
substitute.

The script should still load and run. However, probes that rely on
availability of process-tracking facilities will silently fail to
trigger.


<a name="resolving-the-issue"></a>

# Resolving the Issue

If process-tracking functionality is absolutely necessary, either a
kernel version newer than 3.5 is needed, or an older version must be
compiled with appropriate utrace patches.


<a name="see-also"></a>

# See Also

.nh
    stap(1),
    error::reporting(7stap)
