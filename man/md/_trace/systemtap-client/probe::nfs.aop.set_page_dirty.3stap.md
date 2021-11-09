# probe::nfs\&.aop\&.s(3stap)

SystemTap Tapset Reference, May 2021

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

probe::nfs.aop.set_page_dirty - NFS client marking page as dirty

<a name="synopsis"></a>

# Synopsis

```


```
    nfs.aop.set_page_dirty 

<a name="values"></a>

# Values


_page\_flag_
page flags

_\_\_page_
the address of page

<a name="description"></a>

# Description


This probe attaches to the generic __set_page_dirty_nobuffers function. Thus, this probe is going to fire on many other file systems in addition to the NFS client.

<a name="see-alson-"></a>

# See Also\N 

_tapset::nfs_(3stap)
