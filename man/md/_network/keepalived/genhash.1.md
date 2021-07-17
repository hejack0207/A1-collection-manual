# genhash(1) - md5 hash generation tool for remote web pages

Feb 2004

```
"genhash [options] [-s server-address] [-p port] [-u url]"
```

<a name="description"></a>

# Description

**genhash**
is a tool used for generating md5sum hashes of remote web pages.
**genhash**
can use HTTP or HTTPS to connect to the web page.  The output by this
utility includes the HTTP header, page data, and the md5sum of the data.
This md5sum can then be used within the
**keepalived(8)**
program, for monitoring HTTP and HTTPS services.

<a name="options"></a>

# Options


* **--use-ssl, -S**  
  Use SSL to connect to the server.
* **--server &lt;host&gt;, -s**  
  Specify the ip address to connect to.
* **--port &lt;port&gt;, -p**  
  Specify the port to connect to.
* **--url &lt;url&gt;, -u**  
  Specify the path to the file you want to generate the hash of.
* **--use-virtualhost &lt;host&gt;, -V**  
  Specify the virtual host to send along with the HTTP headers.
* **--hash &lt;alg&gt;, -H**  
  Specify the hash algorithm to make a digest of the target page.
  Consult the help screen for list of available ones with a mark
  of the default one.
* **--protocol &lt;protocol_version&gt;, -P**  
  Specify the HTTP protocol version to use. protocol_version can
  be 1.0, 1.1 or 1.0c. 1.0c means protocol version 1.0 but with
  a "Connection: close" line; this is included in version 1.1 by
  default.
* **--timeout &lt;timeout&gt;, -t**  
  Specify the connection timeout in seconds.
* **--verbose, -v**  
  Be verbose with the output.
* **--help, -h**  
  Display the program help screen and exit.
* **--release, -r**  
  Display the release number (version) and exit.
*   
<a name="see-also"></a>

# See Also

**keepalived**(8),
**keepalived.conf**(5)

<a name="author"></a>

# Author
  
**genhash**
was written by Alexandre Cassen &lt;[acassen@linux-vs.org](mailto:acassen@linux-vs.org)&gt;.

This man page was contributed by Andres Salomon &lt;[dilinger@voxel.net](mailto:dilinger@voxel.net)&gt;
for the Debian GNU/Linux system (but may be used by others).

