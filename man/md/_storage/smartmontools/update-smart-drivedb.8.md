# update-smart-drivedb(8) - update smartmontools drive database

smartmontools-7.2, 2020-12-30

.Sp

<a name="synopsis"></a>

# Synopsis

```
update-smart-drivedb [OPTIONS] [DESTFILE] .Sp
```

<a name="description"></a>

# Description


[This man page is generated for the Linux version of smartmontools. 
It does not contain info specific to other platforms.] 


**update-smart-drivedb**
updates
**/usr/share/smartmontools/drivedb.h**
or
_DESTFILE_
from branches/RELEASE_7_2_DRIVEDB of smartmontools SVN repository.

The tools used for downloading are either
**curl**(1),
**wget**(1),
**lynx**(1),








or
**svn**(1).

The downloaded file is verified with OpenPGP/GPG key ID 721042C5.
The public key block is included in the script.

The old file is kept if the downloaded file is identical (ignoring
the differences in Id string) otherwise it is moved to
**drivedb.h.old**.
.Sp

<a name="options"></a>

# Options


* **-s SMARTCTL**  
  Use the
  **smartctl**(8)
  executable at path SMARTCTL for drive database syntax check.
  The form -s -\*(Aq disables the syntax check.
  The default is
  **/usr/sbin/smartctl**.
* **-t TOOL**  
  Use TOOL for download.
  TOOL is one of:
  _curl wget lynx_
  
  
  
  
  
  
  _svn_.
  The default is the first one found in PATH.
* **-u LOCATION**  
  Use URL of LOCATION for download.
  LOCATION is one of:  
  _github_
  (GitHub mirror of SVN repository),  
  _sf_
  (Sourceforge code browser),  
  _svn_
  (SVN repository),  
  _svni_
  (SVN repository via HTTP instead of HTTPS),  
  _trac_
  (Trac code browser).  
  The default is
  _svn_.
* **--trunk**  
  Download from SVN trunk.
  This requires --no-verify\*(Aq unless the trunk version is still
  identical to branches/RELEASE_7_2_DRIVEDB.
* **--branch X.Y**  
  [NEW EXPERIMENTAL UPDATE-SMART-DRIVEDB FEATURE]
  Download from branches/RELEASE\_**X**\_**Y**_DRIVEDB.
  This also selects the OpenPGP/GPG key for older branches
  (5.40 to 6.6: Key ID DFD22559).
* **--cacert FILE**  
  Use CA certificates from FILE to verify the peer.
* **--capath DIR**  
  Use CA certificate files from DIR to verify the peer.
* **--insecure**  
  Don't abort download if certificate verification fails.
  This option is also required if a HTTP URL is selected with -u\*(Aq
  option.
* **--no-verify**  
  Don't verify signature with GnuPG.
* **--export-key**  
  Print the OpenPGP/GPG public key block.
* **--dryrun**  
  Print download commands only.
* **-v**  
  Verbose output.
  .Sp

<a name="examples"></a>

# Examples

.Vb 2
# update-smart-drivedb
/usr/share/smartmontools/drivedb.h updated from \e
branches/RELEASE_7_2_DRIVEDB
.Ve
.Sp

<a name="exit-status"></a>

# Exit Status

The exit status is 0 if the database has been successfully
updated.
If an error occurs the exit status is 1.
.Sp

<a name="files"></a>

# Files


* **/usr/sbin/update-smart-drivedb**  
  full path of this script.
* **/usr/sbin/smartctl**  
  used to check syntax of new drive database.
* **/usr/share/smartmontools/drivedb.h**  
  current drive database.
* **/usr/share/smartmontools/drivedb.h.raw**  
  current drive database with unexpanded SVN Id string.
* **/usr/share/smartmontools/drivedb.h.raw.asc**  
  signature file.
* **/usr/share/smartmontools/drivedb.h.*old***  
  previous files.
* **/usr/share/smartmontools/drivedb.h.*error***  
  new files if rejected due to errors.
* **/usr/share/smartmontools/drivedb.h.lastcheck**  
  empty file created if downloaded file was identical.
  .Sp

<a name="authors"></a>

# Authors

**Christian Franke**.  
This manual page was originally written by
**Hannes von Haugwitz &lt;[hannes@vonhaugwitz.com](mailto:hannes@vonhaugwitz.com)&gt;**.
.Sp

<a name="reporting-bugs"></a>

# Reporting Bugs

To submit a bug report, create a ticket in smartmontools wiki:  
&lt;**https://www.smartmontools.org/**&gt;.  
Alternatively send the info to the smartmontools support mailing list:  
&lt;https://listi.jpberlin.de/mailman/listinfo/smartmontools-support&gt;.
.Sp

<a name="see-also"></a>

# See Also

**smartctl**(8), **smartd**(8).
.Sp

<a name="package-version"></a>

# Package Version

smartmontools-7.2 2020-12-30 r5155  
$Id: update-smart-drivedb.8.in 5112 2020-11-07 11:41:13Z chrfranke $
