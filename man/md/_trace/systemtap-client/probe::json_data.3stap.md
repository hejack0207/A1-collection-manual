# probe::json_data(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::json_data - Fires whenever JSON data is wanted by a reader.

<a name="synopsis"></a>

# Synopsis

```


```
    json_data 

<a name="values"></a>

# Values


None

<a name="context"></a>

# Context


This probe fires when the JSON data is about to be read. This probe must gather up data and then call the following macros to output the data in JSON format. First, @**json\_output\_data\_start**
must be called. That call is followed by one or more of the following (one call for each data item): @**json\_output\_string\_value**, @**json\_output\_numeric\_value**, @**json\_output\_array\_string\_value**, and @**json\_output\_array\_numeric\_value**. Finally @**json\_output\_data\_end**
must be called.

<a name="see-alson-"></a>

# See Also\N 

_tapset::json_(3stap)
