# nslookup(1)

ISC, 2014\-01\-24

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

nslookup - query Internet name servers interactively

<a name="synopsis"></a>

# Synopsis

```
.HP 9 nslookup [-option] [name&nbsp;|&nbsp;-] [server]
```

<a name="description"></a>

# Description


**Nslookup**
is a program to query Internet domain name servers.
**Nslookup**
has two modes: interactive and non-interactive. Interactive mode allows the user to query name servers for information about various hosts and domains or to print a list of hosts in a domain. Non-interactive mode is used to print just the name and requested information for a host or domain.

<a name="arguments"></a>

# Arguments


Interactive mode is entered in the following cases:

.ie n \{\h'-04' 1.\h'+01'\c
.\}
.el \{.sp -1

*   1.  
  .\}
  when no arguments are given (the default name server will be used)

.ie n \{\h'-04' 2.\h'+01'\c
.\}
.el \{.sp -1

*   2.  
  .\}
  when the first argument is a hyphen (-) and the second argument is the host name or Internet address of a name server.

Non-interactive mode is used when the name or Internet address of the host to be looked up is given as the first argument. The optional second argument specifies the host name or address of a name server.

Options can also be specified on the command line if they precede the arguments and are prefixed with a hyphen. For example, to change the default query type to host information, and the initial timeout to 10 seconds, type:

.if n \{.RS 4
.\}
    nslookup -query=hinfo  -timeout=10
.if n \{.RE
.\}


The
**-version**
option causes
**nslookup**
to print the version number and immediately exits.

<a name="interactive-commands"></a>

# Interactive Commands


**host** [server]
Look up information for host using the current default server or using server, if specified. If host is an Internet address and the query type is A or PTR, the name of the host is returned. If host is a name and does not have a trailing period, the search list is used to qualify the name.

To look up a host not in the current domain, append a period to the name.

**server** _domain_

**lserver** _domain_
Change the default server to
_domain_;
**lserver**
uses the initial server to look up information about
_domain_, while
**server**
uses the current default server. If an authoritative answer cant be found, the names of servers that might have the answer are returned.

**root**
not implemented

**finger**
not implemented

**ls**
not implemented

**view**
not implemented

**help**
not implemented

**?**
not implemented

**exit**
Exits the program.

**set** _keyword__[=value]_
This command is used to change state information that affects the lookups. Valid keywords are:

**all**
Prints the current values of the frequently used options to
**set**. Information about the current default server and host is also printed.

**class=**_value_
Change the query class to one of:

**IN**
the Internet class

**CH**
the Chaos class

**HS**
the Hesiod class

**ANY**
wildcard

The class specifies the protocol group of the information.

(Default = IN; abbreviation = cl)

**[no]****debug**
Turn on or off the display of the full response packet and any intermediate response packets when searching.

(Default = nodebug; abbreviation =
[no]deb)

**[no]****d2**
Turn debugging mode on or off. This displays more about what nslookup is doing.

(Default = nod2)

**domain=**_name_
Sets the search list to
_name_.

**[no]****search**
If the lookup request contains at least one period but doesnt end with a trailing period, append the domain names in the domain search list to the request until an answer is received.

(Default = search)

**port=**_value_
Change the default TCP/UDP name server port to
_value_.

(Default = 53; abbreviation = po)

**querytype=**_value_

**type=**_value_
Change the type of the information query.

(Default = A; abbreviations = q, ty)

**[no]****recurse**
Tell the name server to query other servers if it does not have the information.

(Default = recurse; abbreviation = [no]rec)

**ndots=**_number_
Set the number of dots (label separators) in a domain that will disable searching. Absolute names always stop searching.

**retry=**_number_
Set the number of retries to number.

**timeout=**_number_
Change the initial timeout interval for waiting for a reply to number seconds.

**[no]****vc**
Always use a virtual circuit when sending requests to the server.

(Default = novc)

**[no]****fail**
Try the next nameserver if a nameserver responds with SERVFAIL or a referral (nofail) or terminate query (fail) on such a response.

(Default = nofail)


<a name="return-values"></a>

# Return Values


**nslookup**
returns with an exit status of 1 if any query failed, and 0 otherwise.

<a name="idn-support"></a>

# Idn Support


If
**nslookup**
has been built with IDN (internationalized domain name) support, it can accept and display non-ASCII domain names.
**nslookup**
appropriately converts character encoding of domain name before sending a request to DNS server or displaying a reply from the server. If youd like to turn off the IDN support for some reason, define the
**IDN\_DISABLE**
environment variable. The IDN support is disabled if the variable is set when
**nslookup**
runs.

<a name="files"></a>

# Files


/etc/resolv.conf

<a name="see-also"></a>

# See Also


**dig**(1),
**host**(1),
**named**(8).

<a name="author"></a>

# Author


**Internet Systems Consortium, Inc.**

<a name="copyright"></a>

# Copyright
  
Copyright © 2004-2007, 2010, 2013-2019 Internet Systems Consortium, Inc. ("ISC")  
