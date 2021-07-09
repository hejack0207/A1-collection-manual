# basic classifier in tc(8) - basic traffic control filter

iproute2, 21 Oct 2015

```
.in +8 .ti -8 tc filter ... basic [ match EMATCH_TREE ] [  action ACTION_SPEC ] [  classid CLASSID ]
```

<a name="description"></a>

# Description

The
**basic**
filter allows to classify packets using the extended match infrastructure.

<a name="options"></a>

# Options


* **action**_ ACTION_SPEC_  
  Apply an action from the generic actions framework on matching packets.
* **classid**_ CLASSID_  
  Push matching packets into the class identified by
  _CLASSID_.
* **match**_ EMATCH_TREE_  
  Match packets using the extended match infrastructure. See
  **tc-ematch**(8)
  for a detailed description of the allowed syntax in
  _EMATCH_TREE_.

<a name="see-also"></a>

# See Also

**tc**(8),
**tc-ematch**(8)
