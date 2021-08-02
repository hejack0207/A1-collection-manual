# ovsdb(5) - Open vSwitch Database (File Formats)

2.10, Sep 16, 2019

.nr rst2man-indent-level 0
.de1 rstReportMargin
\\$1 \\n[an-margin]
level \\n[rst2man-indent-level]
level margin: \\n[rst2man-indent\\n[rst2man-indent-level]]
-
\\n[rst2man-indent0]
\\n[rst2man-indent1]
\\n[rst2man-indent2]
..
.de1 INDENT


..

<a name="description"></a>

# Description


OVSDB, the Open vSwitch Database, is a database system whose network protocol
is specified by RFC 7047.  The RFC does not specify an on-disk storage format.
The OVSDB implementation in Open vSwitch implements two storage formats: one
for standalone (and active-backup) databases, and the other for clustered
databases.  This manpage documents both of these formats.

Most users do not need to be concerned with this specification.  Instead,
to manipulate OVSDB files, refer to _ovsdb-tool(1)_.  For an
introduction to OVSDB as a whole, read _ovsdb(7)_.

OVSDB files explicitly record changes that are implied by the database schema.
For example, the OVSDB “garbage collection” feature means that when a client
removes the last reference to a garbage-collected row, the database server
automatically removes that row.  The database file explicitly records the
deletion of the garbage-collected row, so that the reader does not need to
infer it.

OVSDB files do not include the values of ephemeral columns.

Standalone and clustered database files share the common structure described
here.  They are text files encoded in UTF-8 with LF (U+000A) line ends,
organized as append-only series of records.  Each record consists of 2 lines of
text.

The first line in each record has the format **OVSDB &lt;magic&gt; &lt;length&gt; &lt;hash&gt;**,
where &lt;magic&gt; is **JSON** for standalone databases or **CLUSTER** for clustered
databases, &lt;length&gt; is a positive decimal integer, and &lt;hash&gt; is a SHA-1
checksum expressed as 40 hexadecimal digits.  Words in the first line must be
separated by exactly one space.

The second line must be exactly _length_ bytes long (including the LF) and its
SHA-1 checksum (including the LF) must match _hash_ exactly.  The line’s
contents must be a valid JSON object as specified by RFC 4627.  Strings in the
JSON object must be valid UTF-8.  To ensure that the second line is exactly one
line of text, the OVSDB implementation expresses any LF characters within a
JSON string as **\en**.  For the same reason, and to save space, the OVSDB
implementation does not “pretty print” the JSON object with spaces and LFs.
(The OVSDB implementation tolerates LFs when reading an OVSDB database file, as
long as _length_ and _hash_ are correct.)

<a name="json-notation"></a>

### JSON Notation


We use notation from RFC 7047 here to describe the JSON data in records.
In addition to the notation defined there, we add the following:
.INDENT 0.0

* **&lt;raw-uuid&gt;**  
  A 36-character JSON string that contains a UUID in the format described by
  RFC 4122, e.g. **"550e8400-e29b-41d4-a716-446655440000"**
  .UNINDENT

<a name="standalone-format"></a>

### Standalone Format


The first record in a standalone database contains the JSON schema for the
database, as specified in RFC 7047.  Only this record is mandatory (a
standalone file that contains only a schema represents an empty database).

The second and subsequent records in a standalone database are transaction
records.  Each record may have the following optional special members,
which do not have any semantics but are often useful to administrators
looking through a database log with **ovsdb-tool show-log**:
.INDENT 0.0

* <b>**"_date": &lt;integer&gt;**</b>  
  The time at which the transaction was committed, as an integer number of
  milliseconds since the Unix epoch.  Early versions of OVSDB counted seconds
  instead of milliseconds; these can be detected by noticing that their
  values are less than 2**32.

OVSDB always writes a **\_date** member.

* <b>**"_comment": &lt;string&gt;**</b>  
  A JSON string that specifies the comment provided in a transaction
  **comment** operation.  If a transaction has multiple **comment**
  operations, OVSDB concatenates them into a single **\_comment** member,
  separated by a new-line.

OVSDB only writes a **\_comment** member if it would be a nonempty string.
.UNINDENT

Each of these records also has one or more additional members, each of which
maps from the name of a database table to a &lt;table-txn&gt;:
.INDENT 0.0

