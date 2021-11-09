# unbound\-streamtcp(1)

NLnet Labs, Mar 21, 2013


**unbound-streamtcp**
- unbound DNS lookup utility

<a name="synopsis"></a>

# Synopsis

```

 unbound-streamtcp [-unsh] [-f ipaddr[@port]] [-d secs] name type class
```

<a name="description"></a>

# Description


**unbound-streamtcp**
sends a DNS Query of the given **type** and **class** for the given **name**
to the DNS server over TCP and displays the response.

If the server to query is not given using the **-f** option then localhost
(127.0.0.1) is used. More queries can be given on one commandline, they
are resolved in sequence.

The available options are:

* _name_  
  This name is resolved (looked up in the DNS).
* _type_  
  Specify the type of data to lookup.
* _class_  
  Specify the class to lookup for.
* **-u**  
  Use UDP instead of TCP. No retries are attempted.
* **-n**  
  Do not wait for the answer.
* **-a**  
  Print answers on arrival.  This mean queries are sent in sequence without
  waiting for answer but if answers arrive in this time they are printed out. 
  After sending queries the program waits and prints the remainder.
* **-s**  
  Use SSL.
* **-h**  
  Print program usage.
* **-f ipaddr[@port]**  
  Specify the server to send the queries to. If not specified localhost (127.0.0.1) is used.
* **-d secs**  
  Delay after the connection before sending query.  This tests the timeout
  on the other side, eg. if shorter the connection is closed.

<a name="examples"></a>

# Examples


Some examples of use.

$ unbound-streamtcp www.example.com A IN

$ unbound-streamtcp -f 192.168.1.1 www.example.com SOA IN

$ unbound-streamtcp -f 192.168.1.1@1234 153.1.168.192.in-addr.arpa. PTR IN

<a name="exit-code"></a>

# Exit Code

The unbound-streamtcp program exits with status code 1 on error, 
0 on no error.

<a name="author"></a>

# Author

This manual page was written by Tomas Hozza &lt;[thozza@redhat.com](mailto:thozza@redhat.com)&gt;.
