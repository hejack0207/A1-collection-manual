# xfs_estimate(8) - estimate the space that an XFS filesystem will take

    xfs_estimate [ -h ] [ -b blocksize ] [ -i logsize ]
    		   [ -e logsize ] [ -v ] directory ...  
    xfs_estimate -V

<a name="description"></a>

# Description

For each _directory_ argument,
_xfs_estimate_
estimates the space that directory would take if it were copied to an XFS
filesystem.
_xfs_estimate_
does not cross mount points.
The following definitions
are used:

* KB = *1024
* MB = *1024*1024
* GB = *1024*1024*1024

The
_xfs_estimate_
options are:

* **-b** _blocksize_  
  Use
  _blocksize_
  instead of the default blocksize of 4096 bytes.
  The modifier
  **k**
  can be used
  after the number to indicate multiplication by 1024.
  For example,

	**_xfs_estimate -b 64k /_**

* requests an estimate of the space required by the directory / on an
  XFS filesystem using a blocksize of 64K (65536) bytes.
* **-v**  
  Display more information, formatted.
* **-h**  
  Display usage message.
* **-i, -e** _logsize_  
  Use
  _logsize_
  instead of the default log size of 1000 blocks.
  **-i**
  refers to an internal log, while
  **-e**
  refers to an external log.
  The modifiers
  **k**
  or
  **m**
  can be used
  after the number to indicate multiplication by 1024 or 1048576, respectively.
* For example,

	**_xfs_estimate -i 1m /_**

* requests an estimate of the space required by the directory / on an
  XFS filesystem using an internal log of 1 megabyte.
* **-V**  
  Print the version number and exits.

<a name="examples"></a>

# Examples

    
    % xfs_estimate -e 10m /var/tmpf7
    /var/tmp will take about 4.2 megabytes
            with the external log using 2560 blocks or about 10.0 megabytes
    
    % xfs_estimate -v -e 10m /var/tmpf7
    directory                     bsize   blocks    megabytes    logsize
    /var/tmp                       4096      792        4.0MB   10485760
    
    % xfs_estimate -v /var/tmpf7
    directory                     bsize   blocks    megabytes    logsize
    /var/tmp                       4096     3352       14.0MB   10485760
    
    % xfs_estimate /var/tmpf7
    /var/tmp will take about 14.0 megabytes