* **&lt;table-txn&gt;**  
  A JSON object that describes the effects of a transaction on a database
  table.  Its names are &lt;raw-uuid&gt;s for rows in the table and its values are
  &lt;row-txn&gt;s.
* **&lt;row-txn&gt;**  
  Either **null**, which indicates that the transaction deleted this row, or
  a JSON object that describes how the transaction inserted or modified the
  row, whose names are the names of columns and whose values are &lt;value&gt;s
  that give the column’s new value.

For new rows, the OVSDB implementation omits columns whose values have the
default values for their types defined in RFC 7047 section 5.2.1; for
modified rows, the OVSDB implementation omits columns whose values are
unchanged.
.UNINDENT

<a name="clustered-format"></a>

### Clustered Format


The clustered format has the following additional notation:
.INDENT 0.0

* **&lt;uint64&gt;**  
  A JSON integer that represents a 64-bit unsigned integer.  The OVS JSON
  implementation only supports integers in the range -2**63 through 2**63-1,
  so 64-bit unsigned integer values from 2**63 through 2**64-1 are expressed
  as negative numbers.
* **&lt;address&gt;**  
  A JSON string that represents a network address to support clustering, in
  the **&lt;protocol&gt;:&lt;ip&gt;:&lt;port&gt;** syntax described in **ovsdb-tool(1)**.
* **&lt;servers&gt;**  
  A JSON object whose names are &lt;raw-uuid&gt;s that identify servers and
  whose values are &lt;address&gt;es that specify those servers’ addresses.
* **&lt;cluster-txn&gt;**  
  A JSON array with two elements:
  .INDENT 7.0
* 1.  
  The first element is either a &lt;database-schema&gt; or **null**.  A
  &lt;database-schema&gt; element is always present in the first record of a
  clustered database to indicate the database’s initial schema.  If it is
  not **null** in a later record, it indicates a change of schema for the
  database.
