# ethers(5)

net\-tools, 2008\-10\-03


<a name="name-"></a>

# Name 

ethers - Ethernet address to IP number database


<a name="description-"></a>

# Description 

**/etc/ethers** contains 48 bit Ethernet addresses and their corresponding
IP numbers, one line for each IP number:

_Ethernet-address_  _IP-number_

The two items are separated by any number of SPACE and/or TAB characters.
A **#** at the beginning of a line starts a comment
which extends to the end of the line.  The _Ethernet-address_ is
written as
_x_:_x_:_x_:_x_:_x_:_x_,
where _x_ is a hexadecimal number between **0** and **ff**
which represents one byte of the address, which is in network byte
order (big-endian).  The _IP-number_ may be a hostname which
can be resolved by DNS or a dot separated number.


<a name="examples-"></a>

# Examples 

08:00:20:00:61:CA  pal


<a name="files-"></a>

# Files 

/etc/ethers

