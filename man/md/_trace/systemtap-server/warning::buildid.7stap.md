# warning::buildid(7stap) - build-id verification failures




<a name="description"></a>

# Description


Because systemtap's script translation / execution stages may be
executed at different times and places, it is sometimes necessary to
verify certain invariants.  One such invariant is that if a script
was informed by translate-time analysis of executables, then those
same executables need to be used at run time.  This checking
is done based upon the build-id, a binary hash that modern (post-2007)
compilers/toolchains add as an 
_NT_GNU_BUILD_ID_
ELF note to object files and executables.
Use the
_readelf -n_
command to examine the build-ids of binaries, if you are interested.



Only scripts are sensitive to executables' build-ids: generally those
that perform deep analysis of the binaries or their debuginfo.  For example,
scripts that place
_.function_ or _.statement_
probes, or use stack backtrace-related tapset functions may be sensitive.
Other scripts that rely only on
_process.mark_ or _kernel.trace_
probes do not require debuginfo.  See the DWARF DEBUGINFO section in the
_stapprobes_(3stap)
man page.



During translation, systemtap saves a copy of the relevant files'
build-ids within the compiled modules.  At run-time, the modules
compare the saved ones to the actual run-time build-ids in memory.
The warning message indicates that they did not match, so the module
will decline placing a probe that was computed based upon obsolete
data.  This is important for safety, as placing them at an
inappropriate address could crash the programs.  However, this is not
necessarily a fatal error, since probes unrelated to the mismatching
binaries may operate.



A build-id mismatch could be caused by a few different situations.
The main one is where the executable versions or architecture were
different between the systemtap translation and execution
times/places.  For example, one may run a stap-server on a slightly
different version of the OS distribution.  Someone may have rebuilt a
new kernel image, but preserved the previous version numbers.  The
kernel running on the workstation may be slightly different from the
version being targeted - perhaps due to a pending kernel upgrade
leaving different files on disk versus running in memory.  If your OS
distribution uses separate debuginfo packages, the split _.debug_
files may not exactly match the main binaries.



To disable build-id verification warnings, if one is confident that they
are an artefact of build accidents rather than a real mismatch, one
might try the
_-DSTP_NO_BUILDID_CHECK_
option.


<a name="see-also"></a>

# See Also

.nh
    http://fedoraproject.org/wiki/Releases/FeatureBuildId,
    stap(1),
    stapprobes(3stap),
    warning::debuginfo(7stap),
    error::reporting(7stap)
