# checkpoint(7)

PostgreSQL 12.7, 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

CHECKPOINT - force a write-ahead log checkpoint

<a name="synopsis"></a>

# Synopsis

```


```
    CHECKPOINT

<a name="description"></a>

# Description


A checkpoint is a point in the write-ahead log sequence at which all data files have been updated to reflect the information in the log. All data files will be flushed to disk. Refer to
Section&nbsp;29.4
for more details about what happens during a checkpoint.

The
**CHECKPOINT**
command forces an immediate checkpoint when the command is issued, without waiting for a regular checkpoint scheduled by the system (controlled by the settings in
Section&nbsp;19.5.2).
**CHECKPOINT**
is not intended for use during normal operation.

If executed during recovery, the
**CHECKPOINT**
command will force a restartpoint (see
Section&nbsp;29.4) rather than writing a new checkpoint.

Only superusers can call
**CHECKPOINT**.

<a name="compatibility"></a>

# Compatibility


The
**CHECKPOINT**
command is a
PostgreSQL
language extension.
