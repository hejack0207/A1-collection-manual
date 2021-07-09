# actions in tc(8) - independently defined actions in tc

iproute2, 1 Aug 2017

```
tc [ TC_OPTIONS ] actions add | change | replace ACTSPEC
</synopsis>

<synopsis>
tc [ TC_OPTIONS ] actions get | delete ACTISPEC
</synopsis>

<synopsis>
tc [ TC_OPTIONS ] actions flush ACTNAMESPEC
</synopsis>

<synopsis>
tc [ TC_OPTIONS ] actions ls | list ACTNAMESPEC [ ACTFILTER ]
</synopsis>

<synopsis>
.in +8 ACTSPEC := action ACTDETAIL [ INDEXSPEC ] [ COOKIESPEC ] [ FLAGS ] [ HWSTATSSPEC ] [ CONTROL ]
</synopsis>

<synopsis>
ACTISPEC := ACTNAMESPEC INDEXSPEC
</synopsis>

<synopsis>
ACTNAMESPEC := action ACTNAME
</synopsis>

<synopsis>
INDEXSPEC := index INDEX
</synopsis>

<synopsis>
ACTFILTER := since MSTIME
</synopsis>

<synopsis>
COOKIESPEC := cookie COOKIE
</synopsis>

<synopsis>
FLAGS := no_percpu
</synopsis>

<synopsis>
HWSTATSSPEC := hw_stats { immediate | delayed | disabled }
</synopsis>

<synopsis>
ACTDETAIL := ACTNAME ACTPARAMS
</synopsis>

<synopsis>
ACTNAME may be any valid action type: gact, mirred, bpf, connmark, csum, police, etc.
</synopsis>

<synopsis>
MSTIME Time since last update.
</synopsis>

<synopsis>
CONTROL := { reclassify | pipe | drop | continue | ok }
</synopsis>

<synopsis>
TC_OPTIONS These are the options that are specific to tc and not only the options. Refer to tc(8) for more information. .in
```


<a name="description"></a>

# Description


The
**actions**
object in
**tc**
allows a user to define actions independently of a classifier (filter). These
actions can then be assigned to one or more filters, with any
packets matching the classifier's criteria having that action performed
on them.

Each action type (mirred, police, etc.) will have its own table to store
all created actions.


<a name="operations"></a>

# Operations


* **add**  
  Create a new action in that action's table.
  
* **change**  
  .TQ
  **replace**
  Make modifications to an existing action.
* **get**  
  Display the action with the specified index value. When combined with the
  **-s**
  option for
  **tc**,
  display the statistics for that action.
* **delete**  
  Delete the action with the specified index value. If the action is already
  associated with a classifier, it does not delete the classifier.
* **ls**  
  .TQ
  **list**
  List all the actions in the specified table. When combined with the
  **-s**
  option for
  **tc**,
  display the statistics for all actions in the specified table.
  When combined with the option
  **since**
  allows doing a millisecond time-filter since the last time an
  action was used in the datapath.
* **flush**  
  Delete all actions stored in the specified table.
  

<a name="action-options"></a>

# Action Options

Note that these options are available to all action types.

* **index**_ INDEX_  
  Specify the table index value of an action.
  _INDEX_
  is a 32-bit value that is unique to the specific type of action referenced.
  
      For
      **add**, **change**, and
      **replace**
      operations, the index is
      **optional.**
      When adding a new action,
      specifying an index value will assign the action to that index unless that
      index value has already been assigned. Omitting the index value for an add
      operation will cause the kernel to assign a value to the new action.
  
      For
      **get** and **delete**
      operations, the index is
      **required**
      to identify the specific action to be displayed or deleted.
  
* **cookie**_ COOKIE_  
  In addition to the specific action, mark the matching packet with the value
  specified by
  _COOKIE_.
  The
  _COOKIE_
  is a 128-bit value that will not be interpreted by the kernel whatsoever.
  As such, it can be used as a correlating value for maintaining user state.
  The value to be stored is completely arbitrary and does not require a specific
  format. It is stored inside the action structure itself.
  
* _FLAGS_  
  Action-specific flags. Currently, the only supported flag is
  _no_percpu_
  which indicates that action is expected to have minimal software data-path
  traffic and doesn't need to allocate stat counters with percpu allocator.
  This option is intended to be used by hardware-offloaded actions.
  
* **hw_stats**_ HW_STATS_  
  Specifies the type of HW stats of new action. If omitted, any stats counter type
  is going to be used, according to driver and its resources.
  The
  _HW_STATS_
  indicates the type. Any of the following are valid:
    * **immediate**  
      Means that in dump, user gets the current HW stats state from the device
      queried at the dump time.
    * **delayed**  
      Means that in dump, user gets HW stats that might be out of date for
      some time, maybe couple of seconds. This is the case when driver polls
      stats updates periodically or when it gets async stats update
      from the device.
    * **disabled**  
      No HW stats are going to be available in dump.
  
* **since**_ MSTIME_  
  When dumping large number of actions, a millisecond time-filter can be
  specified
  _MSTIME_.
  The
  _MSTIME_
  is a millisecond count since last time a packet hit the action.
  As an example specifying "since 20000" implies to dump all actions
  that have seen packets in the last 20 seconds. This option is useful
  when the kernel has a large number of actions and you are only interested
  in recently used actions.
  
* _CONTROL_  
  The
  _CONTROL_
  indicates how
  **tc**
  should proceed after executing the action. Any of the following are valid:
    * **reclassify**  
      Restart the classifiction by jumping back to the first filter attached to
      the action's parent.
    * **pipe**  
      Continue with the next action. This is the default control.
    * **drop**  
      Drop the packed without running any further actions.
    * **continue**  
      Continue the classification with the next filter.
    * **pass**  
      Return to the calling qdisc for packet processing, and end classification of
      this packet.
  

<a name="see-also"></a>

# See Also

**tc**(8),
**tc-bpf**(8),
**tc-connmark**(8),
**tc-csum**(8),
**tc-ife**(8),
**tc-mirred**(8),
**tc-nat**(8),
**tc-pedit**(8),
**tc-police**(8),
**tc-simple**(8),
**tc-skbedit**(8),
**tc-skbmod**(8),
**tc-tunnel_key**(8),
**tc-vlan**(8),
**tc-xt**(8)
