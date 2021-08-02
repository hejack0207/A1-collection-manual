# ovsdb-server(5)

Open vSwitch 2.10.1,  DB Schema 1.1.0

.fp 5 L CR              \\" Make fixed-width font available as \\fL.

<a name="name"></a>

# Name

ovsdb-server - _Server database schema




Every **ovsdb-server** (version 2\[char46]9 or later) always hosts an instance of this schema, which holds information on the status and configuration of the server itself\[char46] This database is read-only\[char46] This manpage describes the schema for this database\[char46]

<a name="table-summary"></a>

# Table Summary


The following list summarizes the purpose of each of the tables in the
**\_Server** database.  Each table is described in more detail on a later
page.

* Table  
  Purpose
  .TQ 1in
  **Database**
  Databases\[char46]
  .bp

<a name="database-table"></a>

# Database Table




This table describes the databases hosted by the database server, with one row per database\[char46] As its database configuration and status changes, the server automatically and immediately updates the table to match\[char46]


The OVSDB protocol specified in RFC 7047 does not provide a way for an OVSDB client to find out about some kinds of configuration changes, such as about databases added or removed while a client is connected to the server, or databases changing between read/write and read-only due to a transition between active and backup roles\[char46] This table provides a solution: clients can monitor the table’s contents to find out about important changes\[char46]


Traditionally, **ovsdb-server** disconnects all of its clients when a significant configuration change occurs, because this prompts a well-written client to reassess what is available from the server when it reconnects\[char46] Because this table provides an alternative and more efficient way to find out about those changes, OVS 2\[char46]9 also introduces the **set\_db\_change\_aware** RPC, documented in **ovsdb-server**(7), to allow clients to suppress this disconnection behavior\[char46]


When a database is removed from the server, in addition to **Database** table updates, the server sends **canceled** messages, as described in RFC 7047 section 4\[char46]1\[char46]4, in reply to outstanding transactions for the removed database\[char46] The server also cancels any outstanding monitoring initiated by **monitor** or **monitor\_cond** requested on the removed database, sending the **monitor\_canceled** RPC described in **ovsdb-server**(7)\[char46] Only clients that disable disconnection with **set\_db\_change\_aware** receive these messages\[char46]


Clients can use the **\_uuid** column in this table as a generation number\[char46] The server generates a fresh **\_uuid** every time it adds a database, so that removing and then re-adding a database to the server causes its row **\_uuid** to change\[char46]

<a name="summary"></a>

### "Summary:

.TQ 3.00in
**name**
string
.TQ 3.00in
**model**
string, either **clustered** or **standalone**
.TQ 3.00in
**schema**
optional string
.TQ .25in
_Clustered Databases:_
.TQ 2.75in
**connected**
boolean
.TQ 2.75in
**leader**
boolean
.TQ 2.75in
**cid**
optional uuid
.TQ 2.75in
**sid**
optional uuid
.TQ 2.75in
**index**
optional integer

<a name="details"></a>

### "Details:


* **name**: string  
  The database’s name, as specified in its schema\[char46]
* **model**: string, either **clustered** or **standalone**  
  The storage model: **standalone** for a standalone or active-backup database, **clustered** for a clustered database\[char46]
* **schema**: optional string  
  The database schema, as a JSON string\[char46] In the case of a clustered database, this is empty until it finishes joining its cluster\[char46]
  .ST "Clustered Databases:"



These columns are most interesting and in some cases only relevant for clustered databases, that is, those where the **model** column is **clustered**\[char46]

* **connected**: boolean  
  True if the database is connected to its storage\[char46] A standalone or active-backup database is always connected\[char46] A clustered database is connected if the server is in contact with a majority of its cluster\[char46] An unconnected database cannot be modified and its data might be unavailable or stale\[char46]
* **leader**: boolean  
  True if the database is the leader in its cluster\[char46] For a standalone or active-backup database, this is always true\[char46]
* **cid**: optional uuid  
  The cluster ID for this database, which is the same for all of the servers that host this particular clustered database\[char46] For a standalone or active-backup database, this is empty\[char46]
* **sid**: optional uuid  
  The server ID for this database, different for each server that hosts a particular clustered database\[char46] A server that hosts more than one clustered database will have a different **sid** in each one\[char46] For a standalone or active-backup database, this is empty\[char46]
* **index**: optional integer  
  For a clustered database, the index of the log entry currently exposed to clients\[char46] For a given server, this increases monotonically\[char46] When a client switches from one server to another in a cluster, it can ensure that it never sees an older snapshot of data by avoiding servers that have **index** less than the largest value they have already observed\[char46]
* For a standalone or active-backup database, this is empty\[char46]
