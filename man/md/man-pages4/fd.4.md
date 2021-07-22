# fd(4) - floppy disk device

Linux, 2014-05-10


<a name="configuration"></a>

# Configuration

Floppy drives are block devices with major number 2.
Typically they
are owned by
_root.floppy_
(i.e., user root, group floppy) and have
either mode 0660 (access checking via group membership) or mode 0666
(everybody has access).
The minor
numbers encode the device type, drive number, and controller number.
For each device type (that is, combination of density and track count)
there is a base minor number.
To this base number, add the drive's
number on its controller and 128 if the drive is on the secondary
controller.
In the following device tables, _n_ represents the
drive number.

Warning: if you use formats with more tracks
than supported by your drive, you may cause it mechanical damage.
Trying once if more tracks than the usual 40/80 are supported should not
damage it, but no warranty is given for that.
If you are not sure, don't create device
entries for those formats, so as to prevent their usage.

Drive-independent device files which automatically detect the media
format and capacity:
.TS
l c
l c.
Name	Base
	minor #
_
**fd**_n_	0
.TE

5.25 inch double-density device files:
.TS
lw(1i) l l l l c
lw(1i) c c c c c.
Name	Capacity	Cyl.	Sect.	Heads	Base
	KiB				minor #
_
**fd**_n_**d360**	360	40	9	2	4
.TE

5.25 inch high-density device files:
.TS
lw(1i) l l l l c
lw(1i) c c c c c.
Name	Capacity	Cyl.	Sect.	Heads	Base
	KiB				minor #
_
**fd**_n_**h360**	360	40	9	2	20
**fd**_n_**h410**	410	41	10	2	48
**fd**_n_**h420**	420	42	10	2	64
**fd**_n_**h720**	720	80	9	2	24
**fd**_n_**h880**	880	80	11	2	80
**fd**_n_**h1200**	1200	80	15	2	8
**fd**_n_**h1440**	1440	80	18	2	40
**fd**_n_**h1476**	1476	82	18	2	56
**fd**_n_**h1494**	1494	83	18	2	72
**fd**_n_**h1600**	1600	80	20	2	92
.TE

3.5 inch double-density device files:
.TS
lw(1i) l l l l c
lw(1i) c c c c c.
Name	Capacity	Cyl.	Sect.	Heads	Base
	KiB				minor #
_
**fd**_n_**u360**	360	80	9	1	12
**fd**_n_**u720**	720	80	9	2	16
**fd**_n_**u800**	800	80	10	2	120
**fd**_n_**u1040**	1040	80	13	2	84
**fd**_n_**u1120**	1120	80	14	2	88
.TE

3.5 inch high-density device files:
.TS
lw(1i) l l l l c
lw(1i) c c c c c.
Name	Capacity	Cyl.	Sect.	Heads	Base
	KiB				minor #
_
**fd**_n_**u360**	360	40	9	2	12
**fd**_n_**u720**	720	80	9	2	16
**fd**_n_**u820**	820	82	10	2	52
**fd**_n_**u830**	830	83	10	2	68
**fd**_n_**u1440**	1440	80	18	2	28
**fd**_n_**u1600**	1600	80	20	2	124
**fd**_n_**u1680**	1680	80	21	2	44
**fd**_n_**u1722**	1722	82	21	2	60
**fd**_n_**u1743**	1743	83	21	2	76
**fd**_n_**u1760**	1760	80	22	2	96
**fd**_n_**u1840**	1840	80	23	2	116
**fd**_n_**u1920**	1920	80	24	2	100
.TE

3.5 inch extra-density device files:
.TS
lw(1i) l l l l c
lw(1i) c c c c c.
Name	Capacity	Cyl.	Sect.	Heads	Base
	KiB				minor #
_
**fd**_n_**u2880**	2880	80	36	2	32
**fd**_n_**CompaQ**	2880	80	36	2	36
**fd**_n_**u3200**	3200	80	40	2	104
**fd**_n_**u3520**	3520	80	44	2	108
**fd**_n_**u3840**	3840	80	48	2	112
.TE

<a name="description"></a>

# Description

**fd** special files access the floppy disk drives in raw mode.
The following
**ioctl**(2)
calls are supported by **fd** devices:

* **FDCLRPRM**  
  clears the media information of a drive (geometry of disk in drive).
* **FDSETPRM**  
  sets the media information of a drive.
  The media information will be
  lost when the media is changed.
* **FDDEFPRM**  
  sets the media information of a drive (geometry of disk in drive).
  The media information will not be lost when the media is changed.
  This will disable autodetection.
  In order to reenable autodetection, you
  have to issue an **FDCLRPRM**.
* **FDGETDRVTYP**  
  returns the type of a drive (name parameter).
  For formats which work
  in several drive types, **FDGETDRVTYP** returns a name which is
  appropriate for the oldest drive type which supports this format.
* **FDFLUSH**  
  invalidates the buffer cache for the given drive.
* **FDSETMAXERRS**  
  sets the error thresholds for reporting errors, aborting the operation,
  recalibrating, resetting, and reading sector by sector.
* **FDSETMAXERRS**  
  gets the current error thresholds.
* **FDGETDRVTYP**  
  gets the internal name of the drive.
* **FDWERRORCLR**  
  clears the write error statistics.
* **FDWERRORGET**  
  reads the write error statistics.
  These include the total number of
  write errors, the location and disk of the first write error, and the
  location and disk of the last write error.
  Disks are identified by a
  generation number which is incremented at (almost) each disk change.
* **FDTWADDLE**  
  Switch the drive motor off for a few microseconds.
  This might be
  needed in order to access a disk whose sectors are too close together.
* **FDSETDRVPRM**  
  sets various drive parameters.
* **FDGETDRVPRM**  
  reads these parameters back.
* **FDGETDRVSTAT**  
  gets the cached drive state (disk changed, write protected et al.)
* **FDPOLLDRVSTAT**  
  polls the drive and return its state.
* **FDGETFDCSTAT**  
  gets the floppy controller state.
* **FDRESET**  
  resets the floppy controller under certain conditions.
* **FDRAWCMD**  
  sends a raw command to the floppy controller.

For more precise information, consult also the _&lt;linux/fd.h&gt;_ and
_&lt;linux/fdreg.h&gt;_ include files, as well as the
**floppycontrol**(1)
manual page.

<a name="files"></a>

# Files

_/dev/fd*_

<a name="notes"></a>

# Notes

The various formats permit reading and writing many types of disks.
However, if a floppy is formatted with an inter-sector gap that is too small,
performance may drop,
to the point of needing a few seconds to access an entire track.
To prevent this, use interleaved formats.

It is not possible to
read floppies which are formatted using GCR (group code recording),
which is used by Apple II and Macintosh computers (800k disks).

Reading floppies which are hard sectored (one hole per sector, with
the index hole being a little skewed) is not supported.
This used to be common with older 8-inch floppies.




<a name="see-also"></a>

# See Also

**chown**(1),
**floppycontrol**(1),
**getfdprm**(1),
**mknod**(1),
**superformat**(1),
**mount**(8),
**setfdprm**(8)

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