* 2.  
  The second element is either a transaction record in the format
  described under **Standalone Format'' above, or \`\`null**.
  .UNINDENT

When a schema is present, the transaction record is relative to an empty
database.  That is, a schema change effectively resets the database to
empty and the transaction record represents the full database contents.
This allows readers to be ignorant of the full semantics of schema change.
.UNINDENT

The first record in a clustered database contains the following members,
all of which are required:
.INDENT 0.0

* <b>**"server_id": &lt;raw-uuid&gt;**</b>  
  The server’s own UUID, which must be unique within the cluster.
* <b>**"local_address": &lt;address&gt;**</b>  
  The address on which the server listens for connections from other
  servers in the cluster.
* <b>**name": &lt;id&gt;**</b>  
  The database schema name.  It is only important when a server is in the
  process of joining a cluster: a server will only join a cluster if the
  name matches.  (If the database schema name were unique, then we would
  not also need a cluster ID.)
* <b>**"cluster_id": &lt;raw-uuid&gt;**</b>  
  The cluster’s UUID.  The all-zeros UUID is not a valid cluster ID.
* <b>**"prev_term": &lt;uint64&gt;** and **"prev_index": &lt;uint64&gt;**</b>  
  The Raft term and index just before the beginning of the log.
* <b>**"prev_servers": &lt;servers&gt;**</b>  
  The set of one or more servers in the cluster at index “prev_index” and
  term “prev_term”.  It might not include this server, if it was not the
  initial server in the cluster.
* <b>**"prev_data": &lt;json-value&gt;** and **"prev_eid": &lt;raw-uuid&gt;**</b>  
  A snapshot of the data in the database at index “prev_index” and term
  “prev_term”, and the entry ID for that data.  The snapshot must contain a
  schema.
  .UNINDENT

The second and subsequent records, if present, in a clustered database
represent changes to the database, to the cluster state, or both.  There are
several types of these records.  The most important types of records directly
represent persistent state described in the Raft specification:
.INDENT 0.0

* **Entry**  
  A Raft log entry.
* **Term**  
  The start of a new term.
* **Vote**  
  The server’s vote for a leader in the current term.
  .UNINDENT

The following additional types of records aid debugging and troubleshooting,
but they do not affect correctness.
.INDENT 0.0

* **Leader**  
  Identifies a newly elected leader for the current term.
* **Commit Index**  
  An update to the server’s **commit\_index**.
* **Note**  
  A human-readable description of some event.
  .UNINDENT

The table below identifies the members that each type of record contains.
“yes” indicates that a member is required, “?” that it is optional, blank that
it is forbidden, and [1] that **data** and **eid** must be either both present
or both absent.
.TS
center;
|l|l|l|l|l|l|l|.
_
T{
member
T}	T{
Entry
T}	T{
Term
T}	T{
Vote
T}	T{
Leader
T}	T{
Commit Index
T}	T{
Note
T}
_
T{
comment
T}	T{
?
T}	T{
?
T}	T{
?
T}	T{
?
T}	T{
?
T}	T{
?
T}
_
T{
term
T}	T{
yes
T}	T{
yes
T}	T{
yes
T}	T{
yes
T}	T{
T}	T{
T}
_
T{
index
T}	T{
yes
T}	T{
T}	T{
T}	T{
T}	T{
T}	T{
T}
_
T{
servers
T}	T{
?
T}	T{
T}	T{
T}	T{
T}	T{
T}	T{
T}
_
T{
data
T}	T{
[1]
T}	T{
T}	T{
T}	T{
T}	T{
T}	T{
T}
_
T{
eid
T}	T{
[1]
T}	T{
T}	T{
T}	T{
T}	T{
T}	T{
T}
_
T{
vote
T}	T{
T}	T{
T}	T{
yes
T}	T{
T}	T{
T}	T{
T}
_
T{
leader
T}	T{
T}	T{
T}	T{
T}	T{
yes
T}	T{
T}	T{
T}
_
T{
commit_index
T}	T{
T}	T{
T}	T{
T}	T{
T}	T{
yes
T}	T{
T}
_
T{
note
T}	T{
T}	T{
T}	T{
T}	T{
T}	T{
T}	T{
yes
T}
_
.TE

The members are:
.INDENT 0.0

* <b>**"comment": &lt;string&gt;**</b>  
  A human-readable string giving an administrator more information about
  the reason a record was emitted.
* <b>**"term": &lt;uint64&gt;**</b>  
  The term in which the activity occurred.
* <b>**"index": &lt;uint64&gt;**</b>  
  The index of a log entry.
* <b>**"servers": &lt;servers&gt;**</b>  
  Server configuration in a log entry.
* <b>**"data": &lt;json-value&gt;**</b>  
  The data in a log entry.
* <b>**"eid": &lt;raw-uuid&gt;**</b>  
  Entry ID in a log entry.
* <b>**"vote": &lt;raw-uuid&gt;**</b>  
  The server ID for which this server voted.
* <b>**"leader": &lt;raw-uuid&gt;**</b>  
  The server ID of the server.  Emitted by both leaders and followers when a
  leader is elected.
* <b>**"commit_index": &lt;uint64&gt;**</b>  
  Updated **commit\_index** value.
* <b>**"note": &lt;string&gt;**</b>  
  One of a few special strings indicating important events.  The currently
  defined strings are:
  .INDENT 7.0
* <b>**"transfer leadership"**</b>  
  This server transferred leadership to a different server (with details
  included in **comment**).
* <b>**"left"**</b>  
  This server finished leaving the cluster.  (This lets subsequent
  readers know that the server is not part of the cluster and should not
  attempt to connect to it.)
  .UNINDENT
  .UNINDENT

<a name="joining-a-cluster"></a>

### Joining a Cluster


In addition to general format for a clustered database, there is also a special
case for a database file created by **ovsdb-tool join-cluster**.  Such a file
contains exactly one record, which conveys the information passed to the
**join-cluster** command.  It has the following members:
.INDENT 0.0

* <b>**"server_id": &lt;raw-uuid&gt;** and **"local_address": &lt;address&gt;** and **"name": &lt;id&gt;**</b>  
  These have the same semantics described above in the general description
  of the format.
* <b>**"cluster_id": &lt;raw-uuid&gt;**</b>  
  This is provided only if the user gave the **--cid** option to
  **join-cluster**.  It has the same semantics described above.
* <b>**"remote_addresses"; [&lt;address&gt;*]**</b>  
  One or more remote servers to contact for joining the cluster.
  .UNINDENT

When the server successfully joins the cluster, the database file is replaced
by one described in _Clustered Format_.

<a name="author"></a>

# Author

The Open vSwitch Development Community

<a name="copyright"></a>

# Copyright

2016, The Open vSwitch Development Community

