# doxygen -g -s /path/to/newconfig.file

The option /path/to/newconfig.file should be the directory in which you want to even-

tually produce your Doxygen documentation. After Doxygen has created the configuration file

for you, simply open the configuration file in your favorite editor and edit the sections you

need. Usually, you will need to modify only the OUTPUT_DIRECTORY, INPUT, and PROJECT_NAME

settings. Once you’ve edited the configuration file, simply execute the following:

# doxygen </path/to/config-file>

For your convenience, a version of the MySQL 5.0.2 Doxygen output is available at

http://www.jpipes.com/mysqldox/.

The MySQL Documentation

The internal system documentation is available to you if you download the source code of

MySQL. It is in the Docs directory of the source tree, available in the internals.texi TEXI

document.

The TEXI documentation covers the following topics in detail:

• Coding guidelines

• The optimizer (highly recommended reading)

• Important algorithms and structures

• Charsets and related issues

• How MySQL transforms queries

• Communication protocol

• Replication

• How MySQL performs different SELECT operations (very useful information)


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

• The MyISAM record structure

• The .MYI file structure

• The InnoDB record structure

• The InnoDB page structure

Although the documentation is extremely helpful in researching certain key elements of

the server (particularly the query optimizer), it is worth noting that the internal documentation

does not directly address how the different subsystems interact with each other. To determine

this interaction, it is necessary to examine the source code itself and the comments of the

developers.2

■Caution Even the most recent internals.texi documentation has a number of bad hyperlinks, refer-

ences, and incorrect filenames and paths, so do your homework before you take everything for granted. The

internals.texi documentation may not be as up-to-date as your MySQL server version!

TEXI and texi2html Viewing

TEXI is the GNU standard documentation format. A number of utilities can convert the TEXI

source documentation to other, perhaps more readable or portable, formats. For those of you

using Emacs or some variant of it, that editor supports a TEXI major mode for easy reading.

If you prefer an HTML version, you can use the free Perl-based utility texi2html, which

can generate a highly configurable HTML output of a TEXI source document. texi2html is

available for download from https://texi2html.cvshome.org/. Once you’ve downloaded this

utility, you can install it, like so:

# tar -xzvf texi2html-1.76.tar.gz

# cd texi2html-1.6

# ./configure

# make install

# cd /path/to/mysql-5.0.2-alpha/

# texi2html Docs/internals.texi

Here, we’ve untarred the latest (as of this writing) texi2html version and installed the soft-

ware on our Linux system. Next, we want to generate an HTML version of the internals.texi

document available in our source download:

After installation, you’ll notice a new HTML document in the /Docs directory of your

source tree called internals.html. You can now navigate the internal documentation via a web

browser. For your convenience, this HTML document is also available at http://www.jpipes.com/

mysqldox/.

2. Whether the developers chose to purposefully omit a discussion on the subsystem’s communication

in order to allow for changes in that communication is up for debate.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

MySQL Architecture Overview

MySQL’s architecture consists of a web of interrelated function sets, which work together to

fulfill the various needs of the database server. A number of authors3 have implied that these

function sets are indeed components, or entirely encapsulated packages; however, there is

little evidence in the source code that this is the case.

Indeed, the architecture includes separate function libraries, composed of functions that

handle similar tasks, but there is not, in the traditional object-oriented programming sense, a

full component-level separation of functionality. By this, we mean that you will be disappointed

if you go into the source code looking for classes called BufferManager or QueryManager. They

don’t exist. We bring this point up because some developers, particularly ones with Java back-

grounds, write code containing a number of “manager” objects, which fulfill the requests of

client objects in a very object-centric approach. In MySQL, this simply isn’t the case.

In some cases—notably in the source code for the query cache and log management

subsystems—a more object-oriented approach is taken to the code. However, in most cases,

system functionality is run through the various function libraries (which pass along a core set

of structs) and classes (which do the dirty work of code execution), as opposed to an encapsu-

lated approach, where components manage their internal execution and provide an API for

other components to use the component. This is due, in part, to the fact that the system archi-

tecture is made up of both C and C++ source files, as well as a number of Perl and shell scripts

that serve as utilities. C and C++ have different functional capabilities; C++ is a fully object-

oriented language, and C is more procedural. In the MySQL system architecture, certain

libraries have been written entirely in C, making an object-oriented component type architec-

ture nearly impossible. For sure, the architecture of the server subsystems has a lot to do with

performance and portability concerns as well.

■Note As MySQL is an evolving piece of software, you will notice variations in both coding and naming

style and consistency. For example, if you compare the source files for the older MyISAM handler files with

the newer query cache source files, you’ll notice a marked difference in naming conventions, commenting

by the developers, and function-naming standards. Additionally, as we go to print, there have been rumors

that significant changes to the directory structure and source layout will occur in MySQL 5.1.

Furthermore, if you analyze the source code and internal documentation, you will find

little mention of components or packages.4 Instead, you will find references to various

task-related functionality. For instance, the internals TEXI document refers to “The Opti-

mizer,” but you will find no component or package in the source code called Optimizer.

Instead, as the internals TEXI document states, “The Optimizer is a set of routines which

decide what execution path the RDBMS should take for queries.” For simplicity’s sake, we

3. For examples, see MySQL: The Complete Reference, by Vikram Vaswani (McGraw-Hill/Osborne) and

http://wiki.cs.uiuc.edu/cs427/High-Level+Component+Diagram+of+the+MySQL+Architecture.

4. The function init_server_components() in /sql/mysqld.cpp is the odd exception. Really, though, this

method runs through starting a few of the functional subsystems and initializes the storage handlers

and core buffers.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

will refer to each related set of functionality by the term subsystem, rather than component,

as it seems to more accurately reflect the organization of the various function libraries.

Each subsystem is designed to both accept information from and feed data into the other

subsystems of the server. In order to do this in a standard way, these subsystems expose this

functionality through a well-defined function application programming interface (API).5

As requests and data funnel through the server’s pipeline, the subsystems pass information

between each other via these clearly defined functions and data structures. As we examine

each of the major subsystems, we’ll take a look at some of these data structures and methods.

MySQL Server Subsystem Organization

The overall organization of the MySQL server architecture is a layered, but not particularly

hierarchical, structure. We make the distinction here that the subsystems in the MySQL server

architecture are quite independent of each other.

In a hierarchical organization, subsystems depend on each other in order to function, as

components derive from a tree-like set of classes. While there are indeed tree-like organiza-

tions of classes within some of the subsystems—notably in the SQL parsing and optimization

subsystem—the subsystems themselves do not follow a hierarchical arrangement.

A base function library and a select group of subsystems handle lower-level responsibili-

ties. These libraries and subsystems serve to support the abstraction of the storage engine

systems, which feed data to requesting client programs. Figure 4-1 shows a general depiction

of this layering, with different subsystems identified. We’ll cover each of the subsystems sepa-

rately in this chapter.

Note that client programs interact with an abstracted API for the storage engines. This

enables client connections to issue statements that are storage-engine agnostic, meaning the

client does not need to know which storage engine is handling the data request. No special

client functions are required to return InnoDB records versus MyISAM records. This arrange-

ment enables MySQL to extend its functionality to different storage requirements and media.

We’ll take a closer look at the storage engine implementation in the “Storage Engine Abstrac-

tion” section later in this chapter, and discuss the different storage engines in detail in the next

chapter.

5. This abstraction generally leads to a loose coupling, or dependence, of related function sets to each

other. In general, MySQL’s components are loosely coupled, with a few exceptions.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Client program

C client API

Storage engine

implementations

Core shared

subsystems

Query parsing and optimization subsystem

Query cache

Storage engine abstraction layer

MyISAM

handler

and library

MEMORY

handler and

library

InnoDB handler

and library

NDB cluster

handler and

library

Process, thread, and

resource management

subsystem

Logs and log event

classes

Base Function Library

Cache and buffer

management

Networking

subsystem

Access control

subsystem

Figure 4-1. MySQL subsystem overview


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Base Function Library

All of MySQL’s subsystems share the use of a base library of common functions. Many of these

functions exist to shield the subsystem (and the developers) from needing to operate directly

with the operating system, main memory, or the physical hardware itself.6 Additionally, the

base function library enables code reuse and portability. Most of the functions in this base

library are found in the C source files of the /mysys and /strings directories. Table 4-2 shows

a sampling of core files and locations for this base library.

Table 4-2. Some Core Function Files

File

Contents

/mysys/array.c

Dynamic array functions and definitions

/mysys/hash.c/.h

Hash table functions and definitions

/mysys/mf_qsort.c

Quicksort algorithms and functions

/mysys/string.c

Dynamic string functions

/mysys/my_alloc.c

Some memory allocation routines

/mysys/mf_pack.c

Filename and directory path packing routines

/strings/*

Low-level string and memory manipulation functions, and some data

type definitions

Process, Thread, and Resource Management

One of the lowest levels of the system architecture deals with the management of the various

processes that are responsible for various activities on the server. MySQL happens to be a

thread-based server architecture, which differs dramatically from database servers that oper-

ate on a process-based system architecture, such as Oracle and Microsoft SQL Server. We’ll

explain the difference in just a minute.

The library of functions that handles these various threads of execution is designed

so that all the various executing threads can access key shared resources. These resources—

whether they are simple variables maintained for the entire server system or other resources

like files and certain data caches—must be monitored to avoid having multiple executing

threads conflict with each other or overwriting critical data. This function library handles the

coordination of the many threads and resources.

Thread-Based vs. Process-Based Design

A process can be described as an executing set of instructions the operating system has allo-

cated an address space in which to conduct its operations. The operating system grants the

process control over various resources, like files and devices. The operations conducted by

the process have been given a certain priority by the operating system, and, over the course

of its execution, the process maintains a given state (sleeping, running, and so on).

6. Certain components and libraries, however, will still interact directly with the operating system or

hardware where performance or other benefits may be realized.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

A thread can be thought of as a sort of lightweight process, which, although not given its

own address space in memory, does execute a series of operations and does maintain its own

state. A thread has a mechanism to save and restore its resources when it changes state, and it

has access to the resources of its parent process. A multithreaded environment is one in which

a process can create, or spawn, any number of threads to handle—sometimes synchronously7

—its needed operations.

Some database servers have multiple processes handling multiple requests. However,

MySQL uses multiple threads to accomplish its activities. This strategy has a number of differ-

ent advantages, most notably in the arena of performance and memory use:

• It is less costly to create or destroy threads than processes. Because the threads use the

parent process’s address space, there is no need to allocate additional address space for

a new thread.

• Switching between threads is a relatively inexpensive operation because threads are

running in the same address space.

• There is little overhead involved in shared resources, since threads automatically have

access to the parent’s resources.

■Tip Since each instance of a MySQL database server—that is, each execution of the mysqd server

daemon—executes in its own address space, it is possible to simulate a multiprocess server by creating

multiple instances of MySQL. Each instance will run in its own process and have a set of its own threads to

use in its execution. This arrangement is useful when you need to have separate configurations for different

instances, such as in a shared hosting environment, with different companies running different, separately

configured and secured MySQL servers on the same machine.

Implementation Through a Library of Related Functions

A set of functions handles the creation of a myriad threads responsible for running the various

parts of the server application. These functions are optimized to take advantage of the ability

of the underlying operating system resource and process management systems. The process,

thread, and resource management subsystem is in charge of creating, monitoring, and destroying

threads. Specifically, threads are created by the server to manage the following main areas:

• A thread is created to handle each new user connection. This is a special thread we’ll

cover in detail later in the upcoming “User Connection Threads and THD Objects” sec-

tion. It is responsible for carrying out both query execution and user authentication,

although, as you will see, it passes this responsibility to other classes designed espe-

cially to handle those events.

• A global (instance-wide) thread is responsible for creating and managing each user con-

nection thread. This thread can be considered a sort of user connection manager thread.

7. This depends on the available hardware; for instance, whether the system supports symmetric multi-

processing.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

• A single thread handles all DELAYED INSERT requests separately.

• Another thread handles table flushes when requested by the system or a user connection.

• Replication requires separate threads for handling the synchronization of master and

slave servers.

• A thread is created to handle shutdown events.

• Another thread handles signals, or alarms, inside the system.

• Another thread handles maintenance tasks.

• A thread handles incoming connection requests, either TCP/IP or Named Pipes.

The system is responsible for regulating the use of shared resources through an internal

locking system. This locking system ensures that resources shared by all threads are properly

managed to ensure the atomicity of data. Locks on resources that are shared among multiple

threads, sometimes called critical sections, are managed using mutex structures.

MySQL uses the POSIX threads library. When this library is not available or not suited

to the operating system, MySQL emulates POSIX threads by wrapping an operating system’s

available process or resource management library in a standard set of POSIX function defini-

tions. For instance, Windows uses its own common resource management functions and

definitions. Windows threads are known as handles, and so MySQL wraps, or redefines, a

HANDLE struct to match a POSIX thread definition. Likewise, for locking shared resources,

Windows uses functions like InitializeCriticalSection() and EnterCriticalSection().

MySQL wraps these function definitions to match a POSIX-style API: pthread_mutex_init()

and pthread_mutex_lock().

On server initialization, the function init_thread_environment() (in /sql/mysqld.cc) is

called. This function creates a series of lock structures, called mutexes, to protect the resources

used by the various threads executing in the server process. Each of these locks protects a spe-

cific resource or group of resources. When a thread needs to modify or read from the resource

or resource group, a call is made to lock the resource, using pthread_mutex_lock(). The thread

modifies the resource, and then the resource is unlocked using pthread_mutex_unlock(). In

our walk-through of a typical query execution at the end of this chapter, you’ll see an example

of how the code locks and unlocks these critical resources (see Listing 4-10).

Additionally, the functions exposed by this subsystem are used by specific threads in

order to allocate resources inside each thread. This is referred to as thread-specific data (TSD).

Table 4-3 lists a sampling of files for thread and process management.

Table 4-3. Some Thread and Process Management Subsystem Files

File

Contents

/include/my_pthread.h

Wrapping definitions for threads and thread locking (mutexes)

/mysys/my_pthread.c

Emulation and degradation of thread management for nonsupporting

systems

Functions for reading, writing, and checking status of thread locks

/mysys/thr_lock.c and

/mysys/thr_lock.h

/sql/mysqld.cc

Functions like create_new_thread(), which creates a new user

connection thread, and close_connection(), which removes

(either destroys or sends to a pool) that user connection


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

User Connection Threads and THD Objects

For each user connection, a special type of thread, encapsulated in a class named THD, is

responsible for handling the execution of queries and access control duties. Given its impor-

tance, you might think that it’s almost ubiquitously found in the source code, and indeed it is.

THD is defined in the /sql/sql_class.h file and implemented in the /sql/sql_class.cc file.

The class represents everything occurring during a user’s connection, from access control

through returning a resultset, if appropriate. The following are just some of the class members

of THD (some of them should look quite familiar to you):

• last_insert_id

• limit_found_rows

• query

• query_length

• row_count

• session_tx_isolation

• thread_id

• user

This is just a sampling of the member variables available in the substantial THD class.

You’ll notice on your own inspection of the class definition that THD houses all the functions

and variables you would expect to find to maintain the state of a user connection and the

statement being executed on that connection. We’ll take a more in-depth look at the different

parts of the THD class as we look further into how the different subsystems make use of this

base class throughout this chapter.

The create_new_thread() function found in /sql/mysqld.cc spawns a new thread and

creates a new user thread object (THD) for each incoming connection.8 This function is called

by the managing thread created by the server process to handle all incoming user connec-

tions. For each new thread, two global counters are incremented: one for the total number of

threads created and one for the number of open threads. In this way, the server keeps track of

the number of user connections created since the server started and the number of user con-

nections that are currently open. Again, in our examination of a typical query execution at the

end of this chapter, you’ll see the actual source code that handles this user thread-spawning

process.

Storage Engine Abstraction

The storage engine abstraction subsystem enables MySQL to use different handlers of the

table data within the system architecture. Each storage engine implements the handler super-

class defined in /sql/handler.h. This file indicates the standard API that the query parsing

and execution subsystem will call when it needs to store or retrieve data from the engine.

8. This is slightly simplified, as there is a process that checks to see if an existing thread can be reused

(pooling).


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Not all storage engines implement the entire handler API; some implement only a small

fraction of it. Much of the bulk of each handler’s implementation details is concerned with

converting data, schema, and index information into the format needed by MySQL’s internal

record format (in-memory record format).

■Note For more information about the internal format for record storage, see the internals.texi docu-

ment included with the MySQL internal system documentation, in the Docs directory of the source tree.

Key Classes and Files for Handlers

When investigating the storage engine subsystem, a number of files are important. First, the

definition of the handler class is in /sql/handler.h. All the storage engines implement their

own subclass of handler, meaning each subclass inherits all the functionality of the handler

superclass. In this way, each storage engine’s handler subclass follows the same API. This

enables client programs to operate on the data contained in the storage engine’s tables in an

identical manner, even though the implementation of the storage engines—how and where

they actually store their data—is quite different.

The handler subclass for each storage engine begins with ha_ followed by the name of

the storage engine. The definition of the subclass and its member variables and methods are

available in the /sql directory of the source tree and are named after the handler subclass. The

files that actually implement the handler class of the storage engine differ for each storage

engine, but they can all be found in the directory named for the storage engine:

• The MyISAM storage engine handler subclass is ha_myisam, and it is defined in

/sql/ha_myisam.h. Implementation files are in the /myisam directory.

• The MyISAM MERGE storage engine handler subclass is ha_myisammrg, and it is defined

in /sql/ha_myisammrg.h. Implementation files are in the /myisammrg directory.

• The InnoDB storage engine handler subclass is ha_innodb, and it is defined in

/sql/ha_innodb.h. Implementation files are in the /innobase directory.

• The MEMORY storage engine handler subclass is ha_heap, and it is defined in

/sql/ha_heap.h. Implementation files are in the /heap directory.

• The NDB Cluster handler subclass is ha_ndbcluster, and it is defined in /sql/ha_

ndbcluster.h. Unlike the other storage engines, which are implemented in a separate

directory, the Cluster handler is implemented entirely in /sql/ha_ndbcluster.cc.

The Handler API

The storage engine handler subclasses must implement a base interface API defined in the

handler superclass. This API is how the server interacts with the storage engine.

Listing 4-1 shows a stripped-out version (for brevity) of the handler class definition. Its

member methods are the API of which we speak. We’ve highlighted the member method names

to make it easier for you to pick them out. Out intention here is to give you a feel for the base

class of each storage engine’s implementation.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Listing 4-1. handler Class Definition (Abridged)

class handler // …

{

protected:

struct st_table *table;       /* The table definition */

virtual int index_init(uint idx) { active_index=idx; return 0; }

virtual int index_end() { active_index=MAX_KEY; return 0; }

// omitted ...

virtual int rnd_init(bool scan) =0;

virtual int rnd_end() { return 0; }

public:

handler (TABLE *table_arg) {}

virtual ~handler(void) {}

// omitted ...

void update_auto_increment();

// omitted ...

virtual bool has_transactions(){ return 0;}

// omitted ...

// omitted ...

virtual int open(const char *name, int mode, uint test_if_locked)=0;

virtual int close(void)=0;

virtual int write_row(byte * buf) { return  HA_ERR_WRONG_COMMAND; }

virtual int update_row(const byte * old_data, byte * new_data) {}

virtual int delete_row(const byte * buf) {}

virtual int index_read(byte * buf, const byte * key,

uint key_len, enum ha_rkey_function find_flag) {}

virtual int index_read_idx(byte * buf, uint index, const byte * key,

uint key_len, enum ha_rkey_function find_flag);

virtual int index_next(byte * buf) {}

virtual int index_prev(byte * buf) {}

virtual int index_first(byte * buf) {}

virtual int index_last(byte * buf) {}

// omitted ...

virtual int rnd_next(byte *buf)=0;

virtual int rnd_pos(byte * buf, byte *pos)=0;

virtual int read_first_row(byte *buf, uint primary_key);

// omitted ...

virtual void position(const byte *record)=0;

virtual void info(uint)=0;

// omitted ...

virtual int start_stmt(THD *thd) {return 0;}

// omitted ...

virtual ulonglong get_auto_increment();

virtual void restore_auto_increment();

virtual void update_create_info(HA_CREATE_INFO *create_info) {}


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

/* admin commands - called from mysql_admin_table */

virtual int check(THD* thd, HA_CHECK_OPT* check_opt) {}

virtual int backup(THD* thd, HA_CHECK_OPT* check_opt) {}

virtual int restore(THD* thd, HA_CHECK_OPT* check_opt) {}

virtual int repair(THD* thd, HA_CHECK_OPT* check_opt) {}

virtual int optimize(THD* thd, HA_CHECK_OPT* check_opt) {}

virtual int analyze(THD* thd, HA_CHECK_OPT* check_opt) {}

virtual int assign_to_keycache(THD* thd, HA_CHECK_OPT* check_opt) {}

virtual int preload_keys(THD* thd, HA_CHECK_OPT* check_opt) {}

/* end of the list of admin commands */

// omitted ...

virtual int add_index(TABLE *table_arg, KEY *key_info, uint num_of_keys) {}

virtual int drop_index(TABLE *table_arg, uint *key_num, uint num_of_keys) {}

// omitted ...

virtual int rename_table(const char *from, const char *to);

virtual int delete_table(const char *name);

virtual int create(const char *name, TABLE *form, HA_CREATE_INFO *info)=0;

// omitted ...

};

You should recognize most of the member methods. They correspond to features you

may associate with your experience using MySQL. Different storage engines implement some

or all of these member methods. In cases where a storage engine does not implement a spe-

cific feature, the member method is simply left alone as a placeholder for possible future

development. For instance, certain administrative commands, like OPTIMIZE or ANALYZE,

require that the storage engine implement a specialized way of optimizing or analyzing the

contents of a particular table for that storage engine. Therefore, the handler class provides

placeholder member methods (optimize() and analyze()) for the subclass to implement, if it

wants to.

The member variable table is extremely important for the handler, as it stores a pointer to

an st_table struct. This struct contains information about the table, its fields, and some meta

information. This member variable, and four member methods, are in a protected area of the

handler class, which means that only classes that inherit from the handler class—specifically,

the storage engine handler subclasses—can use or see those member variables and methods.

Remember that not all the storage engines actually implement each of handler’s member

methods. The handler class definition provides default return values or functional equivalents,

which we’ve omitted here for brevity. However, certain member methods must be imple-

mented by the specific storage engine subclass to make the handler at least useful. The

following are some of these methods:

• rnd_init(): This method is responsible for preparing the handler for a scan of the table

data.

• rnd_next(): This method reads the next row of table data into a buffer, which is passed

to the function. The data passed into the buffer must be in a format consistent with the

internal MySQL record format.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

• open(): This method is in charge of opening the underlying table and preparing it for use.

• info(): This method fills a number of member variables of the handler by querying the

table for information, such as how many records are in the table.

• update_row(): This member method replaces old row data with new row data in the

underlying data block.

• create (): This method is responsible for creating and storing the schema for a table

definition in whatever format used by the storage engine. For instance, MyISAM’s

ha_myisam::create() member method implementation writes the .frm file containing

the table schema information.

We’ll cover the details of storage engine implementations in the next chapter.

■Note For some light reading on how to create your own storage engine and handler implementations,

check out John David Duncan’s article at http://dev.mysql.com/tech-resources/articles/

creating-new-storage-engine.html.

Caching and Memory Management Subsystem

MySQL has a separate subsystem devoted to the caching and retrieval of different types of

data used by all the threads executing within the server process. These data caches, some-

times called buffers, enable MySQL to reduce the number of requests for disk-based I/O (an

expensive operation) in return for using data already stored in memory (in buffers).

The subsystem makes use of a number of different types of caches, including the record,

key, table, hostname, privilege, and other caches. The differences between the caches are in

the type of data they store and why they store it. Let’s briefly take a look at each cache.

Record Cache

The record cache isn’t a buffer for just any record. Rather, the record cache is really just a set

of function calls that mostly read or write data sequentially from a collection of files. For this

reason, the record cache is used primarily during table scan operations. However, because of

its ability to both read and write data, the record cache is also used for sequential writing,

such as in some log writing operations.

The core implementation of the record cache can be found in /mysys/io_cache.c and

/sql/records.cc; however, you’ll need to do some digging around before anything makes

much sense. This is because the key struct used in the record cache is called st_io_cache,

aliased as IO_CACHE. This structure can be found in /mysys/my_sys.h, along with some very

important macros, all named starting with my_b_. They are defined immediately after the

IO_CACHE structure, and these macros are one of the most interesting implementation

details in MySQL.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

The IO_CACHE structure is essentially a structure containing a built-in buffer, which can

be filled with record data structures.9 However, this buffer is a fixed size, and so it can store

only so many records. Functions throughout the MySQL system can use an IO_CACHE object to

retrieve the data they need, using the my_b_ functions (like my_b_read(), which reads from the

IO_CACHE internal buffer of records). But there’s a problem.

What happens when somebody wants the “next” record, and IO_CACHE’s buffer is full?

Does the calling program or function need to switch from using the IO_CACHE’s buffer to some-

thing else that can read the needed records from disk? No, the caller of my_b_read() does not.

These macros, in combination with IO_CACHE, are sort of a built-in switching mechanism for

other parts of the MySQL server to freely read data from a record cache, but not worry about

whether or not the data actually exists in memory. Does this sound strange? Take a look at the

definition for the my_b_read macro, shown in Listing 4-2.

Listing 4-2. my_b_read Macro

#define my_b_read(info,Buffer,Count) \

((info)->read_pos + (Count) <= (info)->read_end ? \

(memcpy(Buffer,(info)->read_pos,(size_t) (Count)), \

((info)->read_pos+=(Count)),0) : \

(*(info)->read_function)((info),Buffer,Count))

Let’s break it down to help you see the beauty in its simplicity. The info parameter is an

IO_CACHE object. The Buffer parameter is a reference to some output storage used by the caller

of my_b_read(). You can consider the Count parameter to be the number of records that need

to be read.

The macro is simply a ternary operator (that ? : thing). my_b_read() simply looks to

see whether the request would read a record from before the end of the internal record buffer

( (info)->read_pos + (Count) <= (info)->read_end ). If so, the function copies (memcpy) the

needed records from the IO_CACHE record buffer into the Buffer output parameter. If not, it

calls the IO_CACHE read_function. This read function can be any of the read functions defined

in /mysys/mf_iocache.c, which are specialized for the type of disk-based file read needed

(such as sequential, random, and so on).

Key Cache

The implementation of the key cache is complex, but fortunately, a good amount of documen-

tation is available. This cache is a repository for frequently used B-tree index data blocks for all

MyISAM tables and the now-deprecated ISAM tables. So, the key cache stores key data for

MyISAM and ISAM tables.

9. Actually, IO_CACHE is a generic buffer cache, and it can contain different data types, not just records.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

The primary source code for key cache function definitions and implementation can be

found in /include/keycache.h and mysys/mf_keycache.c. The KEY_CACHE struct contains a

number of linked lists of accessed index data blocks. These blocks are a fixed size, and they

represent a single block of data read from an .MYI file.

■Tip As of version 4.1 you can change the key cache’s block size by changing the key_cache_block_size con-

figuration variable. However, this configuration variable is still not entirely implemented, as you cannot currently

change the size of an index block, which is set when the .MYI file is created. See http://dev.mysql.com/

doc/mysql/en/key-cache-block-size.html for more details.

These blocks are kept in memory (inside a KEY_CACHE struct instance), and the KEY_CACHE

keeps track of how “warm”10 the index data is—for instance, how frequently the index data

block is requested. After a time, cold index blocks are purged from the internal buffers. This is

a sort of least recently used (LRU) strategy, but the key cache is smart enough to retain blocks

that contain index data for the root B-tree levels.

The number of blocks available inside the KEY_CACHE’s internal list of used blocks is con-

trolled by the key_buffer_size configuration variable, which is set in multiples of the key

cache block size.

The key cache is created the first time a MyISAM table is opened. The multi_key_cache_

search() function (found in /mysys/mf_keycaches.c) is called during the storage engine’s

mi_open() function call.

When a user connection attempts to access index (key) data from the MyISAM table, the

table’s key cache is first checked to determine whether the needed index block is available in

the key cache. If it is, the key cache returns the needed block from its internal buffers. If not,

the block is read from the relevant .MYI file into the key cache for storage in memory. Subse-

quent requests for that index block will then come from the key cache, until that block is

purged from the key cache because it is not used frequently enough.

Likewise, when changes to the key data are needed, the key cache first writes the changes

to the internally buffered index block and marks it as dirty. If this dirty block is selected by the

key cache for purging—meaning that it will be replaced by a more recently requested index

block—that block is flushed to disk before being replaced. If the block is not dirty, it’s simply

thrown away in favor of the new block. Figure 4-2 shows the flow request between user con-

nections and the key cache for requests involving MyISAM tables, along with the relevant

function calls in /mysys/mf_keycache.c.

10. There is actually a BLOCK_TEMPERATURE variable, which places the block into warm or hot lists of blocks

(enum BLOCK_TEMPERATURE { BLOCK_COLD, BLOCK_WARM , BLOCK_HOT }).


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

key_cache_read()

found in /mysys/mf_keycache.c

read_block()

found in /mysys/mf_keycache.c

find_key_block()

found in /mysys/mf_keycache.c

Found block

Return index key

data in block at

offset X

Read request for

My|SAM key

(index) block at

offset X

Check if index

block in My|SAM

key cache

No found block

Read block from

disk into key

cache list of

blocks

Return index key

data in block at

offset X

Figure 4-2. The key cache

statistical variables:

You can monitor the server’s usage of the key cache by reviewing the following server

• Key_blocks_used: This variable stores the number of index blocks currently contained

in the key cache. This should be high, as the more blocks in the key cache, the less the

server is using disk-based I/O to examine the index data.

• Key_read_requests: This variable stores the total number of times a request for index

blocks has been received by the key cache, regardless of whether the key cache actually

needed to read the block from disk.

• Key_reads: This variable stores the number of disk-based reads the key cache performed

in order to get the requested index block.

• Key_write_requests: This variable stores the total number of times a write request was

received by the key cache, regardless of whether the modifications (writes) of the key

data were to disk. Remember that the key cache writes changes to the actual .MYI file

only when the index block is deemed too cold to stay in the cache and it has been

marked dirty by a modification.

• Key_writes: This variable stores the number of actual writes to disk.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Experts have recommended that the Key_reads to Key_read_requests and Key_writes to

Key_write_requests should have, at a minimum, a 1:50–1:100 ratio.11 If the ratio is lower than

that, consider increasing the size of key_buffer_size and monitoring for improvements. You

can review these variables by executing the following:

mysql> SHOW STATUS LIKE 'Key_%';

Table Cache

The table cache is implemented in /sql/sql_base.cc. This cache stores a special kind of

structure that represents a MySQL table in a simple HASH structure. This hash, defined as a

global variable called open_cache, stores a set of st_table structures, which are defined in

/sql/table.h and /sql/table.cc.

■Note For the implementation of the HASH struct, see /include/hash.h and /mysys/hash.c.

The st_table struct is a core data structure that represents the actual database table in

memory. Listing 4-3 shows a small portion of the struct definition to give you an idea of what

is contained in st_table.

Listing 4-3. st_table Struct (Abridged)

struct st_table {

handler *file;

Field **field;            /* Pointer to fields */

Field_blob **blob_field;        /* Pointer to blob fields */

/* hash of field names (contains pointers to elements of field array) */

HASH name_hash;

byte *record[2];    /* Pointer to records */

byte *default_values;         /* Default values for INSERT */

byte *insert_values;            /* used by INSERT ... UPDATE */

uint fields;    /* field count */

uint reclength;    /* Recordlength */

// omitted…

};

struct st_table *next,*prev;

The st_table struct fulfills a variety of purposes, but its primary focus is to provide other

objects (like the user connection THD objects and the handler objects) with a mechanism to

find out meta information about the table’s structure. You can see that some of st_table’s

member variables look familiar: fields, records, default values for inserts, a length of records,

and a count of the number of fields. All these member variables provide the THD and other

consuming classes with information about the structure of the underlying table source.

11. Jeremy Zawodny and Derrek Bailing, High Performance MySQL (O’Reilly, 2004), p 242.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

This struct also serves to provide a method of linking the storage engine to the table, so

that the THD objects may call on the storage engine to execute requests involving the table.

Thus, one of the member variables (*file) of the st_table struct is a pointer to the storage

engine (handler subclass), which handles the actual reading and writing of records in the table

and indexes associated with it. Note that the developers named the member variable for the

handler as file, bringing us to an important point: the handler represents a link for this in-

memory table structure to the physical storage managed by the storage engine (handler). This

is why you will sometimes hear some folks refer to the number of open file descriptors in the

system. The handler class pointer represents this physical file-based link.

The st_table struct is implemented as a linked list, allowing for the creation of a list of

used tables during executions of statements involving multiple tables, facilitating their navi-

gation using the next and prev pointers. The table cache is a hash structure of these st_table

structs. Each of these structs represents an in-memory representation of a table schema. If the

handler member variable of the st_table is an ha_myisam (MyISAM’s storage engine handler

subclass), that means that the .frm file has been read from disk and its information dumped

into the st_table struct. The task of initializing the st_table struct with the information from

the .frm file is relatively expensive, and so MySQL caches these st_table structs in the table

cache for use by the THD objects executing queries.

■Note Remember that the key cache stores index blocks from the .MYI files, and the table cache stores

st_table structs representing the .frm files. Both caches serve to minimize the amount of disk-based

activity needed to open, read, and close those files.

It is very important to understand that the table cache does not share cached st_table

structs between user connection threads. The reason for this is that if a number of concur-

rently executing threads are executing statements against a table whose schema may change,

it would be possible for one thread to change the schema (the .frm file) while another thread

is relying on that schema. To avoid these issues, MySQL ensures that each concurrent thread

has its own set of st_table structs in the table cache. This feature has confounded some

MySQL users in the past when they issue a request like the following:

mysql> SHOW STATUS LIKE 'Open_%';

and see a result like this:

+---------------+-------+

| Variable_name | Value |

+---------------+-------+

| Open_tables   | 200   |

| Open_files    | 315   |

| Open_streams  | 0     |

| Opened_tables | 216   |

+---------------+-------+

4 rows in set (0.03 sec)

knowing that they have only ten tables in their database.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

The reason for the apparently mismatched open table numbers is that MySQL opens a

new st_table struct for each concurrent connection. For each opened table, MySQL actually

needs two file descriptors (pointers to files on disk): one for the .frm file and another for the

.MYD file. The .MYI file is shared among all threads, using the key cache. But just like the key

cache, the table cache has only a certain amount of space, meaning that a certain number of

st_table structs will fit in there. The default is 64, but this is modifiable using the table_cache

configuration variable. As with the key cache, MySQL provides some monitoring variables for

you to use in assessing whether the size of your table cache is sufficient:

• Open_tables: This variable stores the number of table schemas opened by all storage

engines for all concurrent threads.

• Open_files: This variable stores the number of actual file descriptors currently opened

by the server, for all storage engines.

• Open_streams: This will be zero unless logging is enabled for the server.

• Opened_tables: This variable stores the total number of table schemas that have been

opened since the server started, across all concurrent threads.

If the Opened_tables status variable is substantially higher than the Open_tables status

variable, you may want to increase the table_cache configuration variable. However, be aware

of some of the limitations presented by your operating system for file descriptor use. See the

MySQL manual for some gotchas: http://dev.mysql.com/doc/mysql/en/table-cache.html.

■Caution There is some evidence in the MySQL source code comments that the table cache is being

redesigned. For future versions of MySQL, check the changelog to see if this is indeed the case. See the

code comments in the sql/sql_cache.cc for more details.

Hostname Cache

The hostname cache serves to facilitate the quick lookup of hostnames. This cache is particularly

useful on servers that have slow DNS servers, resulting in time-consuming repeated lookups. Its

implementation is available in /sql/hostname.cc, with the following globally available variable

declaration:

static hash_filo *hostname_cache;

As is implied by its name, hostname_cache is a first-in/last-out (FILO) hash structure.

/sql/hostname.cc contains a number of functions that initialize, add to, and remove items

from the cache. hostname_cache_init(), add_hostname(), and ip_to_hostname() are some of

the functions you’ll find in this file.

Privilege Cache

MySQL keeps a cache of the privilege (grant) information for user accounts in a separate

cache. This cache is commonly called an ACL, for access control list. The definition and imple-

mentation of the ACL can be found in /sql/sql_acl.h and /sql/sql_acl.cc. These files


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

define a number of key classes and structs used throughout the user access and grant man-

agement system, which we’ll cover in the “Access and Grant Management” section later in this

chapter.

The privilege cache is implemented in a similar fashion to the hostname cache, as a FILO

hash (see /sql/sql_acl.cc):

static hash_filo *acl_cache;

acl_cache is initialized in the acl_init() function, which is responsible for reading the

contents of the mysql user and grant tables (mysql.user, mysql.db, mysql.tables_priv, and

mysql.columns_priv) and loading the record data into the acl_cache hash. The most interest-

ing part of the function is the sorting process that takes place. The sorting of the entries as

they are inserted into the cache is important, as explained in Chapter 15. You may want to

take a look at acl_init() after you’ve read that chapter.

Other Caches

MySQL employs other caches internally for specialized uses in query execution and optimization.

For instance, the heap table cache is used when SELECT…GROUP BY or DISTINCT statements find

all the rows in a MEMORY storage engine table. The join buffer cache is used when one or more

tables in a SELECT statement cannot be joined in anything other than a FULL JOIN, meaning that

all the rows in the table must be joined to the results of all other joined table results. This opera-

tion is expensive, and so a buffer (cache) is created to speed the returning of result sets. We’ll cover

JOIN queries in great detail in Chapter 7.

Network Management and Communication

The network management and communication system is a low-level subsystem that handles

the work of sending and receiving network packets containing MySQL connection requests

and commands across a variety of platforms. The subsystem makes the various communica-

tion protocols, such as TCP/IP or Named Pipes, transparent for the connection thread. In this

way, it releases the query engine from the responsibility of interpreting the various protocol

packet headers in different ways. All the query engine needs to know is that it will receive from

the network and connection management subsystem a standard data structure that complies

with an API.

The network and connection management function library can be found in the files listed

Table 4-4. Network and Connection Management Subsystem Files

Contents

The client/server network layer API and protocol for

communications between the client and server

Definitions for common structs used in the communication

between the client and server

Addresses some portability and thread-safe issues for various

networking functions

in Table 4-4.

File

/sql/net_pkg.cc

/include/mysql_com.h

/include/my_net.h


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

The main struct used in client/server communications is the st_net struct, aliased as NET.

This struct is defined in /include/mysql_com.h. The definition for NET is shown in Listing 4-4.

Listing 4-4. st_net Struct Definition

typedef struct st_net {

Vio* vio;

unsigned char *buff,*buff_end,*write_pos,*read_pos;

my_socket fd;    /* For Perl DBI/dbd */

unsigned long max_packet,max_packet_size;

unsigned int pkt_nr,compress_pkt_nr;

unsigned int write_timeout, read_timeout, retry_count;

int fcntl;

my_bool compress;

/*

The following variable is set if we are doing several queries in one

command ( as in LOAD TABLE ... FROM MASTER ),

and do not want to confuse the client with OK at the wrong time

*/

unsigned long remain_in_buf,length, buf_length, where_b;

unsigned int *return_status;

unsigned char reading_or_writing;

char save_char;

my_bool no_send_ok;  /* For SPs and other things that do multiple stmts */

my_bool no_send_eof; /* For SPs' first version read-only cursors */

/*

Pointer to query object in query cache, do not equal NULL (0) for

queries in cache that have not stored its results yet

*/

char last_error[MYSQL_ERRMSG_SIZE], sqlstate[SQLSTATE_LENGTH+1];

unsigned int last_errno;

unsigned char error;

gptr query_cache_query;

my_bool report_error; /* We should report error (we have unreported error) */

my_bool return_errno;

} NET;

The NET struct is used in client/server communications as a handler for the communica-

tion protocol. The buff member variable of NET is filled with a packet by either the server or

client. These packets, like all packets used in communications protocols, follow a rigid format,

containing a fixed header and the packet data.

Different packet types are sent for the various legs of the trip between the client and server.

The legs of the trip correspond to the diagram in Figure 4-3, which shows the communication

between the client and server.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

CLIENT SIDE

Packet Format:

2-byte CLIENT_xxx options

3-byte max_allowed_packet

n-byte username

1-byte 0x00

8-byte encrypted password

1-byte 0x00

n-byte database name

1-byte 0x00

Login packet

received by client

Credentials packet

sent by client

Packet Format:

1-byte command type

n-byte query text

Command packet

sent by client

OK packet

received by client

Result set packet

received by client

Login packet

sent by server

Credentials packet

received by server

OK packet

sent by server

Command packet

received by

server

Result packet

sent by server

SERVER SIDE

Packet Format:

1-byte protocol version

n-byte server version

1-byte 0x00

4-byte thread number

8-byte crypt seed

1-byte 0x00

2-byte CLIENT_xxx options

1-byte number of current server charset

2-byte server status flags

13-byte 0x00 )reserved)

Packet Format:

1-byte number of rows (always 0)

1- to 8-bytes num affected rows

1- to 8-bytes last insert id

2-byte status flag (usually 0)

If OK packet contains a

message then:

1- to 8-bytes length of message

n-bytes message text

Packet Format:

1- to 8-bytes num fields in results

If the num fields equals 0, then:

(We know it is a command (versus select))

1- to 8-bytes affected rows count

1- to 8-bytes insert id

2-bytes server status flags

If field count greater than zero, then:

send n packets comprised of:

header info

column info for each column in result

result packets

Figure 4-3. Client/server communication

In Figure 4-3, we’ve included some basic notation of the packet formats used by the various

legs of the communication trip. Most are self-explanatory. The result packets have a standard

header, described in the protocol, which the client uses to obtain information about how many

result packets will be received to get all the information back from the server.

The following functions actually move the packets into the NET buffer:

• my_net_write(): This function stores a packet to be sent in the NET->buff member variable.

• net_flush(): This function sends the packet stored in the NET->buff member variable.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

• net_write_command(): This function sends a command packet (1 byte; see Figure 4-3)

from the client to the server.

• my_net_read(): This function reads a packet in the NET struct.

These functions can be found in the /sql/net_serv.cc source file. They are used by the

various client and server communication functions (like mysql_real_connect(), found in

/libmysql/libmysql.c in the C client API). Table 4-5 lists some other functions that operate

with the NET struct and send packets to and from the server.

Table 4-5. Some Functions That Send and Receive Network Packets

Function

File

Purpose

mysql_real_connect()

/libmysql/client.c

mysql_real_query()

/libmysql/client.c

Connects to the mysqld server. Look for the

CLI_MYSQL_REAL_CONNECT function, which

handles the connection from the client to

the server.

Sends a query to the server and reads the

OK packet or columns header returned

from the server. The packet returned

depends on whether the query was a

command or a resultset returning SHOW

or SELECT.

Takes a resultset sent from the server

entirely into client-side memory by

reading all sent packets definitions

Contains some useful definitions of the

structs used by the client API, namely

MYSQL and MYSQL_RES, which represent

the MySQL client session and results

returned in it.

mysql_store_result()

/libmysql/client.c

various

/include/mysql.h

■Note The internals.texi documentation thoroughly explains the client/server communications protocol.

Some of the file references, however, are a little out-of-date for version 5.0.2’s source distribution. The directories

and filenames in Table 4-5 are correct, however, and should enable you to investigate this subsystem yourself.

Access and Grant Management

A separate set of functions exists solely for the purpose of checking the validity of incoming

connection requests and privilege queries. The access and grant management subsystem

defines all the GRANTs needed to execute a given command (see Chapter 15) and has a set of

functions that query and modify the in-memory versions of the grant tables, as well as some

utility functions for password generation and the like. The bulk of the subsystem is contained

in the /sql/sql_acl.cc file of the source tree. Definitions are available in /sql/sql_acl.h, and

the implementation is in /sql/sql_acl.cc. You will find all the actual GRANT constants defined

at the top of /sql/sql_acl.h, as shown in Listing 4-5.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Listing 4-5. Constants Defined in sql_acl.h

#define SELECT_ACL    (1L << 0)

#define INSERT_ACL    (1L << 1)

#define UPDATE_ACL    (1L << 2)

#define DELETE_ACL    (1L << 3)

#define CREATE_ACL    (1L << 4)

#define DROP_ACL    (1L << 5)

#define RELOAD_ACL    (1L << 6)

#define SHUTDOWN_ACL    (1L << 7)

#define PROCESS_ACL    (1L << 8)

#define FILE_ACL    (1L << 9)

#define GRANT_ACL    (1L << 10)

#define REFERENCES_ACL    (1L << 11)

#define INDEX_ACL    (1L << 12)

#define ALTER_ACL    (1L << 13)

#define SHOW_DB_ACL    (1L << 14)

#define SUPER_ACL    (1L << 15)

#define CREATE_TMP_ACL    (1L << 16)

#define LOCK_TABLES_ACL    (1L << 17)

#define EXECUTE_ACL    (1L << 18)

#define REPL_SLAVE_ACL    (1L << 19)

#define REPL_CLIENT_ACL    (1L << 20)

#define CREATE_VIEW_ACL    (1L << 21)

#define SHOW_VIEW_ACL    (1L << 22)

These constants are used in the ACL functions to compare user and hostname privileges. The

<< operator is bit-shifting a long integer one byte to the left and defining the named constant as

the resulting power of 2. In the source code, these constants are compared using Boolean opera-

tors in order to determine if the user has appropriate privileges to access a resource. If a user is

requesting access to a resource that requires more than one privilege, these constants are ANDed

together and compared to the user’s own access integer, which represents all the privileges the

user has been granted.

We won’t go into too much depth here, because Chapter 15 covers the ACL in detail, but

Table 4-6 shows a list of functions in this library.

Table 4-6. Selected Functions in the Access Control Subsystem

Function

acl_get()

check_grant()

Purpose

Returns the privileges available for a user, host, and database

combination (database privileges).

Determines whether a user thread THD’s user has appropriate

permissions on all tables used by the requested statement

on the thread.

check_grant_column()

Same as check_grant(), but on a specific column.

check_grant_all_columns()

Checks all columns needed in a user thread’s field list.

mysql_create_user()

Creates one or a list of users; called when a command received

over a user thread creates users, such as GRANT ALL ON *.* ➥

TO 'jpipes'@'localhost', 'mkruck'@'localhost'.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Feel free to roam around the access control function library and get a feel for these core

functions that handle the security between the client and server.

Log Management

In one of the more fully encapsulated subsystems, the log management subsystem imple-

ments an inheritance design whereby a variety of log event subclasses are consumed by a log

class. Similar to the strategy deployed for storage engine abstraction, this strategy allows the

MySQL developers to add different logs and log events as needed, without breaking the sub-

system’s core functionality.

The main log class, MYSQL_LOG, is shown in Listing 4-6 (we’ve stripped out some material

for brevity and highlighted the member variables and methods).

Listing 4-6. MYSQL_LOG Class Definition

class MYSQL_LOG

{

private:

/* LOCK_log and LOCK_index are inited by init_pthread_objects() */

pthread_mutex_t LOCK_log, LOCK_index;

// ... omitted

IO_CACHE log_file;

// ... omitted

volatile enum_log_type log_type;

// ... omitted

public:

MYSQL_LOG();

~MYSQL_LOG();

// ... omitted

void set_max_size(ulong max_size_arg);

void signal_update();

void wait_for_update(THD* thd, bool master_or_slave);

void set_need_start_event() { need_start_event = 1; }

void init(enum_log_type log_type_arg,

enum cache_type io_cache_type_arg,

bool no_auto_events_arg, ulong max_size);

void init_pthread_objects();

void cleanup();

bool open(const char *log_name,enum_log_type log_type,

const char *new_name, const char *index_file_name_arg,

enum cache_type io_cache_type_arg,

bool no_auto_events_arg, ulong max_size,

bool null_created);

void new_file(bool need_lock= 1);

bool write(THD *thd, enum enum_server_command command,

const char *format,...);

bool write(THD *thd, const char *query, uint query_length,


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

bool write(Log_event* event_info); // binary log write

bool write(THD *thd, IO_CACHE *cache, bool commit_or_rollback);

/*

v stands for vector

invoked as appendv(buf1,len1,buf2,len2,...,bufn,lenn,0)

*/

bool appendv(const char* buf,uint len,...);

bool append(Log_event* ev);

// ... omitted

int purge_logs(const char *to_log, bool included,

bool need_mutex, bool need_update_threads,

ulonglong *decrease_log_space);

int purge_logs_before_date(time_t purge_time);

// ... omitted

void close(uint exiting);

// ... omitted

void report_pos_in_innodb();

// iterating through the log index file

int find_log_pos(LOG_INFO* linfo, const char* log_name,

bool need_mutex);

int find_next_log(LOG_INFO* linfo, bool need_mutex);

int get_current_log(LOG_INFO* linfo);

// ... omitted

};

This is a fairly standard definition for a logging class. You'll notice the various member

methods correspond to things that the log must do: open, append stuff, purge records from

itself, and find positions inside itself. Note that the log_file member variable is of type

IO_CACHE. You may recall from our earlier discussion of the record cache that the IO_CACHE

can be used for writing as well as reading. This is an example of how the MYSQL_LOG class uses

the IO_CACHE structure for exactly that.

Three global variables of type MYSQL_LOG are created in /sql/mysql_priv.h to contain the

three logs available in global scope:

extern MYSQL_LOG mysql_log,mysql_slow_log,mysql_bin_log;

During server startup, a function called init_server_components(), found in /sql/mysqld.cc,

actually initializes any needed logs based on the server’s configuration. For instance, if the server

is running with the binary log enabled, then the mysql_bin_log global MYSQL_LOG instance is ini-

tialized and opened. It is also checked for consistency and used in recovery, if necessary. The

function open_log(), also found in /sql/mysqld.cc, does the job of actually opening a log file

and constructing a MYSQL_LOG object.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Also notice that a number of the member methods accept arguments of type Log_event,

namely write() and append(). The Log_event class represents an event that is written to a

MYSQL_LOG object. Log_event is a base (abstract) class, just like handler is for the storage

engines, and a number of subclasses derive from it. Each of the subclasses corresponds to

a specific event and contains information on how the event should be recorded (written)

to the logs. Here are some of the Log_event subclasses:

• Query_log_event: This subclass logs when SQL queries are executed.

• Load_log_event: This subclass logs when the logs are loaded.

• Intvar_log_event: This subclass logs special variables, such as auto_increment values.

• User_var_log_event: This subclass logs when a user variable is set. This event is

recorded before the Query_log_event, which actually sets the variable.

The log management subsystem can be found in the source files listed in Table 4-7. The

definitions for the main log class (MYSQL_LOG) can be found in /sql/sql_class.h, so don’t look

for a log.h file. There isn’t one. Developer’s comments note that there are plans to move log-

specific definitions into their own header file at some later date.

Table 4-7. Log Management Source Files

File

Contents

/sql/sql_class.h

The definition of the MYSQL_LOG class

/sql/log_event.h

Definitions of the various Log_event class and subclasses

/sql/log_event.cc

The implementation of Log_event subclasses

/sql/log.cc

The implementation of the MYSQL_LOG class

/sql/ha_innodb.h

The InnoDB-specific log implementation (covered in the next chapter)

Note that this separation of the logging subsystem allows for a variety of system activi-

ties—from startup, to multistatement transactions, to auto-increment value changes—to be

logged via the subclass implementations of the Log_event::write() method. For instance, the

Intvar_log_event subclass handles the logging of AUTO_INCREMENT values and partly imple-

ments its logging in the Intvar_log_event::write() method.

Query Parsing, Optimization, and Execution

You can consider the query parsing, optimization, and execution subsystem to be the brains

behind the MySQL database server. It is responsible for taking the commands brought in on

the user’s thread and deconstructing the requested statements into a variety of data structures

that the database server then uses to determine the best path to execute the requested statement.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Parsing

This process of deconstruction is called parsing, and the end result is sometimes referred to as

an abstract syntax tree. MySQL’s parser was actually generated from a program called Bison.12

Bison generates the parser using a tool called YACC, which stands for Yet Another Compiler

Compiler. YACC accepts a stream of rules. These rules consist of a regular expression and a

snippet of C code designed to handle any matches made by the regular expression. YACC then

produces an executable that can take an input stream and “cut it up” by matching on regular

expressions. It then executes the C code paired with each regular expression in the order in

which it matches the regular expression.13 Bison is a complex program that uses the YACC com-

piler to generate a parser for a specific set of symbols, which form the lexicon of the parsable

language.

■Tip If you’re interested in more information about YACC, Bison, and Lex, see http://dinosaur.

compilertools.net/.

The MySQL query engine uses this Bison-generated parser to do the grunt work of cutting

up the incoming command. This step of parsing not only standardizes the query into a tree-like

request for tables and joins, but it also acts as an in-code representation of what the request

needs in order to be fulfilled. This in-code representation of a query is a struct called Lex. Its defi-

nition is available in /sql/sql_lex.h. Each user thread object (THD) has a Lex member variable,

which stores the state of the parsing.

As parsing of the query begins, the Lex struct fills out, so that as the parsing process exe-

cutes, the Lex struct is filled with an increasing amount of information about the items used in

the query. The Lex struct contains member variables to store lists of tables used by the query,

fields used in the query, joins needed by the query, and so on. As the parser operates over

the query statements and determines which items are needed by the query, the Lex struct is

updated to reflect the needed items. So, on completion of the parsing, the Lex struct contains

a sort of road map to get at the data. This road map includes the various objects of interest to

the query. Some of Lex’s notable member variables include the following:

• table_list and group_list are lists of tables used in the FROM and GROUP BY clauses.

• top_join_list is a list of tables for the top-level join.

• order_list is a list of tables in the ORDER BY clause.

• where and having are variables of type Item that correspond to the WHERE and HAVING

clauses.

• select_limit and offset_limit are used in the LIMIT clause.

12. Bison was originally written by Richard Stallman.

13. The order of matching a regular expression is not necessarily the order in which a particular word

appears in the input stream.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

■Tip At the top of /sql/sql_lex.h, you will see an enumeration of all of the different SQL commands that

may be issued across a user connection. This enumeration is used throughout the parsing and execution

process to describe the activity occurring.

In order to properly understand what’s stored in the Lex struct, you’ll need to investigate

the definitions of classes and structs defined in the files listed in Table 4-8. Each of these files

represents the core units of the SQL query execution engine.

Table 4-8. Core Classes Used in SQL Query Execution and Parsing

File

Contents

/sql/field.h and /sql/field.cc

Definition and implementation of the Field class

/sql/item.h and /sql/item.cc

Definition and implementation of the Item class

/sql/item_XXX.h and /sql/item_XXX.cc

Definition and implementation of the specialized

Item_ classes used to represent various objects in

database; for instance, Item_row and Item_subselect

Definition and implementation of the various generic

classes and THD

/sql/sql_class.h and /sql/sql_class.cc

The different Item_XXX files implement the various components of the SQL language: its

operators, expressions, functions, rows, fields, and so on.

At its source, the parser uses a table of symbols that correspond to the parts of a query or

command. This symbol table can be found in /sql/lex.h, /sql/lex_symbol.h, and /sql/lex_hash.h.

The symbols are really just the keywords supported by MySQL, including ANSI standard SQL and

all of the extended functions usable in MySQL queries. These symbols make up the lexicon of the

query engine; the symbols are the query engine’s alphabet of sorts.

Don’t confuse the files in /sql/lex* with the Lex class. They’re not the same. The /sql/lex*

files contain the symbol tables that act as tokens for the parser to deconstruct the incoming SQL

statement into machine-readable structures, which are then passed on to the optimization

processes.

You may view the MySQL-generated parser in /sql/sql_yacc.cc. Have fun. It’s obscenely

complex. The meat of the parser begins on line 11676 of that file, where the yyn variable is

checked and a gigantic switch statement begins. The yyn variable represents the currently

parsed symbol number. Looking at the source file for the parser will probably result in a mind

melt. For fun, we’ve listed some of the files that implement the parsing functionality in Table 4-9.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Table 4-9. Parsing and Lexical Generation Implementation Files

File

/sql/lex.h

Contents

The base symbol table for parsing.

/sql/lex_symbol.h

Some more type definitions for the symbol table.

/sql/lex_hash.h

/sql/sql_lex.h

/sql/sql_lex.cc

/sql/sql_yacc.h

/sql/sql_yacc.cc

/sql/sql_parse.cc

A mapping of symbols to functions.

The definition of the Lex class and other parsing structs.

The implementation of the Lex class.

Definitions used in the parser.

The Bison-generated parser implementation

Ties in all the different pieces and parts of the parser, along with a huge

library of functions used in the query parsing and execution stages.

Optimization

Much of the optimization of the query engine comes from the ability of this subsystem to

“explain away” parts of a query, and to find the most efficient way of organizing how and in

which order separate data sets are retrieved and merged or filtered. We’ll go into the details of

the optimization process in Chapters 6 and 7, so stay tuned. Table 4-10 shows a list of the main

files used in the optimization system.

Table 4-10. Files Used in the Optimization System

File

/sql/sql_select.h

/sql/sql_select.cc

/sql/opt_sum.cc

/sql/opt_range.h and /sql/opt_range.cc

Contents

Definitions for classes and structs used in the

SELECT statements, and thus, classes used in

the optimization process

The implementation of the SELECT statement and

optimization system

The definition and implementation of range query

optimization routines

The implementation of aggregation optimization

(MIN/MAX/GROUP BY)

For the most part, optimization of SQL queries is needed only for SELECT statements, so it

is natural that most of the optimization work is done in /sql/sql_select.cc. This file uses the

structs defined in /sql/sql_select.h. This header file contains the definitions for some of the

most widely used classes and structs in the optimization process: JOIN, JOIN_TAB, and JOIN_CACHE.

The bulk of the optimization work is done in the JOIN::optimize() member method. This com-

plex member method makes heavy use of the Lex struct available in the user thread (THD) and the

corresponding road map into the SQL request it contains.

JOIN::optimize() focuses its effort on “optimizing away” parts of the query execution by

eliminating redundant WHERE conditions and manipulating the FROM and JOIN table lists into

the smoothest possible order of tables. It executes a series of subroutines that attempt to opti-

mize each and every piece of the JOIN conditions and WHERE clause.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Execution

Once the path for execution has been optimized as much as possible, the SQL commands

must be executed by the statement execution unit. The statement execution unit is the func-

tion responsible for handling the execution of the appropriate SQL command. For instance,

the statement execution unit for the SQL INSERT commands is mysql_insert(), which is found

in /sql/sql_insert.cc. Similarly, the SELECT statement execution unit is mysql_select(),

housed in /sql/sql_select.cc. These base functions all have a pointer to a THD object as their

first parameter. This pointer is used to send the packets of result data back to the client. Take a

look at the execution units to get a feel for how they operate.

The Query Cache

The query cache is not a subsystem, per se, but a wholly separate set of classes that actually

do function as a component. Its implementation and documentation are noticeably different

from other subsystems, and its design follows a cleaner, more component-oriented approach

than most of the rest of the system code.14 We’ll take a few moments to look at its implemen-

tation and where you can view the source and explore it for yourself.

The purpose of the query cache is not just to cache the SQL commands executed on the

server, but also to store the actual results of those commands. This special ability is, as far as

we know, unique to MySQL. Its addition to the MySQL source distribution, as of version 4.0.1,

greatly improves MySQL’s already impressive performance. We’ll take a look at how the query

cache can be used. Right now, we’ll focus on the internals.

The query cache is a single class, Query_cache, defined in /sql/sql_cache.h and imple-

mented in /sql/sql_cache.cc. It is composed of the following:

• Memory pool, which is a cache of memory blocks (cache member variable) used to

store the results of queries

• Hash table of queries (queries member variable)

• Hash table of tables (tables member variable)

• Linked lists of all the blocks used for storing queries, tables, and the root block

The memory pool (cache member variable) contains a directory of both the allocated (used)

memory blocks and the free blocks, as well as all the actual blocks of data. In the source docu-

mentation, you’ll see this directory structure referred to as memory bins, which accurately

reflects the directory’s hash-based structure.

A memory block is a specially defined allocation of the query cache’s resources. It is not

an index block or a block on disk. Each memory block follows the same basic structure. It has

a header, represented by the Query_cache_block struct, shown in Listing 4-7 (some sections

are omitted for brevity).

14. This may be due to a different developer or developers working on the code than in other parts of the

source code, or simply a change of approach over time taken by the development team.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Listing 4-7. Query_cache_block Struct Definition (Abridged)

struct Query_cache_block

{

enum block_type {FREE, QUERY, RESULT, RES_CONT, RES_BEG,

RES_INCOMPLETE, TABLE, INCOMPLETE};

ulong length;                 // length of all block

ulong used;                   // length of data

// … omitted

Query_cache_block *pnext,*pprev,      // physical next/previous block

*next,*prev;        // logical next/previous block

block_type type;

TABLE_COUNTER_TYPE n_tables;          // number of tables in query

// ... omitted

};

As you can see, it’s a simple header struct that contains a block type (type), which is one

of the enum values defined as block_type. Additionally, there is a length of the whole block

and the length of the block used for data. Other than that, this struct is a simple doubly linked

list of other Query_cache_block structs. In this way, the Query_cache.cache contains a chain of

these Query_cache_block structs, each containing different types of data.

When user thread (THD) objects attempt to fulfill a statement request, the Query_cache

is first asked to see if it contains an identical query as the one in the THD. If it does, the

Query_cache uses the send_result_to_client() member method to return the result in its

memory pool to the client THD. If not, it tries to register the new query using the store_query()

member method.

The rest of the Query_cache implementation, found in /sql/sql_cache.cc, is concerned

with managing the freshness of the memory pool and invalidating stored blocks when a

modification is made to the underlying data source. This invalidation process happens when

an UPDATE or DELETE statement occurs on the tables connected to the query result stored in

the block. Because a list of tables is associated with each query result block (look for the

Query_cache_result struct in /sql/sql_cache.h), it is a trivial matter for the Query_cache to

look up which blocks are invalidated by a change to a specific table’s data.

A Typical Query Execution

In this section, we’re going to explore the code execution of a typical user connection that issues

a typical SELECT statement against the database server. This should give you a good picture of

how the different subsystems work with each other to complete a request. The code snippets

we’ll walk through will be trimmed down, stripped editions of the actual source code. We’ll

highlight the sections of the code to which you should pay the closest attention.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

For this exercise, we assume that the issued statement is a simple SELECT * FROM ➥

some_table WHERE field_x = 200, where some_table is a MyISAM table. This is important,

because, as you’ll see, the MyISAM storage engine will actually execute the code for the

request through the storage engine abstraction layer.

We’ll begin our journey at the starting point of the MySQL server, in the main() routine of

/sql/mysqld.cc, as shown in Listing 4-8.

Listing 4-8. /sql/mysqld.cc main()

int main(int argc, char **argv)

{

init_common_variables(MYSQL_CONFIG_NAME,

argc, argv, load_default_groups);

init_ssl();

server_init();

init_server_components();

start_signal_handler();               // Creates pidfile

acl_init((THD *)0, opt_noacl);

init_slave();

create_shutdown_thread();

create_maintenance_thread();

handle_connections_sockets(0);

DBUG_PRINT("quit",("Exiting main thread"));

exit(0);

}

This is where the main server process execution begins. We’ve highlighted some of the

more interesting sections. init_common_variables() works with the command-line arguments

used on executing mysqld or mysqld_safe, along with the MySQL configuration files. We’ve

gone over some of what init_server_components() and acl_init() do in this chapter. Basi-

cally, init_server_components() makes sure the MYSQL_LOG objects are online and working,

and acl_init() gets the access control system up and running, including getting the privilege

cache into memory. When we discussed the thread and resource management subsystem, we

mentioned that a separate thread is created to handle maintenance tasks and also to handle

shutdown events. create_maintenance_thread() and create_shutdown_thread() accomplish

getting these threads up and running.

The handle_connections_sockets() function is where things start to really get going.

Remember from our discussion of the thread and resource management subsystem that a

thread is created for each incoming connection request, and that a separate thread is in

charge of monitoring those connection threads?15 Well, this is where it happens. Let’s

take a look in Listing 4-9.

15. A thread might be taken from the connection thread pool, instead of being created.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Listing 4-9. /sql/mysqld.cc handle_connections_sockets()

handle_connections_sockets(arg attribute((unused)))

{

if (ip_sock != INVALID_SOCKET)

{

FD_SET(ip_sock,&clientFDs);

DBUG_PRINT("general",("Waiting for connections."));

while (!abort_loop)

{

new_sock = accept(sock, my_reinterpret_cast(struct sockaddr *)

(&cAddr), &length);

thd= new THD;

if (sock == unix_sock)

thd->host=(char*) my_localhost;

create_new_thread(thd);

}

}

}

The basic idea is that the mysql.sock socket is tapped for listening, and listening begins on

the socket. While the listening is occurring on the port, if a connection request is received, a new

THD struct is created and passed to the create_new_thread() function. The if (sock==unix_sock)

checks to see if the socket is a Unix socket. If so, it defaults the THD->host member variable to be

localhost. Let’s check out what create_new_thread() does, in Listing 4-10.

Listing 4-10. /sql/mysqld.cc create_new_thread()

static void create_new_thread(THD *thd)

{

DBUG_ENTER("create_new_thread");

/* don't allow too many connections */

if (thread_count - delayed_insert_threads >= max_connections+1 || abort_loop)

{

DBUG_PRINT("error",("Too many connections"));

close_connection(thd, ER_CON_COUNT_ERROR, 1);

delete thd;

DBUG_VOID_RETURN;

}

pthread_mutex_lock(&LOCK_thread_count);

if (cached_thread_count > wake_thread)

{

start_cached_thread(thd);

}

else

{


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

thread_count++;

thread_created++;

if (thread_count-delayed_insert_threads > max_used_connections)

max_used_connections=thread_count-delayed_insert_threads;

DBUG_PRINT("info",(("creating thread %d"), thd->thread_id));

pthread_create(&thd->real_id,&connection_attrib, \

handle_one_connection, (void*) thd))

(void) pthread_mutex_unlock(&LOCK_thread_count);

}

DBUG_PRINT("info",("Thread created"));

}

In this function, we’ve highlighted some important activity. You see firsthand how the

resource subsystem locks the LOCK_thread_count resource using pthread_mutex_lock(). This is

crucial, since the thread_count and thread_created variables are modified (incremented) dur-

ing the function’s execution. thread_count and thread_created are global variables shared by

all threads executing in the server process. The lock created by pthread_mutex_lock() prevents

any other threads from modifying their contents while create_new_thread() executes. This is a

great example of the work of the resource management subsystem.

Secondly, we highlighted start_cached_thread() to show you where the connection thread

pooling mechanism kicks in. Lastly, and most important, pthread_create(), part of the thread

function library, creates a new thread with the THD->real_id member variable and passes a func-

tion pointer for the handle_one_connection() function, which handles the creation of a single

connection. This function is implemented in the parsing library, in /sql/sql_parse.cc, as shown

in Listing 4-11.

Listing 4-11. /sql/sql_parse.cc handle_one_connection()

handle_one_connection(THD *thd)

{

while (!net->error && net->vio != 0 && !(thd->killed == THD::KILL_CONNECTION))

{

if (do_command(thd))

break;

}

}

We’ve removed most of this function’s code for brevity. The rest of the function focuses

on initializing the THD struct for the session. We highlighted two parts of the code listing within

the function definition. First, we’ve made the net->error check bold to highlight the fact that

the THD->net member variable struct is being used in the loop condition. This must mean

that do_command() must be sending and receiving packets, right? net is simply a pointer to the

THD->net member variable, which is the main structure for handling client/server communica-

tions, as we noted in the earlier section on the network subsystem. So, the main thing going on in

handle_one_connection() is the call to do_command(), which we’ll look at next in Listing 4-12.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Listing 4-12. /sql/sql_parse.cc do_command()

bool do_command(THD *thd)

{

char *packet;

ulong packet_length;

NET *net;

enum enum_server_command command;

packet=0;

net_new_transaction(net);

packet_length=my_net_read(net);

packet=(char*) net->read_pos;

command = (enum enum_server_command) (uchar) packet[0];

DBUG_RETURN(dispatch_command(command,thd, packet+1, (uint) packet_length));

}

{

Now we’re really getting somewhere, eh? We’ve highlighted a bunch of items in do_command()

to remind you of topics we covered earlier in the chapter.

First, remember that packets are sent using the network subsystem’s communication proto-

col. net_new_transaction() starts off the communication by initiating that first packet from the

server to the client (see Figure 4-3 for a refresher). The client uses the passed net struct and fills

the net’s buffers with the packet sent back to the server. The call to my_net_read() returns the

length of the client’s packet and fills the net->read_pos buffer with the packet string, which is

assigned to the packet variable. Voilá, the network subsystem in all its glory!

Second, we’ve highlighted the command variable. This variable is passed to the dispatch_

command() routine along with the THD pointer, the packet variable (containing our SQL state-

ment), and the length of the statement. We’ve left the DBUG_RETURN() call in there to remind

you that do_command() returns 0 when the command requests succeed to the caller, handle_

one_connection(), which, as you’ll recall, uses this return value to break out of the connection

wait loop in case the request failed.

Let’s now take a look at dispatch_command(), in Listing 4-13.

Listing 4-13. /sql/sql_parse.cc dispatch_command()

bool dispatch_command(enum enum_server_command command, THD *thd,

char* packet, uint packet_length)

switch (command) {

// ... omitted

case COM_TABLE_DUMP:

case COM_CHANGE_USER:

// ... omitted

case COM_QUERY:

{

if (alloc_query(thd, packet, packet_length))

break;                    // fatal error is set

mysql_log.write(thd,command,"%s",thd->query);

mysql_parse(thd,thd->query, thd->query_length);


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

}

// ... omitted

}

Just as the name of the function implies, all we’re doing here is dispatching the query to the

appropriate handler. In the switch statement, we get case’d into the COM_QUERY block, since we’re

executing a standard SQL query over the connection. The alloc_query() call simply pulls the

packet string into the THD->query member variable and allocates some memory for use by the

thread. Next, we use the mysql_log global MYSQL_LOG object to record our query, as is, in the log

file using the log’s write() member method. This is the General Query Log (see Chapter 6)

simply recording the query which we've requested.

Finally, we come to the call to mysql_parse(). This is sort of a misnomer, because besides

parsing the query, mysql_parse() actually executes the query as well, as shown in Listing 4-14.

Listing 4-14. /sql/sql_parse.cc mysql_parse()

void mysql_parse(THD *thd, char *inBuf, uint length)

{

if (query_cache_send_result_to_client(thd, inBuf, length) <= 0)

{

LEX *lex= thd->lex;

yyparse((void *)thd);

mysql_execute_command(thd);

query_cache_end_of_result(thd);

}

DBUG_VOID_RETURN;

}

Here, the server first checks to see if the query cache contains an identical query request

that it may use the results from instead of actually executing the command. If there is no hit on

the query cache, then the THD is passed to yyparse() (the Bison-generated parser for MySQL) for

parsing. This function fills the THD->Lex struct with the optimized road map we discussed earlier

in the section about the query parsing subsystem. Once that is done, we go ahead and execute

the command with mysql_execute_command(), which we’ll look at in a second. Notice, though,

that after the query is executed, the query_cache_end_of_result() function awaits. This function

simply lets the query cache know that the user connection thread handler (thd) is finished pro-

cessing any results. We’ll see in a moment how the query cache actually stores the returned

resultset.

Listing 4-15 shows the mysql_execute_command().

Listing 4-15. /sql/sql_parse.cc mysql_execute_command()

bool mysql_execute_command(THD *thd)

{

all_tables= lex->query_tables;

statistic_increment(thd->status_var.com_stat[lex->sql_command],

&LOCK_status);

switch (lex->sql_command) {


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

case SQLCOM_SELECT:

{

select_result *result=lex->result;

check_table_access(thd,

lex->exchange ? SELECT_ACL | FILE_ACL :

SELECT_ACL,

all_tables, 0);

open_and_lock_tables(thd, all_tables);

query_cache_store_query(thd, all_tables);

res= handle_select(thd, lex, result);

break;

}

case SQLCOM_PREPARE:

case SQLCOM_EXECUTE:

// ...

send_ok(thd);

break;

}

}

default:                  /* Impossible */

In mysql_execute_command(), we see a number of interesting things going on. First, we

highlighted the call to statistic_increment() to show you an example of how the server

updates certain statistics. Here, the statistic is the com_stat variable for SELECT statements.

Secondly, you see the access control subsystem interplay with the execution subsystem in

the check_table_access() call. This checks that the user executing the query through THD

has privileges to the list of tables used by the query.

Of special interest is the open_and_lock_tables() routine. We won’t go into the code for it

here, but this function establishes the table cache for the user connection thread and places

any locks needed for any of the tables. Then we see query_cache_store_query(). Here, the

query cache is storing the query text used in the request in its internal HASH of queries. And

finally, there is the call to handle_select(), which is where we see the first major sign of the

storage engine abstraction layer. handle_select() is implemented in /sql/sql_select.cc, as

shown in Listing 4-16.

Listing 4-16. /sql/sql_select.cc handle_select()

bool handle_select(THD *thd, LEX *lex, select_result *result)

{

res= mysql_select(thd, &select_lex->ref_pointer_array,

(TABLE_LIST*) select_lex->table_list.first,

select_lex->with_wild, select_lex->item_list,

select_lex->where,

select_lex->order_list.elements +

select_lex->group_list.elements,

(ORDER*) select_lex->order_list.first,

(ORDER*) select_lex->group_list.first,


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

select_lex->having,

(ORDER*) lex->proc_list.first,

select_lex->options | thd->options,

result, unit, select_lex);

DBUG_RETURN(res);

As you can see in Listing 4-17, handle_select() is nothing more than a wrapper for the

statement execution unit, mysql_select(), also in the same file.

}

{

}

}

Listing 4-17. /sql/sql_select.cc mysql_select()

bool mysql_select(THD *thd, Item ***rref_pointer_array,

TABLE_LIST *tables, uint wild_num, List<Item> &fields,

COND *conds, uint og_num,  ORDER *order, ORDER *group,

Item *having, ORDER *proc_param, ulong select_options,

select_result *result, SELECT_LEX_UNIT *unit,

SELECT_LEX *select_lex)

JOIN *join;

join= new JOIN(thd, fields, select_options, result);

join->prepare(rref_pointer_array, tables, wild_num,

conds, og_num, order, group, having, proc_param,

select_lex, unit));

join->optimize();

join->exec();

Well, it seems that mysql_select() has shrugged the responsibility of executing the

SELECT statement off onto the shoulders of a JOIN object. We’ve highlighted the code sections

in Listing 4-17 to show you where the optimization process occurs.

Now, let’s move on to the JOIN::exec() implementation, in Listing 4-18.

Listing 4-18. /sql/sql_select.cc JOIN:exec()

void JOIN::exec()

{

error= do_select(curr_join, curr_fields_list, NULL, procedure);

thd->limit_found_rows= curr_join->send_records;

thd->examined_row_count= curr_join->examined_rows;

Oh, heck, it seems that we’ve run into another wrapper. JOIN::exec() simply calls the

do_select() routine to do its dirty work. However, we do acknowledge that once do_select()

returns, we have some information about record counts to populate some of the THD member

variables. Let’s take a look at do_select() in Listing 4-19. Maybe that function will be the

answer.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Listing 4-19. /sql/sql_select.cc do_select()

static int do_select(JOIN *join,List<Item> *fields,TABLE \

*table,Procedure *procedure)

{

}

JOIN_TAB *join_tab;

sub_select(join,join_tab,0);

join->result->send_eof())

This looks a little more promising. We see that join object’s result member variable

sends an end-of-file (EOF) marker after a call to another function called sub_select(), so

we must be getting closer. From this behavior, it looks as though the sub_select() function

should fill the result member variable of the join object with some records. Let’s see whether

we’re right, in Listing 4-20.

Listing 4-20. /sql/sql_select.cc sub_select ()

static int sub_select(JOIN *join,JOIN_TAB *join_tab,bool end_of_records)

{

join_init_read_record(join_tab);

READ_RECORD *info= &join_tab->read_record;

join->thd->row_count= 0;

do

{

join->examined_rows++;

join->thd->row_count++;

} while (info->read_record(info)));

}

return 0;

}

The key to the sub_select()16 function is the do…while loop, which loops until a

READ_RECORD struct variable (info) finishes calling its read_record() member method. Do

you remember the record cache we covered earlier in this chapter? Does the read_record()

function look familiar? You’ll find out in a minute.

■Note The READ_RECORD struct is defined in /sql/structs.h. It represents a record in the MySQL inter-

nal format.

16. We’ve admittedly taken a few liberties in describing the sub_select() function here. The real sub_select()

function is quite a bit more complicated than this. Some very advanced and complex C++ paradigms,

such as recursion through function pointers, are used in the real sub_select() function. Additionally, we

removed much of the logic involved in the JOIN operations, since, in our example, this wasn’t needed.

In short, we kept it simple, but the concept of the function is still the same.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

But first, the join_init_read_record() function, shown in Listing 4-21, is our link (finally!)

to the storage engine abstraction subsystem. The function initializes the records available in

the JOIN_TAB structure and populates the read_record member variable with a READ_RECORD

object. Doesn’t look like much when we look at the implementation of join_init_read_

records(), does it?

Listing 4-21. /sql/sql_select.cc join_init_read_record()

static int join_init_read_record(JOIN_TAB *tab)

{

init_read_record(&tab->read_record, tab->join->thd, tab->table,

tab->select,1,1);

return (*tab->read_record.read_record)(&tab->read_record);

}

{

}

It seems that this simply calls the init_read_record() function, and then returns the

record number read into the read_record member variable of tab. That’s exactly what it is

doing, so where do the storage engines and the record cache come into play? We thought

you would never ask. Take a look at init_read_record() in Listing 4-22. It is found in

/sql/records.cc (sound familiar?).

Listing 4-22. /sql/records.cc init_read_record ()

void init_read_record(READ_RECORD *info,THD *thd, TABLE *table,

SQL_SELECT *select,

int use_record_cache, bool print_error)

info->read_record=rr_sequential;

table->file->ha_rnd_init(1);

Two important things are happening here. First, the info pointer to a READ_RECORD

variable (passed in the arguments of init_read_records()) has had its read_record member

variable changed to rr_sequential. rr_sequential is a function pointer, and setting this means

that subsequent calls to info->read_record() will be translated into rr_sequential(READ_RECORD ➥

*info), which uses the record cache to retrieve data. We’ll look at that function in a second.

For now, just remember that all those calls to read_record() in the while loop of Listing 4-21

will hit the record cache from now on. First, however, notice the call to ha_rnd_init().

Whenever you see ha_ in front of a function, you know immediately that you’re dealing

with a table handler method (a storage engine function). A first guess might be that this func-

tion is used to scan a segment of records from disk for a storage engine. So, let’s check out

ha_rnd_init(), shown in Listing 4-23, which can be found in /sql/handler.h. Why just the

header file? Well, the handler class is really just an interface for the storage engine’s subclasses

to implement. We can see from the class definition that a skeleton method is defined.


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

Listing 4-23. /sql/handler.h handler::ha_rnd_init()

int ha_rnd_init(bool scan)

DBUG_ENTER("ha_rnd_init");

DBUG_ASSERT(inited==NONE || (inited==RND && scan));

inited=RND;

DBUG_RETURN(rnd_init(scan));

{

}

// …

}

// …

}

Since we are querying on a MyISAM table, we’ll look for the virtual method declaration

for rnd_init() in the ha_myisam handler class, as shown in Listing 4-24. This can be found in

the /sql/ha_myisam.cc file.

Listing 4-24. /sql/ha_myisam.cc ha_myisam::rnd_init()

int ha_myisam::rnd_init(bool scan)

{

if (scan)

return mi_scan_init(file);

Sure enough, as we suspected, the rnd_init method involves a scan of the table’s records.

We’re sure you’ve gotten tired of us saying this by now, but yes, the mi_scan_init() function is

implemented in yet another file: /myisam/mi_scan.c, shown in Listing 4-25.

Listing 4-25. /myisam/mi_scan.c mi_scan_init()

int mi_scan_init(register MI_INFO *info)

{

info->nextpos=info->s->pack.header_length; /* Read first record */

Unbelievable—all this work just to read in a record to a READ_RECORD struct! Fortunately,

we’re almost done. Listing 4-26 shows the rr_sequential() function of the record cache

library.

Listing 4-26. /sql/records.cc rr_sequential()

static int rr_sequential(READ_RECORD *info)

{

while ((tmp=info->file->rnd_next(info->record)))

{

if (tmp == HA_ERR_END_OF_FILE)

tmp= -1;

}

return tmp;

}


C H A P T E R   4   ■ M Y S Q L   S YS T E M  A R C H I T E C T U R E

This function is now called whenever the info struct in sub_select() calls its read_record()

member method. It, in turn, calls another MyISAM handler method, rnd_next(), which simply

moves the current record pointer into the needed READ_RECORD struct. Behind the scenes,

rnd_next simply maps to the mi_scan() function implemented in the same file we saw earlier,

as shown in Listing 4-27.

Listing 4-27. /myisam/mi_scan.c mi_scan()

int mi_scan(MI_INFO *info, byte *buf)

{

// …

info->update&= (HA_STATE_CHANGED | HA_STATE_ROW_CHANGED);

DBUG_RETURN ((*info->s->read_rnd)(info,buf,info->nextpos,1));

}

In this way, the record cache acts more like a wrapper library to the handlers than it does

a cache. But what we’ve left out of the preceding code is much of the implementation of the

shared IO_CACHE object, which we touched on in the section on caching earlier in this chapter.

You should go back to records.cc and take a look at the record cache implementation now

that you know a little more about how the handler subclasses interact with the main parsing

and execution system. This advice applies for just about any of the sections we covered in this

chapter. Feel free to go through this code execution over and over again, even branching out

to discover, for instance, how an INSERT command is actually executed in the storage engine.

Summary

We’ve certainly covered a great deal of ground in this chapter. Hopefully, you haven’t thrown

the book away in frustration as you worked your way through the source code. We know it can

be a difficult task, but take your time and read as much of the documentation as you can. It

really helps.

So, what have we covered in this chapter? Well, we started off with some instructions on

how to get your hands on the source code, and configure and retrieve the documentation in

various formats. Then we outlined the general organization of the server’s subsystems.

Each of the core subsystems was covered, including thread management, logging, storage

engine abstraction, and more. We intended to give you an adequate road map from which to

start investigating the source code yourself, to get an even deeper understanding of what’s

behind the scenes. Trust us, the more you dig in there, the more you’ll be amazed at the skill

of the MySQL development team to “keep it all together.” There’s a lot of code in there.

We finished up with a bit of a code odyssey, which took us from server initialization all the

way through to the retrieval of data records from the storage engine. Were you surprised at just

how many steps we took to travel such a relatively short distance?

We hope this chapter has been a fun little excursion into the world of database server

internals. The next chapter will cover some additional advanced topics, including implemen-

tation details on the storage engines themselves and the differences between them. You’ll

learn the strengths and weaknesses of each of the storage engines, to gain a better under-

standing of when to use them.


C H A P T E R   5

■ ■ ■

Storage Engines

and Data Types

In this chapter, we’ll delve into an aspect of MySQL that sets it apart from other relational

database management systems: its ability to use entirely different storage mechanisms for

various data within a single database. These mechanisms are known as storage engines, and

each one has different strengths, restrictions, and uses. We’ll examine these storage engines

in depth, suggesting how each one can best be utilized for common data storage and access

requirements.

After discussing each storage engine, we’ll review the various types of information that

can be stored in your database tables. We’ll look at how each data type can play a role in your

system, and then provide guidelines on which data types to apply to your table columns. In

some cases, you’ll see how your choice of storage engine, and indeed your choice of primary

and secondary keys, will influence which type of data you store in each table.

In our discussion of storage engines and data types, we’ll cover the following topics:

• Storage engine considerations

• The MyISAM storage engine

• The InnoDB storage engine

• The MERGE storage engine

• The MEMORY storage engine

• The ARCHIVE storage engine

• The CSV storage engine

• The FEDERATED storage engine

• The NDB Cluster storage engine

• Guidelines for choosing a storage engine

• Considerations for choosing data types


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

Storage Engine Considerations

The MySQL storage engines exist to provide flexibility to database designers, and also to allow

for the server to take advantage of different types of storage media. Database designers can

choose the appropriate storage engines based on their application’s needs. As with all soft-

ware, to provide specific functionality in an implementation, certain trade-offs, either in

performance or flexibility, are required. The implementations of MySQL’s storage engines are

no exception—each one comes with a distinct set of benefits and drawbacks.

■Note Storage engines used to be called table types (or table handlers). In the MySQL documentation, you

will see both terms used. They mean the same thing, although the preferred description is storage engine.

As we discuss each of the available storage engines in depth, keep in mind the following

questions:

• What type of data will you eventually be storing in your MySQL databases?

• Is the data constantly changing?

• Is the data mostly logs (INSERTs)?

• Are your end users constantly making requests for aggregated data and other reports?

• For mission-critical data, will there be a need for foreign key constraints or multiple-

statement transaction control?

The answers to these questions will affect the storage engine and data types most appro-

priate for your particular application.

■Tip In order to specify a storage engine, use the CREATE TABLE (… ) ENGINE=EngineType option,

where EngineType is one of the following: MYISAM, MEMORY, MERGE, INNODB, FEDERATED, ARCHIVE, or CSV.

The MyISAM Storage Engine

ISAM stands for indexed sequential access method. The MyISAM storage engine, an improved

version of the original but now deprecated ISAM storage engine, allows for fast retrieval of its

data through a non-clustered index and data organization. (See Chapter 2 to learn about non-

clustered index organization and the index sequential access method.)

MyISAM is the default storage engine for all versions of MySQL. However, the Windows

installer version of MySQL 4.1 and later offers to make InnoDB the default storage engine

when you install it.

The MyISAM storage engine offers very fast and reliable data storage suitable for a variety

of common application requirements. Although it does not currently have the transaction

processing or relational integrity capacity of the InnoDB engine, it more than makes up for


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

these deficiencies in its speed and in the flexibility of its storage formats. We’ll cover those

storage formats here, and take a detailed look at the locking strategy that MyISAM deploys

in order to provide consistency to table data while keeping performance a priority.

MyISAM File and Directory Layout

All of MySQL’s storage engines use one or more files to handle operations within data sets

structured under the storage engine’s architecture. The data_dir directory contains one subdi-

rectory for each schema housed on the server. The MyISAM storage engine creates a separate

file for each table’s row data, index data, and metadata:

• table_name.frm contains the meta information about the MyISAM table definition.

• table_name.MYD contains the table row data.

• table_name.MYI contains the index data.

Because MyISAM tables are organized in this way, it is possible to move a MyISAM table

from one server to another simply by moving these three files (this is not the case with InnoDB

tables). When the MySQL server starts, and a MyISAM table is first accessed, the server reads

the table_name.frm data into memory as a hash entry in the table cache (see Chapter 4 for

more information about the table cache for MyISAM tables).

■Note Files are not the same as file descriptors. A file is a collection of data records and data pages into a

logical unit. A file descriptor is an integer that corresponds to a file or device opened by a specific process.

The file descriptor contains a mode, which informs the system whether the process opened the file in an

attempt to read or write to the file, and where the first offset (base address) of the underlying file can be

found. This offset does not need to be the zero-position address. If the file descriptor’s mode was append,

this offset may be the address at the end of the file where data may first be written.

As we noted in Chapter 2, the MyISAM storage engine manages only index data, not record

data, in pages. As sequential access implies, MyISAM stores records one after the other in a sin-

gle file (the .MYD file). The MyISAM record cache (discussed in Chapter 4) reads records through

an IO_CACHE structure into main memory record by record, as opposed to a larger-sized page at

a time. In contrast, the InnoDB storage engine loads and manages record data in memory as

entire 16KB pages.

Additionally, since the MyISAM engine does not store the record data on disk in a paged

format (as the InnoDB engine does), there is no wasted “fill factor” space (free space available

for inserting new records) between records in the .MYD file. Practically speaking, this means

that the actual data portion of a MyISAM table will likely be smaller than an identical table

managed by InnoDB. This fact, however, should not be a factor in how you choose your stor-

age engines, as the differences between the storage engines in functional capability are much

more significant than this slight difference in size requirements of the data files.

For managing index data, MyISAM uses a 1KB page (internally, the developers refer to this

index page as an index block). If you remember from our coverage of the MyISAM key cache in

Chapter 4, we noted that the index blocks were read from disk (the .MYI file) if the block was


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

not found in the key cache (see Figure 4-2). In this way, the MyISAM and InnoDB engine’s

treatment of index data using fixed-size pages is similar. (The InnoDB storage engine uses a

clustered index and data organization, so the 16KB data pages are actually the index leaf

pages.)

MyISAM Record Formats

When analyzing a table creation statement (CREATE TABLE or ALTER TABLE), MyISAM determines

whether the data to be stored in each row of the table will be a static (fixed) length or if the length

of each row’s data might vary from row to row (dynamic). The physical format of the .MYD file

and the records contained within the file depend on this distinction. In addition to the fixed and

dynamic record formats, the MyISAM storage engine supports a compressed row format. We’ll

cover each of these record formats in the following sections.

■Note The MyISAM record formats are implemented in the following source files: /myisam/mi_sta➥

trec.c (for fixed records), /myisam/mi_dynrec.c (for dynamic records), and /myisam/mi_packrec.c

(for compressed records).

Fixed Record Format

When the record format is of a fixed length, the .MYD file will contain each MyISAM record in

sequential order, with a NULL byte (0x00) between each record. Each record contains a bitmap

record header. By bitmap, we’re not referring to the graphic. A bitmap in programming is a set

of single bits, arranged in segments of eight (to align them into a byte structure), where each

bit in the byte is a flag that represents some status or Boolean value. For instance, the bitmap

1111 0101 in binary, or 0xF5 in hexadecimal, would have the second and fourth bits turned off

(set to 0) and all other bits turned on (set to 1). Remember that a byte is composed of a low-

order and a high-order byte, and is read right to left. Therefore, the first bit is the rightmost bit.

The MyISAM bitmap record header for fixed-length records is composed of the following

bits, in this order:

• One bit representing whether the record has been deleted (0 means the row is deleted).

• One bit for each field in the MyISAM table that can be NULL. If the record contains a NULL

value in the field, the bit is equal to 1, else 0.

• One or more “filler” bits set to 1 up to the byte mark.

The total size of the record header bitmap subsequently depends on the number of nul-

lable fields the table contains. If the table contains zero to seven nullable fields, the header

bitmap will be 1 byte; eight to fifteen nullable fields, it will be 2 bytes; and so on. Therefore,

although it is advisable to have as few NULL fields as possible in your schema design, there

will be no practical effect on the size of the .MYD file unless your table contains more than

seven nullable fields.

After each record header, the values of the record’s fields, in order of the columns defined

in the table creation, will follow, consuming as much space as the data type requires.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

Since it can rely on the length of the row data being static for fixed-format records, the

MyISAM table cache (see Chapter 4) will contain information about the maximum length of

each row of data. With this information available, when row data is sequentially read (scanned)

by the separate MyISAM access requests, there is no need to calculate the next record’s offset

in the record buffer. Instead, it will always be x bytes forward in the buffer, where x is the maxi-

mum row length plus the size of the header bitmap. Additionally, when seeking for a specific

data record through the key cache, the MyISAM engine can very quickly locate the needed

row data by simply multiplying the sum of the record length and header bitmap size by the

row’s internal record number (which starts at zero). This allows for faster access to tables with

fixed-length records, but can lead to increased actual storage space on disk.

■Note You can force MySQL to apply a specific row format using the ROW_FORMAT option in your CREATE ➥

TABLE statement.

Dynamic Record Format

When a MyISAM table contains variably sized data types (VARCHAR, TEXT, BLOB, and so on), the

format of the records in the .MYD file is known as dynamic. Similar to the fixed-length record

storage, each dynamically sized record contains a record header, and records are laid out in

the .MYD file in sequential order, one after the next. That is where the similarities end, however.

The header for a dynamically sized record is composed of more elements, including the

following:

• A 2-byte record header start element indicates the beginning of the record header. This

is necessary because, unlike the fixed-length record format, the storage engine cannot

rely on record headers being at a static offset in the .MYD file.

• One or more bytes that store the actual length (in bytes) of the record.

• One or more bytes that store the unused length (in bytes) of the record. MyISAM leaves

space in each record to allow for the data to expand a certain amount without needing

to move records around within the .MYD file. This part of the record header indicates

how much unused space exists from the end of the actual data stored in the record to

the beginning of the next record.

• A bitmap similar to the one used for fixed-length record, indicating NULL fields and

whether the record has been deleted.

• An overflow pointer that points to a location in the .MYD file if the record has been updated

and now contains more data than existed in the original record length. The overflow loca-

tion is simply the address of another record storing the rest of the record data.

After this record header, the actual data is stored, followed by the unused space until the

next record’s record header. Unlike the fixed-record format, however, the dynamic record for-

mat does not consume the full field size when a NULL value is inserted. Instead, it stores only a

single NULL value (0x00) instead of one or more NULL values up to the size of the same nullable

field in a fixed-length record.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

A significant difference between the static-length row format and this dynamic-length

row format is the behavior associated with updating a record. For a static-length row record,

updating the data does not have any effect on the structure of the record, because the length

of the data being inserted is the same as the data being deleted.1 For a varying-length row

record, if the updating of the row data causes the length of the record to be greater than it was

before, a link is inserted into the row pointing to another record where the remainder of the

data can be found (the overflow pointer). The reason for this linking is to avoid needing to

facilitate the rearrangement of multiple buffers of row records in order to accommodate the

new record. The link serves as a placeholder for the new information, and the link will point

to an address location that is available to the engine at the time of the update. This fragmenta-

tion of the record data can be corrected by running an OPTIMIZE TABLE command, or by

running #> myisamchk -r.

MINIMIZE MYISAM TABLE FRAGMENTATION

Because of the fragmentation that can occur, if you are using MyISAM tables for data that is frequently

updated or deleted, you should avoid using variably sized data types and instead use fixed-length fields. If

this is not possible, consider separating a large table definition containing both fixed and variably sized fields

into two tables: one containing the fixed-length data and the other containing the variably sized data. This

strategy is particularly effective if the variably sized fields are not frequently updated compared to the fixed-

size data.

For instance, suppose you had a MyISAM table named Customer, which had some fixed-length fields

like last_action (of type DATETIME) and status (of type TINYINT), along with some variably sized fields

for storing address and location data. If the address data and location data are updated infrequently com-

pared to the data in the last_action and status fields, it might be a good idea to separate the one table

into a CustomerMain table and a CustomerExtra table, with the latter containing the variably sized fields.

This way, you can minimize the table fragmentation and allow the main record data to take advantage of the

speedier MyISAM fixed-size record format.

For data of types TEXT and BLOB, this behavior does not occur for the in-memory record, since for

these data types, the in-memory record structure contains only a pointer to where the actual TEXT or BLOB

data is stored. This pointer is a fixed size, and so no additional reordering or linking is required.

Compressed Record Format

An additional flavor of MyISAM allows you to specify that the entire contents of a specified

table are read-only, and the records should be compressed on insertion to save disk space.

Each data record is compressed separately and uncompressed when read.

To compress a MyISAM table, use the myisampack utility on the .MYI index data file:

#> myisampack [options] tablename.MYI

1. Remember that an UPDATE is really a DELETE of the existing data and an INSERT of the new data.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

MyISAM uses Huffman encoding (see Chapter 2) to compress data, along with a technique

where fields with few distinct values are compressed to an ENUM format. Typical compression

ratios are between 40% and 70% of the original size. The myisampack utility can, among other

things, combine multiple large MyISAM tables into a single compressed table (suitable for

CD distribution for instance). For more information about the myisampack utility, visit

http://dev.mysql.com/doc/mysql/en/myisampack.html.

The .MYI File Structure

The .MYI file contains the disk copy of all MyISAM B-tree and R-tree indexes built on a single

MyISAM table. The file consists of a header section and the index records.

■Note The developer’s documentation (/Docs/internals.texi) contains a very thorough examination of

the structures composing the header and index records. We’ll cover these basic structures from a bird’s-eye

view. We encourage you to take a look at the TEXI documentation for more technical details.

The .MYI File Header Section

The .MYI header section contains a blueprint of the index structure, and is used in navigating

through the tree. There are two main structures contained in the header section, as well as

three other sections that repeat for the various indexes attached to the MyISAM table:

• A single state structure contains meta information about the indexes in the file. Some

notable elements include the number of indexes, type of index (B-tree or R-tree), num-

ber of key parts in each index, number of index records, and number of records marked

for deletion.

• A single base structure contains information about the table itself and some additional

offset information, including the start address (offset) of the first index record, length

of each index block (index data page in the key cache), length of a record in the base

table or an average row length for dynamic records, and index packing (compression)

information.

• For each index defined on the table, a keydef struct is inserted in the header section,

containing information about the size of the key, whether it can contain NULL values,

and so on.

• For each column in the index, a keyseg struct defines what data type the key part

contains, where the column is located in the index record, and the size of the column’s

data type.

• The end of the header section contains a recinfo struct for each column in the indexes,

containing (somewhat redundant) information about the data types in the indexes. An

extra recinfo struct contains information about removal of key fields on an index.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

■Note You can find the definition for these data structures in /myisam/myisamdef.h. Additionally, /myisam/

mi_open.c contains functions that write the respective header section elements to the .MYI file. Each section

has its own function; for instance, the recinfo struct is written to file in the mi_recinfo_write() function.

The .MYI File Index Records

After the header section, the MyISAM index blocks compose the remainder of the .MYI file.

The index blocks are 1KB on-disk pages of data, representing the B-tree leaf and non-leaf

nodes. A single index block contains only key values pertaining to one index in the table. The

header section (detailed in the previous section) contains information about how the MyISAM

storage engine should find the root node of each index by supplying the offset for the root

node’s index block in the keydef elements.

Each index block contains the following:

• A single 2-byte block header. The first bit of the 16 bits in the header indicates whether

the block is a leaf node (0 for leaf; 1 for non-leaf ). The remaining 15 bits contain the

total length of bytes used in the block (nonfree space).

• Following the header, index keys and record identifiers are laid out in a balanced organ-

ization (the B-tree format). With each key is stored the key value (of a length equal to

the data type of the indexed field) and a 4-byte record pointer.

• The remainder of the index block is junk bytes (filler bytes), which become used as

the B-tree index “fills out” with inserts. This is the “fill factor” for MyISAM B-tree index

pages, and typically represents between 65% and 80% of the data used within the index

block under normal operations, to allow for split-free growth along with the insertions.

■Tip Running #> myisamchk -rq on a MyISAM table will cause the fill factor to rise to close to 100%, as

it fills the index blocks as compactly as possible, which may be advisable on static or infrequently modified

MyISAM tables.

MyISAM Table-Level Locking

To ensure the integrity of its data, the MyISAM storage engine supports only a single type of

locking level: table-level locking. Much has been made of this “deficiency,” but for many appli-

cations, this level of locking, and its specific implementation in the MyISAM storage engine,

works quite well and can be effective even in very high concurrency scenarios.

MyISAM issues one of three separate types of locks on its resources (data records),

depending on the request issued to it by the connecting thread:

• READ LOCAL: If the thread issues a SELECT statement against the in-memory copy of the

data records, MyISAM asks for a READ LOCAL lock on the data. This type of lock does not

prevent INSERTs into the table, as long as the data will be appended to the end of the

data file. If the INSERT would push data into the middle of the data file, then the INSERT

statement would need to wait until the READ LOCAL lock was released by the SELECT

statement’s thread.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

• READ: If the actual .MYD data file is used to get information for the requesting client (for

instance, the myisamchk utility), as opposed to the in-memory cache of the table data, a

lock of type READ (sometimes called a shared lock) is issued. While a READ lock is placed

on the resource, all UPDATE, INSERT, and DELETE statements are blocked from executing

against the table’s data.

• WRITE: A WRITE lock (sometimes called an exclusive lock) is placed on the table resource

whenever an UPDATE or DELETE request is received, or if an INSERT is received that would

fill an existing space in the data file that had previously been removed via a DELETE

request.

So, with the READ LOCAL lock type, MyISAM tables can write data to the table without

blocking simultaneous reads of the table’s data. You may wonder, given your understanding of

data isolation levels, how this is possible. MyISAM recognizes that INSERT operations occur-

ring on a table in which the primary key is an auto-incrementing number can write the new

key data at the end of the index file, as opposed to reading into the index file to find an appro-

priate place to insert new data. Because the insertion of new keys will always occur at the end

of the index file for this type of table, there is no need to hold up SELECT statements that have

requested keys or data from anywhere else in the table.

For this reason, MyISAM makes an excellent choice for tables that primarily accomplish

logging activity. For instance, it’s ideal for a table containing web site traffic data, where you

may want to issue queries against a part of the traffic data, while continuing to insert thou-

sands of new records a minute.

MyISAM Index Choices

Although the actual data is not stored in the order of the table’s primary key, MyISAM does

maintain a list of pointers (think of them as internal record numbers) to those data records

within its indexes. This key cache contains a linked list of pointers referencing address spaces

inside the .MYD file where the actual data rows are stored. Regardless of the number of indexes

attached to the MyISAM table, all indexes are implemented using this non-clustered organiza-

tion (see Chapter 2).

You can have up to 64 separate indexes on a MyISAM table (32 in versions prior to 4.1.2).

MyISAM supports three indexing options through which it can retrieve data from its key

cache: B-tree, R-tree, and FULLTEXT.

B-Tree Indexes

In order to quickly locate information within the non-clustered index buffers, MyISAM uses a

B-tree search algorithm. Therefore, keys are inserted into the index based on the key’s logical

location in the index tree. If the key has a string data type and can be compressed using prefix

compression, it will be. Alternatively, you can manually specify that compression should

happen on INSERT by using the PACK_KEYS=1 option in the CREATE TABLE or CREATE INDEX

statement. This can be useful for integer keys where you have a data set with most, if not all,

key values using just the low-byte value (see the earlier section on the MyISAM fixed-record

format). Packing the keys will strip the nonunique high-byte part of the integer value to allow

for higher density indexing.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

■Note The MyISAM key buffer system can be found in the /myisam/mi_key.c and /myisam/mi_

keycache.c files. The B-tree algorithm is implemented in /myisam/mi_search.c. Table scans on MyISAM

are implemented in /myisam/mi_scan.c.

R-Tree Indexes

For those of you who require the ability to work with spatial data types (geographical coordi-

nates or three-dimensional shapes), the MyISAM storage engine supports R-tree indexing for

that spatial data. Currently, MyISAM is the only storage engine that supports R-tree analysis.

Effectively, the implementation of R-tree indexing on the MyISAM storage engine is a kind of

extension to its existing key cache organization. It used the same informational structures as the

B-tree indexes, but implements the comparison of values in a different way (the spatial way).

■Note The R-tree algorithm is implemented in the /myisam/rt_* files. Notably, rt_mbr.c contains the

implementation for how key values are compared. By the way, mbr stands for minimum bounding rectangle.

FULLTEXT Indexes

MyISAM is currently the only storage engine supporting the FULLTEXT index option. A FULLTEXT

index can be defined on any CHAR, VARCHAR, or TEXT field of a MyISAM table. When a record is

inserted into a MyISAM table containing a FULLTEXT index, the data for the indexed fields is

analyzed and split into “words.” For each word, an index entry is created, with the following

elements:

• The word itself

• The number of times the word is found in the text being inserted

• A floating-point weight value designed to express the importance of this word in

relation to the entire string of data

• The record identifier of the record, used as a pointer into the .MYD file

When a query is run against the index, the index entries are queried and, by default,

returned in an order based on the weight value in the index entries. To query a FULLTEXT

index, use the MATCH … AGAINST construct, as follows:

SELECT * FROM some_table

WHERE MATCH(fulltext_field1, fulltext_field2) AGAINST ('some search string');


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

In order to see the weighting of the index in your query results, simply use the MATCH con-

struct in the SELECT clause, like so:

SELECT some_field, MATCH (fulltext_field1, fulltext_field2)

AGAINST ('some search string') FROM some_table;

■Tip You can make numerous tweaks to your FULLTEXT indexes, such as changing the minimum word

length, altering the stopword file, and running queries in Boolean mode. http://dev.mysql.com/doc/

mysql/en/fulltext-search.html has more information about various FULLTEXT options. In addition,

Peter Gulutzan’s article, “The Full-Text Stuff That We Didn't Put in the Manual” (http://dev.mysql.com/

tech-resources/articles/full-text-revealed.html) has some excellent material.

MyISAM Limitations

Despite MyISAM’s various strengths, it does have a few downsides, primarily its lack of foreign

key constraints and multiple-statement transaction safety.

Despite plans to include it, there is currently no way of making the MyISAM storage

engine enforce a foreign key constraint. Though the FOREIGN KEY clause in your CREATE TABLE

statement is parsed by the DDL compiler, nothing is actually stored or done to protect foreign

key relational integrity.

The protection of foreign key constraints is a principle of sound database design, yet

some in the database community have come out against foreign key constraints because of

performance reasons. The MySQL development team is determined to keep performance as

a top priority, and has indicated that the MyISAM storage engine may support foreign key

constraints in the future, but only if doing so would not seriously impact the performance

of the engine.

Unfortunately, at the time of this writing, if you are designing an application that has

foreign key dependency support as a top priority, your storage engine choice is limited to

InnoDB.2 As with other things, enforcing relational integrity for foreign keys comes with

a performance cost in InnoDB. However, we should stress that for most applications, this

performance difference will be negligible, partly due to InnoDB’s row-level locking scheme,

discussed in the next section.

MyISAM also does not give you the ability to ensure the atomicity, consistency, and durabil-

ity of multiple statements executed with a transaction. The ACID test (see Chapter 3) cannot be

applied to statement sets run against MyISAM tables. Although it is possible to mix and match

storage engines in the database, if you have a transaction executing against both InnoDB tables

(which do support transaction control) and MyISAM tables, you can be assured only that the

statements executed against the InnoDB tables will be written to disk and recovered in the event

of a crash.

2. Technically, you could also use the BDB storage engine, but there are few to no advantages to using

this earlier transaction-safe engine over InnoDB.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

The InnoDB Storage Engine

The InnoDB storage engine3 addresses some of the drawbacks to the MyISAM storage engine.

Namely, it provides enforcement of foreign key constraints and full ACID-compliant transac-

tion processing abilities (see Chapter 3).

Much of InnoDB’s power is derived from its implementation of row-level locking through

multiversion concurrency control (MVCC). Through MVCC, InnoDB has support for a number

of transaction isolation levels, giving you control over how your transactions are processed.

In the following sections, we’ll examine these transaction-processing capabilities, as well as

InnoDB’s doublewrite log system, file and record formats, and buffers.

Enforcement of Foreign Key Relationships

InnoDB enforces the referential integrity of foreign key relationships at the database level.

When a CREATE TABLE statement is issued with the FOREIGN KEY … REFERENCES clause, the par-

ent table (REFERENCES table) is checked to verify the existence of a key when a record in the

child table is inserted.

A common example of this parent-child relationship, as we discussed in Chapter 1, is the

Customer to CustomerOrder to CustomerOrderItem scenario. A customer can place zero or more

orders. An order can contain one or more order details. In order to enforce the relationship,

we would issue the statements in Listing 5-1. Note that the parent tables must be created first,

before any foreign keys reference them, and the parent tables must have a unique index con-

taining the columns referenced in the FOREIGN KEY clause. Additionally, all data types must be

identical on both sides of the relationship.

Listing 5-1. Creating an InnoDB Table with a Foreign Key Constraint

mysql> CREATE TABLE customer (

> id INT NOT NULL AUTO_INCREMENT,

> name VARCHAR(30) NOT NULL,

> address VARCHAR(100) NOT NULL,

> PRIMARY KEY (id)) ENGINE = INNODB;

mysql> CREATE TABLE customer_order (

> id INT NOT NULL AUTO_INCREMENT,

> customer INT NOT NULL,

> date_ordered INT NOT NULL,

> PRIMARY KEY (id),

> FOREIGN KEY (customer) REFERENCES customer (id)) ENGINE = INNODB;

mysql> CREATE TABLE customer_order_item (

> id INT NOT NULL AUTO_INCREMENT,

> order INT NOT NULL,

> product VARCHAR(30) NOT NULL,

> PRIMARY KEY (id),

> FOREIGN KEY (order) REFERENCES customer_order (id)) ENGINE = INNODB;

3.

InnoDB was originally developed by Heikki Tuuri and is now developed and maintained by Innobase

Oy (http://www.innodb.com/).


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

■Tip You can use the ON UPDATE CASCADE and ON UPDATE DELETE options in order to force InnoDB

to automatically handle updates and deletes on the parent record. Refer to the manual for detailed instruc-

tions on these options. See http://dev.mysql.com/doc/mysql/en/create-table.html and also

http://dev.mysql.com/doc/mysql/en/ansi-diff-foreign-keys.html.

InnoDB Row-Level Locking

Although InnoDB does implement table-level locking (you can order it to use table-level locks

using the LOCK TABLES statement), the default lock granularity is at the row level. While table-

level lock granularity is more efficient from a memory perspective, a row-level lock is crucial

for applications that have a high read and write rate where updates to the data are common.

You might wonder how table-level locking could be more efficient, since it locks a larger

block of records. During table-level locking, MyISAM places a lock on the table information

structure that is shared by threads reading and writing. The lock is applied to this single shared

resource and is held for a relatively short period of time (usually nanoseconds). In row-level

locking, an array of locks must be maintained for the rows active in transactions. So, while on

the surface, table-level locking may seem inefficient because it holds on to a large logical block,

the implementation of row-level locking is more CPU- and memory-intensive because of the

number of locks that must be tracked.

InnoDB’s implementation of row-level locking uses an internal table that contains lock

information for the keys. This internal format is a memory-efficient, compressed hash lookup

of the primary keys in the table. (This is, by the way, the reason you cannot have an InnoDB

table without a PRIMARY KEY assigned to it; see the discussion of clustered versus non-clus-

tered data and index organization in Chapter 2 for details.)

That said, there are situations in which the level of lock granularity becomes more of a

player than the resources needed to maintain the actual locks. For systems where there are

a large number of concurrent users issuing both UPDATE and SELECT statements on the same

data—typically in a mixed OLTP/OLAP4 environment—situations arise where there are too

many requests for write locks, which inhibit, or block, the read requests until the write has

completed. For table-level lock granularity, these read requests must wait until the write

request has released the table-level lock in order to read any of the data records in the table.

Row-level locking solves this dilemma by allowing update requests to only block read (or

other write) requests to the data records that are affected by the update. Other read requests—

ones that do not need to be read from the segment being written by the write request—are not

held up. InnoDB implements this granularity of locking. This is one of the reasons that the

InnoDB storage engine is an excellent candidate for systems having high read and write

requests.

Like MyISAM, InnoDB implements a mechanism to allow insertions that occur at the end

of the data file—which, in the case of InnoDB, is always the end of the clustered index—to

happen concurrently without issuing any exclusive locks on the table.

4. OLTP stands for online transaction processing, and these systems typically have high write requests.

OLAP stands for online analytical processing, and these systems typically have high read requests.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

ACID-Compliant Multistatement Transaction Control

If you have an absolute requirement that certain sets of statements run against your database

tables must be completed inside an ACID-compliant transaction, InnoDB is your storage

engine of choice. As noted earlier, InnoDB accomplishes transaction control through MVCC.

The default isolation level in which InnoDB runs multistatement transactions is

REPEATABLE READ and, for most situations, this isolation level is sufficient.5 However, in certain

circumstances, you may need a higher level of isolation. In these cases, InnoDB offers a SERI-

ALIZABLE isolation level that can be set using the SET TRANSACTION ISOLATION LEVEL statement

before issuing any commands in the connection thread. See Chapter 2 for a detailed discus-

sion of isolation levels and MVCC, to determine situations where you may need to set a

specific isolation level.

The InnoDB File and Directory Layout

The InnoDB storage engine file organization is different from the MyISAM arrangement.

While the MySQL server maintains an .frm file for each InnoDB table, similar to MyISAM

tables, InnoDB also keeps its own store of meta information about InnoDB tables. Because

of this, it is not currently possible to simply transfer InnoDB databases from one server to

another by copying the table files.

By default, the storage engine manages all InnoDB tables in what’s called a tablespace,

which is modeled after the Oracle concept of the same name. The tablespace is composed of

multiple files, which can grow to the size limitation of the operating system. These files are

named based on what is in your configuration file. By default, these files begin with ibdata

and then a number. In your my.cnf file (discussed in Chapter 14), you will see a section

similar to the following:

innodb_data_home_dir = /usr/local/var/

innodb_data_file_path = ibdata1:2000M;ibdata2:10M:autoextend

The ibdata files contain both the table and index data for all InnoDB tables. These ibdata

files will be in innodb_data_home_dir, while the .frm file will be in the schema’s directory under

the main MySQL data_dir directory. All the ibdata files are concatenated by InnoDB to form

the InnoDB tablespace. The tablespace can contain any number of files, and the autoextend

functionality ensures that the tablespace files can grow with the database. This also means

that file system size limitations (for instance, 2GB on most Linux distributions) can be over-

come, since the tablespace can contain multiple files, unlike with the MyISAM .MYD storage.

5. A few folks will insist that this isolation level is indeed more than sufficient for normal default

operations. Oracle and SQL Server both default to the READ COMMITTED isolation level. See the

InnoDB manual for a discussion on its isolation levels: http://dev.mysql.com/doc/mysql/en/

innodb-transaction-model.html and follow the links to the various subsections.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

Within the tablespace, two internal files (called segments) maintain each InnoDB table

(these segments aren’t visible to you, however). One segment is used for the clustered index

data pages, and another segment is used for any secondary indexes built on that clustering

key. The reason this is done this way is so that records may be added sequentially in large

blocks, to both the data and secondary index pages of the table.

To implement InnoDB’s transaction processing system, a series of log files will also be

created. In your my.cnf file, you will find something like the following two lines:

innodb_log_group_home_dir = /usr/local/var/

innodb_log_arch_dir = /usr/local/var/

These are the directories where the main log files and archive log files are stored. The default

naming convention for these log files is ib_logfile and then a number representing the log

segment. You will have a number of log files equal to the innodb_log_files_in_group configu-

ration variable (with a default of two log files). We’ll take a closer look at the log system a little

later in the chapter, in the “InnoDB Doublewrite Buffer and Log Format” section.

Optionally, as of version 4.1.1, you can elect to have InnoDB organize its files in a per-

table format, similar to the MyISAM file organization. To enable this file layout, insert the

innodb_file_per_table configuration option under the mysqld section of your my.cnf file.

Keep in mind, however, that enabling this option does not remove the ibdata files, nor

allow you to transfer InnoDB schema to another machine by simply copying the .ibd files,

as you can with the MyISAM storage engine’s files.

■Note Currently, the tables cannot be manually assigned to the multiple ibdata files. Therefore, it is not

possible to have InnoDB store separate tables on separate disks or devices.

InnoDB Data Page Organization

The InnoDB storage engine stores (both on disk and in-memory) record and index data in

16KB pages. These pages are organized within the ibdata files as extents of 64 consecutive

pages. The reason InnoDB does this is to allocate large spaces of memory and disk space at

once, to ensure that data is as sequential on the hard disk as possible. This is a proactive

stance at maintaining as defragmented a system as possible.

Each extent stores data related to a single index, with one exception. One extent contains

a page directory, or catalog, which contains the master list of data pages as a linked tree of

pointers to all extents in the tablespace.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

Clustered Index Page Format

Since the storage engine uses a clustered index organization, the leaf pages of the index contain

the actual record data. Secondary B-tree indexes are built on the clustered index data pages.

A clustered index data page in the InnoDB storage engine is a complex beast. It consists

of seven distinct elements:

• Fil header: This 34-byte header contains the directory information about the page

within the segment. Important directory information includes an identifier for the

page, the previous and next page’s identifiers,6 and the log serial number (LSN) for the

latest log record for the page. We’ll discuss the importance of the log serial number in

the upcoming section on the InnoDB log format.

• Page header: This 50-byte header contains meta information about the data page itself.

Important elements of this section include pointers to the first record on the page, the

first free record, and the last inserted record. Also of interest are an identifier for the

index to which the data page belongs and the number of records on the page.

• Infimum and Supremum records: These are two fixed-size records placed in the header.

These records are used to prevent the next-previous link relationship to go beyond the

index bounds and as a space to put dummy lock information.

• User records: After the Infimum and Supremum records come one or more user records.

The format of the user record is detailed in the next section.

• Free space: After the user records is free space available for InnoDB to insert new records.

This is the “fill factor” space for InnoDB, which attempts to keep data pages at 15/16 filled.

• Page directory: Following the free space, the page directory contains a variably sized set

of pointers to each record, paired with the record’s clustering key. In this way, queries

can use the page directory’s smaller size to do very fast lookups and range queries for

records on the page.

• Fil trailer: Finally, this section contains a checksum of the page’s data, along with the

page log sequence number, for use in error-checking the contents of the page.

InnoDB Record Format

InnoDB records have a very different format from MyISAM records. The record is composed of

three parts:

• One- or two-byte field start offsets contain the position of the next field in the record,

relative to the start address of the record. There will be n field offsets, where n is the

number of fields in the table. The field offsets will be 1 byte if the total record size is

127 bytes or less; otherwise, each field offset will be 2 bytes long.

6. The next and previous page identifiers provide a mechanism for InnoDB to perform fast range query

and scan operations by providing a linking relationship between the index data pages. This linking

relationship is a major difference between the implementation of the B-tree index structure in

InnoDB versus MyISAM. This type of B-tree algorithm is commonly called a B+ tree (B-plus tree)

and is useful for clustered data organizations.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

• A fixed-size 48-bit (6-byte) “extra bytes” information section contains meta information

about the record. This meta information includes the following important elements:

• One bit denoting if the record is deleted. In this case, a value of 1 means the record

is deleted (the opposite of MyISAM).

• Ten bits detailing the number of fields in the record.

• Thirteen bits identifying the record within the data page (the heap number).

• One bit telling InnoDB whether the field offsets mentioned previously are 1 or 2

bytes long.

• Sixteen-bit (2-byte) pointer to the next-key record in the page.

• The field contents compose the remainder of the record, with no NULL value separating

the field contents, because the field offsets enable the storage engine to navigate to the

beginning of each field.

The most important aspect of the InnoDB record structure is the two parts of the “extra

bytes” section that contain the 13-bit heap number and the 16-bit next-key pointer.

Remember that InnoDB tables follow a clustered data organization where the data page is

clustered, or ordered, based on the primary key value. Would it then surprise you to know that

InnoDB does not actually store records in the order of the primary key?

“But wait!” you say. “How is it possible that a clustered data organization can be built on

index pages without those records being laid out in primary key order?” The answer lies in the

storage engine’s use of next-key pointers in the data records.

The designers of InnoDB knew that maintaining clustered index data pages in sort order

of the primary key would be a performance problem. When records were inserted, the storage

engine would need to find where the record “fit” into the appropriate data page, then move

records around within the file in order to sort correctly. Updating a record would likewise

cause problems. Additionally, the designers knew that inserting records on a heap structure

(with no regard to the order of the records) would be faster, since multiple insertions could be

serialized to go into contiguous blocks on the data page. Therefore, the developers came up

with a mechanism whereby records can be inserted into the data page in no particular order

(a heap), but be affixed with a pointer to the record that had the next primary key value.

The InnoDB storage engine inserts a record wherever the first available free space is

located. It gets this free record space address from the page header section. To determine the

next-key pointer, it uses the small, condensed page directory trailing section of the data page

to locate the appropriate place to insert the primary key value for the inserted record. In this

way, only the small page directory set of key values and pointers must be rearranged. Note

also that the next-key pointers are a one-way (forward-only) list.

■Note The InnoDB page and record source code files are in the /innobase/page/ and /innobase/rem/

directories of your source distribution. rem stands for record manager.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

Internal InnoDB Buffers

InnoDB caches information in two major internal buffers:

• Buffer pool: This buffer contains cached index data pages (both leaf and non-leaf ).

The innodb_buffer_pool_size configuration variable controls the size of this buffer.

• Log buffer: This buffer contains cached log records. The innodb_log_buffer_size

configuration variable controls the size of the log buffer.

■Note It is unfortunate that InnoDB currently does not have the ability to change the configuration vari-

ables associated with the internal buffers on the fly. A restart of the mysqld process is required in order to

facilitate the changes, which considering InnoDB was designed for always-on, high-availability systems, may

be a significant downside. We hope that, in the future, these values will be modifiable through SQL commands.

In addition to these two main buffers, InnoDB also keeps a separate cache of memory for

its internal data dictionary about the table and index structures in the tablespace.

InnoDB Doublewrite Buffer and Log Format

In order to ensure the ACID properties of transaction control, InnoDB uses a write-ahead log-

ging system called a doublewrite buffer system. Remember from Chapters 2 and 3 that there is

a difference between a write and a flush of data. A write simply changes the in-memory copy

of a piece of data. A flush commits those writes to disk.

The doublewrite buffer refers to the dual-write process that occurs when InnoDB records

changes issued under a transaction, as illustrated in Figure 5-1. Because of the principles of

write-ahead logging, InnoDB must ensure that any statement that modifies the in-memory

data set is first recorded on disk (in a log) before a COMMIT is issued for the entire transaction.

This ensures that, in the case of a disk failure or software crash, the changes can be re-created

from the log records. However, the designers of InnoDB realized that if a transaction were

rolled back before a COMMIT was received, the statements on log records representing those

changes would not need to be reissued during a recovery. So, InnoDB inserts transactional

statements as log records into the log buffer (described in the previous section), while simul-

taneously executing the modifications those statements make against the in-memory copy of

the record data available in the buffer pool. This dual-buffer write explains the doublewrite

buffer terminology.

When a COMMIT is received for a transaction, by default, InnoDB flushes to disk (to the

ib_logfile files) the log records in the log buffer representing the transaction in question.

The reason we say “by default” is that you can tell InnoDB to only flush the transaction log

files to disk every second, approximately. You can tell InnoDB to flush to disk based on the

operating system process scheduling (around one second) by setting innodb_flush_log_at_

trx_commit to 0. This practice is not, however, recommended for mission-critical applications.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

Writes log

records to disk

at transaction

COMMIT and at

checkpoints

Log Record

Buffer

Data Page

Buffer

(Buffer Pool)

Writes data

pages to disk at

checkpoints

ib_logfile

Files

ibdata

Files

These files

represent the

InnoDB

tablespace

Figure 5-1. The doublewrite buffer process

■Caution Regardless of whether innodb_flush_log_at_trx_commit is set to 1, if the operating

system on which the MySQL server is running does not have a reliable flushing mechanism, or if the disk

drives attempt to fool the operating system into thinking a flush has occurred when, in fact, it hasn’t, InnoDB

may lose data. This is not a fault of the storage engine, but rather of the operating system or hardware.

For more information about this problem, see Peter Zaitsev’s (one of the InnoDB developers) article at

http://www.livejournal.com/users/peter_zaitsev/12639.html.

InnoDB log files contain a fixed number of log records.7 Because the log files cannot grow

to an infinite size, and because log records are going to continue to be inserted into the log,

there must be a way of overwriting log records that have been flushed to disk, and therefore

are redundant.

InnoDB’s log record flushing system is circular in this way: it overwrites log records from

the beginning of the log record with newer log records if the log file’s file size limit is reached.

Figure 5-2 depicts a sample log file with a maximum of 14 log records.

■Caution Because of InnoDB’s process of overwriting logs, you must ensure that you provide enough

room in your log file to cover the data changes made between backups. See Chapter 17 for more informa-

tion about these administrative precautions.

7. The number of records depends on the number of log files set in the innodb_log_files_in_group

configuration setting and the actual size of the file set with innodb_log_file_size.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

The log file can contain

at most 14 log records

A single log

record

Free space

Log file containing 8 records

Add 6 log records, and the log file is full

Adding 3 more records overwrites first 3 log records

Figure 5-2. InnoDB’s log file overwrites itself from the beginning of the file when it’s full.

The actual log record format is itself quite compact. It contains a log serial number (LSN),

which is an 8-byte file and byte offset for the particular log record. Along with the LSN is a

compressed form of the data modifications made by the statement.

In the case when the buffer pool exceeds its limits, InnoDB is forced to flush data pages to

disk in order to remove the least recently used data pages. But, before it does so, InnoDB uses

the LSN element of the page header section of the data page to check that the LSN of the page

header is less than the last log record in the log file. If it’s not, then InnoDB writes the log file

records before flushing the data pages.

The Checkpointing and Recovery Processes

As we explained in Chapter 3, transaction processing systems employ a checkpointing process

to mark in a log file that all data pages that have had changes made to records have been

flushed to disk. We explained that this checkpoint mark contained a list of open transaction

numbers at the time that the checkpoint was made. In the InnoDB checkpointing process, the

checkpoint contains a linked list of data pages that may still be dirty because of pending

transactions.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

A separate background thread spawned specifically to handle the InnoDB checkpointing

process wakes on a timed interval to flush changed data pages in the buffer pool to the ibdata

files. However, InnoDB may not actually flush any data pages at this interval. This is due to the

fact that InnoDB is a fuzzy checkpointer, meaning that it will not flush data changes in mem-

ory as long as all of the following conditions exist:

• Either the log buffer or buffer pool is not filled beyond a certain percentage of its total

size limit

by the log writer

• Log file writes have not fallen behind data page writes (a separate thread handles each)

• No data pages have a page header LSN the same as a log record about to be overwritten

After a crash, the InnoDB recovery process automatically kicks in on startup. InnoDB uses

the LSN values in the log record to bring the data store to a consistent state based on the last

checkpoint record’s LSN.

Other Storage Engines

Although MyISAM and InnoDB are the most commonly used storage engines, MySQL also

offers other storage engines that are more specialized. In the following sections, we’ll cover

the MERGE, MEMORY, ARCHIVE, CSV, FEDERATED, and NDB Cluster choices.

The MERGE Storage Engine

If you have a situation where, for performance or space reasons, you need to cut large blocks

of similar data into smaller blocks, the MERGE storage engine can virtually combine identical

MyISAM tables into an aggregated virtual table. A MERGE table must be created with an iden-

tical table definition to the MyISAM tables for which it offers a combined view. To create a

MERGE table from multiple MyISAM tables, follow the CREATE TABLE statement with the

ENGINE=MERGE  UNION=(table_list) construct, as shown in Listing 5-2 for a fictional set of tables.8

Listing 5-2. Creating a MERGE Table from Two Identical Tables

mysql> CREATE TABLE t1 (

->    a INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

->    message CHAR(20));

mysql> CREATE TABLE t2 (

->    a INT NOT NULL AUTO_INCREMENT PRIMARY KEY,

->    message CHAR(20));

mysql> INSERT INTO t1 (message) VALUES ('Testing'),('table'),('t1');

mysql> INSERT INTO t2 (message) VALUES ('Testing'),('table'),('t2');

mysql> CREATE TABLE total (

->    a INT NOT NULL AUTO_INCREMENT,

->    message CHAR(20), INDEX(a))

->    ENGINE=MERGE UNION=(t1,t2);

8. The example in Listing 5-2 is adapted from the MySQL manual.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

Note that column definitions for all three tables (the original tables and the MERGE table)

are identical. Instead of a PRIMARY KEY being defined in the MERGE table, a normal index is

used on the column a.

The most common example of MERGE storage engine usage is in archival and logging

schemes. For instance, suppose we have a MyISAM table that stores the web site traffic informa-

tion from our online toy store. It is a fairly simple log table, which looks something like Listing 5-3.

Listing 5-3. A Simple MyISAM Web Traffic Log Table

mysql> CREATE TABLE traffic_log (

> id INT UNSIGNED NOT NULL AUTO_INCREMENT,

> refer_site VARCHAR(255) NOT NULL,

> requested_uri VARCHAR(255) NOT NULL,

> hit_date TIMESTAMP NOT NULL,

> user_agent VARCHAR(255) NOT NULL,

> PRIMARY KEY (id),

> INDEX (hit_date, refer_site(30))) ENGINE=MYISAM;

Although this table is simple, it could quickly fill up with a lot of information over the

course of a month’s average web traffic to our store. Let’s imagine that, in the first month

of tracking, our traffic_log table logged 250,000 hits. MyISAM is buzzing along, inserting

records at light speed because of its ability to do thousands of writes per second on an incre-

menting numeric primary key. But this growth rate will eventually make the table unwieldy,

consuming a massive amount of disk space or, worse, using up all the available space for the

data file. So, we decide to make some slight changes to the application code that inserts the

log records. Instead of one giant table, we create monthly tables, named traffic_log_yymm,

where y and m are the year and month, respectively. We create the tables for the year up front

and change the application code to insert into the appropriate month’s table based on the log

record’s timestamp.

A couple month’s into our new system’s lifetime, we make a bold move and compress

older logs using the myisampack utility (discussed earlier, in the section about the MyISAM

compressed record format). Then we seem to be getting more and more requests to provide

reporting for a number of months of data at a time. Manually UNIONing table results together

has started to get a bit annoying.

So, we decide to investigate the MERGE storage engine option. We define a MERGE table

as in Listing 5-4.

Listing 5-4. Creating a MERGE Table from Monthly Log Tables

mysql> CREATE TABLE traffic_log_05 (

> id INT UNSIGNED NOT NULL AUTO_INCREMENT,

> refer_site VARCHAR(255) NOT NULL,

> requested_uri VARCHAR(255) NOT NULL,

> hit_date TIMESTAMP NOT NULL,

> user_agent VARCHAR(255) NOT NULL,

> INDEX (id),

> INDEX (hit_date, refer_site(30)))

> ENGINE=MERGE

> UNION=( traffic_log_0501, traffic_log_0502, … , traffic_log_0512)

> INSERT_METHOD=NO;


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

This creates a table that aggregates the data for the entire year of 2005. Setting the

INSERT_METHOD to NO is good because our application is inserting records into one of the under-

lying tables anyway. We create indexes on id and on hit_date and refer_site because most of

the requests from the sales team have been for reports grouped by week and by referring site.

We put a limit of 30 characters for the index on refer_site because, after analyzing the data,

the majority of the data is variable at or below 30 characters. Note that we did not define a

PRIMARY KEY index for the MERGE table; doing so would produce an error since the MERGE

storage engine cannot enforce primary key constraints over all its UNIONed underlying tables.

We now have a method of accessing the varying log tables using a single table interface,

as shown in Listing 5-5.

Listing 5-5. Aggregated Results from the MERGE Table

mysql> SELECT LEFT(refer_site, 30) AS 'Referer', COUNT(*) AS 'Referrals'

> FROM traffic_log_05

> WHERE hit_date BETWEEN '2005-01-01' AND '2005-01-10'

> GROUP BY LEFT(refer_site, 30)

> HAVING 'Referrals' > 1000

> ORDER BY 'Referrals' DESC

> LIMIT 5;

This would return the top five highest referring sites (limited to 30 characters), in the first

ten days of January 2005, with the number of referrals greater than a thousand. The MERGE

engine, internally, will access the traffic_log_0501 table, but, now, we don’t need to use dif-

ferent table names in order to access the information. All we need to do is supply our WHERE

condition value to the name of the MERGE table—in this case: traffic_log_05. Furthermore,

we could create a separate MERGE table, traffic_log (replacing your original table), which

houses all records for our web site traffic.

Be aware that MERGE tables have some important limitations. You cannot use the REPLACE

command on a MERGE table, and UNIQUE INDEX constraints are not enforced across the entire

combined data set. For more information, see the MySQL manual at http://dev.mysql.com/

doc/mysql/en/MERGE_table_problems.html.

When you’re considering using a MERGE table, also investigate using views, available only

in MySQL 5.0, instead. They provide much more flexibility than the MERGE storage engine.

See Chapter 12 for a detailed discussion of views.

The MEMORY Storage Engine

The MEMORY storage engine,9 as its name aptly implies, stores its entire contents, both data

and index records, in memory. The trick with MEMORY tables, however, is that the data in the

table is lost when the server is restarted. Therefore, data stored in MEMORY tables should be

data that can be easily re-created on startup by using application scripts, such as lookup sets,

or data that represents a time period of temporary data, like daily stock prices.

When you create a MEMORY table, one file is created under the /data_dir/schema_name/

directory named table_name.frm. This file contains the definition of the table.

9. Prior to MySQL 4.1, the MEMORY storage engine was called the HEAP table type.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

To automatically re-create data in MEMORY tables, you should use the --init-file=file

startup option. The file specified should contain the SQL statements used to populate the

MEMORY tables from a persistent table. You do not need to issue a CREATE TABLE statement in

the file, because the table definition is persistent across restarts.

For instance, if you wanted to increase the speed of queries asking for information on zip

code radius searching (a topic we will cover in Chapter 8), you might have an InnoDB table

zips for persistent, transaction-safe storage, coupled with a MEMORY table zips_mem, which

contains the zip codes entirely in memory. While the InnoDB zips table might contain a lot

of information about each zip code—population statistics, square mileage, and so on—the

zips_mem table would contain only the information needed to do radius calculations (longi-

tude and latitude of the zip code’s centroid). In the startup file, you could have the following

SQL statement, which would populate the MEMORY table:

INSERT INTO zips_mem SELECT zip, latitude, longitude FROM zips;

The downside is that any changes to the zip code information would need to be replicated

against the zips_mem table to ensure consistency. This is why static lookups are ideally suited for

MEMORY tables. After all, how often do the latitude and longitudes of zip codes change?

As you learned in Chapter 2, certain data sets and patterns can be searched more efficiently

using different index algorithms. Starting with version 4.1, you can specify either a hash (the

default) or B-tree index be created on a MEMORY table. Do so with the USING algorithm clause,

where algorithm is the index algorithm, in your CREATE TABLE statement. For example, Listing 5-6

demonstrates how to implement a B-tree algorithm on a MEMORY table where you expect a lot

of range queries to be issued against a temporal data type. This query pattern is often best

implemented with a B-tree algorithm, versus the default hash algorithm.

Listing 5-6. Making a MEMORY Table Use a B-Tree Index

mysql> CREATE TABLE daily_stock_prices (

> symbol VARCHAR(8) NOT NULL,

> high DECIMAL(6,2) NOT NULL,

> low DECIMAL(6,2) NOT NULL,

> date DATE NOT NULL,

> INDEX USING BTREE (date, resource)) ENGINE = MEMORY;

The ARCHIVE Storage Engine

New in MySQL 4.1.3 is the ARCHIVE storage engine. Its purpose is to compress large volumes

of data into a smaller size. While this storage engine should not be used for regular data access

(normal operations), it is excellent for storing log or archive information that is taking up too

much regular space on disk.

The ARCHIVE storage engine is not available on default installations of MySQL. In order

to create an ARCHIVE table, you will need to build MySQL with the --with-archive-storage-➥

engine option.

No indexes are allowed when creating an ARCHIVE table; indeed, the only access method

for retrieving records is through a table scan. Typically, you would want to convert stale log

data tables into ARCHIVE tables. On the rare occasion that analysis is needed, you could

create a temporary MyISAM table by selecting the entire data set and create indexes on the

MyISAM table.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

The CSV Storage Engine

As of version 4.1.4, MySQL introduced the CSV storage engine. The CSV storage engine is not

available on default installations of MySQL. In order to create a CSV table, you will need to

build MySQL with the --with-csv-storage-engine option.

Although this is not the most useful of all the storage engines, it can have its advantages. The

CSV engine stores table meta information, like all storage engines, in an .frm file in the database

directory. However, for the actual data file, the CSV engine creates a file with the table name and a

.CSV extension. This is handy in that the table data can be easily copied from the database direc-

tory and transferred to a client, like Microsoft Excel, to open the table in spreadsheet format.

Practically speaking, however, there is little use to the CSV storage engine given two facts.

First, no indexing is available for the storage engine, making the use of it in normal operations

somewhat implausible. Second, the INTO OUTFILE extension clause of the SELECT statement

negates some of the benefits we mentioned. In order to output a section of an existing table

into a CSV format, you could just as easily run the following statement:

mysql> SELECT * INTO OUTFILE '/home/user1/my_table.csv'

> FIELDS TERMINATED BY ',' ENCLOSED BY '"'

> FROM my_table;

This would dump the file to the server’s location of /home/user1/my_table.csv. If you wanted

to place the output file onto the local client (say, if you were connecting remotely), you could

execute the following from a shell prompt:

mysql -t -e "SELECT * FROM my_schema.my_table" | tr "\011" "," > my_file.csv

This would pipe tabbed results (the -t option) from MySQL to the tr program, which would

translate the tab character (\011) to a comma character and dump the results to a CSV file on

the local computer.

The FEDERATED Storage Engine

If any of you are coming from a Microsoft SQL Server background and have wondered whether

MySQL implements anything like the concept of linked servers in SQL Server, look no further.

Starting in version 5.0.3, you can use the FEDERATED storage engine to access databases

located on remote servers in the same way you would on the local server.

The FEDERATED storage engine is not available on default installations of MySQL. In

order to create a FEDERATED table, you will need to build a version of MySQL 5.0.3 or later

with the --with-federated-storage-engine option.

On the local server, only an .frm file is created when a table with ENGINE=FEDERATED is cre-

ated. Naturally, the data file is stored on the remote server, and thus there is no actual data file

stored on the local server.

When accessing records from a FEDERATED table, MySQL uses the mysql client API to

request resultsets from the remote server. If any results are returned, the FEDERATED storage

engine converts the results to the format used by the underlying remote server’s storage engine.

So, if an InnoDB table on the remote server were accessed on the local server via a FEDERATED

table, the local FEDERATED storage engine would create an InnoDB handler for the request and

issue the requested statements to the remote server, which would execute and return any result-

set needed in the standard client format. The FEDERATED storage engine would then convert


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

the returned results into the internal format of the needed table handler (in this case, InnoDB),

and use that handler to return the results through the handler’s own API.

The NDB Cluster Storage Engine

The MySQL Cluster (NDB) is not really a storage engine, in that it delegates the responsibility

of storage to the actual storage engines used in the databases that it manages. Once a cluster

of database nodes is created, NDB controls the partitioning of data across the nodes to pro-

vide redundancy of data and performance benefits. We discuss clustering and NDB in detail

in Chapter 19.

Guidelines for Choosing a Storage Engine

At this point, you might be wondering how to go about determining which storage engine is a

good match for your application databases. MySQL gives you the ability to mix and match

storage engines to provide the maximum flexibility when designing your schema. However,

there are some caveats and some exceptions to keep in mind when making your choices.

Take time to investigate which index algorithms best fit the type of data you wish to store. As

different storage engines provide different index algorithms, you may get a significant perform-

ance increase by using one over another. In the case of InnoDB, the storage engine will actually

pick a B-tree or hash index algorithm based on its assessment of your data set. This takes away

some of the control you might have by using a combination of MEMORY and MyISAM tables for

storage; however, it might be the best fit overall. When it comes to requirements for FULLTEXT or

spatial indexing, your only choice currently is MyISAM. Look for implementation of these other

indexing algorithms to appear in other storage engines in the future.

Here, we present some general guidelines for choosing an appropriate storage engine for

your various tables.

Use MyISAM for logging. For logging purposes, the MyISAM storage engine is the best

choice. Its ability to serve concurrent read requests and INSERT operations is ideal for log

tables where data is naturally inserted at the end of the data file, and UPDATE and DELETE

operations are rare.

Use MyISAM for SELECT COUNT(*) queries. If you have an application that relies on multi-

ple SELECT COUNT(*) FROM table queries, use the MyISAM storage engine for those tables.

MyISAM’s index statistics make this type of query almost instantaneous. InnoDB’s per-

formance degrades rapidly on larger data sets because it must do a scan of the index data

to find the number of rows in a table. There are plans to improve InnoDB’s performance

of this type of query in the near future.

Use InnoDB for transaction processing. When your application needs to ensure a specific

level of isolation across read requests over multiple statements, use the InnoDB storage

engine. Before deciding to use InnoDB, however, be sure that the transactions issued by

your application code are indeed necessary. It is a mistake to start a multistatement

transaction for statements that can be reduced to a single SQL request.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

Use InnoDB for enforcing foreign key constraints. If the data you are storing has relationships

between a master and child table (foreign keys), and it is absolutely imperative that the

relationship be enforced, use InnoDB tables for both the master and child tables. Consider

using the ON UPDATE CASCADE and ON UPDATE DELETE options to enforce any business rules.

These options can cut down significantly on application code that would normally be

required to handle enforcing business rules.

Use InnoDB for web site session data. If you store web application sessions in your database,

as opposed to a file-based storage, consider using InnoDB for your storage engine. The rea-

son for this is that typical web application sessions are UPDATE-intensive. New sessions are

created, modified, and destroyed in a continual cycle as new HTTP requests are received

and their sessions mapped and remapped to the database table. InnoDB’s row-level locking

enables fast, concurrent access for both read and write requests. Why not use a MEMORY

table instead, since it is fast for reads and writes, including DELETE operations? Well, the rea-

son is that MEMORY tables cannot support TEXT or BLOB data because the hashing algorithm

used in the storage engine cannot include the TEXT and BLOB pointers. Web session data is

typically stored in TEXT columns, often as a serialized array of values.

You should not assume that an initial choice of a storage engine will be appropriate

throughout the life of your applications. Over time, not only will your storage and memory

requirements change, but the selectivity and the data types of your tables may change. If you

feel that changing a table’s storage engine would have an impact, first create a test environ-

ment and make the changes there. Use the information in Chapter 6 to benchmark both

schema and determine if the application would perform better with the changes.

Data Type Choices

As you know, MySQL offers various data types that you can apply to your table columns. Here,

we cover the different data types in terms of some common recommendations for their use

and knowledge areas we feel are often misunderstood.

■Tip If you’re unsure about a specific data type, or simply want a reference check, consider picking up a

copy of Jon Stephens and Chad Russell’s excellent Beginning MySQL Database Design and Optimization

(Apress, 2004).

Numeric Data Considerations

MySQL provides an array of numeric data types in different sizes and flavors. Choose numeric

column types based on the size of the storage you need and whether you need precise or

imprecise storage.

For currency data, use the DECIMAL column type, and specify the precision and scale in

the column specification. Do not use the DOUBLE column type to store currency data. The DOUBLE

column type is not precise, but approximate. If you are doing calculations involving currency

data, you may be surprised at some of the results of your queries.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

For instance, assume you defined a field product_price as DECIMAL(9,4) NOT NULL, and

populate a data record with the value 99.99:

mysql> CREATE TABLE product (id INT NOT NULL, product_price DECIMAL(9,4) NOT NULL);

mysql> INSERT INTO product (id, product_price) VALUES (1, 99.99);

Next, you go to select the data records where product_price is equal to 99.99:

mysql> SELECT * FROM product WHERE product_price = 99.99;

Everything works as expected:

+----+---------------+

| id | product_price |

+----+---------------+

|  1 |       99.9900 |

+----+---------------+

1 row in set (0.00 sec)

However, you may be surprised to learn that the following query:

mysql> SELECT * FROM product WHERE 100 - product_price = .01;

yields different results depending on the data type definition:

mysql> SELECT * FROM product WHERE 100 - product_price = .01;

+----+---------------+

| id | product_price |

+----+---------------+

|  1 | 99.9900       |

+----+---------------+

1 row in set (0.03 sec)

mysql> ALTER TABLE product CHANGE COLUMN product_price product_price DOUBLE;

Query OK, 1 row affected (0.10 sec)

Records: 1  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM product WHERE 100 - product_price = .01;

Empty set (0.00 sec)

As you can see, the same query produces different results depending on the precision of

the data type. The DOUBLE column type cannot be relied on to produce accurate results across

all hardware architectures, whereas the DECIMAL type can. But calculations involving DECIMAL

data can yield unexpected results due to the underlying architecture’s handling of floating-

point arithmetic. Always test floating-point calculations thoroughly in application code and

when upgrading MySQL versions. We have noticed differences in the way precision arithmetic

is handled even across minor version changes. See http://dev.mysql.com/doc/mysql/en/

problems-with-float.html for details about floating-point arithmetic issues.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

String Data Considerations

As with all data types, don’t go overboard when choosing the length of string fields. Be conser-

vative, especially when deciding on the length of character columns that will be frequently

indexed. For those columns that should be indexed because they frequently appear in WHERE

conditions, consider using an INDEX prefix to limit the amount of actual string data stored in

the index rows.

Character fields are frequently used in the storage of address data. When determining how

these character columns should be structured, first consider the maximum number of charac-

ters that can be stored in the specific data field. For example, if your data set includes only

United States zip codes, use a CHAR(5) column type. Don’t make the field have a length of 10 just

because you may need to store the zip+4 format data for some of the records. Instead, consider

having two fields, one CHAR(5) to store the main, non-nullable zip code, and another nullable

field for storing the +4 extension. If you are dealing with international postal addresses, investi-

gate the maximum characters needed to store the postal code; usually, a CHAR(8) will do nicely.

■Tip Store spaces that naturally occur in a postal code. The benefit of removing the single space character

is almost nonexistent compared to the pain of needing to remove and restore the space for display and stor-

age purposes.

Also consider how the data will actually be searched, and ensure that separate search

fields are given their own column. For instance, if your application allows end users to search

for customer records based on a street address, consider using separate fields for the street

number and the street name. Searches, and indexes, can then be isolated on the needed field,

and thus made more efficient. Also, following rules for good database normalization, don’t

have separate fields for different address lines. Instead of having two fields of type VARCHAR(50)

named address_1 and address_2, have a single field address, defined as VARCHAR(100). Address

information can be inserted into the single field with line breaks if needed.

For applications where search speed is critical, consider replacing city and region (state)

fields with a single numeric lookup value. Because they are denser, numeric indexes will have

faster search speeds. You can provide a lookup system defined something like this:

mysql> CREATE TABLE region (

> id INT NOT NULL AUTO_INCREMENT PRIMARY KEY

> , region_name VARCHAR(30) NOT NULL

> , country CHAR(2) NOT NULL);

mysql> CREATE TABLE location (

> id INT NOT NULL AUTO_INCREMENT PRIMARY KEY

> , region INT NOT NULL

> , city VARCHAR(30) NOT NULL

> , INDEX (region, city));


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

You would populate your region and location tables with the data for all cities in your

coverage area. Your customer table would then need only store the 4-byte pointer to the parent

location record. Let’s assume you have a region with an ID of 23, which represents the state of

California, in the United States. In order to find the names of customers in this region living in

the city Santa Clara, you would do something like this:

mysql> SELECT c.name FROM location l

> INNER JOIN customer c ON l.id = c.location

> WHERE l.region = 23 AND l.city = 'Santa Clara';

This search would be able to use the index on location to find the records it needs. If you

had placed the city and region information in the customer table, an index on those two fields

would have needed to contain many more entries, presuming that there would be many more

customer entries than location entries.

Again, indexes on numeric columns will usually be faster than character data columns of

the same length, so think about converting data from a character format into a normalized

lookup table with a numeric key.

Temporal Data Considerations

If you need to store only the date part of your temporal data, use the DATE column type. Don’t

use an INT or TIMESTAMP column type if you don’t need that level of granularity. MySQL stores

all the temporal data types as integers internally. The only real difference between the varia-

tions is how the data is formatted for display. So use the smallest data type (sound familiar?)

that you can.

Use the TIMESTAMP column type if you have audit needs for some tables. Timestamps are

an easy, efficient, and reliable method of determining when applications make changes to

a record. Just remember that the first column defined as a TIMESTAMP column in the CREATE ➥

TABLE statement will be used for the create time of the record. The columns after that field can

be updated to the current system time by updating the column equal to NULL. For instance,

suppose you define your orders table like so:

mysql> CREATE TABLE orders (

> id INT NOT NULL AUTO_INCREMENT PRIMARY KEY

> , customer INT NOT NULL

> , update_time TIMESTAMP NOT NULL

> , create_time TIMESTAMP NOT NULL);

If you insert a record into the orders table, explicitly set the create_time field; otherwise,

it will be entered as a 0. The update_time, being the first TIMESTAMP column defined, will auto-

matically be set to the current timestamp:

mysql> INSERT INTO orders (customer, create_time) VALUES (3, NOW());


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

When you do a SELECT from the table, you will notice that the first TIMESTAMP is set to the

Unix timestamp value of the current time. The second TIMESTAMP field will be 0.

When updating the order record later on, the update_time will automatically get updated

with the current system timestamp, while the create_time will stay the same:

mysql> SELECT * FROM orders;

+----+----------+----------------+----------------+

| id | customer | update_time    | create_time    |

+----+----------+----------------+----------------+

|  1 |        3 | 20050122190832 | 20050122190832 |

+----+----------+----------------+----------------+

1 row in set (0.00 sec)

mysql> UPDATE orders SET customer = 4 WHERE id = 1;

Selecting from the table then yields the following:

mysql> SELECT * FROM orders;

+----+----------+----------------+----------------+

| id | customer | update _time   | create_time    |

+----+----------+----------------+----------------+

|  1 |        3 | 20050122192244 | 20050122190832 |

+----+----------+----------------+----------------+

1 row in set (0.00 sec)

So, in this way, you have a good way of telling not only when records have been updated,

but also which records have not been updated:

mysql> SELECT COUNT(*) FROM orders WHERE update_time = create_time;

■Tip Starting with version 4.1.2, you can tell MySQL how to handle the automatic updates of individual

TIMESTAMP columns, instead of needing to explicitly set the TIMESTAMP to its own value during INSERT

statements. See http://dev.mysql.com/doc/mysql/en/timestamp-4-1.html for more information

and suggestions.

Spatial Data Considerations

The Spatial Data Extensions for MySQL will become more and more useful as more of the

OpenGIS specification is implemented, and, in particular, when MySQL implements the abil-

ity to load geographic information system (GIS) data through the LOAD DATA INFILE command

directly from well-known text (WKT) or well-known binary (WKB) values. Until then, using

spatial types may be a little cumbersome, but you can still reap some benefits. As far as the

actual data types go, the MySQL online manual provides a good lesson on how the myriad

geometry types behave.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

SET and ENUM Data Considerations

Now we come to a topic about which people have differing opinions. Some folks love the SET

and ENUM column types, citing the time and effort saved in not having to do certain joins. Oth-

ers dismiss these data types as poor excuses for not understanding how to normalize your

database.

These data types are sometimes referred to as inline tables or array column types, which

can be a bit of a misnomer. In actuality, both SET and ENUM are internally stored as integers.

The shared meta information struct for the table handler contains the string values for the

numeric index stored in the field for the data record, and these string values are mapped to

the results array when returned to the client.

The SET column type differs from the ENUM column type only in the fact that multiple val-

ues can be assigned to the field, in the way a flag typically is. Values can be ANDed and ORed

together when inserting in order to set the values for the flag. The FIND_IN_SET function can

be used in a WHERE clause and functionally is the same as bitwise ANDing the column value. To

demonstrate, the following two WHERE clauses are identical, assuming that the SET definition is

option_flags SET('Red','White','Blue') NOT NULL:

mysql> SELECT * FROM my_table WHERE FIND_IN_SET('White', option_flags);

mysql> SELECT * FROM my_table WHERE option_flags & 2;

For both ENUM and SET column types, remember that you can always retrieve the underly-

ing numeric value (versus the string mapping) by appending a +0 to your SELECT statement:

mysql> SELECT option_flags+0 FROM my_table;

Boolean Values

For Boolean values, you will notice that there is no corresponding MySQL data type. To mimic

the functionality of Boolean data, you have a few different options:

• You can define the column as a TINYINT, and populate the field data with either 0 or 1.

This option takes a single byte of storage per record if defined as NOT NULL.

• You may set the column as a CHAR(1) and choose a single character value to put into the

field; 'Y'/'N' or '0'/'1' or 'T'/'F', for example. This option also takes a single byte of

storage per record if defined as NOT NULL.

• An option offered in the MySQL documentation is to use a CHAR(0) NOT NULL column

specification. This specification uses only a single bit (as opposed to a full byte), but the

values inserted into the records can only be NULL10 or '' (a null string).

Of these choices, one of the first two is probably the best route. One reason is that you

will have the flexibility to add more values over time if needed—say, because your is_active

Boolean field turned into a status lookup field. Also, the NULL and '' values are difficult to keep

separate, and application code might easily fall into interpreting the two values distinctly.

We hope that, in the future, the BIT data type will be a full-fledged MySQL data type as it is

in other databases, without the somewhat ungraceful current definition.

10. Yes, you did read that correctly. The column must be defined as NOT NULL, but can have NULL values

inserted into data records for the field.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

STORING DATA OUTSIDE THE DATABASE

Before you store data in a database table, first evaluate if a database is indeed the correct choice of storage.

For certain data, particularly image data, the file system is the best choice—storing binary image data in a

database adds an unnecessary level of complexity. The same rule applies to storing HTML or large text val-

ues in the database. Instead, store a file path to the HTML or text data.

There are, of course, exceptions to this rule. One would be if image data needed to be replicated across

multiple servers, in which case, you would store the image data as a BLOB and have slave servers replicate

the data for retrieval. Another would be if there were security restrictions on the files you want to display to a

user. Say, for instance, you need to provide medical documents to doctors around the country through a web

site. You don’t want to simply put the PDF documents on a web server, as doctors may forward a link to one

another, and trying to secure each web directory containing separate documents with an .htaccess file

would be tedious. Instead, it would be better to write the PDF to the database as a BLOB field and provide a

link in your secure application that would download the BLOB data and display it.

Some General Data Type Guidelines

Your choice of not only which data types you use for your field definitions, but the size and

precision you specify for those data types can have a huge impact on database performance

and maintainability. Here are some tips on choosing data types:

Use an auto-incrementing primary key value for MyISAM tables that require many reads

and writes. As shown earlier, the MyISAM storage engine READ LOCAL table locks do not

hinder SELECT statements, nor do they impact INSERT statements, as long as MySQL can

append the new records to the end of the .MYD data file.

Be minimalistic. Don’t automatically make your auto-incrementing primary key a BIGINT

if that’s not required. Determine the realistic limits of your storage requirements and

remember that, if necessary, you can resize data types later. Similarly, for DECIMAL fields,

don’t waste space and speed by specifying a precision and scale greater than you need.

This is especially true for your primary keys. Making them as small as possible will enable

more records to fit into a single block in the key cache, which means fewer reads and

faster results.

Use CHAR with MyISAM; VARCHAR with InnoDB. For your MyISAM tables, you can see a per-

formance benefit by using fixed-width CHAR fields for string data instead of VARCHAR fields,

especially if only a few columns would actually benefit from the VARCHAR specification.

The InnoDB storage engine internally treats CHAR and VARCHAR fields the same way. This

means that you will see a benefit from having VARCHAR columns in your InnoDB tables,

because more data records will fit in a single index data page.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

■Note From time to time, you will notice MySQL silently change column specifications upon table creation.

For character data, MySQL will automatically convert requests for CHAR data types to VARCHAR data types when

the length of the CHAR field is greater than or equal to four and there is already a variable length column in the

table definition. If you see column specifications change silently, head to http://dev.mysql.com/doc/

mysql/en/Silent_column_changes.html to see why the change was made.

Don’t use NULL if you can avoid it. NULLs complicate the query optimization process and

increase storage requirements, so avoid them if you can. Sometimes, if you have a major-

ity of fields that are NOT NULL and a minority that are NULL, it makes sense to create a

separate table for the nullable data. This is especially true if the NOT NULL fields are a fixed

width, as MyISAM tables can use a faster scan operation algorithm when the row format

is fixed length. However, as we noted in our coverage of the MyISAM record format, you

will see no difference unless you have more than seven NULL fields in the table definition.

Use DECIMAL for money data, with UNSIGNED if it will always be greater than zero. For

instance, if you want to store a column that will contain prices for items, and those items

will never go above $1,000.00, you should use DECIMAL(6,2) UNSIGNED, which accounts for

the maximum scale and precision necessary without wasting any space.

Consider replacing ENUM column types with separate lookup tables. Not only does this

encourage proper database normalization, but it also eases changes to the lookup table

values. Changing ENUM values once they are defined is notoriously awkward. Similarly,

consider replacing SET columns with a lookup table for the SET values and a relationship

(N-M) table to join lookup keys with records. Instead of using bitwise logic for search con-

ditions, you would look for the existence or absence of values in the relational table.

If you are really unsure about whether a data type you have chosen for a table is appropri-

ate, you can ask MySQL to help you with your decision. The ANALYSE() procedure returns

suggestions for an appropriate column definition, based on a query over existing data, as

shown in Listing 5-7. Use an actual data set with ANALYSE(), so that your results are as realistic

as possible.

Listing 5-7. Using PROCEDURE ANALYSE() to Find Data Type Suggestions

mysql> SELECT * FROM http_auth_idb PROCEDURE ANALYSE() \G

*************************** 1. row ***************************

Field_name: test.http_auth_idb.username

Min_value: aaafunknufcnhmiosugnsbkqp

Max_value: yyyxjvnmrmsmrhadwpwkbvbdd

Min_length: 25

Max_length: 25

Empties_or_zeros: 0

Nulls: 0


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

Avg_value_or_avg_length: 25.0000

Std: NULL

Optimal_fieldtype: CHAR(25) NOT NULL

*************************** 2. row ***************************

Field_name: test.http_auth_idb.pass

Min_value: aaafdgtvorivxgobgkjsvauto

Max_value: yyyllrpnmuphxyiffifxhrfcq

Min_length: 25

Max_length: 25

Empties_or_zeros: 0

Nulls: 0

Avg_value_or_avg_length: 25.0000

Std: NULL

Optimal_fieldtype: CHAR(25) NOT NULL

*************************** 3. row ***************************

Field_name: test.http_auth_idb.uid

Min_value: 1

Max_value: 90000

Min_length: 1

Max_length: 5

Empties_or_zeros: 0

Nulls: 0

Avg_value_or_avg_length: 45000.5000

Std: 54335.7692

Optimal_fieldtype: MEDIUMINT(5) UNSIGNED NOT NULL

*************************** 4. row ***************************

Field_name: test.http_auth_idb.gid

Min_value: 1210

Max_value: 2147446891

Min_length: 4

Max_length: 10

Empties_or_zeros: 0

Nulls: 0

Avg_value_or_avg_length: 1073661145.4308

Std: 0.0000

Optimal_fieldtype: INT(10) UNSIGNED NOT NULL

4 rows in set (1.53 sec)

As you can see, the ANALYSE() procedure gives suggestions on an optimal field type based

on its assessment of the values contained within the columns and the minimum and maximum

lengths of those values. Be aware that ANALYSE() tends to recommend ENUM values quite often,

but we suggest using separate lookup tables instead. ANALYSE() is most useful for quickly deter-

mining if a NULL field can be NOT NULL (see the Nulls column in the output), and for determining

the average, minimum, and maximum values for textual data.


C H A P T E R   5   ■ S TO R A G E   E N G I N E S  A N D   D ATA  T Y P E S

Summary

In this chapter, we’ve covered information that will come in handy as you develop an under-

standing of how to implement your database applications in MySQL. Our discussion on storage

engines focused on the main differences in the way transactions, storage, and indexing are

implemented across the range of available options. We gave you some recommendations in

choosing your storage engines, so that you can learn from the experience of others before

making any major mistakes.

We also examined the various data types available to you as you define the schema of

your database. We looked at the strengths and peculiarities of each type of data, and then

provided some suggestions to guide you in your database creation.

In the next chapter, you will learn some techniques for benchmarking and profiling your

database applications. These skills will be vital to our exploration of SQL and index optimiza-

tion in the following chapters.


C H A P T E R   6

■ ■ ■

Benchmarking and Profiling

This book departs from novice or intermediate texts in that we focus on using and develop-

ing for MySQL from a professional angle. We don’t think the difference between a normal user

and a professional user lies in the ability to recite every available function in MySQL’s SQL

extensions, nor in the capacity to administer large databases or high-volume applications.

Rather, we think the difference between a novice user and a professional is twofold. First,

the professional has the desire to understand why and how something works. Merely knowing

the steps to accomplish an activity is not enough. Second, the professional approaches a

problem with an understanding that the circumstances that created the problem can and

will change over time, leading to variations in the problem’s environment, and consequently,

a need for different solutions. The professional developer or administrator focuses on under-

standing how things work, and sets about to build a framework that can react to and adjust

for changes in the environment.

The subject of benchmarking and profiling of database-driven applications addresses

the core of this professional outlook. It is part of the foundation on which the professional’s

framework for understanding is built. As a professional developer, understanding how and

why benchmarking is useful, and how profiling can save you and your company time and

money, is critical.

As the size of an application grows, the need for a reliable method of measuring the appli-

cation’s performance also grows. Likewise, as more and more users start to query the database

application, the need for a standardized framework for identifying bottlenecks also increases.

Benchmarking and profiling tools fill this void. They create the framework on which your abil-

ity to identify problems and compare various solutions depends. Any reader who has been on

a team scrambling to figure out why a certain application or web page is not performing cor-

rectly understands just how painful not having this framework in place can be.

Yes, setting up a framework for benchmarking your applications takes time and effort.

It’s not something that just happens by flipping a switch. Likewise, effectively profiling an

application requires the developer and administrator to take a proactive stance. Waiting for

an application to experience problems is not professional, but, alas, is usually the status quo,

even for large applications. Above all, we want you to take from this chapter not only knowl-

edge of how to establish benchmarks and a profiling system, but also a true understanding of

the importance of each.

In this chapter, we don’t assume you have any knowledge of these topics. Why? Well, one

reason is that most novice and intermediate books on MySQL don’t cover them. Another rea-

son is that the vast majority of programmers and administrators we’ve met over the years

(including ourselves at various points) have resorted to the old trial-and-error method of

identifying bottlenecks and comparing changes to application code.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

In this chapter, we’ll cover the following topics:

• Benefits of benchmarking

• Guidelines for conducting benchmarks

• Tools for benchmarking

• Benefits of profiling

• Guidelines for profiling

• Tools for profiling

What Can Benchmarking Do for You?

Benchmark tests allow you to measure your application’s performance, both in execution

speed and memory consumption. Before we demonstrate how to set up a reliable benchmark-

ing framework, let’s first examine what the results of benchmark tests can show you about

your application’s performance and in what situations running benchmarks can be useful.

Here is a brief list of what benchmark tests can help you do:

• Make simple performance comparisons

• Determine load limits

• Test your application’s ability to deal with change

• Find potential problem areas

BENCHMARKING, PROFILING—WHAT’S THE DIFFERENCE?

No doubt, you’ve all heard the terms benchmarking and profiling bandied about the technology schoolyard

numerous times over the years. But what do these terms mean, and what’s the difference between them?

Benchmarking is the practice of creating a set of performance results for a given set of tests. These

tests represent the performance of an entire application or a piece of the application. The performance

results are used as an indicator of how well the application or application piece performed given a specific

configuration. These benchmark test results are used in comparisons between the application changes to

determine the effects, if any, of that change.

Profiling, on the other hand, is a method of diagnosing the performance bottlenecks of an application.

Like benchmark tests, profilers produce resultsets that can be analyzed in order to determine the pieces of

an application that are problematic, either in their performance (time to complete) or their resource usage

(memory allocation and utilization). But, unlike benchmark tools, which typically test the theoretical limits of

the application, profilers show you a snapshot of what is actually occurring on your system.

Taken together, benchmarking and profiling tools provide a platform that can pinpoint the problem areas

of your application. Benchmark tools provide you the ability to compare changes in your application, and pro-

filers enable you to diagnose problems as they occur.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Conducting Simple Performance Comparisons

Suppose you are in the beginning phases of designing a toy store e-commerce application.

You’ve mapped out a basic schema for the database and think you have a real winner on your

hands. For the product table, you’ve determined that you will key the table based on the com-

pany’s internal SKU, which happens to be a 50-character alphanumeric identifier. As you start

to add more tables to the database schema, you begin to notice that many of the tables you’re

adding have foreign key references to this product SKU. Now, you start to question whether

the 50-character field is a good choice, considering the large number of joined tables you’re

likely to have in the application’s SQL code.

You think to yourself, “I wonder if this large character identifier will slow down things

compared to having a trimmer, say, integer identifier?” Common sense tells you that it will, of

course, but you don’t have any way of determining how much slower the character identifier

will perform. Will the performance impact be negligible? What if it isn’t? Will you redesign the

application to use a smaller key once it is in production?

But you don’t need to just guess at the ramifications of your schema design. You can

benchmark test it and prove it! You can determine that using a smaller integer key would result

in an improvement of x% over the larger character key.

The results of the benchmark tests alone may not determine whether or not you decide to

use an alphanumeric key. You may decide that the benefit of having a natural key, as opposed to

a generated key, is worth the performance impact. But, when you have the results of your bench-

marks in front of you, you’re making an informed decision, not just a guess. The benchmark test

results show you specifically what the impact of your design choices will be.

Here are some examples of how you can use benchmark tests in performance comparisons:

• A coworker complained that when you moved from MySQL 4.0.18 to MySQL 4.1, the

performance of a specific query decreased dramatically. You can use a benchmark test

against both versions of MySQL to test the claim.

• A client complained that the script you created to import products into the database

from spreadsheets does not have the ability to “undo” itself if an error occurs halfway

through. You want to understand how adding transactions to the script will affect its

performance.

• You want to know whether replacing the normal B-tree index on your product.name

varchar(150) field with a full-text index will increase search speeds on the product

name once you have 100,000 products loaded into the database.

• How will the performance of a SELECT query against three of your tables be affected by

having 10 concurrent client connections compared with 20, 30, or 100 client connections?

Determining Load Limits

Benchmarks also allow you to determine the limitations of your database server under load. By

load, we simply mean a heavy level of activity from clients requesting data from your application.

As you’ll see in the “Benchmarking Tools” section later in this chapter, the benchmarking tools

you will use allow you to test the limits, measured in the number of queries performed per sec-

ond, given a supplied number of concurrent connections. This ability to provide insight into the

stress level under which your hardware and application will most likely fail is an invaluable tool in

assessing both your hardware and software configuration.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Determining load limits is particularly of interest to web application developers. You want

to know before a failure occurs when you are approaching a problematic volume level for the

web server and database server. A number of web application benchmarking tools, commonly

called load generators, measure these limits effectively. Load generators fall into two general

categories:

Contrived load generator: This type of load generator makes no attempt to simulate actual

web traffic to a server. Contrived load generators use a sort of brute-force methodology to

push concurrent requests for a specific resource through the pipeline. In this way, con-

trived load generation is helpful in determining a particular web page’s limitations, but

these results are often theoretical, because, as we all know, few web sites receive traffic to

only a single web page or resource. Later in this chapter, we’ll take a look at the most com-

mon contrived load generator available to open-source web application developers:

ApacheBench.

Realistic load generator: On the flip side of the coin, realistic load generators attempt to

determine load limitations based on actual traffic patterns. Typically, these tools will use

actual web server log files in order to simulate typical user sessions on the site. These real-

istic load generation tools can be very useful in determining the limitations of the overall

system, not just a specific piece of one, because the entire application is put through the

ropes. An example of a benchmarking tool with the capability to do realistic load genera-

tion is httperf, which is covered later in this chapter.

Testing an Application’s Ability to Deal with Change

To continue our online store application example, suppose that after running a few early

benchmark tests, you determine that the benefits of having a natural key on the product SKU

outweigh the performance impact you found—let’s say, you discovered an 8% performance

degradation. However, in these early benchmark tests, you used a test data set of 10,000 prod-

ucts and 100,000 orders.

While this might be a realistic set of test data for the first six months into production,

it might be significantly less than the size of those tables in a year or two. Your benchmark

framework will show you how your application will perform with a larger database size, and

in doing so, will help you to be realistic about when your hardware or application design may

need to be refactored.

Similarly, if you are developing commercial-grade software, it is imperative that you know

how your database design will perform under varying database sizes and hardware configura-

tions. Larger customers may often demand to see performance metrics that match closely

their projected database size and traffic. Your benchmarking framework will allow you to

provide answers to your clients’ questions.

Finding Potential Problem Areas

Finally, benchmark tests give you the ability to identify potential problems on a broad scale.

More than likely, a benchmark test result won’t show you what’s wrong with that faulty loop

you just coded. However, the test can be very useful for determining which general parts of

an application or database design are the weakest.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

For example, let’s say you run a set of benchmark tests for the main pages in your toy store

application. The results show that of all the pages, the page responsible for displaying the order

history has the worst performance; that is, the least number of concurrent requests for the order

history page could be performed by the benchmark. This shows you the area of the application

that could be a potential problem. The benchmark test results won’t show you the specific code

blocks of the order history page that take the most resources, but the benchmark points you in

the direction of the problem. Without the benchmark test results, you would be forced to wait

until the customer service department started receiving complaints about slow application

response on the order history page.

As you’ll see later in this chapter, profiling tools enable you to see which specific blocks of

code are problematic in a particular web page or application screen.

General Benchmarking Guidelines

We’ve compiled a list of general guidelines to consider as you develop your benchmarking

framework. This list highlights strategies you should adopt in order to most effectively diag-

nose the health and growth prospects of your application code:

• Set real performance standards.

• Be proactive.

• Isolate the changed variables.

• Use real data sets.

• Make small changes and then rerun benchmarks.

• Turn off unnecessary programs and the query cache.

• Repeat tests to determine averages.

• Save benchmark results.

Let’s take a closer look at each of these guidelines.

Setting Real Performance Standards

Have you ever been on the receiving end of the following statement by a fellow employee or

customer? “Your application is really slow today.” (We bet just reading it makes some of you

cringe. Hey, we’ve all been there at some point or another.) You might respond with something

to the effect of, “What does ‘really slow’ mean, ma’am?”

As much as you may not want to admit it, this situation is not the customer’s fault. The prob-

lem has arisen due to the fact that the customer’s perception of the application’s performance is

that there has been a slowdown compared with the usual level of performance. Unfortunately for

you, there isn’t anything written down anywhere that states exactly what the usual performance of

the application is.

Not having a clear understanding of the acceptable performance standards of an applica-

tion can have a number of ramifications. Working with the project stakeholders to determine

performance standards helps involve the end users at an early stage of the development and

gives the impression that your team cares about their perceptions of the application’s


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

performance and what an acceptable response time should be. As any project manager can

tell you, setting expectations is one of the most critical components of a successful project.

From a performance perspective, you should endeavor to set at least the following acceptable

standards for your application:

Response times: You should know what the stakeholders and end users consider an

acceptable response time for most application pieces from the outset of the project.

For each application piece, work with business experts, and perhaps conduct surveys,

to determine the threshold for how fast your application should return results to the user.

For instance, for an e-commerce application, you would want to establish acceptable

performance metrics for your shopping cart process: adding items to the cart, submitting

an order, and so on. The more specific you can be, the better. If a certain process will

undoubtedly take more time than others, as might be the case with an accounting data

export, be sure to include realistic acceptable standards for those pieces.

Concurrency standards: Determining predicted levels of concurrency for a fledging

project can sometimes be difficult. However, there is definite value to recording the

stakeholders’ expectation of how many users should be able to concurrently use the

application under a normal traffic volume. For instance, if the company expects the toy

store to be able to handle 50 customers simultaneously, then benchmark tests must test

against those expectations.

Acceptable deviation: No system’s traffic and load are static. Fluctuations in concurrency

and request volumes naturally occur on all major applications, and it is important to set

expectations with the stakeholders as to a normal deviation from acceptable standards.

Typically, this is done by providing for a set interval during which performance standards

may fluctuate a certain percentage. For instance, you might say that having performance

degrade 10% over the course of an hour falls within acceptable performance standards. If

the performance decrease lasts longer than this limit, or if the performance drops by 30%,

then acceptable standards have not been met.

Use these performance indicators in constructing your baselines for benchmark testing.

When you run entire application benchmarks, you will be able to confirm that the current

database performance meets the acceptable standards set by you and your stakeholders.

Furthermore, you can determine how the growth of your database and an increase in traffic

to the site might threaten these goals.

The main objective here is to have these goals in writing. This is critical to ensuring that

expectations are met. Additionally, having the performance standards on record allows your

team to evaluate its work with a real set of guidelines. Without a record of acceptable stan-

dards and benchmark tests, you’ll just be guessing that you’ve met the client’s requirements.

Being Proactive

Being proactive goes to the heart of what we consider to be a professional outlook on applica-

tion development and database administration. Your goal is to identify problems before they

occur. Being reactive results in lost productivity and poor customer experience, and can signif-

icantly mar your development team’s reputation. There is nothing worse than working in an IT

department that is constantly “fighting fires.” The rest of your company will come to view the

team as inexperienced, and reach the conclusion that you didn’t design the application prop-


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Don’t let reactive attitudes tarnish your project team. Take up the fight from the start by

including benchmark testing as an integral part of your development process. By harnessing

the power of your benchmarking framework, you can predict problems well before they rear

their ugly heads.

Suppose early benchmark tests on your existing hardware have shown your e-commerce

platform’s performance will degrade rapidly once 50 concurrent users are consistently query-

ing the database. Knowing that this limit will eventually be reached, you can run benchmarks

against other hardware configurations or even different configurations of the MySQL server

variables to determine if changes will make a substantial impact. You can then turn to the

management team and show, certifiably, that without an expenditure of, say, $3,000 for new

hardware, the web site will fall below the acceptable performance standards.

The management team will appreciate your ability to solve performance problems before

they occur and provide real test results as opposed to a guess.

Isolating Changed Variables

When testing application code, or configurations of hardware or software, always isolate the

variable you wish to test. This is an important scientific principle: in order to show a correlation

between one variable and a test result, you must ensure that all other things remain equal.

You must ensure that the tests are run in an identical fashion, with no other changes to

the test other than those tested for. In real terms, this means that when you run a benchmark

to test that your integer product key is faster than your character product key, the only differ-

ence between the two benchmarks should be the product table’s key field data type. If you

make other changes to the schema, or run the tests against different data sets, you dilute the

test result, and you cannot reliably state that the difference in the benchmark results is due to

the change in the product key’s data type.

Likewise, if you are testing to determine the impact of a SQL statement’s performance

given a twentyfold increase in the data set’s size, the only difference between the two bench-

marks should be the number of rows being operated upon.

Because it takes time to set up and to run benchmarks, you’ll often be tempted to take

shortcuts. Let’s say you have a suspicion that if you increase the key_buffer_size, query_

cache_size, and sort_buffer_size server system variables in your my.cnf file, you’ll get a big

performance increase. So, you run the test with and without those variable changes, and find

you’re absolutely right! The test showed a performance increase of 4% over the previous run.

You’ve guessed correctly that your changes would increase throughput and performance, but,

sadly, you’re operating on false assumptions. You’ve assumed, because the test came back with

an overall increase in performance, that increasing all three system variable values each

improves the performance of the application. What if the changes to the sort_buffer_size

and query_cache_size increased throughput by 5%, but the change in the key_buffer_size

variable decreased performance by 1%? You wouldn’t know this was the case. So, the bottom

line is that you should try to isolate a single changed variable in your tests.

Using Real Data Sets

To get the most accurate results from your benchmark tests, try to use data sets from actual

database tables, or at least data sets that represent a realistic picture of the data to be stored

in your future tables. If you don’t have actual production tables to use in your testing, you can

use a data generator to produce sample data sets. We’ll demonstrate a simple generation tool


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

(the gen-data program that accompanies Super Smack) a little later in this chapter, but you

may find that writing your own homegrown data set generation script will produce test sets

that best meet your needs.

When trying to create or collect realistic test data sets, consider key selectivity, text

columns, and the number of rows.

Key Selectivity

Try to ensure that fields in your tables on which indexes will be built contain a distribution

of key values that accurately depicts the real application. For instance, assume you have an

orders table with a char(1) field called status containing one of ten possible values, say, the

letters A through J to represent the various stages that order can be in during its lifetime. You

know that once the orders table is filled with production data, more than 70% of the status

field values will be in the J stage, which represents a closed, completed order.

Suppose you run benchmark tests for an order-report SQL statement that summarizes

the orders filtered by their status, and this statement uses an index on the status field. If your

test data set uses an equal distribution of values in the status column—perhaps because you

used a data generation program that randomly chose the status value—your test will likely be

skewed. In the real-world database, the likelihood that the optimizer would choose an index

on the status column might be much less than in your test scenario. So, when you generate

data sets for use in testing, make sure you investigate the selectivity of indexed fields to ensure

the generated data set approximates the real-world distribution as closely as possible.

Text Columns

When you are dealing with larger text columns, especially ones with varying lengths, try to put

a realistic distribution of text lengths into your data sets. This will provide a much more accu-

rate depiction of how your database will perform in real-world scenarios.

If you load a test data set with similarly sized rows, the performance of the benchmark

may not accurately reflect a true production scenario, where a table’s data pages contain vary-

ing numbers of rows because of varying length text fields. For instance, let’s say you have a

table in your e-commerce database that stores customer product reviews. Clearly, these

reviews can vary in length substantially. It would be imprudent to run benchmarks against

a data set you’ve generated with 100,000 records, each row containing a text field with 1,000

bytes of character data. It’s simply not a realistic depiction of the data that would actually fill

the table.

Number of Rows

If you actually have millions of orders completed in your e-commerce application, but run

benchmarks against a data set of only 100,000 records, your benchmarks will not represent the

reality of the application, so they will be essentially useless to you. The benchmark run against

100,000 records may depict a scenario in which the server was able to cache in memory most or

all of the order records. The same benchmark performed against two million order records may

yield dramatically lower load limits because the server was not able to cache all the records.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Making Small Changes and Rerunning Benchmarks

The idea of making only small changes follows nicely from our recommendation of always

isolating a single variable during testing. When you do change a variable in a test case, make

small changes if you are adjusting settings. If you want to see the effects on the application’s

load limits given a change in the max_user_connections setting, adjust the setting in small

increments and rerun the test, noting the effects. “Small” is, of course, relative, and will

depend on the specific setting you’re changing. The important thing is to continue making

similar adjustments in subsequent tests.

For instance, you might run a baseline test for the existing max_user_connections value.

Then, on the next tests, you increase the value of the max_user_connections value by 20 each

time, noting the increase or decrease in the queries per second and concurrency thresholds

in each run. Usually, your end goal will be to determine the optimal setting for the max_user_

connections, given your hardware configuration, application design, and database size.

By plotting the results of your benchmark tests and keeping changes at a small, even

pace, you will be able to more finely analyze where the optimal setting of the tested variable

should be.

Turning Off Unnecessary Programs and the Query Cache

When running benchmark tests against your development server to determine the difference

in performance between two methods or SQL blocks, make sure you turn off any unnecessary

programs during testing, because they might interfere or obscure a test’s results. For instance,

if you run a test for one block of code, and, during the test for a comparison block of code a

cron job is running in the background, the test results might be skewed, depending on how

much processing power is being used by the job.

Typically, you should make sure only necessary services are running. Make sure that any

backup jobs are disabled and won’t run during the testing. Remember that the whole purpose

is to isolate the test environment as much as possible.

Additionally, we like to turn off the query cache when we run certain performance compar-

isons. We want to ensure that one benchmark run isn’t benefiting from the caching of resultsets

inserted into the query cache during a previous run. To disable the query cache, you can simply

set the query_cache_size variable to 0 before the run:

mysql> SET GLOBALS query_cache_size = 0;

Just remember to turn it back on when you need it!

Repeating Tests to Determine Averages

Always repeat your benchmark tests a number of times. You’ll sometimes find that the test results

come back with slightly different numbers each time. Even if you’ve shut down all nonessential

processes on the testing server and eliminated the possibility that other programs or scripts may

interfere with the performance tests, you still may find some discrepancies from test to test. So, in

order to get an accurate benchmark result, it’s often best to take a series of the same benchmark,

and then average the results across all test runs.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Saving Benchmark Results

Always save the results of your benchmarks for future analysis and as baselines for future bench-

mark tests. Remember that when you do performance comparisons, you want a baseline test to

compare the change to. Having a set of saved benchmarks also allows you to maintain a record

of the changes you made to your hardware, application configuration, and so on, which can be a

valuable asset in tracking where and when problems may have occurred.

Benchmarking Tools

Now that we’ve taken a look at how benchmarking can help you and some specific strategies

for benchmarking, let’s get our hands dirty. We’re going to show you a set of tools that, taken

together, can provide the start of your benchmarking framework. Each of these tools has its

own strengths, and you will find a use for each of them in different scenarios. We’ll investigate

the following tools:

• MySQL benchmarking suite

• MySQL Super Smack

• MyBench

• ApacheBench

• httperf

MySQL’s Benchmarking Suite

MySQL comes with its own suite of benchmarking tools, available in the source distribution

under the /sql-bench directory. This suite of benchmarking shell and Perl scripts is useful

for testing differences between installed versions of MySQL and testing differences between

MySQL running on different hardware. You can also use MySQL’s benchmarking tools to com-

pare MySQL with other database server systems, like Oracle, PostgreSQL, and Microsoft SQL

Server.

■Tip Of course, many benchmark tests have already been run. You can find some of these tests

in the source distribution in the /sql-bench/Results directory. Additionally, you can find other

non-MySQL-generated benchmarks at http://www.mysql.com/it-resources/benchmarks/.

In addition to the benchmarking scripts, the crash-me script available in the /sql-bench

directory provides a handy way to test the feature set of various database servers. This script

is also available on MySQL’s web site: http://dev.mysql.com/tech-resources/features.html.

However, there is one major flaw with the current benchmark tests: they run in a serial

manner, meaning statements are issued one after the next in a brute-force manner. This

means that if you want to test differences between hardware with multiple processes, you

will need to use a different benchmarking toolset, such as MyBench or Super Smack, in order


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

to get reliable results. Also note that this suite of tools is not useful for testing your own spe-

cific applications, because the tools test only a specific set of generic SQL statements and

operations.

Running All the Benchmarks

Running the MySQL benchmark suite of tests is a trivial matter, although the tests themselves

can take quite a while to execute. To execute the full suite of tests, simply run the following:

#> cd /path/to/mysqlsrc/sql-bench

#> ./run-all-tests [options]

Quite a few parameters may be passed to the run-all-tests script. The most notable of

these are outlined in Table 6-1.

Table 6-1. Parameters for Use with MySQL Benchmarking Test Scripts

Option

Description

--server='server name' Specifies which database server the benchmarks should be run against.

Possible values include 'MySQL', 'MS-SQL', 'Oracle', 'DB2', 'mSQL',

'Pg', 'Solid', 'Sybase', 'Adabas', 'AdabasD', 'Access', 'Empress',

and 'Informix'.

Stores the results of the tests in a directory specified by the --dir

option (defaults to /sql-bench/output). Result files are named in

a format RUN-xxx, where xxx is the platform tested; for instance,

/sql-bench/output/RUN-mysql-Linux_2.6.10_1.766_FC3_i686.

If this looks like a formatted version of #> uname -a, that’s because it is.

--dir

Directory for logging output (see --log).

--use-old-result

Overwrites any existing logged result output (see --log).

A convenient way to insert a comment into the result file indicating the

hardware and database server configuration tested.

Lets the benchmark framework use non-ANSI-standard SQL commands

if such commands can make the querying faster.

Very useful option when running the benchmark test from a remote

location. 'Host' should be the host address of the remote server where

the database is located; for instance 'www.xyzcorp.com'.

Really handy for doing a short, simple test to ensure a new MySQL

installation works properly on the server you just installed it on.

Instead of running an exhaustive benchmark, this forces the suite to

verify only that the operations succeeded.

--user

--password

User login.

User password.

So, if you wanted to run all the tests against the MySQL database server, logging to an out-

put file and simply verifying that the benchmark tests worked, you would execute the following

from the /sql-bench directory:

#> ./run-all-tests --small-test ––log

--log

--comment

--fast

--host='host'

--small-test


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Viewing the Test Results

When the benchmark tests are finished, the script states:

Test finished.  You can find the result in:

output/RUN-mysql-Linux_2.6.10_1.766_FC3_i686

To view the result file, issue the following command:

#> cat output/RUN-mysql-Linux_2.6.10_1.766_FC3_i686

The result file contains a summary of all the tests run, including any parameters that were

supplied to the benchmark script. Listing 6-1 shows a small sample of the result file.

Listing 6-1. Sample Excerpt from RUN-mysql-Linux_2.6.10_1.766_FC3_i686

… omitted

alter-table: Total time:  2 wallclock secs ( 0.03 usr  0.01 sys +  0.00 cusr  0.00 \

csys =  0.04 CPU)

ATIS: Total time:  6 wallclock secs ( 1.61 usr  0.29 sys +  0.00 cusr  0.00 \

csys =  1.90 CPU)

big-tables: Total time:  0 wallclock secs ( 0.14 usr  0.05 sys +  0.00 cusr  0.00 \

csys =  0.19 CPU)

connect: Total time:  2 wallclock secs ( 0.58 usr  0.16 sys +  0.00 cusr  0.00 \

csys =  0.74 CPU)

create: Total time:  1 wallclock secs ( 0.08 usr  0.01 sys +  0.00 cusr  0.00 \

csys =  0.09 CPU)

insert: Total time:  9 wallclock secs ( 3.32 usr  0.68 sys +  0.00 cusr  0.00 \

csys =  4.00 CPU)

select: Total time: 14 wallclock secs ( 5.22 usr  0.63 sys +  0.00 cusr  0.00 \

csys =  5.85 CPU)

… omitted

As you can see, the result file contains a summary of how long each test took to execute,

in “wallclock” seconds. The numbers in parentheses, to the right of the wallclock seconds,

show the amount of time taken by the script for some housekeeping functionality; they repre-

sent the part of the total seconds that should be disregarded by the benchmark as simply

overhead of running the script.

In addition to the main RUN-xxx output file, you will also find in the /sql-bench/output

directory nine other files that contain detailed information about each of the tests run in the

benchmark. We’ll take a look at the format of those detailed files in the next section (Listing 6-2).

Running a Specific Test

The MySQL benchmarking suite gives you the ability to run one specific test against the data-

base server, in case you are concerned about the performance comparison of only a particular

set of operations. For instance, if you just wanted to run benchmarks to compare connection

operation performance, you could execute the following:

#> ./test-connect


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

This will start the benchmarking process that runs a series of loops to compare the con-

nection process and various SQL statements. You should see the script informing you of

various tasks it is completing. Listing 6-2 shows an excerpt of the test run.

Listing 6-2. Excerpt from ./test-connect

Testing server 'MySQL 5.0.2 alpha' at 2005-03-07  1:12:54

Testing the speed of connecting to the server and sending of data

Connect tests are done 10000 times and other tests 100000 times

Testing connection/disconnect

Time to connect (10000): 13 wallclock secs \

( 8.32 usr  1.03 sys +  0.00 cusr  0.00 csys =  9.35 CPU)

Test connect/simple select/disconnect

Time for connect+select_simple (10000): 17 wallclock secs \

( 9.18 usr  1.24 sys +  0.00 cusr  0.00 csys = 10.42 CPU)

Test simple select

Time for select_simple (100000): 10 wallclock secs \

( 2.40 usr  1.55 sys +  0.00 cusr  0.00 csys =  3.95 CPU)

… omitted

Total time: 167 wallclock secs \

(58.90 usr 17.03 sys +  0.00 cusr  0.00 csys = 75.93 CPU)

As you can see, the test output shows a detailed picture of the benchmarks performed.

You can use these output files to analyze the effects of changes you make to the MySQL

server configuration. Take a baseline benchmark script, like the one in Listing 6-2, and save it.

Then, after making the change to the configuration file you want to test—for instance, chang-

ing the key_buffer_size value—rerun the same test and compare the output results to see if,

and by how much, the performance of your benchmark tests have changed.

MySQL Super Smack

Super Smack is a powerful, customizable benchmarking tool that provides load limitations, in

terms of queries per second, of the benchmark tests it is supplied. Super Smack works by pro-

cessing a custom configuration file (called a smack file), which houses instructions on how to

process one or more series of queries (called query barrels in smack lingo). These configura-

tion files are the heart of Super Smack’s power, as they give you the ability to customize the

processing of your SQL queries, the creation of your test data, and other variables.

Before you use Super Smack, you need to download and install it, since it does not come

with MySQL. Go to http://vegan.net/tony/supersmack and download the latest version of

Super Smack from Tony Bourke’s web site.1 Use the following to install Super Smack, after

1. Super Smack was originally developed by Sasha Pachev, formerly of MySQL AB. Tony Bourke now

maintains the source code and makes it available on his web site (http://vegan.net/tony/).


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

changing to the directory where you just downloaded the tar file to (we’ve downloaded version

1.2 here; there may be a newer version of the software when you reach the web site):

#> tar -xzf super-smack-1.2.tar.gz

#> cd super-smack-1.2

#> ./configure –with-mysql

#> make install

Running Super Smack

Make sure you’re logged in as a root user when you install Super Smack. Then, to get an idea of

what the output of a sample smack run is, execute the following:

#> super-smack -d mysql smacks/select-key.smack 10 100

This command fires off the super-smack executable, telling it to use MySQL (-d mysql), passing

it the smack configuration file located in smack/select-key.smack, and telling it to use 10 con-

current clients and to repeat the tests in the smack file 100 times for each client.

You should see something very similar to Listing 6-3. The connect times and q_per_s values

may be different on your own machine.

Listing 6-3. Executing Super Smack for the First Time

Error running query select count(*) from http_auth: \

Table 'test.http_auth' doesn't exist

Creating table 'http_auth'

Populating data file '/var/smack-data/words.dat' \

with # command 'gen-data -n 90000 -f %12-12s%n,%25-25s,%n,%d'

Loading data from file '/var/smack-data/words.dat' into table 'http_auth'

Table http_auth is now ready for the test

Query Barrel Report for client smacker1

connect: max=4ms  min=0ms avg= 1ms from 10 clients

Query_type      num_queries     max_time        min_time        q_per_s

select_index    2000            0               0               4983.79

Let’s walk through what’s going on here. Going from the top of Listing 6-3, you see that

when Super Smack started the benchmark test found in smack/select-key.smack, it tried to

execute a query against a table (http_auth) that didn’t exist. So, Super Smack created the

http_auth table. We’ll explain how Super Smack knew how to create the table in just a

minute. Moving on, the next two lines tell you that Super Smack created a test data file

(/var/smack-data/words.dat) and loaded the test data into the http_auth table.

■Tip As of this writing, Super Smack can also benchmark against the PostgreSQL database server (using

the -d pg option). See the file TUTORIAL located in the /super-smack directory for some details on speci-

fying PostgreSQL parameters in the smack files.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Finally, under the line Query Barrel Report for client smacker1, you see the output of

the benchmark test (highlighted in Listing 6-3). The first highlighted line shows a breakdown

of the times taken to connect for the clients we requested. The number of clients should

match the number from your command line. The following lines contain the output results

of each type of query contained in the smack file. In this case, there was only one query type,

called select_index. In our run, Super Smack executed 2,000 queries for the select_index

query type. The corresponding output line in Listing 6-3 shows that the minimum and maxi-

mum times for the queries were all under 1 millisecond (thus, 0), and that 4,982.79 queries

were executed per second (q_per_s). This last statistic, q_per_s, is what you are most inter-

ested in, since this statistic gives you the best number to compare with later benchmarks.

■Tip Remember to rerun your benchmark tests and average the results of the tests to get the most accu-

rate benchmark results. If you rerun the smack file in Listing 6-3, even with the same parameters, you’ll

notice the resulting q_per_s value will be slightly different almost every time, which demonstrates the need

for multiple test runs.

To see how Super Smack can help you analyze some useful data, let’s run the following

slight variation on our previous shell execution. As you can see, we’ve changed only the num-

ber of concurrent clients, from 10 to 20.

#> super-smack -d mysql smacks/select-key.smack 20 100

Query Barrel Report for client smacker1

connect: max=206ms  min=0ms avg= 18ms from 20 clients

Query_type      num_queries     max_time        min_time        q_per_s

select_index    4000            0               0               5054.71

Here, you see that increasing the number of concurrent clients actually increased the per-

formance of the benchmark test. You can continue to increment the number of clients by a small

amount (increments of ten in this example) and compare the q_per_s value to your previous runs.

When you start to see the value of q_per_s decrease or level off, you know that you’ve hit your

peak performance for this benchmark test configuration.

In this way, you perform a process of determining an optimal condition. In this scenario,

the condition is the number of concurrent clients (the variable you’re changing in each itera-

tion of the benchmark). With each iteration, you come closer to determining the optimal value

of a specific variable in your scenario. In our case, we determined that for the queries being

executed in the select-key.smack benchmark, the optimal number of concurrent client con-

nections would be around 30—that’s where this particular laptop peaked in queries per

second. Pretty neat, huh?

But, you might ask, how is this kind of benchmarking applicable to a real-world example?

Clearly, select-key.smack doesn’t represent much of anything (just a simple SELECT statement,

as you’ll see in a moment). The real power of Super Smack lies in the customizable nature of

the smack configuration files.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Building Smack Files

You can build your own smack files to represent either your whole application or pieces of the

application. Let’s take an in-depth look at the components of the select-key.smack file, and you’ll

get a feel for just how powerful this tool can be. Do a simple #> cat smacks/select-key.smack to

display the smack configuration file you used in the preliminary benchmark tests. You can follow

along as we walk through the pieces of this file.

■Tip When creating your own smack files, it’s easiest to use a copy of the sample smack files included

with Super Smack. Just do #> cp smacks/select-key.smack smacks/mynew.smack to make a new

copy. Then modify the mynew.smack file.

Configuration smack files are composed of sections, formatted in a way that resembles

C syntax. These sections define the following parts of the benchmark test:

• Client configuration: Defines a named client for the smack program (you can view this

as a client connection to the database).

• Table configuration: Names and defines a table to be used in the benchmark tests.

• Dictionary configuration: Names and describes a source for data that can be used in

generating test data.

• Query definition: Names one or more SQL statements to be run during the test and

defines what those SQL statements should do, how often they should be executed, and

what parameters and variables should be included in the statements.

• Main: The execution component of Super Smack.

Going from the top of the smack file to the bottom, let’s take a look at the code.

First Client Configuration Section

Listing 6-4 shows the first part of select-key.smack.

Listing 6-4. Client Configuration in select-key.smack

// this is will be used in the table section

client "admin"

{

user "root";

host "localhost";

db "test";

pass "";

socket "/var/lib/mysql/mysql.sock"; // this only applies to MySQL and is

// ignored for PostgreSQL

}


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

This is pretty straightforward. This section of the smack file is naming a new client for the

benchmark called admin and assigning some connection properties for the client. You can cre-

ate any number of named client components, which can represent various connections to the

various databases. We’ll take a look at the second client configuration in the select-key.smack

file soon. But first, let’s examine the next configuration section in the file.

Table Configuration Section

Listing 6-5 shows the first defined table section.

Listing 6-5. Table Section Definition in select-key.smack

// ensure the table exists and meets the conditions

table "http_auth"

{

client "admin"; // connect with this client

// if the table is not found or does not pass the checks, create it

// with the following, dropping the old one if needed

create "create table http_auth

(username char(25) not null primary key,

pass char(25),

uid integer not null,

gid integer not null

)";

min_rows "90000"; // the table must have at least that many rows

data_file "words.dat"; // if the table is empty, load the data from this file

gen_data_file "gen-data -n 90000 -f %12-12s%n,%25-25s,%n,%d";

// if the file above does not exist, generate it with the above shell command

// you can replace this command with anything that prints comma-delimited

// data to stdout, just make sure you have the right number of columns

}

Here, you see we’re naming a new table configuration section, for a table called http_auth,

and defining a create statement for the table, in case the table does not exist in the database.

Which database will the table be created in? The database used by the client specified in the

table configuration section (in this case the client admin, which we defined in Listing 6-4).

The lines after the create definition are used by Super Smack to populate the http_auth

table with data, if the table has less than the min_rows value (here, 90,000 rows). The data_file

value specifies a file containing comma-delimited data to fill the http_auth table. If this file

does not exist in the /var/smack-data directory, Super Smack will use the command given in

the gen_data_file value in order to create the data file needed.

In this case, you can see that Super Smack is executing the following command in order to

generate the words.dat file:

#> gen-data -n 90000 -f %12-12s%n,%25-25s,%n,%d

gen-data is a program that comes bundled with Super Smack. It enables you to generate

random data files using a simple command-line syntax similar to C’s fprintf() function. The

-n [rows] command-line option tells gen-data to create 90,000 rows in this case, and the -f

option is followed by a formatting string that can take the tokens listed in Table 6-2. The


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

formatting string then outputs randomized data to the file in the data_file value, delimited

by whichever delimiter is used in the format string. In this case, a comma was used to delimit

fields in the data rows.

Table 6-2. Super Smack gen-data -f Option Formatting Tokens

Token

Used For

Comments

%[min][-][max]s

String fields

%n

%d

Row numbers

Integer fields

Prints strings of lengths between the min and max

values. For example, %10-25s creates a character field

between 10 and 25 characters long. For fixed-length

character fields, simply set min equal to the

maximum number of characters.

Puts an integer value in the field with the value of the

row number. Use this to simulate an auto-increment

column.

Creates a random integer number. The version of

gen-data that comes with Super Smack 1.2 does not

allow you to specify the length of the numeric data

produced, so %07d does not generate a seven-digit

number, but a random integer of a random length of

characters. In our tests, gen-data simply generated

7-, 8-, 9-, and 10-character length positive integers.

You can optionally choose to substitute your own scripts or executables in place of the sim-

ple gen-data program. For instance, if you had a Perl script /tests/create-test-data.pl, which

created custom test tables, you could change the table configuration section’s gen-data-file

value as follows:

gen-data-file "perl /tests/create-test-data.pl"

POPULATING TEST SETS WITH GEN-DATA

gen-data is a neat little tool that you can use in your scripts to generate randomized data. gen-data

prints its output to the standard output (stdout) by default, but you can redirect that output to your own

scripts or another file. Running gen-data in a console, you might see the following results:

#> gen-data -n 12 -f %10-10s,%n,%d,%10-40s

ilcpsklryv,1,1025202362,pjnbpbwllsrehfmxr

kecwitrsgl,2,1656478042,xvtjmxypunbqfgxmuvg

fajclfvenh,3,1141616124,huorjosamibdnjdbeyhkbsomb

ltouujdrbw,4,927612902,rcgbflqpottpegrwvgajcrgwdlpgitydvhedt

usippyvxsu,5,150122846,vfenodqasajoyomgsqcpjlhbmdahyvi

uemkssdsld,6,1784639529,esnnngpesdntrrvysuipywatpfoelthrowhf

exlwdysvsp,7,87755422,kfblfdfultbwpiqhiymmy

alcyeasvxg,8,2113903881,itknygyvjxnspubqjppj

brlhugesmm,9,1065103348,jjlkrmgbnwvftyveolprfdcajiuywtvg

fjrwwaakwy,10,1896306640,xnxpypjgtlhf

teetxbafkr,11,105575579,sfvrenlebjtccg

jvrsdowiix,12,653448036,dxdiixpervseavnwypdinwdrlacv


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

You can use a redirect to output the results to a file, as in this example:

#> gen-data -n 12 -f %10-10s,%n,%d,%10-40s > /test-data/table1.dat

A number of enhancements could be made to gen-data, particularly in the creation of more random

data samples. You’ll find that rerunning the gen-data script produces the same results under the same

session. Additionally, the formatting options are quite limited, especially for the delimiters it's capable of pro-

ducing. We tested using the standard \t character escape, which produces just a "t" character when the

format string was left unquoted, and a literal "\t" when quoted. Using ";" as a delimiter, you must remem-

ber to use double quotes around the format string, as your console will interpret the string as multiple

commands to execute.

Regardless of these limitations, gen-data is an excellent tool for quick generation, especially of text

data. Perhaps there will be some improvements to it in the future, but for now, it seems that the author pro-

vided a simple tool under the assumption that developers would generally prefer to write their own scripts for

their own custom needs.

As an alternative to gen-data, you can always use a simple SQL statement to dump existing data into

delimited files, which Super Smack can use in benchmarking. To do so, execute the following:

SELECT field1, field2, field3 INTO OUTFILE "/test-data/test.csv"

FIELDS TERMINATED BY ','

OPTIONALLY ENCLOSED BY '"'

LINES TERMINATED BY "\n"

FROM table1

You should substitute your own directory for our /test-data/ directory in the code. Ensure that the

mysql user has write permissions for the directory as well.

Remember that Super Smack looks for the data file in the /var/smack-data directory by default (you

can configure it to look somewhere else during installation by using the --datadir configure option). So,

copy your test file over to that directory before running a smack file that looks for it:

#> cp /test-data/test.csv /var/smack-data/test.csv

Dictionary Configuration Section

The next configuration section is to configure the dictionary, which is named word in

select-key.smack, as shown in Listing 6-6.

Listing 6-6. Dictionary Configuration Section in select-key.smack

//define a dictionary

dictionary "word"

{

type "rand"; // words are retrieved in random order

source_type "file"; // words come from a file

source "words.dat"; // file location

delim ","; // take the part of the line before,

file_size_equiv "45000"; // if the file is greater than this

//divive the real file size by this value obtaining N and take every Nth

//line skipping others. This is needed to be able to target a wide key

// range without using up too much memory with test keys

}


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

This structure defines a dictionary object named word, which Super Smack can use in

order to find rows in a table object. You’ll see how the dictionary object is used in just a

moment. For now, let’s look at the various options a dictionary section has. The variables are

not as straightforward as you might hope.

The source_type variable is where to find or generate the dictionary entries; that is, where

to find data to put into the array of entries that can be retrieved by Super Smack from the dic-

tionary. The source_type can be one of the following:

• "file": If source_type = "file", the source value will be interpreted as a file path rela-

tive to the data directory for Super Smack. By default, this directory is /var/smack-data,

but it can be changed with the ./configure --with-datadir=DIR option during installa-

tion. Super Smack will load the dictionary with entries consisting of the first field in the

row. This means that if the source file is a comma-delimited data set (like the one gen-

erated by gen-data), only the first character field (up to the comma) will be used as an

entry. The rest of the row is discarded.

• "list": When source_type = "list", the source value must consist of a list of comma-

separated values that will represent the entries in the dictionary. For instance, source =

"cat,dog,owl,bird" with a source_type of "list" produces four entries in the diction-

ary for the four animals.

• "template": If the "template" value is used for the source_type variable, the source vari-

able must contain a valid printf()2 format string, which will be used to generate the

needed dictionary entries when the dictionary is called by a query object. When the

type variable is also set to "unique", the entries will be fed to the template defined in

the source variable, along with an incremented integer ID of the entry generated by

the dictionary. So, if you had set up the source template value as "%05d", the generated

entries would be five-digit auto-incremented integers.

The type variable tells Super Smack how to initialize the dictionary from the source vari-

able. It can be any of the following:

• "rand": The entries in the dictionary will be created by accessing entries in the source

value or file in a random order. If the source_type is "file", to load the dictionary, rows

will be selected from the file randomly, and the characters in the row up to the delimiter

(delim) will be used as the dictionary entry. If you used the same generated file in popu-

lating your table, you’re guaranteed of finding a matching entry in your table.

• "seq": Super Smack will read entries from the dictionary file in sequential order, for

as many rows as the benchmark dictates (as you’ll see in a minute). Again, you’re

guaranteed to find a match if you used the same generated file to populate the table.

• "unique": Super Smack will generate fields in a unique manner similar to the way

gen-data creates field values. You’re not guaranteed that the uniquely generated

field will match any values in your table. Use this type setting with the "template"

source_type variable.

2.

If you’re unfamiliar with printf() C function, simply do a #> man sprintf from your console for

instructions on its usage.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Query Definition Section

The next section in select-key.smack shows the query object definition being tested in the

benchmark. The query object defines the SQL statements you will run for the benchmark.

Listing 6-7 shows the definition.

Listing 6-7. Query Object Definition in select-key.smack

query "select_by_username"

{

query "select * from http_auth where username = '$word'";

// $word will be substitute with the read from the 'word' dictionary

type "select_index";

// query stats will be grouped by type

has_result_set "y";

// the query is expected to return a result set

parsed "y";

// the query string should be first processed by super-smack to do

// dictionary substitution

}

First, the query variable is set to a string housing a SQL statement. In this case, it’s a

simple SELECT statement against the http_auth table defined earlier, with a WHERE expression

on the username field. We’ll explain how the '$word' parameter gets filled in just a second.

The type variable is simply a grouping for the final performance results output. Remember

the output from Super Smack shown earlier in Listing 6-3? The query_type column corre-

sponds to the type variable in the various query object definitions in your smack files. Here,

in select-key.smack, there is only a single query object, so you see just one value in the

query_type column of the output result. If you had more than one query, having distinct

type values, you would see multiple rows in the output result representing the different

query types. You can see an example of this in update-key.smack, the other sample smack

file, which we encourage you to investigate.

The has_result_set value (either "y" or "n") is fairly self-explanatory and simply informs

Super Smack that the query will return a resultset. The parsed variable value (again, either "y"

or "n") is a little more interesting. It relates to the dictionary object definition we covered ear-

lier. If the parsed variable is set to "y", Super Smack will fill any placeholders of the style $xxx

with a dictionary entry corresponding to xxx. Here, the placeholder $word in the query object’s

SQL statement will be replaced with an entry from the "word" dictionary, which was previously

defined in the file.

You can define any number of named dictionaries, similar to the way we defined the

"word" dictionary in this example. For each dictionary, you may refer to dictionary entries in

your queries using the name of the dictionary. For instance, if you had defined two dictionary

objects, one called "username" and one called "password", which you had populated with user-

names and passwords, you could have a query statement like the following:

query "userpass_select"

{

query "SELECT * FROM http_auth WHERE username='$username' AND pass='$password'";

has_result_set = "y";

parsed = "y";


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Second Client Configuration Section

In Listing 6-8, you see the next object definition, another client object. This time, it does the

actual querying against the http_auth table.

Listing 6-8. Second Client Object Definition in select-key.smack

client "smacker1"

{

user "test"; // connect as this user

pass ""; // use this password

host "localhost"; // connect to this host

db "test"; // switch to this database

socket "/var/lib/mysql/mysql.sock"; // this only applies to MySQL and is

// ignored for PostgreSQL

query_barrel "2 select_by_username"; // on each round,

// run select_by_username query 2 times

}

This client is responsible for the brunt of the benchmark queries. As you can see,

"smacker1" is a client object with the normal client variables you saw earlier, but with an

extra variable called query_barrel.3

A query barrel, in smack terms, is simply a series of named queries run for the client object.

The query barrel contains a string in the form of "n query_object_name […]", where n is the num-

ber of “shots” of the query defined in query_object_name that should be “fired” for each invocation

of this client. In this case, the "select_by_username" query object is shot twice for each client

during firing of the benchmark smack file. If you investigate the other sample smack file, update-➥

key.smack, you’ll see that Super Smack fires one shot for an "update_by_username" query object

and one shot for a "select_by_username" query object in its own "smacker1" client object.

Listing 6-9 shows the final main execution object for the select-key.smack file.

Listing 6-9. Main Execution Object in select-key.smack

Main Section

main

{

smacker1.init(); // initialize the client

smacker1.set_num_rounds($2); // second arg on the command line defines

// the number of rounds for each client

smacker1.create_threads($1);

// first argument on the command line defines how many client instances

// to fork. Anything after this will be done once for each client until

// you collect the threads

smacker1.connect();

3. Super Smack uses a gun metaphor to symbolize what’s going on in the benchmark runs. super-smack

is the gun, which fires benchmark test bullets from its query barrels. Each query barrel can contain a

number of shots.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

// you must connect after you fork

smacker1.unload_query_barrel(); // for each client fire the query barrel

// it will now do the number of rounds specified by set_num_rounds()

// on each round, query_barrel of the client is executed

smacker1.collect_threads();

// the master thread waits for the children, each child reports the stats

// the stats are printed

smacker1.disconnect();

// the children now disconnect and exit

}

This object describes the steps that Super Smack takes to actually run the benchmark

using all the objects you’ve previously defined in the smack file.

■Note It doesn’t matter in which order you define objects in your smack files, with one exception. You

must define the main executable object last.

The client "smacker1", which you’ve seen defined in Listing 6-8, is initialized (loaded into

memory), and then the next two functions, set_num_rounds() and create_threads(), use argu-

ments passed in on the command line to configure the test for the number of iterations you

passed through and spawn the number of clients you’ve requested. The $1 and $2 represent

the command-line arguments passed to Super Smack after the name of the smack file (those

of you familiar with shell scripting will recognize the nomenclature here). In our earlier sam-

ple run of Super Smack, we executed the following:

#> super-smack –d mysql smacks/select-key.smack 10 100

The 10 would be put into the $1 variable, and 100 goes into the $2 variable.

Next, the smacker1 client connects to the database defined in its db variable, passing the

authentication information it also contains. The client’s query_barrel variable is fired, using

the unload_query_barrel() function, and finally some cleanup work is done with the collect_

threads() and disconnect() functions. Super Smack then displays the results of the bench-

mark test to stdout.

When you’re doing your own benchmarking with Super Smack, you’ll most likely want to

change the client, dictionary, table, and query objects to correspond to the SQL code you

want to test. The main object definition will not need to be changed, unless you want to start

tinkering with the C++ super-smack code.

■Caution For each concurrent client you specify for Super Smack to create, it creates a persistent con-

nection to the MySQL server. For this reason, unless you want to take a crack at modifying the source code,

it’s not possible to simulate nonpersistent connections. This constraint, however, is not a problem if you are

using Super Smack simply to compare the performance results of various query incarnations. If, however,

you wish to truly simulate a web application environment (and thus, nonpersistent connections) you should

use either ApacheBench or httperf to benchmark the entire web application.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

MyBench

Although Super Smack is a very powerful benchmarking program, it can be difficult to bench-

mark a complex set of logical instructions. As you’ve seen, Super Smack’s configuration files are

fairly limited in what they can test: basically, just straight SQL statements. If you need to test some

complicated logic—for instance, when you need to benchmark a script that processes a number

of statements inside a transaction, and you need to rely on SQL inline variables (@variable . . .)—

you will need to use a more flexible benchmarking system.

Jeremy Zawodny, coauthor of High Performance MySQL (O’Reilly, 2004) has created a

Perl module called MyBench (http://jeremy.zawodny.com/mysql/mybench/), which allows you

to benchmark logic that is a little more complex. The module enables you to write your own

Perl functions, which are fed to the MyBench benchmarking framework using a callback. The

framework handles the chore of spawning the client threads and executing your function,

which can contain any arbitrary logic that connects to a database, executes Perl and SQL

code, and so on.

■Tip For server and configuration tuning, and in-depth coverage of Jeremy Zawodny’s various utility

tools like MyBench and mytop, consider picking up a copy of High Performance MySQL (O’Reilly, 2004), by

Jeremy Zawodny and Derek Bailing. The book is fairly focused on techniques to improve the performance

of your hardware and MySQL configuration, the material is thoughtful, and the book is an excellent tuning

reference.

The sample Perl script, called bench_example, which comes bundled with the software,

provides an example on which you can base your own benchmark tests. Installation of the

module follows the standard GNU make process. Instructions are available in the tarball

you can download from the MyBench site.

■Caution Because MyBench is not compiled (it’s a Perl module), it can be more resource-intensive than

running Super Smack. So, when you run benchmarks using MyBench, it’s helpful to run them on a machine

separate from your database, if that database is on a production machine. MyBench can use the standard

Perl DBI module to connect to remote machines in your benchmark scripts.

ApacheBench (ab)

A good percentage of developers and administrators reading this text will be using MySQL

for web-based applications. Therefore, we found it prudent to cover two web application

stress-testing tools: ApacheBench (described here) and httperf (described in the next section).

ApacheBench (ab) comes installed on almost any Unix/Linux distribution with the Apache

web server installed. It is a contrived load generator, and therefore provides a brute-force method

of determining how many requests for a particular web resource a server can handle.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

As an example, let’s run a benchmark comparing the performance of two simple scripts,

finduser1.php (shown in Listing 6-10) and finduser2.php (shown in Listing 6-11), which select

records from the http_auth table we populated earlier in the section about Super Smack. The

http_auth table contains 90,000 records and has a primary key index on username, which is a

char(25) field. Each username has exactly 25 characters. For the tests, we’ve turned off the

query cache, so that it won't skew any results. We know that the number of records that match

both queries is exactly 146 rows in our generated table. However, here we’re going to do some

simple benchmarks to determine which method of retrieving the same information is faster.

■Note If you’re not familiar with the REGEXP function, head over to http://dev.mysql.com/doc/mysql/

en/regexp.html. You’ll see that the SQL statements in the two scripts in Listings 6-10 and 6-11 produce

identical results.

Listing 6-10. finduser1.php

<?php

// finduser1.php

$conn = mysql_connect("localhost","test","") or die (mysql_error());

mysql_select_db("test", $conn) or die ("Can't use database 'test'");

$result = mysql_query("SELECT * FROM http_auth WHERE username LIKE 'ud%'");

if ($result)

echo "found: " . mysql_num_rows($result);

else

echo mysql_error();

?>

Listing 6-11. finduser2.php

<?php

// finduser2.php

$conn = mysql_connect("localhost","test","") or die (mysql_error());

mysql_select_db("test", $conn) or die ("Can't use database 'test'");

$result = mysql_query("SELECT * FROM http_auth WHERE username REGEXP '^ud'");

if ($result)

echo "found: " . mysql_num_rows($result);

else

echo mysql_error();

?>


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

You can call ApacheBench from the command line, in a fashion similar to calling Super

Smack. Listing 6-12 shows an example of calling ApacheBench to benchmark a simple script and

its output. The resultset shows the performance of the finduser1.php script from Listing 6-10.

Listing 6-12. Running ApacheBench and the Output Results for finduser1.php

# ab -n 100 -c 10 http://127.0.0.1/finduser1.php

Document Path:          /finduser1.php

Document Length:        84 bytes

Concurrency Level:      10

Time taken for tests:   1.797687 seconds

Complete requests:      1000

Failed requests:        0

Write errors:           0

Total transferred:      277000 bytes

HTML transferred:       84000 bytes

Requests per second:    556.27 [#/sec] (mean)

Time per request:       17.977 [ms] (mean)

Time per request:       1.798 [ms] (mean, across all concurrent requests)

Transfer rate:          150.19 [Kbytes/sec] received

Connection Times (ms)

min  mean[+/-sd] median   max

Connect:        0    0   0.3      0       3

Processing:     1   15  62.2      6     705

Waiting:        1   11  43.7      5     643

Total:          1   15  62.3      6     708

Percentage of the requests served within a certain time (ms)

50%      6

66%      9

75%     10

80%     11

90%     15

95%     22

98%     91

99%    210

100%    708 (longest request)

As you can see, ApacheBench outputs the results of its stress testing in terms of the num-

ber of requests per second it was able to sustain (along with the min and max requests), given a

number of concurrent connections (the -c command-line option) and the number of requests

per concurrent connection (the -n option).

We provided a high enough number of iterations and clients to make the means accurate

and reduce the chances of an outlier skewing the results. The output from ApacheBench shows a

number of other statistics, most notably the percentage of requests that completed within a cer-

tain time in milliseconds. As you can see, for finduser1.php, 80% of the requests completed in


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

11 milliseconds or less. You can use these numbers to determine whether, given a certain

amount of traffic to a page (in number of requests and number of concurrent clients), you

are falling within your acceptable response times in your benchmarking plan.

To compare the performance of finduser1.php with finduser2.php, we want to execute

the same benchmark command, but on the finduser2.php script instead. In order to ensure

that we were operating in the same environment as the first test, we did a quick reboot of our

system and ran the tests. Listing 6-13 shows the results for finduser2.php.

Listing 6-13. Results for finduser2.php (REGEXP)

# ab -n 100 -c 10 http://127.0.0.1/finduser2.php

Document Path:          /finduser1.php

Document Length:        10 bytes

Concurrency Level:      10

Time taken for tests:   5.848457 seconds

Complete requests:      1000

Failed requests:        0

Write errors:           0

Total transferred:      203000 bytes

HTML transferred:       10000 bytes

Requests per second:    170.99 [#/sec] (mean)

Time per request:       58.485 [ms] (mean)

Time per request:       5.848 [ms] (mean, across all concurrent requests)

Transfer rate:          33.86 [Kbytes/sec] received

Connection Times (ms)

min  mean[+/-sd] median   max

Connect:        0    0   0.6      0       7

Processing:     3   57 148.3     30    1410

Waiting:        2   56 144.6     29    1330

Total:          3   57 148.5     30    1413

Percentage of the requests served within a certain time (ms)

50%     30

66%     38

75%     51

80%     56

90%     73

95%    109

98%    412

99%   1355

100%   1413 (longest request)

As you can see, ApacheBench reported a substantial performance decrease from the first

run: 556.27 requests per second compared to 170.99 requests per second, making finduser1.php

more than 325% faster. In this way, ApacheBench enabled us to get real numbers in order to

compare our two methods.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Clearly, in this case, we could have just as easily used Super Smack to run the benchmark

comparisons, since we’re changing only a simple SQL statement; the PHP code does very little.

However, the example is meant only as a demonstration. The power of ApacheBench (and

httperf, described next) is that you can use a single benchmarking platform to test both

MySQL-specific code and PHP code. PHP applications are a mixture of both, and having a

benchmark tool that can test and isolate the performance of both of them together is a valu-

able part of your benchmarking framework.

The ApacheBench benchmark has told us only that the REGEXP method fared poorly com-

pared with the simple LIKE clause. The benchmark hasn’t provided any insight into why the

REGEXP scenario performed poorly. For that, we’ll need to use some profiling tools in order to

dig down into the root of the issue, which we’ll do in a moment. But the benchmarking frame-

work has given us two important things: real percentile orders of differentiation between two

comparative methods of achieving the same thing, and knowledge of how many requests per

second the web server can perform given this particular PHP script.

If we had supplied ApacheBench with a page in an actual application, we would have some

numbers on the load limits our actual server could maintain. However, the load limits reflect a

scenario in which users are requesting only a single page of our application in a brute-force way.

If we want a more realistic tool for assessing a web application’s load limitations, we should turn

to httperf.

httperf

Developed by David Mosberger of HP Research Labs, httperf is an HTTP load generator with a

great deal of features, including the ability to read Apache log files, generate sessions in order to

simulate user behavior, and generate realistic user-browsing patterns based on a simple scripting

format. You can obtain httperf from http://www.hpl.hp.com/personal/David_Mosberger/

httperf.html. After installing httperf using a standard GNU make installation, go through

the man pages thoroughly to investigate the myriad options available to you.

Running httperf is similar to running ApacheBench: you call the httperf program

and specify a number of connections (--num-conn) and the number of calls per connection

(--num-calls). Listing 6-14 shows the output of httperf running a benchmark against the same

finduser2.php script (Listing 6-11) we used in the previous section.

Listing 6-14. Output from httperf

# httperf --server=localhost --uri=/finduser2.php --num-conns=10 --num-calls=100

Maximum connect burst length: 1

Total: connections 10 requests 18 replies 8 test-duration 2.477 s

Connection rate: 4.0 conn/s (247.7 ms/conn, <=1 concurrent connections)

Connection time [ms]: min 237.2 avg 308.8 max 582.7 median 240.5 stddev 119.9

Connection time [ms]: connect 0.3

Connection length [replies/conn]: 1.000

Request rate: 7.3 req/s (137.6 ms/req)

Request size [B]: 73.0


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Reply rate [replies/s]: min 0.0 avg 0.0 max 0.0 stddev 0.0 (0 samples)

Reply time [ms]: response 303.8 transfer 0.0

Reply size [B]: header 193.0 content 10.0 footer 0.0 (total 203.0)

Reply status: 1xx=0 2xx=8 3xx=0 4xx=0 5xx=0

CPU time [s]: user 0.06 system 0.44 (user 2.3% system 18.0% total 20.3%)

Net I/O: 1.2 KB/s (0.0*10^6 bps)

Errors: total 10 client-timo 0 socket-timo 0 connrefused 0 connreset 10

Errors: fd-unavail 0 addrunavail 0 ftab-full 0 other 0

As you’ve seen in our benchmarking examples, these tools can provide you with some

excellent numbers in comparing the differences between approaches and show valuable

information regarding which areas of your application struggle compared with others. How-

ever, benchmarks won’t allow you to diagnose exactly what it is about your SQL or application

code scripts that are causing a performance breakdown. For example, benchmark test results

fell short in identifying why the REGEXP scenario performed so poorly. This is where profilers

and profiling techniques enter the picture.

What Can Profiling Do for You?

Profilers and diagnostic techniques enable you to procure information about memory con-

sumption, response times, locking, and process counts from the engines that execute your

SQL scripts and application code.

PROFILERS VS. DIAGNOSTIC TECHNIQUES

When we speak about the topic of profiling, it’s useful to differentiate between a profiler and a profiling technique.

A profiler is a full-blown application that is responsible for conducting what are called traces on appli-

cation code passed through the profiler. These traces contain information about the breakdown of function

calls within the application code block analyzed in the trace. Most profilers commonly contain the functional-

ity of debuggers in addition to their profiling ability, which enables you to detect errors in the application code

as they occur and sometimes even lets you step through the code itself. Additionally, profiler traces come in

two different formats: human-readable and machine-readable. Human-readable traces are nice because you

can easily read the output of the profiler. However, machine-readable trace output is much more extensible,

as it can be read into analysis and graphing programs, which can use the information contained in the trace

file because it’s in a standardized format. Many profilers today include the ability to produce both types of

trace output.

Diagnostic techniques, on the other hand, are not programs per se, but methods you can deploy, either

manually or in an automated fashion, in order to grab information about the application code while it is being

executed. You can use this information, sometimes called a dump or a trace, in diagnosing problems on the

server as they occur.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

From a MySQL perspective, you’re interested in determining how many threads are exe-

cuting against the server, what these threads are doing, and how efficiently your server is

processing these requests. You should already be familiar with many of MySQL’s status vari-

ables, which provide insight into the various caches and statistics that MySQL keeps available.

However, aside from this information, you also want to see the statements that threads are

actually running against the server as they occur. You want to see just how many resources are

being consumed by the threads. You want to see if one particular type of query is consistently

producing a bottleneck—for instance, locking tables for an extended period of time, which

can create a domino effect of other threads waiting for a locked resource to be freed. Addition-

ally, you want to be able to determine how MySQL is attempting to execute SQL statement

requests, and perhaps get some insight into why MySQL chooses a particular path of execution.

From a web application’s perspective, you want to know much the same kind of informa-

tion. Which, if any, of your application blocks is taking the most time to execute? For a page

request, it would be nice to see if one particular function call is demanding the vast majority

of processing power. If you make changes to the code, how does the performance change?

Anyone can guess as to why an application is performing poorly. You can go on any Inter-

net forum, enter a post about your particular situation, and you’ll get 100 different responses,

all claiming their answer is accurate. But, the fact is, until they or you run some sort of diag-

nostic routines or a profiler against your application while it is executing, everyone’s answer is

simply a guess. Guessing just doesn’t cut it in the professional world. Using a profiler and diag-

nostic techniques, you can find out for yourself what specific parts of an application aren’t up

to snuff, and take corrective action based on your findings.

General Profiling Guidelines

There’s a principle in diagnosing and identifying problems in application code that is worth

repeating here before we get into the profiling tools you’ll be using. When you see the results

of a profiler trace, you’ll be presented with information that will show you an application

block broken down into how many times a function (or SQL statement) was called, and how

long the function call took to complete. It is extremely easy to fall into the trap of overoptimiz-

ing a piece of application code, simply because you have the diagnostic tools that show you

what’s going on in your code. This is especially true for PHP programmers who see the func-

tion call stack for their pages and want to optimize every single function call in their

application.

Basically, the rule of thumb is to start with the block of code that is taking the longest time

to execute or is consuming the most resources. Spend your time identifying and fixing those

parts of your application code that will have noticeable impact for your users. Don’t waste

your precious time optimizing a function call that executes in 4 milliseconds just to get the

time down to 2 milliseconds. It’s just not worth it, unless that function is called so often that

it makes a difference to your users. Your time is much better spent going after the big fish.

That said, if you do identify a way to make your code faster, by all means document it and

use that knowledge in your future coding. If time permits, perhaps think about refactoring

older code bases with your newfound knowledge. But always take into account the value of

your time in doing so versus the benefits, in real time, to the user.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Profiling Tools

Your first question might be, “Is there a MySQL profiler?” The flat answer is no, there isn’t.

Although MySQL provides some tools that enable you to do profiling (to a certain extent) of

the SQL statements being run against the server, MySQL does not currently come bundled

with a profiler program able to generate storable trace files.

If you are coming from a Microsoft SQL Server background and have experience using

the SQL Server Profiler, you will still be able to use your basic knowledge of how traces and

profiling work, but unfortunately, MySQL has no similar tool. There are some third-party

vendors who make some purported profilers, but these merely display the binary log file

data generated by MySQL and are not hooked in to MySQL’s process management directly.

Here, we will go over some tools that you can use to simulate a true profiler environment,

so that you can diagnose issues effectively. These tools will prove invaluable to you as you

tackle the often-difficult problem of figuring out what is going on in your systems. We’ll

cover the following tools of the trade:

• The SHOW FULL PROCESSLIST and SHOW STATUS commands

• The EXPLAIN command

• The slow query and general query logs

• Mytop

• The Zend Advanced PHP Debugger extension

The SHOW FULL PROCESSLIST Command

The first tool in any MySQL administrator’s tool belt is the SHOW FULL PROCESSLIST command.

SHOW FULL PROCESSLIST returns the threads that are active in the MySQL server as a snapshot

of the connection resources used by MySQL at the time the SHOW FULL PROCESSLIST command

was executed. Table 6-3 lists the fields returned by the command.

Table 6-3. Fields Returned from SHOW FULL PROCESSLIST

Comment

ID of the user connection thread

Authenticated user

Authenticating host

Name of database or NULL for requests not executing database-specific requests

(like SHOW FULL PROCESSLIST)

Command

Usually either Query or Sleep, corresponding to whether the thread is actually

performing something at the moment

The amount of time in seconds the thread has been in this particular state (shown

in the next field)

The status of the thread’s execution (discussed in the following text)

The SQL statement executing, if you ran your SHOW FULL PROCESSLIST at the time

when a thread was actually executing a query, or some other pertinent information

Field

Id

User

Host

db

Time

State

Info


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Other than the actual query text, which appears in the Info column during a thread’s

query execution,4 the State field is what you’re interested in. The following are the major

states:

Sending data: This state appears when a thread is processing rows of a SELECT statement

in order to return the result to the client. Usually, this is a normal state to see returned,

especially on a busy server. The Info field will display the actual query being executed.

Copying to tmp table: This state appears after the Sending data state when the server

needs to create an in-memory temporary table to hold part of the result set being

processed. This usually is a fairly quick operation seen when doing ORDER BY or GROUP BY

clauses on a set of tables. If you see this state a lot and the state persists for a relatively

long time, it might mean you need to adjust some queries or rethink a table design, or it

may mean nothing at all, and the server is perfectly healthy. Always monitor things over

an extended period of time in order to get the best idea of how often certain patterns

emerge.

Copying to tmp table on disk: This state appears when the server needs to create a tempo-

rary table for sorting or grouping data, but, because of the size of the resultset, the server

must use space on disk, as opposed to in memory, to create the temporary storage area.

Remember from Chapter 4 that the buffer system can seamlessly switch from in-memory

to on-disk storage. This state indicates that this operation has occurred. If you see this

state appearing frequently in your profiling of a production application, we advise you to

investigate whether you have enough memory dedicated to the MySQL server; if so, make

some adjustments to the tmp_table_size system variable and run a few benchmarks to

see if you see fewer Copying to tmp table on disk states popping up. Remember that you

should make small changes incrementally when adjusting server variables, and test, test,

test.

Writing to net: This state means the server is actually writing the contents of the result

into the network packets. It would be rare to see this status pop up, if at all, since it usually

happens very quickly. If you see this repeatedly cropping up, it usually means your server

is getting overloaded or you’re in the middle of a stress-testing benchmark.

Updating: The thread is actively updating rows you’ve requested in an UPDATE statement.

Typically, you will see this state only on UPDATE statements affecting a large number of rows.

Locked: Perhaps the most important state of all, the Locked state tells you that the thread is

waiting for another thread to finish doing its work, because it needs to UPDATE (or SELECT ➥

FOR UPDATE) a resource that the other thread is using. If you see a lot of Locked states

occurring, it can be a sign of trouble, as it means that many threads are vying for the

same resources. Using InnoDB tables for frequently updated tables can solve many of

these problems (see Chapter 5) because of the finer-grained locking mechanism it uses

(MVCC). However, poor application coding or database design can sometimes lead to

frequent locking and, worse, deadlocking, when processes are waiting for each other

to release the same resource.

4. By execution, we mean the query parsing, optimization, and execution, including returning the result-

set and writing to the network packets.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Listing 6-15 shows an example of SHOW FULL PROCESSLIST identifying a thread in the

Locked state, along with a thread in the Copying to tmp table state. (We’ve formatted the out-

put to fit on the page.) As you can see, thread 71184 is waiting for the thread 65689 to finishing

copying data in the SELECT statement into a temporary table. Thread 65689 is copying to a

temporary table because of the GROUP BY and ORDER BY clauses. Thread 71184 is requesting an

UPDATE to the Location table, but because that table is used in a JOIN in thread 65689’s SELECT

statement, it must wait, and is therefore locked.

■Tip You can use the mysqladmin tool to produce a process list similar to the one displayed by SHOW ➥

FULL PROCESSLIST. To do so, execute #> mysqladmin processlist.

Listing 6-15. SHOW FULL PROCESSLIST Results

mysql> SHOW FULL PROCESSLIST;

+-------+--------+-----------+--------+---------+------+----------------------+-----

| Id    | User   | Host      | db     | Command | Time | State                | Info

+-------+--------+-----------+--------+---------+------+----------------------+-----

|    43 | job_db | localhost | job_db | Sleep   | 69   |                      | NULL

| 65378 | job_db | localhost | job_db | Sleep   | 23   |                      | NULL

| 65689 | job_db | localhost | job_db | Query   | 1    | Copying to tmp table |

SELECT e.Code, e.Name

FROM Job j

INNER JOIN Location l

ON j.Location = l.Code

INNER JOIN Employer e

ON j.Employer = e.Code

WHERE l.State = "NY"

AND j.ExpiresOn >= "2005-03-09"

GROUP BY  e.Code, e.Name

ORDER BY e.Sort ASC |

| 65713 | job_db | localhost | job_db | Sleep   | 60   |                      | NULL

| 65715 | job_db | localhost | job_db | Sleep   | 22   |                      | NULL

--- omitted ---

| 70815 | job_db | localhost | job_db | Sleep   | 12   |                      | NULL

| 70822 | job_db | localhost | job_db | Sleep   | 86   |                      | NULL

| 70824 | job_db | localhost | job_db | Sleep   | 62   |                      | NULL

| 70826 | root   | localhost | NULL   | Query   | 0    | NULL                 |  \

SHOW FULL PROCESSLIST

| 70920 | job_db | localhost | job_db | Sleep   | 17   |                      | NULL

| 70999 | job_db | localhost | job_db | Sleep   | 34   |                      | NULL

--- omitted ---

| 71176 | job_db | localhost | job_db | Sleep   | 39   |                      | NULL

| 71182 | job_db | localhost | job_db | Sleep   | 4    |                      | NULL

| 71183 | job_db | localhost | job_db | Sleep   | 17   |                      | NULL

| 71184 | job_db | localhost | job_db | Query   | 0    | Locked               |


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

UPDATE Job

SET   TotalViews = TotalViews + 1

WHERE Location = 55900

AND Position = 147

| 71185 | job_db | localhost | job_db | Sleep   | 6    |                      | NULL

+-------+--------+-----------+--------+---------+------+----------------------+-----

57 rows in set (0.00 sec)

■Note You must be logged in to MySQL as a user with the SUPER privilege in order to execute the

SHOW FULL PROCESSLIST command.

Running SHOW FULL PROCESSLIST is great for seeing a snapshot of the server at any given

time, but it can be a bit of a pain to repeatedly execute the query from a client. The mytop util-

ity, discussed shortly, takes away this annoyance, as you can set up mytop to reexecute the

SHOW FULL PROCESSLIST command at regular intervals.

The SHOW STATUS Command

Another use of the SHOW command is to output the status and system variables maintained

by MySQL. With the SHOW STATUS command, you can see the statistics that MySQL keeps on

various activities. The status variables are all incrementing counters that track the number of

times certain events occurred in the system. You can use a LIKE expression to limit the results

returned. For instance, if you execute the command shown in Listing 6-16, you see the status

counters for the various query cache statistics.

Listing 6-16. SHOW STATUS Command Example

mysql> SHOW STATUS LIKE 'Qcache%';

+-------------------------+----------+

| Variable_name           | Value    |

+-------------------------+----------+

| Qcache_queries_in_cache | 8725     |

| Qcache_inserts          | 567803   |

| Qcache_hits             | 1507192  |

| Qcache_lowmem_prunes    | 49267    |

| Qcache_not_cached       | 703224   |

| Qcache_free_memory      | 14660152 |

| Qcache_free_blocks      | 5572     |

| Qcache_total_blocks     | 23059    |

+-------------------------+----------+

8 rows in set (0.00 sec)

Monitoring certain status counters is a good way to track specific resource and perform-

ance measurements in real time and while you perform benchmarking. Taking before and

after snapshots of the status counters you’re interested in during benchmarking can show


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

you if MySQL is using particular caches effectively. Throughout the course of this book, as the

topics dictate, we cover most of the status counters and their various meanings, and provide

some insight into how to interpret changes in their values over time.

The EXPLAIN Command

The EXPLAIN command tells you how MySQL intends to execute a particular SQL statement.

When you see a particular SQL query appear to take up a significant amount of resources or

cause frequent locking in your system, EXPLAIN can help you determine if MySQL has been

able to choose an optimal pattern for data access. Let’s take a look at the EXPLAIN results from

the SQL commands in the earlier finduser1.php and finduser2.php scripts (Listings 6-10 and

6-11) we load tested with ApacheBench. First, Listing 6-17 shows the EXPLAIN output from our

LIKE expression in finduser1.php.

Listing 6-17. EXPLAIN for finduser1.php

mysql> EXPLAIN SELECT * FROM test.http_auth WHERE username LIKE 'ud%' \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: http_auth

type: range

possible_keys: PRIMARY

key: PRIMARY

key_len: 25

ref: NULL

rows: 128

Extra: Using where

1 row in set (0.46 sec)

Although this is a simple example, the output from EXPLAIN has a lot of valuable informa-

tion. Each row in the output describes an access strategy for a table or index used in the

SELECT statement. The output contains the following fields:

id: A simple identifier for the SELECT statement. This can be greater than zero if there is a

UNION or subquery.

select_type: Describes the type of SELECT being performed. This can be any of the follow-

ing values:

• SIMPLE: Normal, non-UNION, non-subquery SELECT statement

• PRIMARY: Topmost (outer) SELECT in a UNION statement

• UNION: Second or later SELECT in a UNION statement

• DEPENDENT UNION: Second or later SELECT in a UNION statement that is dependent on

the results of an outer SELECT statement

• UNION RESULT: The result of a UNION


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

• DEPENDENT SUBQUERY: The first SELECT in a SUBQUERY that is dependent on the result

• SUBQUERY: The first SELECT in a subquery

of an outer query

• DERIVED: Subquery in the FROM clause

table: The name of the table used in the access strategy described by the row in the

EXPLAIN result.

type: A description of the access strategy deployed by MySQL to get at the data in the

table or index in this row. The possible values are system, const, eq_ref, ref, ref_or_null,

index_merge, unique_subquery, index_subquery, range, index, and ALL. We go into detail

about all the different access types in the next chapter, so stay tuned for an in-depth

discussion on their values.

possible_keys: Lists the available indexes (or NULL if there are none available) that MySQL

had to choose from in evaluating the access strategy for the table that the row describes.

key: Shows the actual key chosen to perform the data access (or NULL if there wasn’t

one available). Typically, when diagnosing a slow query, this is the first place you’ll look,

because you want to make sure that MySQL is using an appropriate index. Sometimes,

you’ll find that MySQL uses an index you didn’t expect it to use.

key_len: The length, in bytes, of the key chosen. This number is often very useful in diag-

nosing whether a key’s length is hindering a SELECT statement’s performance. Stay tuned

for Chapter 7, which has more on this piece of information.

ref: Shows the columns within the key chosen that will be used to access data in the table,

or a constant, if the join has been optimized away with a single constant value. For

instance, SELECT * FROM x INNER JOIN y ON x.1 = y.1 WHERE x.1 = 5 will be optimized

away so that the constant 5 will be used instead of a comparison of key values in the JOIN

between x and y. You’ll find more on the topic of JOIN optimization in Chapter 7.

rows: Shows the number of rows that MySQL expects to find, based on the statistics it

keeps on the table or index (key) chosen to be used and any preliminary calculations

it has done based on your WHERE clause. This is a calculation MySQL does based on its

knowledge of the distribution of key values in your indexes. The freshness of these statis-

tics is determined by how often an ANALYZE TABLE command is run on the table, and,

internally, how often MySQL updates its index statistics. In Chapter 7, you’ll learn just

how MySQL uses these key distribution statistics in determining which possible JOIN

strategy to deploy for your SELECT statement.

Extra: This column contains extra information pertaining to this particular row’s access

strategy. Again, we’ll go over all the possible things you’ll see in the Extra field in our next

chapter. For now, just think of it as any additional information that MySQL thinks you might

find helpful in understanding how it’s optimizing the SELECT statement you executed.

In the example in Listing 6-17, we see that MySQL has chosen to use the PRIMARY index on the

http_auth table. It just so happens that the PRIMARY index is the only index on the table that con-

tains the username field, so it decides to use this index. In this case, the access pattern is a range

type, which makes sense since we’re looking for usernames that begin with ud (LIKE 'ud%').


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Based on its key distribution statistics, MySQL hints that there will be approximately 128 rows

in the output (which isn’t far off the actual number of 146 rows returned). In the Extra column,

MySQL kindly informs us that it is using the WHERE clause on the index in order to find the rows it

needs.

Now, let’s compare that EXPLAIN output to the EXPLAIN on our second SELECT statement

using the REGEXP construct (from finduser2.php). Listing 6-18 shows the results.

Listing 6-18. EXPLAIN Output from SELECT Statement in finduser2.php

mysql> EXPLAIN SELECT * FROM test.http_auth WHERE username REGEXP '^ud' \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: http_auth

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 90000

Extra: Using where

1 row in set (0.31 sec)

You should immediately notice the stark difference, which should explain the perform-

ance nightmare from the benchmark described earlier in this chapter. The possible_keys

column is NULL, which indicates that MySQL was not able to use an index to find the rows in

http_auth. Therefore, instead of 128 in the rows column, you see 90000. Even though the result

of both SELECT statements is identical, MySQL did not use an index on the second statement.

MySQL simply cannot use an index when the REGEXP construct is used in a WHERE condition.

This example should give you an idea of the power available to you in the EXPLAIN state-

ment. We’ll be using EXPLAIN extensively throughout the next two chapters to show you how

various SQL statements and JOIN constructs can be optimized and to help you identify ways in

which indexes can be most effectively used in your application. EXPLAIN’s output gives you an

insider’s diagnostic view into how MySQL is determining a pathway to execute your SQL code.

The Slow Query Log

MySQL uses the slow query log to record any query whose execution time exceeds the

long_query_time configuration variable. This log can be very helpful when used in conjunc-

tion with the bundled Perl script mysqldumpslow, which simply groups and sorts the logged

queries into a more readable format. Before you can use this utility, however, you must enable

the slow query log in your configuration file. Insert the following lines into /etc/my.cnf (or

some other MySQL configuration file):

log-slow-queries

long_query_time=2

Here, we’ve told MySQL to consider all queries taking two seconds and longer to execute

as a slow query. You can optionally provide a filename for the log-slow-queries argument. By


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

default, the log is stored in /var/log/systemname-slow.log. If you do change the log to a spe-

cific filename, remember that when you execute mysqldumpslow, you’ll need to provide that

filename. Once you’ve made the changes, you should restart mysqld to have the changes take

effect. Then your queries will be logged if they exceed the long_query_time.

■Note Prior to MySQL version 4.1, you should also include the log-long-format configuration option in

your configuration file. This automatically logs any queries that aren’t using any indexes at all, even if the

query time does not exceed long_query_time. Identifying and fixing queries that are not using indexes is

an easy way to increase the throughput and performance of your database system. The slow query log with

this option turned on provides an easy way to find out which tables don’t have any indexes, or any appropri-

ate indexes, built on them. Version 4.1 and after have this option enabled by default. You can turn it off

manually by using the log-short-format option in your configuration file.

Listing 6-19 shows the output of mysqldumpslow on the machine we tested our

ApacheBench scripts against.

Listing 6-19. Output from mysqldumpslow

#> mysqldumpslow

Reading mysql slow query log from /var/log/mysql/slow-queries.log

Count: 1148  Time=5.74s (6585s)  \

Lock=0.00s (1s)  Rows=146.0 (167608), [test]@localhost

SELECT * FROM http_auth WHERE username REGEXP 'S'

Count: 1  Time=3.00s (3s)  \

Lock=0.00s (0s)  Rows=90000.0 (90000), root[root]@localhost

select * from http_auth

As you can see, mysqldumpslow groups the slow queries into buckets, along with some

statistics on each, including an average time to execute, the amount of time the query was

waiting for another query to release a lock, and the number of rows found by the query. We

also did a SELECT * FROM http_auth, which returned 90,000 rows and took three seconds,

subsequently getting logged to the slow query log.

In order to group queries effectively, mysqldumpslow converts any parameters passed to

the queries into either 'S' for string or N for number. This means that in order to actually see the

query parameters passed to the SQL statements, you must look at the log file itself. Alternatively,

you can use the -a option to force mysqldumpslow to not replace the actual parameters with 'S'

and N. Just remember that doing so will force many groupings of similar queries.

The slow query log can be very useful in identifying poorly performing queries, but on a

large production system, the log can get quite large and contain many queries that may have

performed poorly for only that one time. Make sure you don’t jump to conclusions about any

particular query in the log; investigate the circumstances surrounding its inclusion in the log.

Was the server just started, and the query cache empty? Was an import or export process that

caused long table locks running? You can use mysqldumpslow’s various optional arguments,

listed in Table 6-4, to help narrow down and sort your slow query list more effectively.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Table 6-4. mysqldumpslow Command-Line Options

Option

Purpose

-s=[t,at,l,al,r,ar]

Sort the results based on time, total time, lock time, total lock time,

rows, total rows

Reverse sort order (list smallest values first)

Show only the top n queries (based on sort value)

-g=string

Include only queries from the include "string" (grep option)

Include the lock time in the total time numbers

Don’t abstract the parameter values passed to the query into 'S' or N

-r

-t=n

-l

-a

For example, the -g=string option is very useful for finding slow queries run on a

particular table. For instance, to find queries in the log using the REGEXP construct, execute

#> mysqldumpslow -g="REGEXP".

The General Query Log

Another log that can be useful in determining exactly what’s going on inside your system is

the general query log, which records most common interactions with the database, including

connection attempts, database selection (the USE statement), and all queries. If you want to

see a realistic picture of the activity occurring on your database system, this is the log you

should use.

Remember that the binary log records only statements that change the database; it does

not record SELECT statements, which, on some systems, comprise 90% or more of the total

queries run on the database. Just like the slow query log, the general query log must first be

enabled in your configuration file. Use the following line in your /etc/my.cnf file:

log=/var/log/mysql/localhost.general.log

Here, we’ve set up our log file under the /var/log/mysql directory with the name

general.log. You can put the general log anywhere you wish; just ensure that the mysql

user has appropriate write permissions or ownership for the directory or file.

Once you’ve restarted the MySQL server, all queries executed against the database server

will be written to the general query log file.

■Note There is a substantial difference between the way records are written to the general query log

versus the binary log. Commands are recorded in the general query log in the order they are received by

the server. Commands are recorded in the binary log in the order in which they are executed by the server.

This variance exists because of the different purposes of the two logs. While the general query log serves

as an information repository for investigating the activity on the server, the binary log’s primary purpose is

to provide an accurate recovery method for the server. Because of this, the binary log must write records in

execution order so that the recovery process can rely on the database’s state being restored properly.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Let’s examine what the general query log looks like. Listing 6-20 shows an excerpt from

our general query log during our ApacheBench benchmark tests from earlier in this chapter.

Listing 6-20. Excerpt from the General Query Log

# head -n 40 /var/log/mysql/mysqld.log

/usr/local/libexec/mysqld, Version: 4.1.10-log. started with:

Tcp port: 3306  Unix socket: /var/lib/mysql/mysql.sock

Time                 Id Command    Argument

050309 16:56:19       1 Connect     root@localhost on

050309 16:56:36       1 Quit

050309 16:56:52       2 Connect     test@localhost as anonymous on

3 Connect     test@localhost as anonymous on

4 Connect     test@localhost as anonymous on

5 Connect     test@localhost as anonymous on

6 Connect     test@localhost as anonymous on

7 Connect     test@localhost as anonymous on

8 Connect     test@localhost as anonymous on

9 Connect     test@localhost as anonymous on

2 Init DB     test

2 Query      SELECT * FROM http_auth WHERE username LIKE 'ud%'

3 Init DB     test

3 Query      SELECT * FROM http_auth WHERE username LIKE 'ud%'

4 Init DB     test

4 Query      SELECT * FROM http_auth WHERE username LIKE 'ud%'

5 Init DB     test

5 Query      SELECT * FROM http_auth WHERE username LIKE 'ud%'

6 Init DB     test

6 Query      SELECT * FROM http_auth WHERE username LIKE 'ud%'

7 Init DB     test

7 Query      SELECT * FROM http_auth WHERE username LIKE 'ud%'

8 Init DB     test

8 Query      SELECT * FROM http_auth WHERE username LIKE 'ud%'

9 Init DB     test

9 Query      SELECT * FROM http_auth WHERE username LIKE 'ud%'

10 Connect     test@localhost as anonymous on

10 Init DB     test

10 Query      SELECT * FROM http_auth WHERE username LIKE 'ud%'

050309 16:56:53      11 Connect     test@localhost as anonymous on

11 Init DB     test

11 Query      SELECT * FROM http_auth WHERE username LIKE 'ud%'

2 Quit

9 Quit

7 Quit

5 Quit

8 Quit


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Using the head command, we’ve shown the first 40 lines of the general query log. The left-

most column is the date the activity occurred, followed by a timestamp, and then the ID of the

thread within the log. The ID does not correspond to any system or MySQL process ID. The

Command column will display the self-explanatory "Connect", "Init DB", "Query", or "Quit"

value. Finally, the Argument column will display the query itself, the user authentication infor-

mation, or the database being selected.

The general query log can be a very useful tool in taking a look at exactly what’s going on

in your system, especially if you are new to an application or are unsure of which queries are

typically being executed against the system.

Mytop

If you spent some time experimenting with SHOW FULL PROCESSLIST and the SHOW STATUS

commands described earlier, you probably found that you were repeatedly executing the

commands to see changes in the resultsets. For those of you familiar with the Unix/Linux

top utility (and even those who aren’t), Jeremy Zawodny has created a nifty little Perl script

that emulates the top utility for the MySQL environment. The mytop script works just like

the top utility, allowing you to set delays on automatic refreshing of the console, sorting of the

resultset, and so on. Its benefit is that it summarizes the SHOW FULL PROCESSLIST and various

SHOW STATUS statements.

In order to use mytop, you’ll first need to install the Term::ReadKey Perl module from

http://www.cpan.org/modules/by-module/Term/. It’s a standard CPAN installation. Just follow

the instructions after untarring the download. Then head over to http://jeremy.zawodny.com/

mysql/mytop/ and download the latest version. Follow the installation instructions and read

the manual (man mytop) to get an idea of the myriad options and interactive prompts available

to you.

Mytop has three main views:

• Thread view (default, interactive key t) shows the results of SHOW FULL PROCESSLIST.

• Command view (interactive key c) shows accumulated and relative totals of various

commands, or command groups. For instance, SELECT, INSERT, and UPDATE are com-

mands, and various administrative commands sometimes get grouped together, like

the SET command (regardless of which SET is changing). This view can be useful for

getting a breakdown of which types of queries are being executed on your system,

giving you an overall picture.

• Status view (interactive key S) shows various status variables.

The Zend Advanced PHP Debugger Extension

If you’re doing any substantive work in PHP, at some point, you’ll want to examine the inner

workings of your PHP applications. In most database-driven PHP applications, you will want

to profile the application to determine where the bottlenecks are. Without a profiler, diagnos-

ing why a certain PHP page is performing slowly is just guesswork, and that guesswork can

involve long, tedious hours of trial-and-error debugging. How do you know if the bottleneck

in your page stems from a long-running MySQL query or a poorly coded looping structure?

How can you determine if there is a specific function or object call that is consuming the

vast majority of the page’s resources?


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

With the Zend Advanced PHP Debugger (APD) extension, help is at hand. Zend exten-

sions are a little different from normal PHP extensions, in that they interact with the Zend

Engine itself. The Zend Engine is the parsing and execution engine that translates PHP code

into what’s called Zend OpCodes (for operation codes). Zend extensions have the ability to

interact, or hook into, this engine, which parses and executes the PHP code.

■Caution Don’t install APD on a production machine. Install it in a development or testing environment.

The installation requires a source version of PHP (not the binary), which may conflict with some production

concerns.

APD makes it possible to see the actual function call traces for your pages, with informa-

tion on execution time and memory consumption. It can display the call tree, which is the tree

organization of all subroutines executing on the page.

Setting Up APD

Although it takes a little time to set up APD, we think the reward for your efforts is substantial.

The basic installation of APD is not particularly complicated. However, there are a number of

shared libraries that, depending on your version of Linux or another operating system, may

need to be updated. Make sure you have the latest versions of gcc and libtools installed on

the server on which you’ll be installing APD.

If you are running PHP 5, you’ll want to download and install the latest version of APD.

You can do so using PEAR’s install process:

#> pear install apd

For those of you running earlier versions of PHP, or if there is a problem with the installa-

tion process through PEAR, you’ll want to download the tarball designed for your version of

PHP from the PECL repository: http://pecl.php.net/package/apd/.

Before you install the APD extension, however, you need to do a couple of things. First,

you must have installed the source version of PHP (you will need the phpize program in order

to install APD). phpize is available only in source versions of PHP. Second, while you don’t

need to provide any special PHP configuration options during installation (because APD is

a Zend extension, not a loaded normal PHP extension), you do need to ensure that the CGI

version of PHP is available. On most modern systems, this is the default.

After installing an up-to-date source version of PHP, install APD:

#> tar –xzf apd-0.9.1.tgz

#> cd apd-0.9.1

apd-0.9.1 #> phpize

apd-0.9.1 #> ./configure

apd-0.9.1 #> make

apd-0.9.1 #> make install


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

After the installation is completed, you will see a printout of the location of the APD

shared library. Take a quick note of this location. Once APD is installed, you will need to

change the php.ini configuration file, adding the following lines:

zend_extension = /absolute/path/to/apd.so

apd.dumpdir = /absolute/path/to/tracedir

apd.statement_trace = 0

Next, you’ll want to create the trace directory for the APD trace files. On our system, we

created the apd.dumpdir at /var/apddumps, but you can set it up anywhere. You want to create

the directory and allow the public to write to it (because APD will be running in the public

domain):

Finally, restart the Apache server process to have your changes go into effect. On our sys-

#> mkdir /var/apddumps

#> chmod 0766 /var/apddumps

tem, we ran the following:

#> /etc/init.d/httpd restart

Profiling PHP Applications with APD

With APD set up, you’re ready to see how it works. Listing 6-21 shows the script we’ll profile in

this example: finduser3.php, a modification of our earlier script that prints user information

to the screen. We’ve used a variety of PHP functions for the demonstration, including a call to

sleep() for one second every twentieth iteration in the loop.

■Note If this demonstration doesn’t work for you, there is more than likely a conflict between libraries in

your system and APD’s extension library. To determine if you have problems with loading the APD extension,

simply execute #> tail –n 20 /var/log/httpd/error_log and look for errors on the Apache process

startup (your Apache log file may be in a different location). The errors should point you in the right direction

to fix any dependency issues that arise, or point out any typo errors in your php.ini file from your recent

changes.

Listing 6-21. finduser3.php

<?php

apd_set_pprof_trace();

$conn = mysql_connect("localhost","test","") or die (mysql_error());

mysql_select_db("test", $conn) or die ("Can't use database 'test'");

$result = mysql_query("SELECT * FROM http_auth WHERE username REGEXP '^ud'");

if ($result) {

echo '<pre>';

echo "UserName\tPassword\tUID\tGID\n";

$num_rows = mysql_num_rows($result);


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

for ($i=0;$i<$num_rows;++$i) {

mysql_data_seek($result, $i);

if ($i % 20 == 0)

sleep(1);

}

echo '</pre>';

$row = mysql_fetch_row($result);

printf("%s\t%s\t%d\t%d\n", $row[0], $row[1], $row[2], $row[4]);

}

?>

-a

-l

-r

-R

-s

-S

-u

-U

-v

-z

-c

-i

-m

-t

-T

We’ve highlighted the apd_set_pprof_trace() function. This must be called at the top of

the script in order to tell APD to trace the PHP page. The traces are dumped into pprof.XXXXX

files in your apd.dumpdir location, where XXXXX is the process ID of the web page you trace.

When we run the finduser3.php page through a web browser, nothing is displayed, which

tells us the trace completed successfully. However, we can check the apd.dumpdir for files

beginning with pprof. To display the pprof trace file, use the pprofp script available in your

APD source directory (where you installed APD) and pass along one or more of the command-

line options listed in Table 6-5.

Table 6-5. pprofp Command-Line Options

Option

Description

Sort by alphabetic name of function

Sort by number of calls to the function

Sort by real time spent in function

Sort by real time spent in function and all its child functions

Sort by system time spent in function

Sort by system time spent in function and all its child functions

Sort by user time spent in function

Sort by user time spent in function and all its child functions

Sort by average amount of time spent in function (across all requests to function)

Sort by total time spent in function (default)

Display real time elapsed alongside call tree

Suppress reporting for PHP built-in functions

Display file/line number locations in trace

-O [n]

Display n number of functions (default = 15)

Display compressed call tree

Display uncompressed call tree


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

Listing 6-22 shows the output of pprofp when we asked it to sort our traced functions by

the real time that was spent in the function. The trace file on our system, which resulted from

browsing to finduser3.php, just happened to be called /var/apddumps/pprof.15698 on our

system.

Listing 6-22. APD Trace Output Using pprofp

# ./pprofp -r /var/apddumps/pprof.15698

Content-type: text/html

X-Powered-By: PHP/4.3.10

Trace for /var/www/html/finduser3.php

Total Elapsed Time = 8.28

Total System Time  = 0.00

Total User Time    = 0.00

Real         User        System             secs/    cumm

%Time (excl/cumm)  (excl/cumm)  (excl/cumm) Calls   call   s/call  Memory Usage Name

------------------------------------------------------------------------------------

96.7 8.01 8.01 0.00 0.00  0.00 0.00     8  1.0012   1.0012         0 sleep

2.9 0.24 0.24  0.00 0.00  0.00 0.00     1  0.2400   0.2400         0 mysql_query

0.2 0.02 0.02  0.00 0.00  0.00 0.00     1  0.0200   0.0200         0 mysql_connect

0.1 0.01 0.01  0.00 0.00  0.00 0.00   146  0.0001   0.0001         0 mysql_data_seek

0.0 0.00 0.00  0.00 0.00  0.00 0.00   146  0.0000   0.0000         0 printf

0.0 0.00 0.00  0.00 0.00  0.00 0.00   146  0.0000   0.0000         0 mysql_fetch_row

0.0 0.00 0.00  0.00 0.00  0.00 0.00     1  0.0000   0.0000         0 mysql_num_rows

0.0 0.00 0.00  0.00 0.00  0.00 0.00     1  0.0000   0.0000         0 mysql_select_db

0.0 0.00 0.00  0.00 0.00  0.00 0.00     1  0.0000   0.0000         0 main

As you can see, APD supplies some very detailed and valuable information about the

state of the page processing, which functions were used, how often they were called, and how

much of a percentage of total processing time each function consumed. Here, you see that the

sleep() function took the longest time, which makes sense because it causes the page to stop

processing for one second at each call. Other than the sleep() command, only mysql_query(),

mysql_connect(), and mysql_data_seek() had nonzero values.

Although this is a simple example, the power of APD is unquestionable when analyzing

large, complex scripts. Its ability to pinpoint the bottleneck functions in your page requests

relies on the pprofp script’s numerous sorting and output options, which allow you to drill

down into the call tree. Take some time to play around with APD, and be sure to add it to your

toolbox of diagnostic tools.


C H A P T E R   6   ■ B E N C H M A R K I N G  A N D   P R O F I L I N G

■Tip For those of you interested in the internals of PHP, writing extensions, and using the APD profiler,

consider George Schlossnagle’s Advanced PHP Programming (Sams Publishing, 2004). This book provides

extensive coverage of how the Zend Engine works and how to effectively diagnose misbehaving PHP code.

Summary

In this chapter, we stressed the importance of benchmarking and profiling techniques for

the professional developer and administrator. You’ve learned how setting up a benchmarking

framework can enable you to perform comprehensive (or even just quick) performance com-

parisons of your design features and help you to expose general bottlenecks in your MySQL

applications. You’ve seen how profiling tools and techniques can help you avoid the guess-

work of application debugging and diagnostic work.

In our discussion of benchmarking, we focused on general strategies you can use to make

your framework as reliable as possible. The guidelines presented in this chapter and the tools

we covered should give you an excellent base to work through the examples and code pre-

sented in the next few chapters. As we cover various aspects of the MySQL query optimization

and execution process, remember that you can fall back on your established benchmarking

framework in order to test the theories we outline next. The same goes for the concepts and

tools of profiling.

We hope you come away from this chapter with the confidence that you can test your

MySQL applications much more effectively. The profilers and the diagnostic techniques we

covered in this chapter should become your mainstay as a professional developer. Figuring

out performance bottlenecks should no longer be guesswork or a mystery.

In the upcoming chapters, we’re going to dive into the SQL language, covering JOIN and

optimization strategies deployed by MySQL in Chapter 7. We’ll be focusing on real-world

application problems and how to restructure problematic SQL code. In Chapter 8, we’ll take it

to the next step, describing how you can structure your SQL code, database, and index strate-

gies for various performance-critical applications. You’ll be asked to use the information and

tools you learned about here in these next chapters, so keep them handy!


C H A P T E R   7

■ ■ ■

Essential SQL

In this chapter, we’ll focus on SQL code construction. Although this is an advanced book,

we’ve named this chapter “Essential SQL” because we consider your understanding of the

topics we cover here to be fundamental in how professionals approach tasks using the SQL

language.

When you compare the SQL coding of beginning database developers to that of more

experienced coders, you often find the starkest differences in the area of join usage. Experi-

enced SQL developers can often accomplish in a single SQL statement what less experienced

coders require multiple SQL statements to do. This is because experienced SQL programmers

think about solving data problems in a set-based manner, as opposed to a procedural manner.

Even some competent software programmers—writing in a variety of procedural and

object-oriented languages—still have not mastered the art of set-based programming because

it requires a fundamental shift in thinking about the problem domain. Instead of approaching

a problem from the standpoint of arrays and loops, professional SQL developers understand

that this paradigm is inefficient in the world of retrieving data from a SQL store. Using joins

appropriately, these developers reduce the problem domain to a single multitable statement,

which accomplishes the same thing much more efficiently than a procedural approach. In

this chapter, we’ll explore this set-based approach to solving problems. Our discussion will

start with an examination of joins in general, and then, more specifically, which types of joins

MySQL supports. After studying topics related to joins, we’ll move on to a few other related

issues.

In this chapter, we’ll cover the following topics:

• Some general SQL style issues

• MySQL join types

• Access types in EXPLAIN results

• Hints that may be useful for joins

• Subqueries and derived tables

In the next chapter, we’ll focus more on situation-specific topics, such as how to deal with

hierarchical data and how to squeeze every ounce of performance from your queries.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

SQL Style

Before we go into the specifics of coding, let’s take a moment to consider some style issues.

We will first look at the two main categories of SQL styles, and then at some ways to ensure

your code is readable and maintainable.

Theta Style vs. ANSI Style

Most of you will have seen SQL written in a variety of styles, falling into two major categories:

theta style and ANSI style. Theta style is an older, and more obscure, nomenclature that looks

similar to the following, which represents a simple join between two tables (Product and

CustomerOrderItem):

SELECT coi.order_id, p.product_id, p.name, p.description

FROM CustomerOrderItem coi, Product p

WHERE coi.product_id = p.product_id

AND coi.order_id = 84463;

This statement produces identical results to the following ANSI-style join:

SELECT coi.order_id, p.product_id, p.name, p.description

FROM CustomerOrderItem coi

INNER JOIN Product p ON coi.product_id = p.product_id

WHERE coi.order_id = 84463;

For all of the examples in the next two chapters, we will be using the ANSI style. We hope

that you will consider using an ANSI approach to your SQL code for the following main reasons:

• MySQL fully supports ANSI-style SQL. In contrast, MySQL supports only a small subset

of the theta style. Notably, MySQL does not support outer joins with the theta style.

While there is nothing preventing you from using both styles in your SQL code, we

highly discourage this practice. It makes your code less maintainable and harder to

decipher for other developers.

• We feel ANSI style encourages cleaner and more supportable code than theta style.

Instead of using commas and needing to figure out which style of join is involved in

each of the table relationships in your multitable SQL statements, the ANSI style forces

you to be specific about your joins. This not only enhances the readability of your SQL

code, but it also speeds up your own development by enabling you to easily see what

you were attempting to do with the code.

Code Formatting

Make liberal use of indentations, line breaks, and comments in your SQL code. There are few

things more frustrating than needing to decipher a 1KB complex SQL string that is written on

a single line with no comments from the developer on why certain joins, hints, and such were

used. In our opinion, there are no valid reasons for not inserting line breaks and proper inden-

tations in your SQL code. It’s simply bad practice.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Separate related clauses on separate lines, and use indentations to make your code more

readable. Take a look at the following SQL code, imagining it stored in a file or in a script block:

SELECT os.description as "Status", sm.name as "ShippingMethod", COUNT(*) as "Orders"

FROM CustomerOrder o JOIN OrderStatus os ON o.status = os.order_status_id JOIN

ShippingMethod sm ON o.shipping_method = sm.shipping_method_id WHERE o.ordered_on

BETWEEN '2005-04-10' AND '2005-04-23' AND sm.max_order_total < 25.00 GROUP BY

os.description, sm.description ORDER BY "Orders" DESC;

Let’s reproduce this code, but this time with line breaks and indentations:

SELECT

os.description as "Status"

, sm.name as "ShippingMethod"

, COUNT(*) as "NumOrders"

FROM CustomerOrder o

JOIN OrderStatus os

ON o.status = os.order_status_id

JOIN ShippingMethod sm

ON o.shipping_method = sm.shipping_method_id

WHERE o.ordered_on BETWEEN '2005-04-10' AND '2005-04-23'

AND sm.max_order_total < 25.00

GROUP BY os.description, sm.description

ORDER BY "NumOrders" DESC;

Which is easier to decipher at a glance? If you’re wondering why we’ve put each column

on a separate line, it is because this style allows for easy changes over time and easier readability.

You’ll find that as your applications develop, you’ll often receive requests to add another element

to the returned results. Laying out your columns on separate lines allows you to easily add

columns to the SELECT clause. It also enables you to easily add comments to the code.

Specific and Consistent Coding

The INNER keyword is technically optional for inner joins, but we feel including the word INNER

makes your code easier for other developers to more quickly discern what you are trying to do

in the code.

Likewise, when running SQL statements on more than one table, make liberal use of table

aliasing. Not only is this useful for schemas where you have identically named columns, but it

also helps for code readability and maintenance. The earlier examples of theta and ANSI style

show proper usage of aliasing in the SELECT clause.

When working with outer joins (both the LEFT JOIN and RIGHT JOIN types), stick to one or

the other in your code. They serve identical purposes, and either can be rewritten to the other

“side” by switching the order of the related tables in the ON clause. In general, the LEFT JOIN has

become the industry standard, so we suggest avoiding the use of RIGHT JOIN entirely.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

TEAM ENVIRONMENTS

When working in a team environment, it is imperative that your team develop a written coding style standard

and that everyone follow the basic guidelines outlined in your standards document. When developing your

style guide, work with everyone on the team to put together a style that is agreeable to everyone. Normally,

you’ll need to compromise on some things, but working toward that compromise makes it more likely that

the team will actually follow the standard, as opposed to just paying lip service to it. So, take the time and

effort to develop the standards; the payoff is well worth it.

Also important when working with a team of developers is the use of a code repository such as CVS or

Subversion. Remember that just because it’s SQL code doesn’t mean it shouldn’t be assigned the same level

of importance as regular application code!

Additionally, if you are building an application supporting MySQL version 5.0 or higher, we strongly

suggest you consider using stored procedures to organize your SQL code. Stored procedures make the devel-

opment of large and complex applications easier by giving you the ability to put complex SQL scripts into

callable routines. Check out Chapter 9 for an in-depth discussion on this new feature.

MySQL Joins

For our discussion on joins, we’ll use a sample schema that includes some tables in our fictional

toy store e-commerce application, which we’ve used in the examples in previous chapters.

Figure 7-1 shows the E-R diagram for all the tables.

In Figure 7-1, we’ve indicated primary keys using bold print, and foreign key relationships

using italics. If you’re unsure about how to read the diagram, refer to Chapter 1, where E-R dia-

gramming is explained. Take some time to review the diagram, and understand the business

rules implied through it. For instance, looking at the relationship between Product, Category,

and Product2Category, you might say that an existing business rule denotes “A Product must

belong to one or more Category elements. Likewise, a Category can contain one or more

Product elements. Additionally, a Category may have a single parent Category, thus making

it a child of that Category.”

The following are some items to note about our sample schema:

• We haven’t shown the data types for columns because we’re focusing on the relation-

ships between the entities, not necessarily their makeup. When necessary, we’ll talk

about specific data type concerns in your SQL code.

• Assume all fields are NOT NULL unless noted.

• For the table representing a many-to-many relationship, we’ve used the number 2

between the related tables to indicate this more fully: Product2Category.

• This schema is clearly not intended to represent an optimal or full e-commerce database

application. For brevity, we’ve omitted a number of columns, tables, and relationships

that would be present in a real-world schema. The table structures shown are designed

for our examples, nothing more.

• For our CustomerOrderItem table, which represents the products contained in the cus-

tomer’s order, we’ve created redundant price and weight columns. We’ve done this for the


C H A P T E R   7   ■ E S S E N T I A L   S Q L

purpose of some examples, and to demonstrate that this table stores a historical view of

the price and weight of the products when the order was made. If this were not done,

price changes in the main product record would be reflected in past order details, where a

different purchase price may have been used. In a real-world schema, you would use this

technique for the customer’s address information as well, which may change over the

course of time. You might store the shipping address in the CustomerOrder table to repre-

sent the actual address used in the shipment.

• The ShippingMethod table has four fields—min_order_weight, max_order_weight, min_

order_total, and max_order_total—which may seem odd. These fields represent criteria

that will be used to identify which shipping method can be used for a CustomerOrder. We’ll

take a closer look at these fields in our later examples covering range queries.

Category

category_id

parent_id NULL

name

description

left_side

right_side

OrderStatus

order_status_id

description

ShippingMethod

shipping_method_id

name

cost

min_order_weight

max_order_weight

min_order_total

max_order_total

Product

product_id

sku

name

description

weight

unit_price

order_id

product_id

price

weight

quality

CustomerOrderItem

Figure 7-1. Sample schema

Product2Category

product_id

category_id

CustomerOrder

order_id

customer_id

status

shipping_method

ordered_on

shipping_price

Customer

customer_id

login

password

created_on

first_name

last_name

billing_address

billing_city

billing_province

billing_postcode

billing_country

shipping_address

shipping_city

shipping_province

shipping_postcode

shipping_county


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Listing 7-1 contains the create script for the sample schema.

Listing 7-1. Create Script for the Sample Schema

CREATE TABLE Product (

product_id  INT NOT NULL AUTO_INCREMENT

, sku   VARCHAR(35) NOT NULL

, name  VARCHAR(150) NOT NULL

, description TEXT NOT NULL

, weight DECIMAL(7,2) NOT NULL

, unit_price DECIMAL(9,2) NOT NULL

, PRIMARY KEY (product_id)

);

);

);

CREATE TABLE Category (

category_id INT NOT NULL AUTO_INCREMENT

, parent_id INT NULL

, name VARCHAR(100) NOT NULL

, description TEXT

, left_side INT NOT NULL

, right_side INT NOT NULL

, PRIMARY KEY (category_id)

, INDEX (parent_id)

CREATE TABLE Product2Category (

product_id INT NOT NULL

, category_id INT NOT NULL

, PRIMARY KEY (product_id, category_id)

CREATE TABLE Customer (

customer_id INT NOT NULL AUTO_INCREMENT

, login VARCHAR(32) NOT NULL

, password VARCHAR(32) NOT NULL

, created_on DATE NOT NULL

, first_name VARCHAR(30) NOT NULL

, last_name VARCHAR(30) NOT NULL

, billing_address VARCHAR(100) NOT NULL

, billing_city VARCHAR(35) NOT NULL

, billing_province CHAR(2) NOT NULL

, billing_postcode VARCHAR(8) NOT NULL

, billing_country CHAR(2) NOT NULL

, shipping_address VARCHAR(100) NOT NULL

, shipping_city VARCHAR(35) NOT NULL

, shipping_province CHAR(2) NOT NULL


C H A P T E R   7   ■ E S S E N T I A L   S Q L

, shipping_postcode VARCHAR(8) NOT NULL

, shipping_country CHAR(2) NOT NULL

, PRIMARY KEY (customer_id)

, INDEX (login, password)

CREATE TABLE OrderStatus (

order_status_id CHAR(1) NOT NULL

, description VARCHAR(150) NOT NULL

, PRIMARY KEY (order_status_id)

CREATE TABLE ShippingMethod (

shipping_method_id INT NOT NULL AUTO_INCREMENT

, name VARCHAR(100) NOT NULL

, cost DECIMAL(5,2) NOT NULL

, min_order_weight DECIMAL(9,2) NOT NULL

, max_order_weight DECIMAL(9,2) NOT NULL

, min_order_total DECIMAL(9,2) NOT NULL

, max_order_total DECIMAL(9,2) NOT NULL

, PRIMARY KEY (shipping_method_id)

CREATE TABLE CustomerOrder (

order_id INT NOT NULL AUTO_INCREMENT

, customer_id INT NOT NULL

, status CHAR(2) NOT NULL

, shipping_method INT NOT NULL

, ordered_on DATE NOT NULL

, shipping_price DECIMAL(5,2) NOT NULL

, PRIMARY KEY (order_id)

, INDEX (customer_id)

CREATE TABLE CustomerOrderItem (

order_id INT NOT NULL

, product_id INT NOT NULL

, price DECIMAL(9,2) NOT NULL

, weight DECIMAL(7,2) NOT NULL

, quantity INT NOT NULL

, PRIMARY KEY (order_id, product_id)

);

);

);

);

);


C H A P T E R   7   ■ E S S E N T I A L   S Q L

We’ve populated our sample schema with some data using the code found in the

/ch07/insert.sql file available from the Downloads section of the Apress web site

(http://www.apress.com). Admittedly, our sample data is less than original.

Joins are the “glue” that allow you to connect two or more sets of data through one or

more key values, thus enabling relationships to be constructed in your SELECT statements.

MySQL supports a variety of standard and not-so-standard join types:

• Inner join

• Outer join

• Cross join

• Union join

Here, we will discuss each type, as well as natural joins and the USING keyword. Although

this information may be review for some readers, we encourage you to read the material, even

if it serves solely as a simple reminder of the fundamentals.

The Inner Join

The most basic and common join type is the inner join. You use this type of join when you

want to relate two sets of data where values in the ON clause columns match in both tables.

The columns are most often, but not always, key columns representing a primary key and

foreign key relationship. For instance, consider the following English language request:

“I need to know the name and SKU for each product purchased by John Doe on December 7,

2004, along with the price and weight of the product at the time he purchased it.”

Based on our E-R diagram, we know that in order to get all the column data in the

request—product’s name, SKU, price, and weight at the time of the order—we’ll need to

query a number of different tables, if the only thing we can use to filter the data is the

order date (CustomerOrder.ordered_on) and John Doe’s name (Customer.first_name

and Customer.last_name). The sets of data we’ll need to deal with involve the Customer,

CustomerOrder, CustomerOrderItem, and Product tables. We want to know where these

sets of data intersect, thus we’ll need to use inner joins. Specifically, we’ll need to find the

intersection of the following sets of data:

• Product (to know the name and SKU of the product); alias: p

• CustomerOrderItem (to relate the order and to get the weight and price); alias: coi

• CustomerOrder (to relate the customer and filter based on the order date); alias: co

• Customer (to filter for John Doe); alias: c

Although this is a fairly simple example, breaking down English-language1 requests into a

list of the sets of data needed or used by the request can be an extremely helpful practice. It

encourages you to think in terms of the sets of data being operated on, and serves as an exer-

cise in breaking down complex requests into smaller, simpler pieces. As you work on more

1. We say “English-language request” here to indicate that the request is coming from a nontechnical

and non-SQL point of view. Clearly, any human language could be substituted.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

advanced SQL statements—using derived tables, UNION constructs, and the like—you’ll find

that deconstructing the request in this manner can isolate problem areas in data-access pat-

terns and help in identifying where indexes may provide key performance benefits.

Building complex SQL statements usually follows a fairly straightforward process. First,

include the SELECT clause with the columns you wish to include in your result output, using an

alias for the set of data from which the column is being obtained:

SELECT p.name, p.sku, coi.price, coi.weight

Next, retrieve the data set you believe will have the least number of rows in it. In this case,

since we expect to find a single Customer record for John Doe, we start our FROM clause with

that set of data:

FROM Customer c

Now, in order to intersect each of our data sets, we do an INNER JOIN on the key relation-

ships from one data set to the next, until we’ve “chained” them all together along their key

relationships:

Finally, we add our WHERE clause to filter the appropriate values from our Customer and

CustomerOrder sets based on the criteria in our request:

Listing 7-2 shows the final SQL built from these data sets, along with the result.

INNER JOIN CustomerOrder co

ON c.customer_id = co.customer_id

INNER JOIN CustomerOrderItem coi

ON co.order_id = coi.order_id

INNER JOIN Product p

ON coi.product_id = p.product_id

WHERE c.last_name = 'Doe'

AND c.first_name = 'John'

AND co.ordered_on = '2004-12-07';

Listing 7-2. Example of a Multiple Inner Join

mysql> SELECT p.name, p.sku, coi.price, coi.weight

-> FROM Customer c

->  INNER JOIN CustomerOrder co

->    ON c.customer_id = co.customer_id

->  INNER JOIN CustomerOrderItem coi

->    ON co.order_id = coi.order_id

->  INNER JOIN Product p

->    ON coi.product_id = p.product_id

-> WHERE c.last_name = 'Doe'

-> AND c.first_name = 'John'

-> AND co.ordered_on = '2004-12-07';


C H A P T E R   7   ■ E S S E N T I A L   S Q L

+-------------+--------+-------+--------+

| name        | sku    | price | weight |

+-------------+--------+-------+--------+

| Soccer Ball | SPT001 | 23.70 |   1.25 |

+-------------+--------+-------+--------+

1 row in set (0.00 sec)

This technique, which we’ll call top-down SQL, is just one method of building complex

SQL statements. Throughout this chapter, we’ll take a look at other techniques you can use to

generate complex SQL statements for other types of joins.

The Outer Join

While an inner join returns only rows where a key value in data set A appears as a key in data

set B, an outer join is used in situations when you want to return all the elements of data set A,

regardless of whether the key value exists in data set B. An outer join is designated in MySQL

using the LEFT JOIN syntax, with the ON clause specifying the key values on which MySQL

should perform the join relationship. As we noted earlier in this chapter, the RIGHT JOIN is

identical to the LEFT JOIN, but includes all elements from the data set on the right side of the

ON condition.

In an outer join, rows in data set B with matching key values to data set A will be returned

just as an inner join; however, columns for data set B will be filled with NULL for those rows in

data set A where no matching key was found in data set B.

Outer joins can or must be used in a number of situations. Here, we’ll go over a few exam-

ples to illustrate outer joins:

• Aggregating data where not all keys are present

• Handling valid NULL column keys

• Finding nonexisting keys in relationships

Aggregating Data Where Not All Keys Are Present

Many times, you’ll run into situations where you need to aggregate data (using the GROUP BY

clause), but find your SQL results are missing records that you know are in the database. The

most common cause of this is the incorrect use of an INNER JOIN in the aggregating SQL.

For instance, let’s take the following request, received from our friends in the sales depart-

ment: “Please provide a report showing how many orders contained each product in our catalog,

and how many items of each were purchased.” Your first attempt might look like Listing 7-3.

Listing 7-3. First Report Attempt with an Inner Join

mysql> SELECT p.name, COUNT(*) as "# Orders", SUM(coi.quantity)"Total Qty"

-> FROM Product p

->   INNER JOIN CustomerOrderItem coi

->     ON p.product_id = coi.product_id

-> GROUP BY p.name;


C H A P T E R   7   ■ E S S E N T I A L   S Q L

+---------------------------+----------+-----------+

| name                      | # Orders | Total Qty |

+---------------------------+----------+-----------+

| Action Figure - Football  |        1 |         1 |

| Action Figure - Gladiator |        1 |         1 |

| Action Figure - Tennis    |        1 |         1 |

| Doll                      |        1 |         2 |

| Soccer Ball               |        1 |         1 |

| Tennis Balls              |        3 |        57 |

| Tennis Racket             |        1 |         1 |

| Video Game - Football     |        1 |         1 |

+---------------------------+----------+-----------+

8 rows in set (0.00 sec)

This looks about right, but then you notice that the list does not include all the products

in the product catalog. The problem is that you’ve used an intersection of the data sets—an

INNER JOIN—meaning that only the products that had been purchased by a customer were

included in the final result. Instead, what you need is all the products in the catalog, along

with a count and total quantity for each. So, you need to rewrite the query using an outer join.

Listing 7-4 shows the rewritten query and its results.

Listing 7-4. Second Report Attempt with an Outer Join

mysql> SELECT p.name, COUNT(*) as "# Orders", SUM(coi.quantity)"Total Qty"

-> FROM Product p

->   LEFT JOIN CustomerOrderItem coi

->     ON p.product_id = coi.product_id

-> GROUP BY p.name;

+---------------------------+----------+-----------+

| name                      | # Orders | Total Qty |

+---------------------------+----------+-----------+

| Action Figure - Football  |        1 |         1 |

| Action Figure - Gladiator |        1 |         1 |

| Action Figure - Tennis    |        1 |         1 |

| Doll                      |        1 |         2 |

| Soccer Ball               |        1 |         1 |

| Tennis Balls              |        3 |        57 |

| Tennis Racket             |        1 |         1 |

| Video Game - Car Racing   |        1 |      NULL |

| Video Game - Football     |        1 |         1 |

| Video Game - Soccer       |        1 |      NULL |

+---------------------------+----------+-----------+

10 rows in set (0.00 sec)

You’re getting closer. Now, you have all ten products in the catalog, as well as some data

returned in the rows for the two products no customer has yet purchased. You’ll notice two

interesting things.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

First, the Total Qty field—SUM(coi.quantity)—has NULL values for the two unmatched

rows in the product data set. This is the behavior of an outer join; columns from unmatched

rows of the second data set are filled with NULL values. The SUM() SQL function treats NULL val-

ues as unknown, therefore summing unknown values always results in unknown, or NULL. This

is a critical point to remember when doing aggregating reports. If you know that NULL values

may be returned from a statement, use the IFNULL() function to “zero out” any NULL values if

appropriate. You’ll see this strategy in practice in Listing 7-5.

Second, given the behavior of SUM(), you would assume that the COUNT() function would

also return NULL since there were no matching rows. This is not necessarily the case, and is the

cause of numerous reporting errors. The COUNT() function works as follows with NULL values:

• COUNT(*): Simply returns the number of rows in the resultset matching the GROUP BY

• COUNT(table.column): Returns the number of rows having non-NULL values found in

columns.

table.

Notice the difference in the aggregated data values in our corrected Listing 7-5.

Listing 7-5. Corrected Output Using COUNT(table.column) and IFNULL()

mysql> SELECT

->   p.name

->   , COUNT(coi.order_id) as "# Orders"

->   , SUM(IFNULL(coi.quantity,0)) as "Total Qty"

-> FROM Product p

->   LEFT JOIN CustomerOrderItem coi

->     ON p.product_id = coi.product_id

-> GROUP BY p.name;

+---------------------------+----------+-----------+

| name                      | # Orders | Total Qty |

+---------------------------+----------+-----------+

| Action Figure - Football  |        1 |         1 |

| Action Figure - Gladiator |        1 |         1 |

| Action Figure - Tennis    |        1 |         1 |

| Doll                      |        1 |         2 |

| Soccer Ball               |        1 |         1 |

| Tennis Balls              |        3 |        57 |

| Tennis Racket             |        1 |         1 |

| Video Game - Car Racing   |        0 |         0 |

| Video Game - Football     |        1 |         1 |

| Video Game - Soccer       |        0 |         0 |

+---------------------------+----------+-----------+

10 rows in set (0.01 sec)


C H A P T E R   7   ■ E S S E N T I A L   S Q L

This demonstration should serve to highlight the importance of always verifying that the

results you get are indeed accurate and reflect the original request.

Handling Valid NULL Column Keys

In certain rare situations, it is necessary to have a foreign key column that contains NULL

values, such as in hierarchical data sets. Luckily, we have just such a structure in our sample

schema, all contained in the Category table. The Category.parent_id column contains either

a NULL value when the row contains a “root” category (one with no parent) or the parent cate-

gory’s category_id value. Imagine the following request: “List all categories along with the

name of their parent category.”

Once again, an inner join fails to fulfill this request, because it cannot account for NULL

values in the matching condition. Listing 7-6 shows a listing of all the categories and then an

attempted inner join to get the parent category names. You should immediately notice the

dilemma (observe the number of rows returned).

Listing 7-6. Inner Join Fails to Get All Categories

mysql> SELECT name, category_id, parent_id FROM Category;

+---------------------------+-------------+-----------+

| name                      | category_id | parent_id |

+---------------------------+-------------+-----------+

| All                       |           1 |      NULL |

| Action Figures            |           2 |         1 |

| Sport Action Figures      |           3 |         2 |

| Tennis Action Figures     |           4 |         3 |

| Football Action Figures   |           5 |         3 |

| Historical Action Figures |           6 |         2 |

| Video Games               |           7 |         1 |

| Racing Video Games        |           8 |         7 |

| Sports Video Games        |           9 |         7 |

| Shooting Video Games      |          10 |         7 |

| Sports Gear               |          11 |         1 |

| Soccer Equipment          |          12 |        11 |

| Tennis Equipment          |          13 |        11 |

| Dolls                     |          14 |         1 |

+---------------------------+-------------+-----------+

14 rows in set (0.05 sec)

mysql> SELECT c.name, pc.name AS "parent"

-> FROM Category c

->   INNER JOIN Category pc

->   ON c.parent_id = pc.category_id;


C H A P T E R   7   ■ E S S E N T I A L   S Q L

+---------------------------+----------------------+

| name                      | parent               |

+---------------------------+----------------------+

| Action Figures            | All                  |

| Sport Action Figures      | Action Figures       |

| Tennis Action Figures     | Sport Action Figures |

| Football Action Figures   | Sport Action Figures |

| Historical Action Figures | Action Figures       |

| Video Games               | All                  |

| Racing Video Games        | Video Games          |

| Sports Video Games        | Video Games          |

| Shooting Video Games      | Video Games          |

| Sports Gear               | All                  |

| Soccer Equipment          | Sports Gear          |

| Tennis Equipment          | Sports Gear          |

| Dolls                     | All                  |

+---------------------------+----------------------+

13 rows in set (0.03 sec)

Notice that the root category that serves as the parent for the topmost parent categories

is not included in the lower resultset. This is because the NULL parent_id column value for the

root category—the one without a parent category—finds no matching value in the inner join

from the Category table to itself, known as a self join. In order to show all the categories, we

need to employ an outer join to get all the categories in the first data set, and then we’ll use the

IFNULL() function to indicate that categories without a parent are root categories. Listing 7-7

shows the updated version.

Listing 7-7. Updated Category Listing

mysql> SELECT

->   c.name

->   , IFNULL(pc.name, "Root Category") as "parent"

-> FROM Category c

->   LEFT JOIN Category pc

->     ON c.parent_id = pc.category_id;

+---------------------------+----------------------+

| name                      | parent               |

+---------------------------+----------------------+

| All                       | Root Category        |

| Action Figures            | All                  |

| Sport Action Figures      | Action Figures       |

| Tennis Action Figures     | Sport Action Figures |

| Football Action Figures   | Sport Action Figures |

| Historical Action Figures | Action Figures       |

| Video Games               | All                  |

| Racing Video Games        | Video Games          |

| Sports Video Games        | Video Games          |

| Shooting Video Games      | Video Games          |


C H A P T E R   7   ■ E S S E N T I A L   S Q L

| Sports Gear               | All                  |

| Soccer Equipment          | Sports Gear          |

| Tennis Equipment          | Sports Gear          |

| Dolls                     | All                  |

+---------------------------+----------------------+

14 rows in set (0.05 sec)

As you can see, now all the categories are included. However, one question still remains:

What if there are more than two levels to this category tree? Currently, our category tree has

only two levels: one root level and one subcategory level for some root-level categories. What

if a subcategory had one or more child categories? We will consider this situation in the next

chapter, where we will discuss how to deal with hierarchical data using the nested set model.

Finding Nonexisting Keys in Relationships

In some cases, you’ll want to find the records in one data set that don’t appear in a foreign key

relationship. You can accomplish this task in a number of ways, but the most efficient method

is to use an outer join. Consider the following request, again received from our illustrious sales

department: “We’d like a list of all of the customers in our database who have signed up at our

online store, but who have not ordered anything from our catalog.”

This kind of request typifies a situation where beginner developers often get into trouble

and overcomplicate things. Novices will often approach this problem using a procedural

method: get a list of all customer ID values, loop through the list of customer IDs, and for each

one, check if the customer ID value is in the CustomerOrder table; if not, add the ID to a list of

values to return. This kind of approach might result in something like the PHP code shown in

Listing 7-8.

Listing 7-8. Inefficient PHP Code to Find Customers Without Orders

<?php

$conn = mysql_connect("localhost","test","") or die (mysql_error());

mysql_select_db("ToyStore", $conn) or die ("Can't use database 'ToyStore'");

$customers = mysql_query("SELECT customer_id, first_name, last_name

$customers_without_orders = array();

if ($customers) {

FROM Customer");

while ($customer = mysql_fetch_row($customers)) {

$orders = mysql_query("SELECT COUNT(*) FROM

CustomerOrder WHERE customer_id = " . $customer[0]);

$order = mysql_fetch_row($orders);

$has_orders = $order[0];

if ($has_orders) {

array_push($customers_without_orders, $customer);

}

}

}

?>


C H A P T E R   7   ■ E S S E N T I A L   S Q L

This kind of code exemplifies the procedural mindset, which goes against the grain of

proper set-based SQL coding. All of the code in Listing 7-8 could be reduced to the outer join

statement shown in Listing 7-9 (along with the result of the query).

Listing 7-9. Proper Set-Based Approach Using an Outer Join

mysql> SELECT

->   c.customer_id

->   , c.first_name

->   , c.last_name

-> FROM Customer c

->   LEFT JOIN CustomerOrder co

->     ON c.customer_id = co.customer_id

-> WHERE co.customer_id IS NULL;

+-------------+------------+-----------+

| customer_id | first_name | last_name |

+-------------+------------+-----------+

|           4 | Homer      | Simpson   |

+-------------+------------+-----------+

1 row in set (0.06 sec)

The key to the statement in Listing 7-9 is the WHERE co.customer_id IS NULL clause, which

tells MySQL to find the rows in the outer-joined result that have no matching foreign key.

Understanding the ON Clause in Outer Joins

Let’s test your understanding of outer joins so far. In English, what does Listing 7-10 accomplish?

Listing 7-10. Another Example of an Outer Join

mysql> SELECT os.description, COUNT(co.order_id) AS "NumOrders"

-> FROM OrderStatus os

->   LEFT JOIN CustomerOrder co

->     ON os.order_status_id = co.status

-> GROUP BY os.description;

If you answered something like, “It will show all order statuses, along with a count for the

number of orders in each status, or zero if no orders are in that status,” you would be correct,

as Listing 7-11 indicates.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Listing 7-11. Result of Query in Listing 7-10

+-------------+-----------+

| description | NumOrders |

+-------------+-----------+

| Cancelled   |         1 |

| Closed      |         0 |

| Completed   |         2 |

| In Progress |         1 |

| Shipped     |         2 |

+-------------+-----------+

5 rows in set (0.00 sec)

If you got that correct, pat yourself on the back. Now answer the following. Given your

knowledge of outer joins thus far, how many rows would you expect the adaptation of the first

statement shown in Listing 7-12 to produce?

Listing 7-12. Slight Adaptation of the Query in Listing 7-10

mysql> SELECT os.description, COUNT(co.order_id) AS "NumOrders"

-> FROM OrderStatus os

->   LEFT JOIN CustomerOrder co

->     ON os.order_status_id = co.status

-> WHERE co.ordered_on = '2004-12-07'

-> GROUP BY os.description;

As you can see, we’ve added a WHERE clause on the CustomerOrder.ordered_on column.

Most readers will arrive at the conclusion that the results of the SQL in Listing 7-12 should still

have five rows in it, because the LEFT JOIN should include all the OrderStatus rows, along with a

count of the orders in each status placed on December 7, 2004. If you arrived at this conclusion,

you would, unfortunately, be mistaken, but don’t be discouraged. The behavior demonstrated

in this example is one of the most common mistakes involving outer joins. The actual result

returned is shown in Listing 7-13.

Listing 7-13. Result from SQL in Listing 7-12

+-------------+-----------+

| description | NumOrders |

+-------------+-----------+

| Completed   |         1 |

+-------------+-----------+

1 row in set (0.00 sec)


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Now, why does the resultset contain only a single row if the outer join is supposed to

include all the rows in the OrderStatus table? The reason stems from the fact that conditions

present in the WHERE clause of a SQL statement filter the resultset produced by the outer join. In

this case, the resultset produced by the outer join can be viewed as all the CustomerOrder rows,

along with a status description matching the status key and NULLed out rows for any statuses

with no matching orders.

When the WHERE condition is executed (after the rows from OrderStatus are LEFT JOINed

with the CustomerOrder table), MySQL filters out all rows in the resulting set that do not have

an ordered_on date of December 7, 2004. Since the WHERE filter was executed after the two

tables were joined, any rows without an ordered_on date equal to '2004-12-07' were removed

from the returned resultset. This eliminated any of the NULLed out rows for statuses having no

matching orders, since NULL ≠ '2004-12-07'.

So, the question remains, how do we fulfill a request like this: “Show all order statuses,

and the number of orders in each status, for orders placed on December 7, 2004.”

The SQL in Listing 7-12 indeed filters the date properly, but, unfortunately, it also filters

out all the nonmatching order statuses from the outer join. To remedy the situation, we must

use the ON clause to limit the compared data set of the right side of the outer join before the

outer join occurs. Listing 7-14 shows the correct SQL to fulfill the request.

Listing 7-14. Corrected SQL Demonstrating the Outer Join ON Clause Filter

mysql> SELECT os.description, COUNT(co.order_id) AS "NumOrders"

-> FROM OrderStatus os

->   LEFT JOIN CustomerOrder co

->     ON os.order_status_id = co.status

->     AND co.ordered_on = '2004-12-07'

-> GROUP BY os.description;

+-------------+-----------+

| description | NumOrders |

+-------------+-----------+

| Cancelled   |         0 |

| Closed      |         0 |

| Completed   |         1 |

| In Progress |         0 |

| Shipped     |         0 |

+-------------+-----------+

5 rows in set (0.00 sec)

If you are doing any sort of reporting work in MySQL, understanding this critical differ-

ence between seemingly similar SQL statements can help you avoid some very frustrating SQL

debugging work. Make sure you understand when to use a filter in the ON clause of an outer

join and when to use a WHERE clause filter.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

■Tip Remember that the WHERE clause will filter the results after the outer join is processed, whereas the

ON condition of the outer join will filter the second data set in the outer join before the join is processed.

The Cross Join (Cartesian Product)

A cross join, sometimes called a Cartesian product, unlike the other types of joins we’ve cov-

ered so far, does not attempt to relate the two sets of data based on some key values. Instead,

it creates a result based on all possible row combinations in both sets of joined data. Thus, the

number of rows returned from a cross join is N ✕ M, where N is the number of rows in data set

A and M is the number of rows in data set B. Clearly, the number of rows in a cross join can

quickly get out of hand!

Most often, cross joins are done by mistake because the developer forgets to include an

ON condition, which will force MySQL to use a cross join across the two data sets by default.

However, in some rare circumstances, the cross join can come in handy.

For example, let’s say we’ve received a request from our product development depart-

ment: “We wish to see a breakdown of our products at various pricing levels so that we can

compare our prices against a study of market-average prices for similar products. Please show

each of our products, along with the current price, and varying price levels, in 5% changes, dif-

fering 25% from the existing level.” To handle this request, we might create a temporary table

for storing the percentage differences in price, as shown in Listing 7-15.

Listing 7-15. Temporary Storage for Percentage Differences

mysql> CREATE TABLE Percentages (percent_difference DECIMAL(5,2) NOT NULL);

Query OK, 0 rows affected (0.94 sec)

mysql> INSERT INTO Percentages VALUES (-.25), (-.20), (-.15), (-.10), (-.05), (.00)

> , (.05), (.10), (.15), (.20), (.25);

Query OK, 11 rows affected (0.14 sec)

Records: 11  Duplicates: 0  Warnings: 0

Using a cross join, we can show the product prices at these various pricing levels, as

shown in Listing 7-16 (for brevity, we’ve filtered for a single product only).

Listing 7-16. Example of a Cross Join

mysql>  SELECT

->   p.name as "Product"

->  , CONCAT((pct.percent_difference * 100), '%') as "% Difference"

->  , ROUND((pct.percent_difference + 1) * p.unit_price, 2) as "Price"

->  FROM Product p

->   CROSS JOIN Percentages pct

->  WHERE p.product_id = 2

-> ORDER BY pct.percent_difference;


C H A P T E R   7   ■ E S S E N T I A L   S Q L

+--------------------------+--------------+-------+

| Product                  | % Difference | Price |

+--------------------------+--------------+-------+

| Action Figure - Football | -25.00%      |  8.96 |

| Action Figure - Football | -20.00%      |  9.56 |

| Action Figure - Football | -15.00%      | 10.16 |

| Action Figure - Football | -10.00%      | 10.76 |

| Action Figure - Football | -5.00%       | 11.35 |

| Action Figure - Football | 0.00%        | 11.95 |

| Action Figure - Football | 5.00%        | 12.55 |

| Action Figure - Football | 10.00%       | 13.15 |

| Action Figure - Football | 15.00%       | 13.74 |

| Action Figure - Football | 20.00%       | 14.34 |

| Action Figure - Football | 25.00%       | 14.94 |

+--------------------------+--------------+-------+

11 rows in set (0.00 sec)

We’ve highlighted the CROSS JOIN and WHERE clauses. Notice that there is no ON clause

attached to the cross join. This is because there is no relation between the two data sets. In

this case, the WHERE clause filters the first data set (Product) to a single row (product_id = 2).

The second data set is all rows from the Percentages table.

While you won’t find too many uses for cross joins in your code, they can occasionally be

useful in this type of analysis, where you want to cross a static (fixed number of rows) table

with another table.

The Union Join

MySQL version 4.0 and higher supports the UNION join type. If you use a lot of complex OR

statements in your application code, and you are using a version of MySQL prior to 5.0, our

advice is to get familiar with UNIONs. We’ll explain why in the next chapter, where we show you

how to optimize complex OR clauses in your WHERE condition using UNION joins.

The basic point of a UNION query is to combine the results of two different, but structurally

similar, data sets. By default, MySQL forces the row uniqueness of the eventual returned

result. This may sounds strange, so we’ll show you by example.

For this example, let’s assume that we have archived our 2004 store data into a set of iden-

tically named tables, appended with the number 2004. We’ve just received this request: “We

need a report showing the orders received in December 2004 and January 2005 only. Provide

the total quantity purchased for any product purchased in those time frames.”

To accomplish this task, we will need to produce one resultset from two similar sets of

tables: one from the 2004 data tables and one from the current tables. Let’s first start with the

current data, and obtain our first data set, shown in Listing 7-17.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Listing 7-17. Current Year’s Data Set

mysql> SELECT

->   p.name as "Product"

->   , "2005 - January" as "Date"

->   , SUM(coi.quantity) as "Total Purchased"

-> FROM CustomerOrder co

->   INNER JOIN CustomerOrderItem coi

->     ON co.order_id = coi.order_id

->   INNER JOIN Product p

->     ON coi.product_id = p.product_id

-> WHERE co.ordered_on BETWEEN '2005-01-01' AND '2005-01-31'

-> GROUP BY p.name;

+---------------------------+----------------+-----------------+

| Product                   | Date           | Total Purchased |

+---------------------------+----------------+-----------------+

| Action Figure - Football  | 2005 - January |               1 |

| Action Figure - Gladiator | 2005 - January |               1 |

| Doll                      | 2005 - January |               2 |

| Tennis Balls              | 2005 - January |              42 |

| Tennis Racket             | 2005 - January |               1 |

| Video Game - Football     | 2005 - January |               1 |

+---------------------------+----------------+-----------------+

6 rows in set (0.00 sec)

Listing 7-18. Creating 2004 Summary Data and Selecting December’s Data

mysql> CREATE TABLE CustomerOrder2004

-> SELECT * FROM CustomerOrder

-> WHERE ordered_on BETWEEN '2004-01-01' AND '2004-12-31';

Query OK, 2 rows affected (0.62 sec)

Records: 2  Duplicates: 0  Warnings: 0

mysql> CREATE TABLE CustomerOrderItem2004

-> SELECT coi.*

-> FROM CustomerOrder co

->  INNER JOIN CustomerOrderItem coi

->   ON co.order_id = coi.order_id

-> WHERE co.ordered_on BETWEEN '2004-01-01' AND '2004-12-31';

Query OK, 3 rows affected (0.00 sec)

Records: 3  Duplicates: 0  Warnings: 0

Notice we include the static column Date, set to the value of "2005 - January". We do this

so that the rows of our next resultset (from 2004) will be distinguishable from the current data

rows. Next, let’s put together our 2004 data in a similar fashion, as shown in Listing 7-18. We’ve

included CREATE TABLE statements for you to create the 2004 archive tables.


Once we’re satisfied with our second result, we finalize the query, adding the UNION key-

word between the two separate queries, as in Listing 7-19.

C H A P T E R   7   ■ E S S E N T I A L   S Q L

mysql> SELECT

-> p.name as "Product"

-> , "2004 - December" as "Date"

-> , SUM(coi.quantity) as "Total Purchased"

-> FROM CustomerOrder2004 co

->  INNER JOIN CustomerOrderItem2004 coi

->   ON co.order_id = coi.order_id

->  INNER JOIN Product p

->   ON coi.product_id = p.product_id

-> WHERE co.ordered_on BETWEEN '2004-12-01' AND '2004-12-31'

-> GROUP BY p.name;

+------------------------+-----------------+-----------------+

| Product                | Date            | Total Purchased |

+------------------------+-----------------+-----------------+

| Action Figure - Tennis | 2004 - December | 1               |

| Soccer Ball            | 2004 - December | 1               |

| Tennis Balls           | 2004 - December | 15              |

+------------------------+-----------------+-----------------+

3 rows in set (0.00 sec)

Listing 7-19. UNION Query Merging Two Previous Resultsets

mysql> (

-> SELECT

->   p.name as "Product"

->   , "2005 - January" as "Date"

->   , SUM(coi.quantity) as "Total Purchased"

-> FROM CustomerOrder co

->   INNER JOIN CustomerOrderItem coi

->     ON co.order_id = coi.order_id

->   INNER JOIN Product p

->     ON coi.product_id = p.product_id

-> WHERE co.ordered_on BETWEEN '2005-01-01' AND '2005-01-31'

-> GROUP BY p.name

-> )

-> UNION

-> (

-> SELECT

->   p.name as "Product"

->   , "2004 - December" as "Date"

->   , SUM(coi.quantity) as "Total Purchased"

-> FROM CustomerOrder2004 co

->   INNER JOIN CustomerOrderItem2004 coi

->     ON co.order_id = coi.order_id

->   INNER JOIN Product2004 p


C H A P T E R   7   ■ E S S E N T I A L   S Q L

->     ON coi.product_id = p.product_id

-> WHERE co.ordered_on BETWEEN '2004-12-01' AND '2004-12-31'

-> GROUP BY p.name

-> );

+---------------------------+-----------------+-----------------+

| Product                   | Date            | Total Purchased |

+---------------------------+-----------------+-----------------+

| Action Figure - Football  | 2005 - January  |               1 |

| Action Figure - Gladiator | 2005 - January  |               1 |

| Doll                      | 2005 - January  |               2 |

| Tennis Balls              | 2005 - January  |              42 |

| Tennis Racket             | 2005 - January  |               1 |

| Video Game - Football     | 2005 - January  |               1 |

| Action Figure - Tennis    | 2004 - December |               1 |

| Soccer Ball               | 2004 - December |               1 |

| Tennis Balls              | 2004 - December |              15 |

+---------------------------+-----------------+-----------------+

9 rows in set (0.09 sec)

Here, the parentheses are optional, but we feel they help to distinguish the two component

resultsets. Furthermore, when using the ORDER BY or LIMIT clause in your UNION statements, the

parentheses are required in order to tell MySQL that you wish the ORDER BY or LIMIT to operate on

the entire merged resultset.

As you can see, the two various results are merged together into a single result. Now, what

would happen if we had not included the static Date column? Listing 7-20 shows the result of

removing this column.

Listing 7-20. Removing the Static Date Column

mysql> (

-> SELECT

->   p.name as "Product"

->   , SUM(coi.quantity) as "Total Purchased"

-> FROM CustomerOrder co

->   INNER JOIN CustomerOrderItem coi

->     ON co.order_id = coi.order_id

->   INNER JOIN Product p

->     ON coi.product_id = p.product_id

-> WHERE co.ordered_on BETWEEN '2005-01-01' AND '2005-01-31'

-> GROUP BY p.name

-> )

-> UNION

-> (

-> SELECT

->   p.name as "Product"

->   , SUM(coi.quantity) as "Total Purchased"

-> FROM CustomerOrder2004 co

->   INNER JOIN CustomerOrderItem2004 coi


C H A P T E R   7   ■ E S S E N T I A L   S Q L

->     ON co.order_id = coi.order_id

->   INNER JOIN Product2004 p

->     ON coi.product_id = p.product_id

-> WHERE co.ordered_on BETWEEN '2004-12-01' AND '2004-12-31'

-> GROUP BY p.name

-> );

+---------------------------+-----------------+

| Product                   | Total Purchased |

+---------------------------+-----------------+

| Action Figure - Football  |               1 |

| Action Figure - Gladiator |               1 |

| Doll                      |               2 |

| Tennis Balls              |              42 |

| Tennis Racket             |               1 |

| Video Game - Football     |               1 |

| Action Figure - Tennis    |               1 |

| Soccer Ball               |               1 |

| Tennis Balls              |              15 |

+---------------------------+-----------------+

9 rows in set (0.00 sec)

As you can see, you can’t tell which row for the Tennis Balls product refers to the 2005 data

and which belongs to the 2004 data. Furthermore, if the two Total Purchased columns for those

rows had been the same, one of the rows would have been eliminated from the resultset, unless

the UNION ALL keywords were used in the statement.

■Tip By default, UNIONs operate in the UNION DISTINCT behavior, which eliminates any duplicate

rows from the return. You may override this behavior by using the UNION ALL keywords. If you know with

certainty that the UNIONed results will naturally contain no duplicates, you can realize a small performance

gain using the UNION ALL variation.

In practice, if you have a properly normalized database, there should be few situations, if

any, where you would use a UNION join. If you do find yourself using UNION for more than optimiz-

ing OR conditions or aggregating log or archive data, you may need to reexamine your schema to

see if some normalization should occur. For example, take a look at the E-R diagram shown in

Figure 7-2.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

CustomerServiceEmployee

WarehouseEmployee

Customer

rep_id

login

password

first_name

last_name

last_login

email_address

tech_id

login

password

first_name

last_name

last_login

manager

night_or_day_shift

customer_id

login

password

created_on

first_name

last_name

billing_address

billing_city

billing_province

billing_postcode

billing_country

shipping_address

shipping_city

shipping_province

shipping_postcode

shipping_county

Figure 7-2. Account schema that isn’t normalized

Each of the entities you see in Figure 7-2 represents a different type of user in the applica-

tion. In order to get a list of all the names, logins, and passwords of all the users in this system,

you would need to perform a UNION query similar to the one shown in Listing 7-21. (Note the

required use of parentheses around the statements because of the ORDER BY clause.)

Listing 7-21. UNION Query to Find System User Information

(

SELECT first_name, last_name, login, password

FROM CustomerServiceEmployee

UNION

SELECT first_name, last_name, login, password

FROM WarehouseEmployee

UNION

SELECT first_name, last_name, login, password

FROM Customer

) ORDER BY last_name, first_name;

However, if the schema were properly normalized, to a form similar to Figure 7-3, the

UNION would not be necessary, and instead could be a simple SELECT from a single table,

Account, like so:

SELECT first_name, last_name, login, password FROM Account;


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Account

account_id

login

password

first_name

last_name

WarehouseEmployee

CustomerServiceEmployee

Customer

account_id

last_login

manager

night_or_day_shift

account_id

last_login

email_address

account_id

created_on

billing_address

billing_city

billing_province

billing_postcode

billing_country

shipping_address

shipping_city

shipping_province

shipping_postcode

shipping_county

Figure 7-3. Properly normalized account schema

The point here is that if you find yourself dealing with UNIONs a lot, it may be time to take a

closer look at your schema and get back to basics. The Account table in Figure 7-3 houses the

attributes common to all system users, thus accomplishing the normalization step of remov-

ing redundant data columns. Similarly, the two types of employee data—WarehouseEmployee

and CustomerServiceEmployee—have been stripped of their redundant Account data and con-

tain only attributes specific to each entity.

Although this brief discussion on proper normalization may come across as common sense

to many of you who have experience using relational database management systems, we almost

guarantee that in the course of your IT travels, you will run across this type of situation. Why? In

the world of object-oriented programming, it is natural, and sometimes encouraged, to create

multiple classes for related objects. Sometimes these related objects correspond to a naturally

normalized relational database model; other times they don’t. In the latter case, object-oriented

programmers with little database experience tend to “translate” their object model quite literally

into the database schema. This is an all-too-common occurrence and is why you will often see

schemas like the one shown in Figure 7-2.

The Natural Join

A natural join, in the MySQL world, is not a different type of join, but rather a different way

of expressing either an inner join or outer join on tables that have identically named columns.

For example, the two statements shown in Listing 7-22 are identical, given our sample schema.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Listing 7-22. Example of a Natural Join

mysql> SELECT p2c.category_id

-> FROM Product p

-> NATURAL JOIN Product2Category p2c

-> WHERE p.product_id = 2;

+-------------+

| category_id |

+-------------+

|           2 |

+-------------+

1 row in set (0.11 sec)

mysql> SELECT p2c.category_id

-> FROM Product p

-> INNER JOIN Product2Category p2c ON p.product_id = p2c.product_id

-> WHERE p.product_id = 2;

+-------------+

| category_id |

+-------------+

|           2 |

+-------------+

1 row in set (0.00 sec)

named columns in both tables.

SQL code.

Likewise, using NATURAL LEFT JOIN would do an outer join based on any identically

We generally discourage the use of NATURAL JOIN, because it leads to less specificity in your

The USING Keyword

Just like NATURAL JOIN, the USING keyword is simply an alternate way of expressing the ON

condition for some joins. Instead of ON tableA.column1 = tableB.column1, you could write

USING (column1). Listing 7-23 shows an example that uses the USING keyword.

Listing 7-23. Example of the USING Keyword

mysql> SELECT p2c.category_id

-> FROM Product p

-> INNER JOIN Product2Category p2c USING (product_id)

-> WHERE p.product_id = 2;

+-------------+

| category_id |

+-------------+

|           2 |

+-------------+

1 row in set (0.00 sec)


C H A P T E R   7   ■ E S S E N T I A L   S Q L

The use of USING is primarily related to style preference. If you’re concerned about porta-

bility issues, however, you may want to stay away from this nonstandard syntax. If not, just

decide which style of syntax you want to adopt, and adhere to that single style.

EXPLAIN and Access Types

The access strategy MySQL chooses for your SELECT statements is based on a complex set of

decisions made by the join optimizer, which is part of the query parsing, optimization, and

execution subsystem (see Chapter 4). The EXPLAIN command, introduced in Chapter 6, helps

you in analyzing the access strategy MySQL chooses in order fulfill your SELECT requests. This

will provide you the information you need to determine if MySQL has indeed chosen an opti-

mal path for joining your various data sets or if your query requires some additional tweaking.

The EXPLAIN statement’s type column2 shows the access type MySQL is using for the query.

In order of most efficient access to least efficient, the following are the values that may appear

in the type column of your EXPLAIN results:

• system

• const

• eq_ref

• ref

• ref_or_null

• unique_subquery

• index_subquery

• range

• index

• ALL

• index_merge (new in MySQL 5.0.0)

The system value refers to a special type of access strategy that MySQL can deploy when

the SELECT statement is requesting data from a MySQL system (in-memory) table and the table

has only one row of data. In the following sections, we’ll look at the meaning of each of the

other values.

2. The MySQL online documentation refers to the type column as the join type. This is a bit of a mis-

nomer, as this column actually refers to the access type, since no actual joins may be present in the

SELECT statement. We encourage you to investigate the internals.texi developer’s documentation,

where this same clarification is made.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

The const Access Type

The const access type is shown when the table for which the row in the EXPLAIN result is

describing meets one of the following conditions:

• The table has either zero or one row in it.

• The table has a unique, non-nullable key for which a WHERE condition containing a

single value for each column in the key is present.

If the table and any expression on it meet either of these conditions, that means that, at

most, one value can be retrieved for the columns needed in the SELECT statement from this

table. Because of this, MySQL will replace any of the data set’s columns used in the SELECT

statement with the single row’s data before any query execution is begun. This is a form of

constant propagation, a technique that the optimizer uses when it can substitute a constant

value for variables or join conditions in the query.

Listing 7-24 shows an EXPLAIN with the const access type. You can see that because the

join’s ON condition provides a single value for the Customer primary key, MySQL is able to use a

const access type.

■Note In the examples here, we use the \G switch from the mysql client utility in order to output wide

display results in rows, rather than in columns.

Listing 7-24. Example of the const Access Type

mysql> EXPLAIN

-> SELECT * FROM Customer

-> WHERE customer_id = 1 \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: Customer

type: const

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

ref: const

rows: 1

Extra:

1 row in set (0.01 sec)

As mentioned, MySQL performs a lookup for constant conditions on a unique key before

the query execution begins. In this way, if it finds that no rows match the WHERE expression, it

will stop the processing of the query, and in the Extra column, EXPLAIN will output Impossible ➥

WHERE noticed after reading const tables.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

The eq_ref Access Type

When the eq_ref access type appears, it means that a single row is read from this table for each

combination of rows returned from previous data set retrieval. When all parts of a key are used

by a join and the key is unique and non-nullable, then an eq_ref access can be performed.

Interestingly, the join condition value can be an expression that uses columns from tables that

are read before this table or a constant.

For example, Listing 7-25 shows a SELECT statement used to retrieve the orders details for

any orders having the product with an ID of 2. The result returned from the access of table co

(using the index access type discussed shortly) is matched using the eq_ref access type to the

PRIMARY key columns in CustomerOrderItem (coi). Even though CustomerOrderItem’s primary

key has two parts, the eq_ref is possible because the second part of the key (product_id) is

eliminated through the WHERE expression containing a constant. We’ve highlighted the ref

column of the EXPLAIN output to show this more clearly.

Listing 7-25. Example of the eq_ref Access Type

mysql> EXPLAIN

-> SELECT coi.*

-> FROM CustomerOrder co

->  INNER JOIN CustomerOrderItem coi

->   ON co.order_id = coi.order_id

-> WHERE coi.product_id = 2 \G

*************************** 1. row ***************************

*************************** 2. row ***************************

id: 1

select_type: SIMPLE

table: co

type: index

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

ref: NULL

rows: 6

Extra: Using index

id: 1

select_type: SIMPLE

table: coi

type: eq_ref

possible_keys: PRIMARY

key: PRIMARY

key_len: 8

ref: ToyStore.co.order_id,const

rows: 1

Extra:

2 rows in set (0.01 sec)


C H A P T E R   7   ■ E S S E N T I A L   S Q L

The ref Access Type

The ref access type is identical to the eq_ref access type, except that one or more rows that

match rows returned from previous table retrieval will be read from the current table. This

access type is performed when either of the following occurs:

• The join condition uses only the leftmost part of a multicolumn key.

• The key is not unique but does not contain NULLs.

To continue our eq_ref example from Listing 7-25, Listing 7-26 shows the effect of remov-

ing the constant part of our WHERE expression, leaving MySQL to use only the leftmost part of

the CustomerOrderItem table’s primary key (order_id).

Listing 7-26. Example of the ref Access Type

mysql> EXPLAIN

-> SELECT coi.*

-> FROM CustomerOrder co

->  INNER JOIN CustomerOrderItem coi

->   ON co.order_id = coi.order_id \G

*************************** 1. row ***************************

*************************** 2. row ***************************

id: 1

select_type: SIMPLE

table: co

type: index

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

ref: NULL

rows: 6

Extra: Using index

id: 1

select_type: SIMPLE

table: coi

type: ref

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

ref: ToyStore.co.order_id

rows: 1

Extra:

2 rows in set (0.01 sec)


C H A P T E R   7   ■ E S S E N T I A L   S Q L

The ref_or_null Access Type

The ref_or_null access type is used in an identical fashion to the ref access type, but when

the key can contain NULL values and a WHERE expression indicates an OR key_column IS NULL

condition. Listing 7-27 shows an example of the ref_or_null access strategy used when doing

a WHERE on Category.parent_id, which can contain NULLs for root categories. Here, we’ve used

a USE INDEX hint to force MySQL to use the ref_or_null access pattern. If we did not do this,

MySQL would choose to perform the access strategy differently, because there are other, more

efficient ways of processing this SELECT statement. You’ll learn more about USE INDEX and

other hints in the “Join Hints” section later in this chapter.

Listing 7-27. Example of the ref_or_null Access Type

mysql> EXPLAIN

-> SELECT *

-> FROM Product p

->  INNER JOIN Product2Category p2c

->   ON p.product_id = p2c.category_id

->  INNER JOIN Category c USE INDEX (parent_id)

->   ON p2c.category_id = c.category_id

-> WHERE c.parent_id = 2

-> OR c.parent_id IS NULL \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: c

type: ref_or_null

possible_keys: parent_id

key: parent_id

key_len: 5

ref: const

rows: 2

Extra: Using where

id: 1

select_type: SIMPLE

table: p

type: eq_ref

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

*************************** 2. row ***************************

*************************** 3. row ***************************

ref: ToyStore.c.category_id

rows: 2

Extra:

id: 1

select_type: SIMPLE

table: p2c


C H A P T E R   7   ■ E S S E N T I A L   S Q L

possible_keys: NULL

key: PRIMARY

key_len: 8

ref: NULL

rows: 10

Extra: Using where; Using index

3 rows in set (0.28 sec)

The index_merge Access Type

Up until MySQL 5.0.0, the following rule always applied to your queries: For each table refer-

enced in your SELECT statement, only one index could be used to retrieve the selected table

columns.

With the release of version MySQL 5.0.0, a new type of access strategy is enabled, called

an Index Merge. In some cases, this type can enable data retrieval using more than one index

for a single referenced table in your queries. In an Index Merge access, multiple executions

of ref, ref_or_null, or range accesses are used to retrieve key values matching various WHERE

conditions, and the results of these various retrievals are combined together to form a single

data set.

You’ll learn about the Index Merge ability in the next chapter, when we discuss dealing

with OR conditions.

The unique_subquery Access Type

A subquery is simply a child query that returns a set of values using an IN clause in the WHERE

condition. When MySQL knows the subquery will return a list of unique values, because a

unique, non-nullable index is used in the subquery’s SELECT statement, then the unique_

subquery access type may appear in the EXPLAIN result. Listing 7-28 shows an example of this.

Listing 7-28. Example of the unique_subquery Access Type

mysql> EXPLAIN

-> SELECT * FROM CustomerOrder co

-> WHERE co.status IN (

->   SELECT order_status_id

->   FROM OrderStatus os

->   WHERE os.description LIKE 'C%'

-> ) \G

*************************** 1. row ***************************

id: 1

select_type: PRIMARY

table: co

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 6


C H A P T E R   7   ■ E S S E N T I A L   S Q L

*************************** 2. row ***************************

id: 2

select_type: DEPENDENT SUBQUERY

table: os

type: unique_subquery

possible_keys: PRIMARY

key: PRIMARY

key_len: 2

ref: func

rows: 1

Extra: Using index; Using where

2 rows in set (0.02 sec)

During a unique_subquery access, MySQL is actually executing the subquery first, so that

the values returned from the subquery can replace the subquery in the IN clause of the parent

query. In this way, a subquery access is more like an optimization process than a true data

retrieval. To be sure, data (or rather, key) values are being returned from the subquery; how-

ever, these values are immediately transformed into a set of constant values in the IN clause.

You may have noticed that the example in Listing 7-28 can be rewritten in a more set-

based manner by using a simple inner join. We’ll discuss this point later in the chapter, in

the “Subqueries and Derived Tables” section.

The index_subquery Access Type

The index_subquery access type is identical to the unique_subquery access type, only in this

case, MySQL has determined that the values returned by the subquery will not be unique.

Listing 7-29 indicates this behavior.

Listing 7-29. Example of the index_subquery Access Type

mysql> EXPLAIN

-> SELECT * FROM CustomerOrderItem coi

-> WHERE coi.product_id IN (

->  SELECT product_id

->  FROM Product2Category p2c

->  WHERE p2c.category_id BETWEEN 1 AND 5

-> ) \G

*************************** 1. row ***************************

id: 1

select_type: PRIMARY

table: coi

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 10

Extra: Using where


C H A P T E R   7   ■ E S S E N T I A L   S Q L

*************************** 2. row ***************************

id: 2

select_type: DEPENDENT SUBQUERY

table: p2c

type: index_subquery

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

ref: func

rows: 1

Extra: Using index; Using where

2 rows in set (0.00 sec)

This query returns all order details for any products that are assigned to categories 1 through

5. MySQL knows, because of the two-column primary key on product_id and category_id, that

more than one category_id can be found in the subquery’s WHERE expression (BETWEEN 1 AND 5).

Again, this particular query is performed before the primary query’s execution, and its results are

dumped as constants into the IN clause of the primary query’s WHERE condition.

Not all subqueries will be reduced to a list of values before a primary query is executed.

These subqueries, known as correlated subqueries, depend on the values in the primary table,

and are thus executed for each value returned in the primary data set. We’ll look at this differ-

ence in the “Correlated Subqueries” section later in this chapter.

The range Access Type

The range access type will be used when your SELECT statements involve WHERE clauses (or ON

conditions) that use any of the following operators: >, >=, <, <=, IN, LIKE, or BETWEEN.

For the LIKE operator, a range operation can be used only if the first character of the com-

parison expression is not a wildcard; therefore, WHERE column1 LIKE 'cat%' will use the range

access type, but WHERE column1 LIKE '%cat' will not.

Listings 7-30 and 7-31 show two examples of the range access type being deployed against

our sample schema. We’ve shown a couple different operators that cause MySQL to apply the

range access strategy.

Listing 7-30. Example of the range Access Type with the BETWEEN Operator

mysql> EXPLAIN

-> SELECT *

-> FROM Product p

-> WHERE product_id BETWEEN 1 AND 3 \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: p

type: range

possible_keys: PRIMARY

key: PRIMARY

key_len: 4


Listing 7-31. Example of the range Access Type with the IN Operator

mysql> EXPLAIN

-> SELECT *

-> FROM Customer c

-> WHERE customer_id IN (2,3) \G

*************************** 1. row ***************************

C H A P T E R   7   ■ E S S E N T I A L   S Q L

ref: NULL

rows: 3

Extra: Using where

1 row in set (0.00 sec)

id: 1

select_type: SIMPLE

table: c

type: range

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

ref: NULL

rows: 2

Extra: Using where

1 row in set (0.00 sec)

Remember that the range access type, and indeed all access types above the ALL access

type, require that an index be available containing the key columns used in WHERE or ON condi-

tions. To demonstrate this, Listing 7-32 shows a SELECT on our CustomerOrder table based on

a range of order dates. It just so happens that CustomerOrder does not have an index on the

ordered_on column, so MySQL can use only the ALL access type, since no WHERE or ON condition

exists containing columns found in the table’s indexes (its primary key on order_id and an

index on the foreign key of customer_id).

Listing 7-32. No Usable Index, Even with a range Type Query

mysql> EXPLAIN

-> SELECT *

-> FROM CustomerOrder co

-> WHERE ordered_on >= '2005-01-01' \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: co

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 6


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Extra: Using where

1 row in set (0.00 sec)

As you can see, no possible keys (indexes) were available for the range access strategy to

be applied. Let’s see what happens if we add an index on the ordered_on column, as shown in

Listing 7-33.

Listing 7-33. Adding an Index on CustomerOrder

mysql> ALTER TABLE CustomerOrder ADD INDEX (ordered_on);

Query OK, 6 rows affected (0.35 sec)

Records: 6  Duplicates: 0  Warnings: 0

mysql> EXPLAIN

-> SELECT *

-> FROM CustomerOrder co

-> WHERE ordered_on >= '2005-01-01' \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: co

type: ALL

possible_keys: ordered_on

key: NULL

key_len: NULL

ref: NULL

rows: 6

Extra: Using where

1 row in set (0.00 sec)

Well, it seems MySQL didn’t choose the range access strategy even when the index was

added on ordered_on. Why did this happen? The answer has to do with some of the concepts

you learned in Chapter 2 regarding how MySQL accesses data.

When MySQL does an evaluation of how to perform a SELECT query, it weighs each of the

strategies for accessing the various tables contained in your request using an optimization for-

mula. Each access strategy is assigned a sort of sliding performance scale that is compared to

a number of statistics. The following are two of the most important statistics:

• The selectivity of an index. This number tells MySQL the relative distribution of values

within the index tree, and helps it determine how many keys in an index will likely

match the WHERE or ON condition in your query. This predicted number of matching key

values is output in the rows column of the EXPLAIN output.

• The relative speed of doing sequential reads for data on disk versus reading an index’s

keys and accessing table data using random seeks from the index row pointers to the

actual data location. If MySQL determines that a WHERE or ON condition will retrieve a

large number of keys, it may decide that it will be faster to simply read through the

data on disk sequentially (perform a scan) than do lookup seeks for each matching

key found in the sorted index.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

MySQL uses a threshold value to determine whether repeated seek operations will be

faster than a sequential read. The threshold value depends on the two statistics listed here,

as well as other storage engine-specific values.

In the case of Listing 7-33, MySQL determined that six matches would be found in the

index on ordered_on. Since the number of rows in CustomerOrder is small, MySQL determined

it would be faster to simply do a sequential scan of the table data (the ALL access type) than to

perform lookups from the matched keys in the index on ordered_on. Let’s see what happens if

we limit the WHERE expression to a smaller range of possible values, as in Listing 7-34.

Listing 7-34. A Smaller Possible Range of Values

mysql> EXPLAIN

-> SELECT *

-> FROM CustomerOrder co

-> WHERE ordered_on >= '2005-04-01' \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: co

type: range

possible_keys: ordered_on

key: ordered_on

key_len: 3

ref: NULL

rows: 1

Extra: Using where

1 row in set (0.01 sec)

As you can tell from Listing 7-34, this time, MySQL chose to use the range access strategy,

performing lookups from the ordered_on index for matched key values on the WHERE expres-

sion. Keep this behavior in mind when analyzing the effectiveness of your indexes and your

SQL statements. If you notice that a particular index is not being used effectively, it may be a

case of the index having too little diversity of key values (poor key distribution), or it may be

that the WHERE condition is simply too broad for the index to be effective.

■Tip When running benchmarking and profiling tests on your database, ensure that your test data set is

representative of your real database. If you are testing queries that run against a production database, but

are using only a subset of the production data, MySQL may choose different access strategies for your test

data than your production data.

The index Access Type

Indexes are supposed to improve the retrieval speed for data access, right? So why would the

index access strategy be so low on MySQL’s list of possible access strategies? The index access

type is a bit confusing. It should be more appropriately named “index_scan.” This access type


C H A P T E R   7   ■ E S S E N T I A L   S Q L

refers to the strategy deployed by MySQL when it does a sequential scan of all the key entries

in an index.

This access type is usually seen only when both of the following two conditions exist:

• No WHERE clause is specified or the table in question does not have an index that would

speed up data retrieval (see the preceding discussion of the range access type).

• All columns used in the SELECT statement for this table are available in the index. This is

called a covering index.

To see an example, let’s go back to Listing 7-33, where we continued to see MySQL use an

ALL access type, even though an index was available on columns in the WHERE condition. The

ALL access type indicates that a sequential scan of the table data is occurring. The reason the

table data is being sequentially scanned is because of the SELECT *, which means that all table

columns in CustomerOrder are used in the SELECT statement. Watch what happens if we change

the statement to read SELECT ordered_on, so that the only column used in the SELECT state-

ment is available in the index on ordered_on, and we remove the WHERE clause to force a scan,

as shown in Listing 7-35.

Listing 7-35. Example of the index Access Type

mysql> EXPLAIN

-> SELECT ordered_on

-> FROM CustomerOrder co \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: co

type: index

possible_keys: NULL

key: ordered_on

key_len: 3

ref: NULL

rows: 6

Extra: Using index

1 row in set (0.00 sec)

Notice that in the Extra column of the EXPLAIN output, you see Using index. This is MySQL

informing you that it was able to use the index data pages to retrieve all the information it needed

for this table. You will always see Using index when the index access type is shown; this is because

the index access type is used only when a covering index is available. Generally, having Using

index in the Extra column is a very good thing. It means that MySQL was able to use the smaller

index pages to retrieve all the data.

Seeing the index access type, however, is not often a good thing. It means that all values of

the index are being read. The only thing that makes the index access type better than the ALL

table scan access type is the fact that index data pages contain more records, and thus the

scan usually happens faster than a scan through the actual table data pages.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

The ALL Access Type

The ALL access type, as mentioned in the previous section, refers to a sequential scan of the

table’s data. This access type is used if either of the following conditions exists:

• No WHERE or ON condition is specified for any columns in any of the table’s keys.

• Index key distribution is poor, making a sequential scan more efficient than numerous

index lookups.

You’ve already seen a number of examples that contained the ALL access type, and by now,

you will have realized that most of our attention has been focused on avoiding this type of

access strategy. You can avoid using the ALL access strategy by paying attention to the EXPLAIN

output of your SQL statements and ensuring that indexes exist on columns that many WHERE

and ON conditions will reference.

Join Hints

For most of the queries you write, MySQL’s join optimization system will pick the most efficient

access path and join order for the various tables involved in your SELECT statements. For those

other cases, MySQL enables you to influence the join optimization process through the use of

join hints. Join hints can be helpful in a number of situations. Here, we’ll discuss the following

MySQL hints:

• STRAIGHT_JOIN

• USE INDEX

• FORCE INDEX

• IGNORE INDEX

■Caution If MySQL isn’t choosing an efficient access strategy, usually there is a very good reason for it.

Before deciding to use a join hint, you should investigate the causes of an inefficient join strategy. Addition-

ally, always take note of queries in which you place join hints of any type. You will often find that when a

database’s size and index distribution change, your join hints will be forcing MySQL to use a less-than-

optimal access strategy. So, do yourself a favor, and regularly check that join hints are performing up to

expectations.

The STRAIGHT_JOIN Hint

Occasionally, you will notice that MySQL chooses to access the tables in a multitable join

statement in an order that you feel is inefficient or unnatural. You can ask MySQL to access

tables in the order you tell it to by using the STRAIGHT_JOIN hint. Using this hint, MySQL will

access tables in order from left to right in the SELECT statement, meaning the first table in the

FROM clause will be accessed first, then its values joined to the first joined table, and so on.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Listing 7-36 shows an example of using the STRAIGHT_JOIN hint. In the first SQL statement,

the EXPLAIN output shows that MySQL chose to access the three tables used in the SELECT

statement in an order different from the order coded; in fact, the order is backwards from the

order given in the SELECT statement.

Listing 7-36. A Join Order Different from the Written SELECT

mysql> EXPLAIN

-> SELECT *

-> FROM Category c

->  INNER JOIN Product2Category p2c

->   ON c.category_id = p2c.category_id

->  INNER JOIN Product p

->   ON p2c.product_id = p.product_id

-> WHERE c.name LIKE 'Video%' \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: p

type: ALL

possible_keys: PRIMARY

key: NULL

key_len: NULL

ref: NULL

rows: 10

Extra:

id: 1

select_type: SIMPLE

table: p2c

type: ref

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

id: 1

select_type: SIMPLE

table: c

type: eq_ref

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

*************************** 2. row ***************************

ref: ToyStore.p.product_id

rows: 2

Extra: Using index

*************************** 3. row ***************************

ref: ToyStore.p2c.category_id

rows: 1

Extra: Using where

3 rows in set (0.00 sec)


C H A P T E R   7   ■ E S S E N T I A L   S Q L

If you felt that a more efficient join order would be to use the order given in the SELECT

statement, you would use the STRAIGHT_JOIN hint, as shown in Listing 7-37.

Listing 7-37. Example of the STRAIGHT_JOIN Hint

mysql> EXPLAIN

-> SELECT *

-> FROM Category c

->  STRAIGHT_JOIN Product2Category p2c

->  STRAIGHT_JOIN Product p

-> WHERE c.name LIKE 'Video%'

-> AND c.category_id = p2c.category_id

-> AND p2c.product_id = p.product_id \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: c

type: ALL

possible_keys: PRIMARY

key: NULL

key_len: NULL

ref: NULL

rows: 14

Extra: Using where

id: 1

select_type: SIMPLE

table: p2c

type: index

possible_keys: PRIMARY

key: PRIMARY

key_len: 8

*************************** 2. row ***************************

ref: NULL

rows: 8

Extra: Using where; Using index

*************************** 3. row ***************************

id: 1

select_type: SIMPLE

table: p

type: eq_ref

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

ref: ToyStore.p2c.product_id

rows: 1

Extra:

3 rows in set (0.00 sec)


C H A P T E R   7   ■ E S S E N T I A L   S Q L

As you can see, MySQL dutifully follows your desired join order. The access pattern it

comes up with, in this case, is suboptimal compared with the original, MySQL-chosen access

path. Where in the original EXPLAIN from Listing 7-36, you see MySQL using ref and eq_ref

access types for the joins to Product2Category and Category, in the STRAIGHT_JOIN EXPLAIN

(Listing 7-37), you see MySQL has reverted to using an index scan on Product2Category and

an eq_ref to access Product.

In this case, the STRAIGHT_JOIN made things worse. In most cases, MySQL will indeed

choose the most optimal pattern for accessing tables in your SELECT statements. However, if

you encounter a situation in which you suspect a different order would produce speedier

results, you can use this technique to test your theories.

■Caution If you do find a situation in which you suspect changing the join order would speed up a query,

make sure that MySQL is using up-to-date statistics on your table before making any changes. After you run

a baseline EXPLAIN to see MySQL’s chosen access strategy for your query, run an ANALYZE TABLE against

the table, and then check your EXPLAIN again to see if MySQL changed the join order or access strategy.

ANALYZE TABLE will update the statistics on key distribution that MySQL uses to decide an access strategy.

Remember that running ANALYZE TABLE will place a read lock on your table, so carefully choose when you

run this statement on large tables.

The USE INDEX and FORCE INDEX Hints

You’ve noticed a particularly slow query, and run an EXPLAIN on it. In the EXPLAIN result, you see

that for a particular table, MySQL has a choice of more than one index that contain columns on

which your WHERE or ON condition depends. It happens that MySQL has chosen to use an index

that you suspect is less efficient than another index on the same table. You can use one of two

join hints to prod MySQL into action:

• The USE INDEX (index_list) hint tells MySQL to consider only the indexes contained

in index_list during its evaluation of the table’s access strategy. However, if MySQL

determines that a sequential scan of the index or table data (index or ALL access types)

will be faster using any of the indexes using a seek operation (eq_ref, ref, ref_or_null,

and range access types), it will perform a table scan.

• The FORCE INDEX (index_list), on the other hand, tells MySQL not to perform a table

scan,3 and to always use one of the indexes in index_list. The FORCE_INDEX hint is avail-

able only in MySQL versions later than 4.0.9.

The IGNORE INDEX Hint

If you simply want to tell MySQL to not use one or more indexes in its evaluation of the access

strategy, you can use the IGNORE INDEX (index_list) hint. MySQL will perform the optimization

of joins as normal, but it will not include in the evaluation any indexes listed in index_list.

Listing 7-38 shows the results of placing an IGNORE INDEX hint in a SELECT statement.

3. Technically, FORCE INDEX makes MySQL assign a table scan a very high optimization weight, making

the use of a table scan very unlikely.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Listing 7-38. Example of How the IGNORE INDEX Hint Forces a Different Access Strategy

*************************** 1. row ***************************

mysql> EXPLAIN

-> SELECT p.name, p.unit_price, coi.price

-> FROM CustomerOrderItem coi

->  INNER JOIN Product p

->   ON coi.product_id = p.product_id

->  INNER JOIN CustomerOrder co

->   ON coi.order_id = co.order_id

-> WHERE co.ordered_on = '2004-12-07' \G

id: 1

select_type: SIMPLE

table: co

type: ref

possible_keys: PRIMARY,ordered_on

key: ordered_on

key_len: 3

ref: const

rows: 1

Extra: Using where; Using index

*************************** 2. row ***************************

ref: ToyStore.co.order_id

rows: 1

Extra:

*************************** 3. row ***************************

id: 1

select_type: SIMPLE

table: coi

type: ref

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

id: 1

select_type: SIMPLE

table: p

type: eq_ref

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

ref: ToyStore.coi.product_id

rows: 1

Extra:

3 rows in set (0.01 sec)

mysql> EXPLAIN

-> SELECT p.name, p.unit_price, coi.price

-> FROM CustomerOrderItem coi


C H A P T E R   7   ■ E S S E N T I A L   S Q L

->  INNER JOIN Product p

->   ON coi.product_id = p.product_id

->  INNER JOIN CustomerOrder co IGNORE INDEX (ordered_on)

->   ON coi.order_id = co.order_id

-> WHERE co.ordered_on = '2004-12-07' \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: co

type: ALL

possible_keys: PRIMARY

key: NULL

key_len: NULL

ref: NULL

rows: 6

Extra: Using where

id: 1

select_type: SIMPLE

table: coi

type: ref

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

*************************** 2. row ***************************

ref: ToyStore.co.order_id

rows: 1

Extra:

*************************** 3. row ***************************

id: 1

select_type: SIMPLE

table: p

type: eq_ref

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

ref: ToyStore.coi.product_id

rows: 1

Extra:

3 rows in set (0.03 sec)

As in the previous example, you see that the resulting query plan was less optimal than

without the join hint. Without the IGNORE_INDEX hint, MySQL had a choice between using the

PRIMARY key or the index on ordered_on. Of these, it chose to use the ref access strategy—a

lookup based on a non-unique index—and used the constant in the WHERE expression to fulfill

the reference condition.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

In contrast, when the IGNORE_INDEX (ordered_on) hint is used, MySQL sees that it has

the choice to use the PRIMARY key index (needed for the inner join from CustomerOrderItem

to CustomerOrder). However, it decided that a table scan of the data, using a WHERE condition to

filter out orders placed on December 7, 2004, would be more efficient in this case.

Subqueries and Derived Tables

Now we’re going to dive into a newer development in the MySQL arena: the subquery and

derived table abilities available in MySQL version 4.1 and later.

Subqueries are, simply stated, a SELECT statement within another statement. Subqueries

are sometimes called sub-SELECTs, for obvious reasons. Derived tables are a specialized version

of a subquery used in the FROM clause of your SELECT statements.

As you’ll see, some subqueries can be rewritten as an outer join, but not all of them can

be. In fact, there are certain SQL activities in MySQL that are impossible to achieve in a single

SQL statement without the use of subqueries.

In versions prior to MySQL 4.1, programmers needed to use multiple SELECT statements,

possibly storing results in a temporary table or program variable and using that result in their

code with another SQL statement.

Subqueries

As we said, a subquery is simply a SELECT statement embedded inside another SQL statement.

As such, like any other SELECT statement, a subquery can return any of the following results:

• A single value, called a scalar result

• A single-row result—one row, multiple columns of data

• A single-column result—one column of data, many rows

• A tabular result—many columns of data for many rows

The result returned by the subquery dictates the context in which the subquery may be

used. Furthermore, the syntax used to represent the subquery varies depending on the

returned result. We’ll show numerous examples for each different type of query in the follow-

ing sections.

Scalar Subqueries

When a subquery returns only a single value, it may be used just like any other constant value

in your SQL statements. To demonstrate, take a look at the example shown in Listing 7-39.

Listing 7-39. Example of a Simple Scalar Subquery

mysql> SELECT *

-> FROM Product p

-> WHERE p.unit_price = (SELECT MAX(unit_price) FROM Product) \G

*************************** 1. row ***************************


C H A P T E R   7   ■ E S S E N T I A L   S Q L

product_id: 6

sku: SPT003

name: Tennis Racket

description: Fiberglass Tennis Racket

weight: 2.15

unit_price: 104.75

1 row in set (0.34 sec)

Here, we’ve used this scalar subquery:

(SELECT MAX(unit_price) FROM Product)

This can return only a single value: the maximum unit price for any product in our catalog.

Let’s take a look at the EXPLAIN output, shown in Listing 7-40, to see what MySQL has done.

Listing 7-40. EXPLAIN for the Scalar Subquery in Listing 7-39

mysql> EXPLAIN

-> SELECT *

-> FROM Product p

-> WHERE p.unit_price = (SELECT MAX(unit_price) FROM Product) \G

*************************** 1. row ***************************

*************************** 2. row ***************************

id: 1

select_type: PRIMARY

table: p

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 10

Extra: Using where

id: 2

select_type: SUBQUERY

table: Product

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 10

Extra:

2 rows in set (0.00 sec)

You see no real surprises here. Since we have no index on the unit_price column, no

indexes are deployed. MySQL helpfully notifies us that a subquery was used.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

The statement in Listing 7-39 may also be written using a simple LIMIT expression with an

ORDER BY, as shown in Listing 7-41. We’ve included the EXPLAIN output for you to compare the

two query execution plans used.

Listing 7-41. Alternate Way of Expressing Listing 7-39

mysql> SELECT *

-> FROM Product p

-> ORDER BY unit_price DESC

-> LIMIT 1 \G

*************************** 1. row ***************************

product_id: 6

sku: SPT003

name: Tennis Racket

description: Fiberglass Tennis Racket

weight: 2.15

unit_price: 104.75

1 row in set (0.00 sec)

mysql> EXPLAIN

-> SELECT *

-> FROM Product p

-> ORDER BY unit_price DESC

-> LIMIT 1 \G

id: 1

select_type: SIMPLE

table: p

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 10

Extra: Using filesort

1 row in set (0.00 sec)

*************************** 1. row ***************************

You may be wondering why even bother with the subquery if the LIMIT statement is more

efficient. There are a number of reasons to consider using a subquery in this situation. First,

the LIMIT clause is MySQL-specific, so it is not portable. If this is a concern for you, the sub-

query is the better choice. Additionally, many developers feel the subquery is a more natural,

structured, and readable way to express the statement.

The subquery in Listing 7-39 is only a simple query. For more complex queries, involving

two or more tables, a subquery would be required, as Listing 7-42 demonstrates.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Listing 7-42. Example of a More Complex Scalar Subquery

mysql> SELECT p.product_id, p.name, p.weight, p.unit_price

-> FROM Product p

-> WHERE p.weight = (

->  SELECT MIN(weight)

->  FROM CustomerOrderItem

-> );

+------------+-------------------------+--------+------------+

| product_id | name                    | weight | unit_price |

+------------+-------------------------+--------+------------+

|          8 | Video Game - Car Racing | 0.25   | 48.99      |

|          9 | Video Game - Soccer     | 0.25   | 44.99      |

|         10 | Video Game - Football   | 0.25   | 46.99      |

+------------+-------------------------+--------+------------+

3 rows in set (0.00 sec)

Here, because the scalar subquery retrieves data from CustomerOrderItem, not Product,

there is no way to rewrite the query using either a LIMIT or a join expression.

Let’s take a look at a third example of a scalar subquery, shown in Listing 7-43.

Listing 7-43. Another Example of a Scalar Subquery

mysql> SELECT

->  p.name

-> , p.unit_price

-> , (

->   SELECT AVG(price)

->   FROM CustomerOrderItem

->   WHERE product_id = p.product_id

->   ) as "avg_sold_price"

-> FROM Product p;

+---------------------------+------------+----------------+

| name                      | unit_price | avg_sold_price |

+---------------------------+------------+----------------+

| Action Figure - Tennis    | 12.95      | 12.950000      |

| Action Figure - Football  | 11.95      | 11.950000      |

| Action Figure - Gladiator | 15.95      | 15.950000      |

| Soccer Ball               | 23.70      | 23.700000      |

| Tennis Balls              | 4.75       | 4.750000       |

| Tennis Racket             | 104.75     | 104.750000     |

| Doll                      | 59.99      | 59.990000      |

| Video Game - Car Racing   | 48.99      | NULL           |

| Video Game - Soccer       | 44.99      | NULL           |

| Video Game - Football     | 46.99      | 46.990000      |

+---------------------------+------------+----------------+

10 rows in set (0.00 sec)


C H A P T E R   7   ■ E S S E N T I A L   S Q L

The statement in Listing 7-43 uses a scalar subquery in the SELECT clause of the outer

statement to return the average selling price of the product, stored in the CustomerOrderItem

table. In the subquery, note that the WHERE expression essentially joins the CustomerOrderItem.

product_id with the product_id of the Product table in the outer SELECT statement. For each

product in the outer Product table, MySQL is averaging the price column for the product

in the CustomerOrderItem table and returning that scalar value into the column aliased as

"avg_sold_price".

Take special note of the NULL values returned for the “Video Game – Car Racing” and

“Video Game – Soccer” products. What does this behavior remind you of? An outer join

exhibits the same behavior. Indeed, we can rewrite the SQL in Listing 7-43 as an outer

join with a GROUP BY expression, as shown in Listing 7-44.

Listing 7-44. Listing 7-43 Rewritten As an Outer Join

mysql> SELECT

->  p.name

-> , p.unit_price

-> , AVG(coi.price) AS "avg_sold_price"

-> FROM Product p

->  LEFT JOIN CustomerOrderItem coi

->   ON p.product_id = coi.product_id

-> GROUP BY p.name, p.unit_price;

+---------------------------+------------+----------------+

| name                      | unit_price | avg_sold_price |

+---------------------------+------------+----------------+

| Action Figure - Football  |      11.95 |      11.950000 |

| Action Figure - Gladiator |      15.95 |      15.950000 |

| Action Figure - Tennis    |      12.95 |      12.950000 |

| Doll                      |      59.99 |      59.990000 |

| Soccer Ball               |      23.70 |      23.700000 |

| Tennis Balls              |       4.75 |       4.750000 |

| Tennis Racket             |     104.75 |     104.750000 |

| Video Game - Car Racing   |      48.99 |           NULL |

| Video Game - Football     |      46.99 |      46.990000 |

| Video Game - Soccer       |      44.99 |           NULL |

+---------------------------+------------+----------------+

10 rows in set (0.11 sec)

However, what if we wanted to fulfill this request: “Return a list of each product name, its

unit price, and the average unit price of all products tied to the product’s related categories.”

As an exercise, see if you can write a single query that fulfills this request. Give up? You

cannot use a single SQL statement, because in order to retrieve the average unit price of prod-

ucts within related categories, you must average across a set of the Product table. Since you

must also GROUP BY all the rows in the Product table, you cannot provide this information in a

single SELECT statement with a join. Without subqueries, you would be forced to make two

separate SELECT statements: one for all the product IDs, product names, and unit prices, and

another for the average unit prices for each product ID in Product2Category that fell in a

related category. Then you would need to manually merge the two results programmatically.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

You could do this in your application code, or you might use a temporary table to store the

average unit price for all categories, and then perform an outer join of your Product resultset

along with your temporary table.

With a scalar subquery, however, you can accomplish the same result with a single SELECT

statement and subquery. Listing 7-45 shows how you would do this.

Listing 7-45. Complex Scalar Subquery Showing Average Category Unit Prices

mysql> SELECT

->  p.name

-> , p.unit_price

-> , (

->    SELECT AVG(p2.unit_price)

->    FROM Product p2

->    INNER JOIN Product2Category p2c2

->    ON p2.product_id = p2c2.product_id

->    WHERE p2c2.category_id = p2c.category_id

->    ) AS avg_cat_price

-> FROM Product p

->  INNER JOIN Product2Category p2c

->   ON p.product_id = p2c.product_id

-> GROUP BY p.name, p.unit_price;

+---------------------------+------------+---------------+

| name                      | unit_price | avg_cat_price |

+---------------------------+------------+---------------+

| Action Figure - Football  |      11.95 |     12.450000 |

| Action Figure - Gladiator |      15.95 |     15.950000 |

| Action Figure - Tennis    |      12.95 |     12.450000 |

| Doll                      |      59.99 |     59.990000 |

| Soccer Ball               |      23.70 |     23.700000 |

| Tennis Balls              |       4.75 |     54.750000 |

| Tennis Racket             |     104.75 |     54.750000 |

| Video Game - Car Racing   |      48.99 |     48.990000 |

| Video Game - Football     |      46.99 |     45.990000 |

| Video Game - Soccer       |      44.99 |     45.990000 |

+---------------------------+------------+---------------+

10 rows in set (0.72 sec)

Here, we’re joining two copies of the Product and Product2Category tables in order to find

the average unit prices for each product and the average unit prices for each product in any

related category. This is possible through the scalar subquery, which returns a single averaged

value.

The key to the SQL is in how the WHERE condition of the subquery is structured. Pay close

attention here. We have a condition that states WHERE p2c2.category_id = p2c.category_id.

This condition ensures that the average returned by the subquery is across rows in the inner

Product table (p2) that have rows in the inner Product2Category (p2c2) table matching any cat-

egory tied to the row in the outer Product table (p). If this sounds confusing, take some time to

scan through the SQL code carefully, noting how the connection between the outer and inner


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Correlated Subqueries

Let’s take a look at the EXPLAIN output from our subquery in Listing 7-43. Listing 7-46 shows

the results.

Listing 7-46. EXPLAIN Output from Listing 7-43

mysql> EXPLAIN

-> SELECT

->  p.name

-> , p.unit_price

-> , (

->   SELECT AVG(price)

->   FROM CustomerOrderItem

->   WHERE product_id = p.product_id

->   ) as "avg_sold_price"

-> FROM Product p \G

id: 1

select_type: PRIMARY

table: p

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 10

Extra:

id: 2

select_type: DEPENDENT SUBQUERY

table: CustomerOrderItem

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 10

Extra: Using where

2 rows in set (0.00 sec)

*************************** 1. row ***************************

*************************** 2. row ***************************

Here, instead of SUBQUERY, we see DEPENDENT SUBQUERY appear in the select_type column.

The significance of this is that MySQL is informing us that the subquery that retrieves average

sold prices is a correlated subquery. This means that the subquery (inner query) contains a ref-

erence in its WHERE clause to a table in the outer query, and it will be executed for each row in

the PRIMARY resultset. In most cases, it would be more efficient to do a retrieval of the aggre-

gated data in a single pass. Fortunately, MySQL can optimize some types of correlated

subqueries, and it also offers another subquery option that remedies this performance

problem: the derived table. We’ll take a closer look at derived tables in a moment.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Correlated subqueries do not necessarily have to occur in the SELECT clause of the outer

query, as in Listing 7-43. They may also appear in the WHERE clause of the outer query. If the

WHERE clause of the subquery contains a reference to a table in the outer query, it is correlated.

Here’s one more example of using a correlated scalar subquery to accomplish what is not

possible to do with a simple outer join without a subquery. Imagine the following request:

“Retrieve all products having a unit price that is less than the smallest sold price for the same

product in any customer’s order.” Subqueries are required in order to fulfill this request. One

possible solution is presented in Listing 7-47.

Listing 7-47. Example of a Correlated Scalar Subquery

SELECT p.name FROM Product p

WHERE p.unit_price < (

SELECT MIN(price) FROM CustomerOrderItem

WHERE product_id = p.product_id

);

Columnar Subqueries

We’ve already seen a couple examples of subqueries that return a single column of data for

one or more rows in a table. Often, these types of queries can be more efficiently rewritten as a

joined set, but columnar subqueries support a syntax that you may find more appealing than

complex outer joins. For example, Listing 7-48 shows an example of a columnar subquery

used in a WHERE condition. Listing 7-49 shows the same query converted to an inner join.

Both queries show customers who have placed completed orders.

Listing 7-48. Example of a Columnar Subquery

mysql> SELECT c.first_name, c.last_name

-> FROM Customer c

-> WHERE c.customer_id IN (

->  SELECT customer_id

->  FROM CustomerOrder co

->  WHERE co.status = 'CM'

-> );

+------------+-----------+

| first_name | last_name |

+------------+-----------+

| John       | Doe       |

+------------+-----------+

1 row in set (0.00 sec)

Listing 7-49. Listing 7-48 Rewritten As an Inner Join

mysql> SELECT DISTINCT c.first_name, c.last_name

-> FROM Customer c

->  INNER JOIN CustomerOrder co

->   ON c.customer_id = co.customer_id


Notice that in the inner join rewrite, we must use the DISTINCT keyword to keep customer

As an alternative to using IN (subquery), MySQL allows you to use the ANSI standard = ANY ➥

(subquery) syntax, as Listing 7-50 shows. The query is identical in function to Listing 7-48.

Listing 7-50. Example of Columnar Subquery with = ANY syntax

mysql> SELECT c.first_name, c.last_name

C H A P T E R   7   ■ E S S E N T I A L   S Q L

-> WHERE co.status = 'CM';

+------------+-----------+

| first_name | last_name |

+------------+-----------+

| John       | Doe       |

+------------+-----------+

1 row in set (0.00 sec)

names from repeating in the resultset.

ANY and ALL ANSI Expressions

-> FROM Customer c

-> WHERE c.customer_id = ANY (

->  SELECT customer_id

->  FROM CustomerOrder co

->  WHERE co.status = 'CM'

-> );

+------------+-----------+

| first_name | last_name |

+------------+-----------+

| John       | Doe       |

+------------+-----------+

1 row in set (0.00 sec)

result subqueries:

The ANSI subquery syntax provides for the following expressions for use in columnar

• operand comparison_operator ANY (subquery): Indicates to MySQL that the expression

should return TRUE if any of the values returned by the subquery result would return

TRUE on being compared to operand with comparison_operator. The SOME keyword is an

alias for ANY.

• operand comparison_operator ALL (subquery): Indicates to MySQL that the expression

should return TRUE if each and every one of the values returned by the subquery result

would return TRUE on being compared to operand with comparison_operator.

EXISTS and NOT EXISTS Expressions

A special type of expression available for subqueries simply tests for the existence of a value

within the data set of the subquery. Existence tests in MySQL subqueries follow this syntax:

WHERE [NOT] EXISTS ( subquery )


C H A P T E R   7   ■ E S S E N T I A L   S Q L

If the subquery returns one or more rows, the EXISTS test will return TRUE. Likewise, if the

query returns no rows, NOT EXISTS will return TRUE. For instance, in Listing 7-51, we show an

example of using EXISTS in a correlated subquery to return all customers who have placed

orders. Again, the subquery is correlated because the subquery references a table available in

the outer query.

Listing 7-51. Example of Using EXISTS in a Correlated Subquery

mysql> SELECT c.first_name, c.last_name

-> FROM Customer c

-> WHERE EXISTS (

->  SELECT * FROM CustomerOrder co

->  WHERE co.customer_id = c.customer_id

-> );

+------------+-----------+

| first_name | last_name |

+------------+-----------+

| John       | Doe       |

| Jane       | Smith     |

| Mark       | Brown     |

+------------+-----------+

3 rows in set (0.00 sec)

There are some slight differences here between using = ANY and the shorter IN subquery,

like the ones shown in Listing 7-50 and 7-48, respectively. ANY will transform the subquery to

a list of values, and then compare those values using an operator to a column (or, more than

one column, as you’ll see in the results of tabular and row subqueries, covered in the next

section). However, EXISTS does not return the values from a subquery; it simply tests to see

whether any rows were found by the subquery. This is a subtle, but important distinction.

In an EXISTS subquery, MySQL completely ignores what columns are in the subquery’s

SELECT statement, thus all of the following are identical:

WHERE EXISTS (SELECT * FROM Table1)

WHERE EXISTS (SELECT NULL FROM Table1)

WHERE EXISTS (SELECT 1, column2, NULL FROM Table1)

The standard convention, however, is to use the SELECT * variation.

The EXISTS and NOT EXISTS expressions can be highly optimized by MySQL, especially

when the subquery involves a unique, non-nullable key, because checking for existence in an

index’s keys is less involved than returning a list of those values and comparing another value

against this list based on a comparison operator.

Likewise, the NOT EXISTS expression is another way to represent an outer join condition.

Consider the code shown in Listings 7-52 and 7-53. Both return categories that have not been

assigned to any products.

Listing 7-52. Example of a NOT EXISTS Subquery

mysql> SELECT c.name

-> FROM Category c


C H A P T E R   7   ■ E S S E N T I A L   S Q L

-> WHERE NOT EXISTS (

->  SELECT *

->  FROM Product2Category

->  WHERE category_id = c.category_id

-> );

+-------------------------+

| name                    |

+-------------------------+

| All                     |

| Action Figures          |

| Tennis Action Figures   |

| Football Action Figures |

| Video Games             |

| Shooting Video Games    |

| Sports Gear             |

+-------------------------+

7 rows in set (0.00 sec)

+-------------------------+

| name                    |

+-------------------------+

| All                     |

| Action Figures          |

| Tennis Action Figures   |

| Football Action Figures |

| Video Games             |

| Shooting Video Games    |

| Sports Gear             |

+-------------------------+

7 rows in set (0.00 sec)

Listing 7-53. Listing 7-52 Rewritten Using LEFT JOIN and IS NULL

mysql> SELECT c.name

-> FROM Category c

->  LEFT JOIN Product2Category p2c

->   ON c.category_id = p2c.category_id

-> WHERE p2c.category_id IS NULL;

As you can see, both queries return identical results. There is a special optimization that

MySQL can do with the NOT EXISTS subquery, however, because NOT EXISTS will return FALSE

as soon as the subquery finds a single row matching the condition in the subquery. MySQL, in

many circumstances, will use a NOT EXISTS optimization over a LEFT JOIN … WHERE … IS NULL

query. In fact, if you look at the EXPLAIN output from Listing 7-53, shown in Listing 7-54, you see

that MySQL has done just that.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Listing 7-54. EXPLAIN from Listing 7-53

mysql> EXPLAIN

-> SELECT c.name

-> FROM Category c

->  LEFT JOIN Product2Category p2c

->   ON c.category_id = p2c.category_id

-> WHERE p2c.category_id IS NULL \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: c

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 14

Extra:

id: 1

select_type: SIMPLE

table: p2c

type: index

possible_keys: NULL

key: PRIMARY

key_len: 8

*************************** 2. row ***************************

ref: NULL

rows: 10

Extra: Using where; Using index; Not exists

2 rows in set (0.01 sec)

Despite the ability to rewrite many NOT EXISTS subquery expressions using an outer

join, there are some situations in which you cannot do an outer join. Most of these situations

involve the aggregating of the joined table using a GROUP BY clause. Why? Because only one

GROUP BY clause is possible for a single SELECT statement, and it groups only columns that have

resulted from any joins in the statement. For instance, you cannot write the following request

as a simple outer join without using a subquery: “Retrieve the average unit price of products

that have not been purchased more than once.”

Listing 7-55 shows the SELECT statement required to get the product IDs for products that

have been purchased more than once, using the CustomerOrderItem table. Notice the GROUP BY

and HAVING clause.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

Listing 7-55. Getting Product IDs Purchased More Than Once

mysql> SELECT coi.product_id

-> FROM CustomerOrderItem coi

-> GROUP BY coi.product_id

-> HAVING COUNT(*) > 1;

+------------+

| product_id |

+------------+

|          5 |

+------------+

1 row in set (0.00 sec)

Because we want to find the average unit price (stored in the Product table), we can use a

correlated subquery in order to match against rows in the resultset from Listing 7-55. This is

necessary because we cannot place two GROUP BY expressions against two different sets of data

within the same SELECT statement.

We use a NOT EXISTS correlated subquery to retrieve products that do not appear in this

result, as Listing 7-56 shows.

Listing 7-56. Subquery of Aggregated Correlated Data Using NOT EXISTS

mysql> SELECT AVG(unit_price) as "avg_unit_price"

-> FROM Product p

-> WHERE NOT EXISTS (

->  SELECT coi.product_id

->  FROM CustomerOrderItem coi

->  WHERE coi.product_id = p.product_id

->  GROUP BY product_id

->  HAVING COUNT(*) > 1

-> );

+----------------+

| avg_unit_price |

+----------------+

| 41.140000      |

+----------------+

1 row in set (0.00 sec)

-> FROM Product p

-> WHERE product_id <> 5;

+----------------+

| avg_unit_price |

+----------------+

| 41.140000      |

+----------------+

1 row in set (0.00 sec)

mysql> SELECT AVG(unit_price) as "avg_unit_price"


C H A P T E R   7   ■ E S S E N T I A L   S Q L

We’ve highlighted where the correlating WHERE condition was added to the subquery. In

addition, we’ve shown a second query that verifies the accuracy of our top result. Since we

know from Listing 7-55 that only the product with a product_id of 5 has been sold more than

once, we simply inserted that value in place of the correlated subquery to verify our accuracy.

We demonstrate an alternate way of approaching this type of problem—where aggregates

are needed across two separate data sets—in our coverage of derived tables coming up soon.

Row and Tabular Subqueries

When subqueries use multiple columns of data, with one or more rows, a special syntax is

required. The row and tabular subquery syntax is sort of a throwback to pre-ANSI 92 days,

when joins were not supported and the only way to structure relationships in your SQL code

was to use subqueries.

When a single row of data is returned, use the following syntax:

WHERE ROW(value1, value 2, … value N)

= (SELECT column1, column2, … columnN FROM table2)

Either a column value or constant value can be used inside the ROW() constructor.4 Any num-

ber of columns or constants can be used in this constructor, but the number of values must

equal the number of columns returned by the subquery. The expression will return TRUE if all

values in the ROW() constructor to the left of the expression match the column values returned

by the subquery, and FALSE otherwise. Most often nowadays, you will use a join to represent

this same query.

Tabular result subqueries work in a similar fashion, but using the IN keyword:

WHERE (value1, value 2, … value N)

IN (SELECT column1, column2, … columnN FROM table2)

It’s almost always better to rewrite this type of tabular subquery to use a join expression

instead; in fact, this syntax is left over from an earlier period of SQL development before joins

had entered the language.

Derived Tables

A derived table is simply a special type of subquery that appears in the FROM clause, as opposed to

the SELECT or WHERE clauses. Derived tables are sometimes called virtual tables or inline views.

The syntax for specifying a derived table is as follows:

SELECT … FROM ( subquery ) as table_name

The parentheses and the as table_name are required.

4. Technically, the ROW keyword is optional. However, we feel it serves to specify that the subquery is

expected to return a single row of data, versus a columnar or tabular result.


C H A P T E R   7   ■ E S S E N T I A L   S Q L

To demonstrate the power and flexibility of derived tables, let’s revisit a correlated sub-

query from earlier (Listing 7-47):

mysql> SELECT p.name FROM Product p

-> WHERE p.unit_price < (

->  SELECT MIN(price) FROM CustomerOrderItem

->  WHERE product_id = p.product_id

-> );

While this is a cool example of how to use a correlated scalar subquery, it has one major

drawback: the subquery will be executed once for each match in the outer result (Product

table). It would be more efficient to do a single pass to find the minimum sale prices for each

unique product, and then join that resultset to the outer query. A derived table fulfills this

need, as shown in Listing 7-57.

Listing 7-57. Example of a Derived Table Query

mysql> SELECT p.name FROM Product p

-> INNER JOIN (

->  SELECT coi.product_id, MIN(price) as "min_price"

->  FROM CustomerOrderItem coi

->  GROUP BY coi.product_id

-> ) as mp

->  ON p.product_id = mp.product_id

-> WHERE p.unit_price < mp.min_price;

So, instead of inner joining our Product table to an actual table, we’ve enclosed a sub-

query in parentheses and provided an alias (mp) for that result. This result, which represents

the minimum sales price for products purchased, is then joined to the Product table. Finally, a

WHERE clause filters out the rows in Product where the unit price is less than the minimum sale

price of the product. This differs from the correlated subquery example, in which a separate

lookup query is executed for each row in Product.

Listing 7-58 shows the EXPLAIN output from the derived table SQL in Listing 7-57.

Listing 7-58. EXPLAIN Output of Listing 7-57

mysql> EXPLAIN

-> SELECT p.name FROM Product p

-> INNER JOIN (

->  SELECT coi.product_id, MIN(price) as "min_price"

->  FROM CustomerOrderItem coi

->  GROUP BY coi.product_id

-> ) as mp

->  ON p.product_id = mp.product_id

-> WHERE p.unit_price < mp.min_price \G


*************************** 1. row ***************************

C H A P T E R   7   ■ E S S E N T I A L   S Q L

id: 1

select_type: PRIMARY

table: <derived2>

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 8

Extra:

id: 1

select_type: PRIMARY

table: p

type: eq_ref

possible_keys: PRIMARY

key: PRIMARY

key_len: 4

ref: mp.product_id

rows: 1

Extra: Using where

*************************** 2. row ***************************

*************************** 3. row ***************************

id: 2

select_type: DERIVED

table: coi

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 10

Extra: Using temporary; Using filesort

3 rows in set (0.00 sec)

The EXPLAIN output clearly shows that the derived table is executed first, creating a tem-

porary resultset to which the PRIMARY query will join. Notice that the alias we used in the

statement (mp) is found in the PRIMARY table’s ref column.

For our next example, assume the following request from our sales department: “We’d like

to know the average order price for all orders placed.” Unfortunately, this statement won’t work:

mysql> SELECT AVG(SUM(price * quantity)) FROM CustomerOrderItem GROUP BY order_id;

ERROR 1111 (HY000): Invalid use of group function


C H A P T E R   7   ■ E S S E N T I A L   S Q L

We cannot aggregate over a single table’s values twice in the same call. Instead, we can use

a derived table to get our desired results, as shown in Listing 7-59.

Listing 7-59. Using a Derived Table to Sum, Then Average Across Results

mysql> SELECT AVG(order_sum)

-> FROM (

->  SELECT order_id, SUM(price * quantity) as order_sum

->  FROM CustomerOrderItem

->  GROUP BY order_id

-> ) as sums;

+----------------+

| AVG(order_sum) |

+----------------+

|     101.170000 |

+----------------+

1 row in set (0.00 sec)

Try executing the following SQL:

mysql> SELECT p.name FROM Product p

-> WHERE p.product_id IN (

->  SELECT DISTINCT product_id

->  FROM CustomerOrderItem

->  ORDER BY price DESC

->  LIMIT 2

-> );

The statement seems like it would return the product names for the two products with

the highest sale price in the CustomerOrderItem table. Unfortunately, you will get the following

unpleasant surprise:

ERROR 1235 (42000): This version of MySQL doesn't yet support \

'LIMIT & IN/ALL/ANY/SOME subquery'

At the time of this writing, MySQL does not support LIMIT expressions in certain sub-

queries, including the one in the preceding example. Instead, you can use a derived table to

get around the problem, as demonstrated in Listing 7-60.

Listing 7-60. Using LIMIT with a Derived Table

mysql> SELECT p.name

> FROM Product p

-> INNER JOIN (

->  SELECT DISTINCT product_id

->  FROM CustomerOrderItem

->  ORDER BY price DESC

->  LIMIT 2

-> ) as top_price_product

->  ON p.product_id = top_price_product.product_id;


C H A P T E R   7   ■ E S S E N T I A L   S Q L

+---------------+

| name          |

+---------------+

| Tennis Racket |

| Doll          |

+---------------+

2 rows in set (0.05 sec)

Summary

We’ve certainly covered a lot of ground in this chapter, with plenty of code examples to

demonstrate the techniques. After discussing some SQL code style issues, we presented a

review of join types, highlighting some important areas, such as using outer joins effectively.

Next, you learned how to read the in-depth information provided by EXPLAIN about your

SELECT statements. We went over how to interpret the EXPLAIN results and determine if MySQL

is constructing a properly efficient query execution plan. We stressed that most of the time, it

does. In case MySQL didn’t pick the plan you prefer to use, we showed you some techniques

using hints, which you can use to suggest that MySQL find a more effective join order or index

access strategy.

Finally, we worked through the advanced subquery and derived table offerings available

in MySQL 4.1.

In the next chapter, we build on this base knowledge, turning our attention to two more

SQL topics. First, we’ll look at how MySQL optimizes query execution and how you can

increase query speed. Then we’ll look at scenarios often encountered in application develop-

ment and administration, and some advanced query techniques you can use to solve these

common, but often complex, problems.


C H A P T E R   8

■ ■ ■

SQL Scenarios

In the previous chapter, we covered the fundamental topics of joins and subqueries, includ-

ing derived tables. In this chapter, we’re going to put those essential skills to use, focusing on

situation-specific examples. This chapter is meant to be a bridge between the basic skills

you’ve picked up so far and the advanced features of MySQL coming up in the next chapters.

The examples here will challenge you intellectually and attune you to the set-based thinking

required to move your SQL skills to the next level. However, the scenarios presented are also

commonly encountered situations, and each section illustrates solutions for these familiar

problem domains.

We hope you will use this particular chapter as a reference when the following situations

arise in your application development and maintenance work:

• OR conditions prior to MySQL 5.0

• Duplicate entries

• Orphan records

• Hierarchical data handling

• Random record retrieval

• Distance calculations with geographic coordinate data

• Running sum and average generation


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Handling OR Conditions Prior to MySQL 5.0

We mentioned in the previous chapter that if you have a lot of queries in your application that

use OR statements in the WHERE clause, you should get familiar with the UNION query. By using

UNION, you can alleviate much of the performance degradation that OR statements can place

on your SQL code.

As an example, suppose we have the table schema shown in Listing 8-1.

Listing 8-1. Location Table Definition

CREATE TABLE Location (

Code MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT

, Address VARCHAR(100) NOT NULL

, City VARCHAR(35) NOT NULL

, State CHAR(2) NOT NULL

, Zip VARCHAR(6) NOT NULL

, PRIMARY KEY (Code)

, KEY (City)

, KEY (State)

, KEY (Zip)

);

We’ve populated a table with around 32,000 records, and we want to issue the query in

Listing 8-2, which gets the number of records that are in San Diego or are in the zip code 10001.

Listing 8-2. A Simple OR Condition

mysql> SELECT COUNT(*) FROM Location WHERE city = 'San Diego' OR Zip = '10001';

+----------+

| COUNT(*) |

+----------+

|       83 |

+----------+

1 row in set (0.49 sec)

If you are running a MySQL server version before 5.0, you will see entirely different behav-

ior than if you run the same query on a 5.0 server. Listings 8-3 and 8-4 show the difference

between the EXPLAIN outputs.

Listing 8-3. EXPLAIN of Listing 8-2 on a 4.1.9 Server

mysql> EXPLAIN SELECT COUNT(*) FROM Location

-> WHERE City = 'San Diego' OR Zip = '10001' \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: Location

type: ALL

possible_keys: City,Zip


C H A P T E R   8   ■ S Q L   S C E N A R I O S

key: NULL

key_len: NULL

ref: NULL

rows: 32365

Extra: Using where

1 row in set (0.01 sec)

Listing 8-4. EXPLAIN of Listing 8-2 on a 5.0.4 Server

mysql> EXPLAIN SELECT COUNT(*) FROM Location

-> WHERE City = 'San Diego' OR Zip = '10001' \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: Location

type: index_merge

possible_keys: City,Zip

key: City,Zip

key_len: 37,6

ref: NULL

rows: 39

Extra: Using union(City,Zip); Using where

1 row in set (0.00 sec)

In Listing 8-4, you see the new index_merge optimization technique available in MySQL 5.0.

The UNION optimization essentially queries both the City and Zip indexes, returning matching

records that meet the part of the WHERE expression using the index, and then merges the two

resultsets into a single resultset.

■Note Prior to MySQL 5.0.4, you may see Using union (City, Zip) presented as Using sort_union

(City, Zip).

Prior to MySQL 5.0, a rule in the optimization process mandated that no more than one

index could be used in any single SELECT statement or subquery. With the new Index Merge opti-

mization, this rule is thrown away, and some queries, particularly ones involving OR conditions

in the WHERE clause, can employ more than one index to quickly retrieve the needed records.

However, with MySQL versions prior to 5.0, you will see EXPLAIN results similar to those in

Listing 8-3, which shows a nonexistent optimization process: the optimizer has chosen to dis-

regard both possible indexes referenced by the WHERE clause and perform a full-table scan to

fulfill the query.

If you find yourself running these types of queries against a pre-5.0 MySQL installation,

don’t despair. You can play a trick on the MySQL server to get the same type of performance as

that of the Index Merge optimization.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

By using a UNION query with two separate SELECT statements on each part of the OR condi-

tion of Listing 8-2, you can essentially mimic the Index Merge behavior. Listing 8-5 shows how

to do this.

Listing 8-5. A UNION Query Resolves the Problem

mysql> SELECT COUNT(*) FROM Location WHERE City = 'San Diego'

-> UNION ALL

-> SELECT COUNT(*) FROM Location WHERE Zip = '10001';

Listing 8-6 shows the EXPLAIN indicating the improved query execution plan generated by

Listing 8-6. EXPLAIN from Listing 8-5

mysql> EXPLAIN

-> SELECT COUNT(*) FROM Location WHERE City = 'San Diego'

-> UNION ALL

-> SELECT COUNT(*) FROM Location WHERE Zip = '10001' \G

*************************** 1. row ***************************

+----------+

| COUNT(*) |

+----------+

|       81 |

|        2 |

+----------+

2 rows in set (0.00 sec)

MySQL 4.1.9.

id: 1

select_type: PRIMARY

table: Location

type: ref

possible_keys: City

key: City

key_len: 37

id: 2

select_type: UNION

table: Location

type: ref

possible_keys: Zip

key: Zip

key_len: 8

ref: const

rows: 60

Extra: Using where; Using index

*************************** 2. row ***************************

ref: const

rows: 2

Extra: Using where; Using index


*************************** 3. row ***************************

C H A P T E R   8   ■ S Q L   S C E N A R I O S

id: NULL

select_type: UNION RESULT

table: <union1,2>

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: NULL

Extra:

3 rows in set (0.11 sec)

As you can tell from Listing 8-6, the optimizer has indeed used both indexes (with a const

reference) in order to pull appropriate records from the table. The third row set in the EXPLAIN

output is simply informing you that the two results from the first and second SELECT state-

ments were combined.

However, we still have one problem. Listing 8-5 has produced two rows in our resultset.

We really only want a single row with the count of the number of records meeting the WHERE

condition. In order to get such a result, we must wrap the UNION query as a derived table (intro-

duced in Chapter 7) from Listing 8-5 in a SELECT statement containing a SUM() of the results

returned by the UNION. We use SUM() because COUNT(*) would return the number 2, as there are

two rows in the resultset. Listing 8-7 shows the final query.

Listing 8-7. Using a Derived Table for an OR Condition

mysql> SELECT SUM(rowcount) FROM (

-> SELECT COUNT(*) AS rowcount FROM Location WHERE City = 'San Diego'

-> UNION ALL

-> SELECT COUNT(*) AS rowcount FROM Location WHERE Zip = '10001'

-> ) AS tmp;

+---------------+

| SUM(rowcount) |

+---------------+

|            83 |

+---------------+

1 row in set (0.06 sec)

Dealing with Duplicate Entries and Orphaned Records

The next scenarios represent two problems that most developers will run into at some point

or another: duplicate entries and orphaned records. Sometimes, you will inherit these prob-

lems from another database design team. Other times, you will design a schema that has flaws

allowing for the corruption or duplication of data. Both dilemmas occur primarily because of

poor database design or the lack of proper constraints on your tables. Here, we’ll focus on how

to correct the situation and prevent it from happening in the future.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Identifying and Removing Duplicate Entries

In the case of duplicate data, you need to be able to identify those records that contain redun-

dant information and remove those entries from your tables.

As an example, imagine that we’ve been given a dump file of a table containing RSS feed

entries related to job listings. A reader system has been reading RSS feeds from various sources

and inserting records into the main RssEntry table. Figure 8-1 shows the E-R diagram for our

sample tables, and Listing 8-8 shows the CREATE statements for the RssEntry and RssFeed tables.

RssEntry

RssFeed

rowID

rssID

url

title

description

rssID

sitename

siteurl

Figure 8-1. Initial E-R diagram for the RSS tables

Listing 8-8. Initial Schema for the Duplicate Data Scenario

CREATE TABLE RssFeed (

rssID INT NOT NULL AUTO_INCREMENT

, sitename VARCHAR(254) NOT NULL

, siteurl VARCHAR(254) NOT NULL

, PRIMARY KEY (rssID)

CREATE TABLE RssEntry (

rowID INT NOT NULL AUTO_INCREMENT

, rssID INT NOT NULL

, url VARCHAR(254) NOT NULL

, title TEXT

, description TEXT

, PRIMARY KEY (rowID)

, INDEX (rssID)

);

);

After loading the dump file containing around 170,000 RSS entries, we decide that each

RSS entry really should have a unique URL. So, we go about setting up a UNIQUE INDEX on the

RssEntry.url field, like this:

mysql> CREATE UNIQUE INDEX Url ON RssEntry (Url);

ERROR 1062 (23000): Duplicate entry 'http://salesheads.4Jobs.com/JS/General/Job.asp\

?id=3931558&aff=FE' for key 2


C H A P T E R   8   ■ S Q L   S C E N A R I O S

MySQL runs for a while, and then spits out an error. It seems that the RssEntry table has

some duplicate entries. The only constraint on the table—an AUTO_INCREMENT PRIMARY KEY—

offers no protection against duplicate URLs being inserted into the table. The reader has

apparently just been dumping records into the table, without checking to see if there is an

identical record already in it. Before adding a UNIQUE constraint on the url field, we must elim-

inate these redundant records. However, first, we’ll add a non-unique index on the rowID and

url fields of RssEntry, as shown in Listing 8-9. As you’ll see shortly, this index helps to speed

up some of the queries we’ll run.

■Tip When doing work to remove duplicate entries from a table with a significant number of rows, adding

a temporary, non-unique index on the columns in question can often speed up operations as you go about

removing duplicate entries.

Listing 8-9. Adding a Non-Unique Index to Speed Up Queries

mysql> CREATE INDEX UrlRow ON RssEntry (Url, rowID);

Query OK, 166170 rows affected (5.19 sec)

Records: 166170  Duplicates: 0  Warnings: 0

The first thing we want to determine is exactly how many duplicate records we have in

our table. To do so, we use the COUNT(*) and COUNT(DISTINCT field) expressions to determine

how many URLs appear in more than one record, as shown in Listing 8-10.

Listing 8-10. Determining How Many Duplicate URLs Exist in the Data Set

mysql> SELECT COUNT(*), COUNT(*) - COUNT(DISTINCT url) FROM RssEntry;

+----------+--------------------------------+

| COUNT(*) | COUNT(*) - COUNT(DISTINCT url) |

+----------+--------------------------------+

|   166170 |                           8133 |

+----------+--------------------------------+

1 row in set (1.90 sec)

Subtracting COUNT(*) from COUNT(DISTINCT url) gives us the number of duplicate URLs

in our RssEntry table. With more than 8,000 duplicate rows, we have our work cut out for us.

Now that we know the number of duplicate entries, we next need to get a resultset of the

unique entries in the table. When retrieving a set of unique results from a table containing

duplicate entries, you must first decide which of the records you want to keep. In this situa-

tion, let’s assume that we’re going to keep the rows having the highest rowID value, and we’ll

discard the rest of the rows containing an identical URL.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

■Tip When removing duplicate entries from a table, first determine which rows having duplicate keys you

wish to keep in the table. For instance, if you are removing a duplicate customer record, will you take the

oldest or newest record? Or will you need to merge the two records? Be sure you have a game plan for what

to do with the redundant data records.

To get a list of these unique entries, we use a GROUP BY expression to group the records

in RssEntry along the URL, and find the highest rowID for records containing that URL. We’ll

insert these unique records into a new table containing a unique index on the url field, and

then rename the original and new tables. Listing 8-11 shows the SELECT statement we’ll use to

get the unique URL records.

Listing 8-11. Using GROUP BY to Get Unique URL Records

mysql> SELECT MAX(rowID) AS rowID, url FROM RssEntry GROUP BY Url;

... omitted

| 114038 | http://www.zend.com/jobs/single_job.php?id=811                |

| 114039 | http://www.zend.com/jobs/single_job.php?id=812                |

| 114040 | http://www.zend.com/jobs/single_job.php?id=813                |

+--------+---------------------------------------------------------------+

158037 rows in set (3.13 sec)

As you can see, the query produces 158,037 rows, which makes sense. In Listing 8-10, we

saw that the number of duplicates was 8,133, compared to a total record count of 166,170.

Subtracting 8,133 from 166,170 yields 158,037.

Remember the index we added in Listing 8-9? We did so specifically to aid in the query

shown in Listing 8-11. Without the index, on our machine the same query took around six

minutes to complete. (Your mileage may vary, of course.)

So, now that we have a resultset of unique records, the last step is to create a new table con-

taining the unique records from the original RssEntry table. Listing 8-12 completes the circle.

Listing 8-12. Creating a New Table with the Unique Records

mysql> CREATE TABLE RssEntry2 (

->   rowID INT NOT NULL AUTO_INCREMENT

-> , rssID INT NOT NULL

-> , title VARCHAR(255) NOT NULL

-> , url VARCHAR(255) NOT NULL

-> , description TEXT

-> , PRIMARY KEY (rowID)

-> , UNIQUE INDEX Url (url));

Query OK, 0 rows affected (0.37 sec)


C H A P T E R   8   ■ S Q L   S C E N A R I O S

mysql> INSERT INTO RssEntry2

-> SELECT * FROM RssEntry

-> INNER JOIN (

->  SELECT MAX(rowID) AS rowID, url

->  FROM RssEntry

->  GROUP BY url

-> ) AS uniques

->  ON RssEntry.rowID = uniques.rowID;

Query OK, 158037 rows affected (11.42 sec)

Records: 158037  Duplicates: 0  Warnings: 0

mysql> ALTER TABLE RssEntry RENAME TO RssEntry_old;

Query OK, 0 rows affected (0.01 sec)

mysql> ALTER TABLE RssEntry2 RENAME TO RssEntry;

Query OK, 0 rows affected (0.00 sec)

If we wanted to drop the old table, we could have done so. Depending on your situation

when you’re dealing with duplicate records, you may or may not want to keep the original

table. As a fail-safe, you may choose to preserve the old table, just in case your queries failed

to produce the required results.

■Note Some readers may have noticed that we could have also done a multitable DELETE statement,

joining our unique resultset to the RssEntry table and removing nonmatching records. This is true, however,

we wanted to demonstrate the table-switching method, because it often performs better for large table sets.

We’ll demonstrate the multitable DELETE method in the next section.

Identifying and Removing Orphaned Records

A more sinister data integrity problem than duplicate records is that of orphaned, or unat-

tached, records. The symptoms of this situation often rear their ugly heads as inexplicable

report data. For example, a manager comes to you asking about a strange item in a summary

report that doesn’t match up to a detail report’s results. Other times, you might stumble across

orphaned records while performing ad hoc queries. Your job is to identify those orphaned

records and remove them.

To demonstrate how to handle orphaned records, we’ll use the same schema that we

used in the previous section (see Figure 8-1 and Listing 8-8). Listing 8-13 shows a series of

SQL statements to select and count records. We begin with a simple summary SELECT that ref-

erences the RssFeed table from the RssEntry table for a range of rssID values in the RssEntry

table, and counts the number of entries in the RssEntry table, along with the sitename field

from the RssFeed table. Then we show a simple count of the rows found for the same range in

the RssEntry table, without referencing the RssFeed table. Notice that the counts are the same

for each result.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Listing 8-13. Two Simple Reports Showing Identical Counts

mysql> SELECT sitename, COUNT(*)

-> FROM RssEntry re

->  INNER JOIN RssFeed rf

->   ON re.rssID = rf.rssID

-> WHERE re.rssID BETWEEN 420 AND 425

-> GROUP BY sitename;

+--------------+----------+

| sitename     | COUNT(*) |

+--------------+----------+

| pickajob.com |      985 |

+--------------+----------+

1 row in set (0.40 sec)

mysql> SELECT COUNT(*) FROM RssEntry

-> WHERE rssID BETWEEN 420 AND 425;

+----------+

| COUNT(*) |

+----------+

|      985 |

+----------+

1 row in set (0.01 sec)

Now, let’s corrupt our tables by removing a parent record from the RssFeed table, leaving

records in the RssEntry referencing a nonexistent parent rssID value. We’ll delete the parent

record in RssFeed for the rssID = 424:

mysql> DELETE FROM RssFeed WHERE rssID = 424;

Query OK, 1 row affected (0.43 sec)

What happens when we rerun the same statements from Listing 8-13? The results are

shown in Listing 8-14.

Listing 8-14. Mismatched Reports Due to a Missing Parent Record

mysql> SELECT sitename, COUNT(*)

-> FROM RssEntry re

->  INNER JOIN RssFeed rf

->   ON re.rssID = rf.rssID

-> WHERE re.rssID BETWEEN 420 AND 425

-> GROUP BY sitename;

+--------------+----------+

| sitename     | COUNT(*) |

+--------------+----------+

| pickajob.com |      850 |

+--------------+----------+

1 row in set (0.00 sec)


C H A P T E R   8   ■ S Q L   S C E N A R I O S

mysql> SELECT COUNT(*) FROM RssEntry WHERE rssID BETWEEN 420 AND 425;

+----------+

| COUNT(*) |

+----------+

|      985 |

+----------+

1 row in set (0.00 sec)

Notice how the count of records in the first statement has changed, because the reference

to RssFeed on the rssID = 424 key has been deleted. Both reports should show the same num-

bers, but because a parent has been removed, the reports show mismatched data. The rows in

RssEntry matching rssID = 424 are now orphaned records.

This is a particularly sticky problem because the report results seem to be accurate until

someone points out the mismatch. If you have a summary report containing thousands of line

items, and detail reports containing hundreds of thousands of items, this kind of data prob-

lem can be almost impossible to detect.

But, you say, if we had used the InnoDB storage engine, we wouldn’t have had this prob-

lem, because we could have placed a FOREIGN KEY constraint on the rssID field of the RssEntry

table! But we specifically chose to use the MyISAM storage engine here for a reason: it is the

only storage engine capable of using FULLTEXT indexing.1

As you learned in Chapter 7, you can use an outer join to identify records in one table that

have no matching records in another table. In this case, we want to identify those records from

the RssEntry table that have no valid parent record in the RssFeed table. Listing 8-15 shows the

SQL to return these records.

Listing 8-15. Identifying the Orphaned Records with an Outer Join

mysql> SELECT re.rowID, LEFT(re.title, 50) AS title

-> FROM RssEntry re

->  LEFT JOIN RssFeed rf

->   ON re.rssID = rf.rssID

-> WHERE rf.rssID IS NULL;

+--------+----------------------------------------------------+

| rowID  | title                                              |

+--------+----------------------------------------------------+

|  27008 | Search Consultant (Louisville, KY)                 |

|  22377 | Enterprise Java Developer (Frankfort, KY)          |

... omitted

| 136167 | JavaJ2ee leadj2ee architects (Fort Knox, KY)       |

| 137709 | Documentum Architect (Louisville, KY)              |

+--------+----------------------------------------------------+

135 rows in set (1.44 sec)

As you can see, the query produces the 135 records that had been orphaned when we

deleted the parent record from RssFeed.

1.

In future versions of MySQL, FULLTEXT indexing may be supported by more storage engines. However,

as we go to press, InnoDB does not currently support it.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Just as with duplicate records, it is important to have a policy in place for how to handle

orphaned records. In some rare cases, it may be acceptable to leave orphaned records alone;

however, in most circumstances, you’ll want to remove them, as they endanger reporting

accuracy and the integrity of your data store. Listing 8-16 shows how to use a multitable

DELETE to remove the offending records.

Listing 8-16. A Multitable DELETE Statement to Remove Orphaned Records

mysql> DELETE RssEntry FROM RssEntry

-> INNER JOIN (

->  SELECT re.rowID FROM RssEntry re

->  LEFT JOIN RssFeed rf

->  ON re.rssID = rf.rssID

->  WHERE rf.rssID IS NULL

-> ) AS orphans

->  ON RssEntry.rowID = orphans.rowID;

Query OK, 135 rows affected (1.52 sec)

Multitable DELETE statements require you to explicitly state which table’s records you

intend to delete. In Listing 8-16, we explicitly tell MySQL we want to remove the records

from the RssEntry table. We then perform an inner join on a derived table containing the outer

join from Listing 8-15, referencing the rowID column (join and derived table techniques are

detailed in Chapter 7). As expected, the query removes the 135 rows from RssEntry correspon-

ding to our orphaned records. Listing 8-17 shows a quick repeat of our initial report queries

from Listing 8-13, verifying that the referencing summary report contains counts matching a

nonreferencing query.

Listing 8-17. Verifying That the DELETE Statement Removed the Orphaned Records

mysql> SELECT sitename, COUNT(*)

-> FROM RssEntry re

->  INNER JOIN RssFeed rf

-> ON re.rssID = rf.rssID

-> WHERE re.rssID BETWEEN 420 AND 425

-> GROUP BY sitename;

+--------------+----------+

| sitename     | COUNT(*) |

+--------------+----------+

| pickajob.com |      850 |

+--------------+----------+

1 row in set (0.00 sec)

mysql> SELECT COUNT(*) FROM RssEntry

-> WHERE rssID BETWEEN 420 AND 425;

+----------+

| COUNT(*) |

+----------+

|      850 |

+----------+

1 row in set (0.00 sec)


C H A P T E R   8   ■ S Q L   S C E N A R I O S

MULTITABLE DELETES PRIOR TO MYSQL 4.0

One of the most frustrating facets of MySQL development before version 4.0 involved removing many-to-

many relationships properly. Before MySQL 4.0, you would need to create a script similar to the following in

order to delete a many-to-many relationship:

<?php

// Connect to database. . .

$products = mysql_query("SELECT product_id FROM Product2Category

WHERE category_id = 5");

if ($products) {

$deletes = array();

while ($product = mysql_fetch_row($products)) {

array_push($deletes, $product[0]);

}

mysql_query("DELETE FROM Product WHERE product_id

IN (" . implode("','", $deletes) . ")");

mysql_query("DELETE FROM Product2Category WHERE category_id = 5");

}

?>

Notice that we needed to build a query to return the product IDs in category 5, and then execute two

DELETE statements: one to remove the parent and another to remove the children in Product2Category.

No temporary table solution is possible, because a join or subquery is not available in the DELETE statement

before MySQL 4.0.

Dealing with Hierarchical Data

In this section, we’ll look at some issues regarding dealing with hierarchical, or tree-like, data

in SQL. For these examples, we’ll use a part of our sample schema from Chapter 7, as shown in

Figure 8-2. We’ll use many of the techniques covered in that chapter, as well.

Product

product_id

sku

name

description

weight

unit_price

Product2Category

product_id

category_id

Category

category_id

parent_id NULL

name

description

left_side

right_side

Figure 8-2. Section of sample schema for hierachical data examples


C H A P T E R   8   ■ S Q L   S C E N A R I O S

The data we’ll be working with predominantly is the Category table. In order for you to get

a visual feel for what we’re doing, we’ve made a diagram of the relationship of the rows in this

table, as shown in Figure 8-3. We’ll use this figure to graphically explain the SQL contained in

this section. You’ll notice that the category_id value for each row, or node in tree-based lan-

guage, is displayed along with the category name.

Action Figures

category_id = 2

Video Games

category_id = 7

Sports Gear

category_id = 11

Dolls

category_id = 14

Root Node

category_id = 1

Racing Video

Games

category_id = 8

Sports Video

Games

category_id = 9

Shooting Video

Games

category_id = 10

Soccer Equipment

category_id = 12

Tennis Equipment

category_id = 13

Sport Action

Figures

category_id = 3

Historical Action

Figures

category_id = 6

Tennis Action

Figures

category_id = 4

Football Action

Figures

category_id = 5

Figure 8-3. Diagram of the category tree

You can use a number of techniques to store and retrieve tree-like structures in a relational

database management system. SQL itself is generally poorly suited for handling tree-based struc-

tures, as the language is designed to work on two-dimensional sets of data, not hierarchical ones.

SQL’s lack of certain structures and processes, like arrays and recursion, sometimes make these

various techniques seem like “hacks.” Although there is some truth to this observation, we’ll

present a technique that we feel demonstrates the most set-based way of handling the problems

inherent with hierarchical data structures in SQL. This technique is commonly referred to as the

nested set model.2

The nested set model technique emphasizes having the programmer update metadata

about the tree at the time of insertion or deletion of nodes. This metadata alleviates the need

for recursion in most aggregating queries across the tree, and thus can significantly speed up

query performance in large data sets.

2. The nested set model was made popular by a leading SQL mind, Joe Celko, author of SQL for Smarties,

among other titles.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

THE ADJACENCY LIST AND PATH ENUMERATION MODELS

Perhaps the most common technique for dealing with trees in SQL is called the adjacency list model. In

Chapter 7, you saw an example of this technique when we covered the self join. In the adjacency list model,

you have two fields in a table corresponding to the ID of the row and the ID of its parent. You use the parent

ID value to traverse the tree and find child nodes. Unfortunately, this technique has one major flaw: it requires

recursion in order to “walk” through the hierarchy of nodes. To find all the children of a specific node in the

tree, the programmer must make repeated SELECTs against the children of each child node in the tree.

When the depth of the tree (number of levels of the hierarchy) is not known, the programmer must use a

cursor (either a client-side or server-side cursor, as described in Chapter 11) and repeatedly issue SELECTs

against the same table.

Another technique, commonly called the path enumeration model, stores a literal path to the node

within a field in the table. While this method can save some time, it is not very flexible and can lead to fairly

obscure and poorly performing SQL code.

We encourage you to read about these methods, as your specific data model might be best served by

these techniques. Additionally, reading about them will no doubt make you a more rounded SQL developer.

For those interested in hierarchies and trees in SQL, we recommend picking up a copy of Joe Celko’s Trees

and Hierarchies in SQL for Smarties (Morgan Kaufmann, 2004). The book is highly rooted in the mathematical

foundations for SQL models of tree structures, and is not for the faint of heart.

Understanding the Nested Set Model

The nested set technique uses a method of storing metadata about the nodes contained in the

tree in order to provide the SQL parser with information about how to “walk” the hierarchy of

nodes. In our example, this metadata is stored in the two fields of Category labeled left_side

and right_side. These fields store values that represent the left and right bounds of the part of

the category tree that the row in Category represents.

The trick to the nested set model is that these two fields must be kept up-to-date as

changes to the hierarchy occur. If these two fields are maintained, we can assume that for

any given row in the table, we can find all children of that Category by looking at rows with

left_side values between the parent node’s left_side and right_side values. This is a critical

aspect of the nested set model, as it alleviates the need for a recursive technique to find all

children, regardless of the depth of the tree.

The nested set model gives the following rules regarding how the left and right numbers

are calculated:

• For the root node in the hierarchy, the left_side value will always be 1, and the

right_side value is calculated as 2*n where n is the number of nodes in the tree.

• For all other nodes, the right_side value will equal the left_side + (2*n) + 1, where n is

the total number of child nodes. Thus, for the leaf nodes (nodes without children), the

right_side value will always be equal to the left_side value + 1.

The second rule may sound a bit tricky, but, it really isn’t. If you think of each node in

the tree as having a left_side and right_side value, these values of each node are ordered

counter-clockwise, as illustrated in Figure 8-4. The process of determining left_side and

right_side values will become clear as we cover inserting and removing nodes from the tree


C H A P T E R   8   ■ S Q L   S C E N A R I O S

in the upcoming examples. For right now, take a look at Figure 8-4 to get a feel for the pattern

by which the left and right values are generated. Remember that for each node, the left and

right value of all child nodes must fall between the left and right value of the parent node.

Root Node

category_id = 1

Action Figures

category_id = 2

Video Games

category_id = 7

Sports Gear

category_id = 11

Dolls

category_id = 14

Sport Action

Figures

category_id = 3

Racing Video

Games

category_id = 8

Sports Video

Games

category_id = 9

Soccer Equipment

category_id = 12

Tennis Equipment

category_id = 13

Tennis Action

Figures

category_id = 4

Football Action

Figures

category_id = 5

Shooting Video

Games

category_id = 10

Historical Action

Figures

category_id = 6

Figure 8-4. Diagram of the category tree, showing left_side and right_side values

Listing 8-18 shows all the data we’ll be working with in the Category table. Use this listing,

along with Figure 8-4, to follow along with the upcoming examples.

Listing 8-18. The Category Table Data

mysql> SELECT category_id, name, left_side, right_side FROM Category;

+-------------+---------------------------+-----------+------------+

| category_id | name                      | left_side | right_side |

+-------------+---------------------------+-----------+------------+

|           1 | All                       |         1 |         28 |

|           2 | Action Figures            |         2 |         11 |

|           3 | Sport Action Figures      |         3 |          8 |

|           4 | Tennis Action Figures     |         4 |          5 |

|           5 | Football Action Figures   |         6 |          7 |

|           6 | Historical Action Figures |         9 |         10 |

|           7 | Video Games               |        12 |         19 |

|           8 | Racing Video Games        |        13 |         14 |

|           9 | Sports Video Games        |        15 |         16 |

|          10 | Shooting Video Games      |        17 |         18 |

|          11 | Sports Gear               |        20 |         25 |

|          12 | Soccer Equipment          |        21 |         22 |

|          13 | Tennis Equipment          |        23 |         24 |

|          14 | Dolls                     |        26 |         27 |

+-------------+---------------------------+-----------+------------+

14 rows in set (0.00 sec)


Now, you’re ready to look at how to accomplish the following common chores using the

C H A P T E R   8   ■ S Q L   S C E N A R I O S

nested set technique:

• Find the depth of a node

• Find all nodes under a specific parent

• Find all nodes above a specific node

• Summarize across the tree

• Insert a node into the tree

• Remove a node from the tree

Finding the Depth of a Node

One of the first tasks you will run into with hierarchical data is how to find the depth of the

tree as a whole, or the depth of a single node within the tree. In our Category example data,

you might want to know how many levels there are in the category tree—how far down does

the tree go? In Figure 8-3, you can see that currently, our category tree has four levels, with the

root node being level 1.

Using the nested set method, you compare two sets of the same information against each

other using the left and right side values. To get the depth of any node in the hierarchy, compare

the base table, which we’ll call set A, against a subset (or nested set) of the same data, which we’ll

refer to as set B. For each value in set A, you know that the level of each row is equal to the num-

ber of elements in set B in which the left side value of set A falls between the left and right side

values of set B.

Let’s take the first two rows in Category, and work through the equation:

• For the root node, we know the left_side = 1. We look for the number of rows in

Category where the number 1 falls between the left_side and right_side values of

the row. We find only one row: the root node itself. All other rows have a left_side value

greater than 1, and so do not meet the BETWEEN expression’s criteria. Therefore, the root

node is at level 1.

• For the next node (category_id = 2), we know the left_side = 2. We look for the number

of rows in Category where the number 2 falls between the left_side and right_side

values of the row. We find two rows: the root node (1 => 2 <= 28) and the current node

itself (2 => 2 <= 9). All other rows have a left_side value > 2, and so do not meet the

BETWEEN expression’s criteria.

Following through this logic, we can deduce the SQL shown in Listing 8-19, which outputs

the level of the hierarchy at which each node happens to reside.

Listing 8-19. Finding the Level of a Node in the Tree

mysql> SELECT c1.name, COUNT(*) AS level

-> FROM Category c1

-> INNER JOIN Category c2

-> ON c1.left_side BETWEEN c2.left_side AND c2.right_side

-> GROUP BY c1.name;


C H A P T E R   8   ■ S Q L   S C E N A R I O S

+---------------------------+-------+

| name                      | level |

+---------------------------+-------+

| All                       |     1 |

| Action Figures            |     2 |

| Sport Action Figures      |     3 |

| Tennis Action Figures     |     4 |

| Football Action Figures   |     4 |

| Historical Action Figures |     2 |

| Video Games               |     2 |

| Racing Video Games        |     3 |

| Sports Video Games        |     3 |

| Shooting Video Games      |     3 |

| Sports Gear               |     2 |

| Soccer Equipment          |     3 |

| Tennis Equipment          |     3 |

| Dolls                     |     2 |

+---------------------------+-------+

14 rows in set (0.03 sec)

Look carefully at Listing 8-19. The relationship between c1 and c2 is critical. We’re com-

paring two copies of the Category table with each other using the BETWEEN clause. We’ll be

using this type of join in the rest of these examples, so make sure you understand what is

going on here. The nesting of sets is occurring along the left_side and right_side values.

As you’ll see, we can derive almost any information about our hierarchy by making slight

adjustments to the query style used in Listing 8-19.

How would we determine the depth of the tree as a whole? Well, the depth of the entire tree

is equal to the maximum level returned by the query in Listing 8-19, as shown in Listing 8-20.

Listing 8-20. Getting the Total Depth of the Tree

mysql> SELECT MAX(level) FROM

-> (

->  SELECT c1.category_id, COUNT(*) AS level

->  FROM Category c1

->  INNER JOIN Category c2

->  ON c1.left_side BETWEEN c2.left_side AND c2.right_side

->  GROUP BY c1.category_id

-> ) AS derived;

+------------+

| MAX(level) |

+------------+

|          4 |

+------------+

1 row in set (0.16 sec)


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Finding All Nodes Under a Specific Parent

When dealing with hierarchical data, you may wish to find all the children under a specified

node. For instance, what if we wanted to find all subcategories belonging to the Sport Action

Figures category? If you look back to Figure 8-4, you’ll see that both the Tennis Action Figures

and Football Action Figures categories are contained in the Sport Action Figures category.

Listing 8-21 shows how to retrieve all child nodes under a specified parent.

Listing 8-21. Finding All Child Nodes Under a Parent Node

mysql> SELECT c1.name, c1.description

-> FROM Category c1

-> INNER JOIN Category c2

-> ON c1.left_side BETWEEN c2.left_side AND c2.right_side

-> WHERE c2.category_id = 3

-> AND c1.category_id <> 3;

+-------------------------+-------------------------+

| name                    | description             |

+-------------------------+-------------------------+

| Tennis Action Figures   | Tennis Action Figures   |

| Football Action Figures | Football Action Figures |

+-------------------------+-------------------------+

2 rows in set (0.08 sec)

If you want to retrieve a node itself and all its children, simply remove the WHERE expres-

sion for c1.category_id <> 3, as shown in Listing 8-22.

Listing 8-22. Retrieving a Node and All Its Children

mysql> SELECT c1.name, c1.description

-> FROM Category c1

-> INNER JOIN Category c2

-> ON c1.left_side BETWEEN c2.left_side AND c2.right_side

-> WHERE c2.category_id = 3;

+-------------------------+---------------------------------------+

| name                    | description                           |

+-------------------------+---------------------------------------+

| Sport Action Figures    | All Types of Action Figures in Sports |

| Tennis Action Figures   | Tennis Action Figures                 |

| Football Action Figures | Football Action Figures               |

+-------------------------+---------------------------------------+

3 rows in set (0.03 sec)

Finding All Nodes Above a Specific Node

Other times, you may be interested in finding nodes in the tree that correspond to parents of a

specific node. Let’s suppose that we want to get a list of all categories from which the Football

Action Figures category derived. We use the inverse of our query in Listing 8-21 to return the

results of set B (c2), instead of set A (c1), as Listing 8-23 demonstrates.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Listing 8-23. Finding All Parent Nodes

mysql> SELECT c2.name, c2.description

-> FROM Category c1

->  INNER JOIN Category c2

->   ON c1.left_side BETWEEN c2.left_side AND c2.right_side

-> WHERE c1.category_id = 5

-> AND c2.category_id <> 5;

+----------------------+---------------------------------------+

| name                 | description                           |

+----------------------+---------------------------------------+

| All                  | All Categories                        |

| Action Figures       | All Types of Action Figures           |

| Sport Action Figures | All Types of Action Figures in Sports |

+----------------------+---------------------------------------+

3 rows in set (0.08 sec)

We’ve highlighted the areas of the query that changed from Listing 8-21. Notice we did

not change the relationship between the two data sets—the ON condition. What changed was

which side of the join we returned.

Summarizing Across the Tree

Let’s go a step further and get some more meaningful information out of MySQL. Let’s assume

our operations manager presented this request: “Provide product names, total number of

items sold, and total sales for all Sports Gear categories.”

To break this request down, we first know that we will need to get the category IDs of all

our Sports Gear categories, including the parent Sports Gear category. Listing 8-22 has already

done most of this work for us; we simply need to return the category_id value, instead of the

name and description values, and change the category_id to that of the Sports Gear category

node, as shown in Listing 8-24.

Listing 8-24. Retrieving All Sports Gear Categories and Subcategory IDs

mysql> SELECT c1.category_id

-> FROM Category c1

->  INNER JOIN Category c2

->  ON c1.left_side BETWEEN c2.left_side AND c2.right_side

->  WHERE c2.category_id = 11;

+-------------+

| category_id |

+-------------+

|           11|

|           12|

|           13|

+-------------+

3 rows in set (0.03 sec)


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Next, we want to use the many-to-many relationship in the Product2Category table in

order to join the CustomerOrderItem table, which houses our sales information. Listing 8-25

shows the join. Notice we use the query in Listing 8-24 as a derived table inner-joined to

Product2Category in order to retrieve the appropriate products matching the needed categories.

Listing 8-25. Getting Sales for Products Within a Node of a Tree

mysql> SELECT

->   p.name AS Product

->   , SUM(coi.quantity) AS ItemsSold

->   , SUM(coi.quantity * coi.price) AS TotalSales

-> FROM Product p

->  INNER JOIN CustomerOrderItem coi

->   ON p.product_id = coi.product_id

->  INNER JOIN Product2Category p2c

->   ON p.product_id = p2c.product_id

->  INNER JOIN (

->   SELECT c1.category_id

->   FROM Category c1

->    INNER JOIN Category c2

->    ON c1.left_side BETWEEN c2.left_side AND c2.right_side

->    WHERE c2.category_id = 11

->  ) AS c

->   ON p2c.category_id = c.category_id

-> GROUP BY p.name;

+---------------+-----------+------------+

| Product       | ItemsSold | TotalSales |

+---------------+-----------+------------+

| Soccer Ball   |         1 |      23.70 |

| Tennis Balls  |        57 |     270.75 |

| Tennis Racket |         1 |     104.75 |

+---------------+-----------+------------+

3 rows in set (0.03 sec)

The query in Listing 8-25 is merely a combination of elements you’ve learned about so far.

We’re following the relationships from three tables back to a set of category IDs we’ve generated

using our nested set model.

Now, let’s see what happens to our SQL if we are asked to fulfill this request: “Provide the

total number of products in our catalog for each category. For parent categories, provide

aggregated numbers.”

When you see a request for aggregated numbers, you know that you’ll be summing informa-

tion using the SUM() and COUNT() functions. However, in this request, we’ve been asked to provide

a special type of aggregation, known as a rollup (because you’re “rolling up” subcategories into

their parent categories). To accomplish this, we’re going to use the inverse technique described

earlier in the “Finding All Nodes Above a Specific Node” section. Take a look at Listing 8-26.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Listing 8-26. Finding Aggregated Totals

mysql> SELECT c2.category_id, c2.name, COUNT(*) AS products

-> FROM Category c1

->  INNER JOIN Category c2

->   ON c1.left_side BETWEEN c2.left_side AND c2.right_side

->  INNER JOIN Product2Category p2c

->   ON c1.category_id = p2c.category_id

-> GROUP BY c2.category_id;

+-------------+---------------------------+----------+

| category_id | name                      | products |

+-------------+---------------------------+----------+

|           1 | All                       |       10 |

|           2 | Action Figures            |        3 |

|           3 | Sport Action Figures      |        2 |

|           6 | Historical Action Figures |        1 |

|           7 | Video Games               |        3 |

|           8 | Racing Video Games        |        1 |

|           9 | Sports Video Games        |        2 |

|          11 | Sports Gear               |        3 |

|          12 | Soccer Equipment          |        1 |

|          13 | Tennis Equipment          |        2 |

|          14 | Dolls                     |        1 |

+-------------+---------------------------+----------+

11 rows in set (0.00 sec)

Again, the trick is knowing which set (either c2 or c1) to return in the resultset. The set that

is returned determines the aggregation of the resultset. In the case of rollups, you want to return

the data set B (c2), which represents the part of the tree including and above the current node in

the join. Note how we use a GROUP BY expression on the c2 set’s category_id values, and use the

COUNT(*) function to return the number of products in the Product2Category table that match

c2’s category_id value. If you don’t understand the logic, work slowly through the SQL, writing

down each set of data and how the join will match certain values. It’s important that you under-

stand the way the data sets relate through the BETWEEN operator. We’ll be returning to this

concept later in this chapter, in the “Generating Running Sums and Averages” section.

For our final query in this section, let’s bring together our two requests: “Provide a list of

all categories, with sales totals for each category. Include rollups for each parent category, and

indent each subcategory appropriately from the root node by the number of levels deep.”

Although it sounds complex, this request is really a simple adaptation of our last query,

along with a trick you learned in the previous section about determining the node depth.

Instead of finding counts of products with the Product2Category table, we’re going to use it to

join to CustomerOrderItem to get our sales totals. Listing 8-27 shows the SQL for this request.

Listing 8-27. Sales Rollup Report by Category

mysql> SELECT

->  CONCAT(REPEAT('--', levels.level - 1), c2.name) AS Category

->  , SUM(coi.quantity) AS TotalItems


C H A P T E R   8   ■ S Q L   S C E N A R I O S

->  , SUM(coi.quantity * coi.price) AS TotalSales

-> FROM Category c1

->  INNER JOIN Category c2

->   ON c1.left_side BETWEEN c2.left_side AND c2.right_side

->  INNER JOIN Product2Category p2c

->   ON c1.category_id = p2c.category_id

->  INNER JOIN CustomerOrderItem coi

->   ON p2c.product_id = coi.product_id

->  INNER JOIN

->   (

->   SELECT c3.category_id, COUNT(*) AS level

->   FROM Category c3

->    INNER JOIN Category c4

->     ON c3.left_side BETWEEN c4.left_side AND c4.right_side

->   GROUP BY c3.category_id

->   ) AS levels

->    ON c2.category_id = levels.category_id

-> GROUP BY c2.category_id;

+-------------------------------+------------+------------+

| Category                      | TotalItems | TotalSales |

+-------------------------------+------------+------------+

| All                           |         65 |     607.02 |

| --Action Figures              |          3 |      40.85 |

| ----Sport Action Figures      |          2 |      24.90 |

| ----Historical Action Figures |          1 |      15.95 |

| --Video Games                 |          1 |      46.99 |

| ----Sports Video Games        |          1 |      46.99 |

| --Sports Gear                 |         59 |     399.20 |

| ----Soccer Equipment          |          1 |      23.70 |

| ----Tennis Equipment          |         58 |     375.50 |

| --Dolls                       |          2 |     119.98 |

+-------------------------------+------------+------------+

10 rows in set (0.41 sec)

We realize Listing 8-27 has a lot going on. But this is a good example of how you can use

all of the knowledge you’ve learned in the previous chapters to produce some pretty amazing

reports. Using the building blocks of the derived tables you learned in Chapter 7, we took the

query from Listing 8-19, which found the depth of each category node. We used the REPEAT

function to insert two dashes for each level in the category from the root node. We made this

section of the query bold in order for you to tell which piece of the overall query is involved in

the depth calculation.

The italicized part of the query shows the rollup adaptation from our query in Listing 8-26.

Instead of counting the products, we’ve simply used Product2Category to join to the sales infor-

mation found in CustomerOrderItem and used the SUM function to provide some aggregated

numbers.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

■Note Notice that the query from Listing 8-27 shows only 10 results? But there are 14 categories. As an

exercise, rewrite the query in Listing 8-27 to use an outer join to include the categories that have no product

sales. Use the techniques you learned in Chapter 7.

Inserting a Node into the Tree

What happens to our nested set model when we need to insert a new category into our catalog?

Clearly, our model depends on the left and right side metadata about each category. To keep

our model from breaking, we need to update this metadata when our tree changes. Luckily,

we have our rules from which we can derive a node-insertion strategy.

When you’re inserting nodes into the tree, you must first decide what the parent of the

new node will be—where will the node be inserted? Once you know which node is the parent,

you can then update the metadata for all nodes according to the right side value of this parent.

Let’s assume we want to add under the Video Games category a new category called Puz-

zle Video Games. Therefore, the parent is the Sports Video Games category node, and the

rightmost child is the Shooting Video Games subcategory.

Figure 8-5 shows what we intend to happen to the category tree. The new node is shaded,

and the updated metadata is circled. Notice the pattern of how the metadata changed from

Figure 8-4. For those nodes with original left_side values greater than that of the parent’s

right_side value (19), their new left_side value was increased by two. Similarly, for those

nodes whose original right_side value was greater than or equal to the rightmost sibling’s

right_side value (19), their new right_side value is also increased by two. The new node

slides easily into the gap. If you’re unsure, compare the two figures side by side until you see

the pattern of changes.

Following from this insertion pattern, we use the SQL in Listing 8-28 to insert the new

node to the right of the insertion point.

Listing 8-28. Inserting a New Node and Updating the Metadata

mysql> SELECT @insert_right := right_side FROM Category WHERE category_id = 7;

+-----------------------------+

| @insert_right := right_side |

+-----------------------------+

|                          19 |

+-----------------------------+

1 row in set (0.11 sec)

mysql> UPDATE Category

-> SET left_side = IF(left_side > @insert_right, left_side + 2, left_side)

-> , right_side = IF(right_side >= @insert_right, right_side + 2, right_side)

-> WHERE right_side >= @insert_right;

Query OK, 6 rows affected (0.16 sec)

Rows matched: 6  Changed: 6  Warnings: 0


C H A P T E R   8   ■ S Q L   S C E N A R I O S

mysql> INSERT INTO Category (parent_id, name, description, left_side, right_side)

-> VALUES (7, 'Puzzle Video Games', 'Puzzle Video Games', @insert_right,

-> (@insert_right + 1));

Query OK, 1 row affected (0.03 sec)

Notice the steps we take:

1. Assign the right_side value of the parent node to a user session variable called

@insert_right.

2. Use the UPDATE expression to “bump up” the left_side and right_side values of the

nodes above the insertion point, and update the right_side value of the parent node,

according to the pattern shown in Figure 8-5.

3. Use a simple INSERT statement to push the new category into the tree at the insertion

point.

Root Node

category_id = 1

Action Figures

category_id = 2

Video Games

category_id = 7

Sports Gear

category_id = 11

Dolls

category_id = 14

Soccer Equipment

category_id = 12

Tennis Equipment

category_id = 13

Sport Action

Figures

category_id = 3

Tennis Action

Figures

category_id = 4

Football Action

Figures

category_id = 5

Historical Action

Figures

category_id = 6

Racing Video

Games

category_id = 8

Sports Video

Games

category_id = 9

Shooting Video

Games

category_id = 10

Puzzle Video

Games

category_id = 15

Figure 8-5. Inserting a new node in the category tree

Listing 8-29 shows a SELECT of the updated category tree to demonstrate the results of our

node insertion.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Listing 8-29. Verifying the New Node Insertion

mysql> SELECT category_id, name, left_side, right_side

-> FROM Category

-> ORDER BY left_side, right_side;

+-------------+---------------------------+-----------+------------+

| category_id | name                      | left_side | right_side |

+-------------+---------------------------+-----------+------------+

|           1 | All                       |         1 |         30 |

|           2 | Action Figures            |         2 |         11 |

|           3 | Sport Action Figures      |         3 |          8 |

|           4 | Tennis Action Figures     |         4 |          5 |

|           5 | Football Action Figures   |         6 |          7 |

|           6 | Historical Action Figures |         9 |         10 |

|           7 | Video Games               |        12 |         21 |

|           8 | Racing Video Games        |        13 |         14 |

|           9 | Sports Video Games        |        15 |         16 |

|          10 | Shooting Video Games      |        17 |         18 |

|          16 | Puzzle Video Games        |        19 |         20 |

|          11 | Sports Gear               |        22 |         27 |

|          12 | Soccer Equipment          |        23 |         24 |

|          13 | Tennis Equipment          |        25 |         26 |

|          14 | Dolls                     |        28 |         29 |

+-------------+---------------------------+-----------+------------+

15 rows in set (0.09 sec)

Removing a Node from the Tree

Finally, we also need a method for removing a category from our catalog. Let’s assume that we

want to remove the category named Shooting Video Games from the Video Games category.

Figure 8-6 shows how we want the new category tree to look. We’ve shaded the node we wish

to remove and circled the metadata values that will need to change.

As you would expect, the pattern for removing a node is basically the reverse of adding a node:

1. Start by determining the left_side and right_side values of the node we’re going to

delete, which are 17 and 18 in this case.

2. Subtract two from the left_side values of any node having a left_side value greater

than the left_side value of the deleted node.

3. Subtract two from the right_side value of any node having a right_side value greater

than the right_side value of the deleted node.

4. Finally, remove the category from both the Category table and the Product2Category

table using a multitable DELETE statement. We use a LEFT JOIN to ensure that the cate-

gory is deleted, even if it has not been assigned to any products.

Listing 8-30 shows the SQL to accomplish the node removal.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Root Node

category_id = 1

Action Figures

category_id = 2

Video Games

category_id = 7

Sports Gear

category_id = 11

Dolls

category_id = 14

Soccer Equipment

category_id = 12

Tennis Equipment

category_id = 13

Sport Action

Figures

category_id = 3

Tennis Action

Figures

category_id = 4

Football Action

Figures

category_id = 5

Historical Action

Figures

category_id = 6

Racing Video

Games

category_id = 8

Sports Video

Games

category_id = 9

Shooting Video

Games

category_id = 10

Puzzle Video

Games

category_id = 15

Figure 8-6. Removing a node from the category tree

mysql> SELECT @delete_left := left_side, @delete_right := right_side

Listing 8-30. Removing a Node

-> FROM Category

-> WHERE category_id = 10;

+---------------------------+-----------------------------+

| @delete_left := left_side | @delete_right := right_side |

+---------------------------+-----------------------------+

|                        17 |                          18 |

+---------------------------+-----------------------------+

1 row in set (0.80 sec)

mysql> UPDATE Category

-> SET left_side = IF(left_side > @delete_left, left_side - 2, left_side)

-> , right_side = IF(right_side > @delete_right, right_side - 2, right_side)

-> WHERE right_side > @delete_right;

Query OK, 7 rows affected (0.17 sec)

Rows matched: 7  Changed: 7  Warnings: 0

mysql> DELETE Product2Category, Category

-> FROM Category

->  LEFT JOIN Product2Category

->   ON Category.category_id = Product2Category.category_id

-> WHERE Category.category_id = 10;

Query OK, 1 row affected (0.09 sec)

Finally, we check the metadata status of our tree, as shown in Listing 8-31.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Listing 8-31. Checking the Metadata Status

mysql> SELECT category_id, name, left_side, right_side

-> FROM Category

-> ORDER BY left_side, right_side;

+-------------+---------------------------+-----------+------------+

| category_id | name                      | left_side | right_side |

+-------------+---------------------------+-----------+------------+

|           1 | All                       |         1 |         28 |

|           2 | Action Figures            |         2 |         11 |

|           3 | Sport Action Figures      |         3 |          8 |

|           4 | Tennis Action Figures     |         4 |          5 |

|           5 | Football Action Figures   |         6 |          7 |

|           6 | Historical Action Figures |         9 |         10 |

|           7 | Video Games               |        12 |         19 |

|           8 | Racing Video Games        |        13 |         14 |

|           9 | Sports Video Games        |        15 |         16 |

|          16 | Puzzle Video Games        |        17 |         18 |

|          11 | Sports Gear               |        20 |         25 |

|          12 | Soccer Equipment          |        21 |         22 |

|          13 | Tennis Equipment          |        23 |         24 |

|          14 | Dolls                     |        26 |         27 |

+-------------+---------------------------+-----------+------------+

14 rows in set (0.03 sec)

Retrieving Random Records

In certain applications, you may need to return a random set of records from a given table.

For instance, your web application might have a banner advertising system that displays a

random image from a table of advertisements stored in MySQL. You can do this in a couple

ways, using MySQL’s extension functions. One method is to use the RAND() function along with

the LIMIT clause. As an example, assume we have the simple table schema for storing adver-

tisements shown in Listing 8-32.

Listing 8-32. Sample Table Schema for Storing Advertisements

CREATE TABLE Banner (

banner_id INT NOT NULL AUTO_INCREMENT

, image_url VARCHAR(255) NOT NULL

, click_url VARCHAR(255) NOT NULL

, expires_on DATE NOT NULL

, PRIMARY KEY (banner_id)

);

If we wanted to return a single random record that is not expired, we could use the code

in Listing 8-33 to do so. We’ve shown two runs of the same SQL to demonstrate the random

return values from the Banner table.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Listing 8-33. Returning a Single Random Banner Record

mysql> SELECT * FROM Banner ORDER BY RAND() LIMIT 1;

+-----------+---------------------+-----------------------+------------+

| banner_id | image_url           | click_url             | expires_on |

+-----------+---------------------+-----------------------+------------+

|         2 | /images/banner2.jpg | http://www.google.com | 2005-06-01 |

+-----------+---------------------+-----------------------+------------+

1 row in set (0.11 sec)

mysql> SELECT * FROM Banner ORDER BY RAND() LIMIT 1;

+-----------+---------------------+--------------------+------------+

| banner_id | image_url           | click_url          | expires_on |

+-----------+---------------------+--------------------+------------+

|         3 | /images/banner3.jpg | http://www.msn.com | 2005-06-01 |

+-----------+---------------------+--------------------+------------+

1 row in set (0.00 sec)

This method works just fine for tables that have small row counts. However, the perform-

ance of this query begins to degrade rapidly on larger tables. Let’s select a random row from

our larger RssEntry table and take a look at the results of an EXPLAIN statement, as shown in

Listing 8-34.

Listing 8-34. The Same Query on a Larger Table

mysql> SELECT title FROM RssEntry ORDER BY RAND() LIMIT 1;

+------------------------------------+

| title                              |

+------------------------------------+

| HVAC Sheetmetal Worker (Aldie, VA) |

+------------------------------------+

1 row in set (4.17 sec)

mysql> EXPLAIN SELECT title, url, rssID FROM RssEntry ORDER BY RAND() LIMIT 1 \G

*************************** 1. row ***************************

id: 1

select_type: SIMPLE

table: RssEntry

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 157902

Extra: Using temporary; Using filesort

1 row in set (0.00 sec)


C H A P T E R   8   ■ S Q L   S C E N A R I O S

As you can see, MySQL loads the data into a temporary table and sorts the data according

to the randomizer. Even on a relatively small table (160,000 records), the performance of the

query was abysmal.

To remedy the situation, we use a user variable to store the count of records in the table,

and then randomize the returned record by retrieving a row ID, as Listing 8-35 shows.

Listing 8-35. Returning a Single Random Record from a Larger Table

mysql> SELECT @row_id := COUNT(*) FROM RssEntry;

+---------------------+

| @row_id := COUNT(*) |

+---------------------+

|              157902 |

+---------------------+

1 row in set (0.01 sec)

mysql> SELECT @row_id := FLOOR(RAND() * @row_id) + 1;

+----------------------------------------+

| @row_id := FLOOR(RAND() * @row_id) + 1 |

+----------------------------------------+

|                                  59569 |

+----------------------------------------+

1 row in set (0.00 sec)

mysql> SELECT title FROM RssEntry WHERE rowID = @row_id;

+----------------------------------+

| title                            |

+----------------------------------+

| Recruiter (TEKsystems Corporate) |

+----------------------------------+

1 row in set (0.00 sec)

This method performs much quicker than the previous method, and we suggest using this

on any table that has more than a few thousand records.

Calculating Distances with Geographic

Coordinate Data

In this section, we’re going to have some fun with trigonometry! You’ll see how, using some

standard trigonometric formulas and your MySQL server, you can accomplish some pretty

cool tricks with information freely available to you.

The Geographic Information System (GIS), in the simplest sense, is data that references a

geographical location using coordinates. Though GIS data is often referred to as spatial data,

we won’t be using the spatial extensions of MySQL in our examples. Instead, we’ll show you

how to use standard MySQL functions and SQL to pull information from a data store of

coordinates.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Although MySQL has made significant headway in implementing the OpenGIS standards in

the spatial extensions, the MySQL implementation is still in its nascent stages. Currently, its spa-

tial extensions support only Euclidean geometry, which deals with shapes and coordinates in

flat measurements. Because the Earth is not a flat, planar surface, distance calculations must

take into account the degree to which the lines of longitude converge as they move towards the

poles. Therefore, doing calculations for spherical distances using Euclidean geometry produces

less and less accurate results as you move away from the equator. Additionally, the lack of certain

spatial SQL functions (for instance, for calculating the area within three points on a sphere)

makes using the extension somewhat cumbersome.

In the examples in this section, we’ll be using a data set of U.S. Census Bureau Zip Code

Tabulation Areas (ZCTAs),3 which is available for free from http://www.census.gov/geo/www/

gazetteer/places2k.html. We have normalized this data set and removed the information we

did not need for the examples.

■Tip A wealth of GIS data is available from a number of sources. Check government web sites for this

information, or go to http://en.wikipedia.org/wiki/GIS, which lists sites that offer free GIS informa-

tion. Additionally, private companies offer standardized GIS data for a fee.

Understanding the Distance Calculation Formula

In our examples, we’re going to be using a formula for calculating distances called the great

circle distance formula. This formula calculates the distance between two coordinates on a

spherical surface—in this case, the Earth.4

The great circle distance formula states that the distance (d) between two points (x1,y1)

and (x2,y2), where the x values are latitude and the y values are longitude, on a sphere of

radius r can be determined by this calculation:

d = acos ( sin(x1) * sin(x2) + cos(x1) * cos(x2) * cos(y2- y1) ) * r

The formula assumes that the latitude and longitude values are in radians. However, the

latitude and longitude values available in the Census Bureau data were in degrees, not radi-

ans. You can see this in the initial design of our ZCTA table, shown in Listing 8-36.

Listing 8-36. Initial Design for the ZCTA Table

CREATE TABLE ZCTA (

zcta CHAR(6) NOT NULL

, lat_degrees DECIMAL(9,6) NOT NULL

, long_degrees DECIMAL (9,6) NOT NULL

, PRIMARY KEY(zcta));

3. ZCTAs are not exactly the same as U.S. Postal Service Zip Codes; however, in our testing, the ZCTAs

match very closely to them and can be considered accurate for the purposes of these calculations.

4. Technically, the Earth is not perfectly spherical, but given its size, the relatively minor imperfections

in the Earth’s surface will not skew the calculations significantly.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

We populated the ZCTA table with 32,038 entries corresponding to the Census Bureau data

latitude and longitude coordinates in degrees for each ZCTA. But since we know that we’ll need

to do at least some calculations using radians, we should save ourselves the repeated calculation

of the degrees to radians conversion, and simply add two columns for the radian value of the

latitude and longitude. In order to convert degrees to radians, we use the following formula:

radians = degrees * (π/180)

shown in Listing 8-37.

A quick SELECT statement of five random rows along with our formula yields the results

Listing 8-37. Determining the Converted Radian Values

mysql> SELECT

->  zcta

-> , lat_degrees

-> , lat_degrees * (PI() / 180) AS lat_radians

-> , long_degrees

-> , long_degrees * (PI() / 180) AS long_radians

-> FROM ZCTA

-> ORDER BY RAND()

-> LIMIT 5;

+-------+-------------+-------------+--------------+--------------+

| zcta  | lat_degrees | lat_radians | long_degrees | long_radians |

+-------+-------------+-------------+--------------+--------------+

| 61568 | 40.513657   |  0.70709671 | -89.474083   |  -1.56161734 |

| 42728 | 37.123196   |  0.64792200 | -85.275620   |  -1.48834034 |

| 75060 | 32.802681   |  0.57251479 | -96.954987   |  -1.69218375 |

| 37316 | 34.995041   |  0.61077869 | -84.729515   |  -1.47880901 |

| 71270 | 32.524761   |  0.56766417 | -92.646965   |  -1.61699458 |

+-------+-------------+-------------+--------------+--------------+

5 rows in set (0.13 sec)

As you can see, the radian values will fit nicely in a column of DECIMAL(9,8). However,

because our degrees columns are a DECIMAL(9,6), we’ll experience some truncating of values

down to the lowest common denominator when we INSERT the converted radian values. So,

we add the columns as DECIMAL(9,6) and INSERT the converted degree values, as shown in

Listing 8-38.

Listing 8-38. Loading the New Radian Values

mysql> ALTER TABLE ZCTA

-> ADD COLUMN lat_radians DECIMAL(9,6) NOT NULL

-> , ADD COLUMN long_radians DECIMAL(9,6) NOT NULL;

Query OK, 32038 rows affected (0.24 sec)

Records: 32038  Duplicates: 0  Warnings: 0


C H A P T E R   8   ■ S Q L   S C E N A R I O S

mysql> UPDATE ZCTA

-> SET lat_radians = lat_degrees * (PI() / 180)

-> , long_radians = long_degrees * (PI() / 180);

Query OK, 32038 rows affected, 64076 warnings (0.34 sec)

Rows matched: 32038  Changed: 32038  Warnings: 64076

mysql> SELECT * FROM ZCTA LIMIT 5;

+-------+-------------+--------------+-------------+--------------+

| zcta  | lat_degrees | long_degrees | lat_radians | long_radians |

+-------+-------------+--------------+-------------+--------------+

| 35004 | 33.606380   | -86.502495   | 0.586542    | -1.509753    |

| 35005 | 33.592587   | -86.959686   | 0.586301    | -1.517733    |

| 35006 | 33.451714   | -87.239578   | 0.583843    | -1.522618    |

| 35007 | 33.232422   | -86.808716   | 0.580015    | -1.515098    |

| 35010 | 32.903431   | -85.926697   | 0.574273    | -1.499704    |

+-------+-------------+--------------+-------------+--------------+

5 rows in set (0.00 sec)

Now that we have all the information stored in our ZCTA table, we’ll look at how to do the

following common distance-related calculations:

• Calculating the distance between two points

• Determining which zip codes fall within a given radius

Calculating the Distance Between Two Points

Let’s say we have a list of store locations, and we want to find the distance between the two

stores. Assume that store A is located in New York City, in zip code 10001, and store B is located

in the Baltimore, Maryland, metropolitan area, in zip code 21236. We want to know how far

the two stores are from each other.

In order to use the great circle distance formula, we first need the coordinates, in radians,

of each store’s zip code. Listing 8-39 demonstrates using user variables to store the needed

radian coordinate values.

Listing 8-39. Gathering Coordinate Information for Zip Codes

mysql> SELECT

->  @lat_A := lat_radians

-> , @long_A := long_radians

-> FROM ZCTA

-> WHERE zcta = '10001';

+-----------------------+-------------------------+

| @lat_A := lat_radians | @long_A := long_radians |

+-----------------------+-------------------------+

| 0.711235              | -1.291483               |

+-----------------------+-------------------------+

1 row in set (0.00 sec)


C H A P T E R   8   ■ S Q L   S C E N A R I O S

mysql> SELECT

->  @lat_B := lat_radians

-> , @long_B := long_radians

-> FROM ZCTA

-> WHERE zcta = '21236';

+-----------------------+-------------------------+

| @lat_B := lat_radians | @long_B := long_radians |

+-----------------------+-------------------------+

| 0.687476              | -1.334952               |

+-----------------------+-------------------------+

1 row in set (0.00 sec)

The final piece of data we need to complete the equation is the radius of the Earth in

miles. This constant is the number 3,956. To complete the distance request, we simply plug

these user variables into the great circle distance formula to obtain the distance between the

stores, as Listing 8-40 shows.

Listing 8-40. Plugging the User Variables into the Distance Formula

mysql> SELECT ACOS(SIN(@lat_A) * SIN(@lat_B)

->  + COS(@lat_A) * COS(@lat_B)

->  * COS(@long_B - @long_A)) * 3956 AS distance;

+-----------------+

| distance        |

+-----------------+

| 161.70380719616 |

+-----------------+

1 row in set (0.00 sec)

But did we need to use user variables to complete the request? Issuing three statements

against the MySQL server seems like a lot of work, don’t you agree? Instead, we could have

done a cross join of the two entries with the coordinate information and done away with the

user variables, as Listing 8-41 demonstrates.

Listing 8-41. Using a Cross Join Rather Than User Variables

mysql> SELECT ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

->  + COS(x1.lat_radians) * COS(x2.lat_radians)

->  * COS(x2.long_radians - x1.long_radians)) * 3956 AS distance

-> FROM ZCTA x1, ZCTA x2

-> WHERE x1.zcta = '10001'

-> AND x2.zcta = '21236';

+-----------------+

| distance        |

+-----------------+

| 161.70380719616 |

+-----------------+

1 row in set (0.04 sec)


C H A P T E R   8   ■ S Q L   S C E N A R I O S

And voilà! We have an easy method of determining the distance in miles between two

coordinates. Now, if you’re wondering about the performance of this query, let’s take a look at

the EXPLAIN, in Listing 8-42.

Listing 8-42. EXPLAIN of the Distance Query

mysql> EXPLAIN

-> SELECT ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

-> + COS(x1.lat_radians) * COS(x2.lat_radians)

-> * COS(x2.long_radians - x1.long_radians)) * 3956 AS distance

-> FROM ZCTA x1, ZCTA x2

-> WHERE x1.zcta = '10001'

-> AND x2.zcta = '21236' \G

*************************** 1. row ***************************

*************************** 2. row ***************************

id: 1

select_type: SIMPLE

table: x1

type: const

possible_keys: PRIMARY

key: PRIMARY

key_len: 6

ref: const

rows: 1

Extra:

id: 1

select_type: SIMPLE

table: x2

type: const

possible_keys: PRIMARY

key: PRIMARY

key_len: 6

ref: const

rows: 1

Extra:

2 rows in set (0.40 sec)

You’ll notice that this query will complete almost instantaneously, as the PRIMARY index of

the ZCTA table is queried for a const (almost instant lookup), and the formula is then calcu-

lated with the values in the two lookups.

■Tip As you progress through the following chapters on stored procedures and functions, refer back to

this and the next section. Once you learn how to write a stored procedure or function, you might want

to consolidate the SQL code in the following code listings into compact procedures. It would be a good

exercise for you.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

What would happen if we removed the WHERE clauses in Listing 8-42? Without the WHERE

clause, we would have a complete Cartesian product of all ZCTA rows crossed against each

other. If we eliminated only part of the WHERE clause (say, for the second zip code), we would

have the distances from the first zip code to all zip codes in our table, as Listing 8-43 shows.

Listing 8-43. Distances from a Specific Zip Code to All Known Zip Codes

mysql> SELECT x2.zcta AS Zip

-> , ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

-> + COS(x1.lat_radians) * COS(x2.lat_radians)

-> * COS(x2.long_radians - x1.long_radians)) * 3956 AS "Distance from 10001"

-> FROM ZCTA x1, ZCTA x2

-> WHERE x1.zcta = '10001';

... omitted

| 00971 |     1617.0076621906 |

| 00976 |     1617.8210570274 |

| 00979 |     1612.0294495892 |

| 00982 |     1613.8683216421 |

| 00983 |     1613.8354440218 |

| 00985 |     1616.9707648494 |

| 00987 |     1616.8698513986 |

+-------+---------------------+

32038 rows in set (0.24 sec)

Removing the WHERE clause from Listing 8-43 entirely would lead to a table containing dis-

tances from every zip code to every other zip code. However, we don’t recommend doing this,

because you’ll end up with a table of 32,0382, or 1,026,433,444 records!

Determining Zip Codes Within a Given Radius

Suppose that we are building a store locator for our e-commerce web site, and we want to give

customers the ability to find a store within a certain number of miles from where they live.

Following the logic from our example in Listing 8-43, we should be able to retrieve all zip

codes falling within a certain distance from the first zip code by moving the distance calcula-

tion from the SELECT statement into the WHERE condition.

Let’s assume that we have a customer in Maryland at the zip code 21236. We want to

find all ZCTAs that fall within five miles of this zip code. Listing 8-44 shows the adaptation

of Listing 8-43, moving the distance formula to the WHERE clause.

Listing 8-44. Finding ZCTAs Within a Specific Radius

mysql> SELECT

->  x2.zcta

-> FROM ZCTA x1, ZCTA x2

-> WHERE x1.zcta = '21236'

-> AND ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

->  + COS(x1.lat_radians) * COS(x2.lat_radians)

->  * COS(x2.long_radians - x1.long_radians)) * 3956 <= 5;


C H A P T E R   8   ■ S Q L   S C E N A R I O S

+-------+

| zcta  |

+-------+

| 21057 |

| 21128 |

| 21162 |

| 21206 |

| 21214 |

| 21234 |

| 21236 |

| 21237 |

+-------+

8 rows in set (0.13 sec)

As you can see, this produced eight zip codes lying within five miles of the customer’s

home zip code of 21236. Now, what if we wanted to show these zip codes along with the dis-

tance from the home zip code, and order the results from nearest to farthest? Listing 8-45

shows an adaptation of our previous query to return this ordered result.

Listing 8-45. Ordering Results from Nearest to Farthest

mysql> SELECT

->    x2.zcta AS Zip

->  , ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

->  + COS(x1.lat_radians) * COS(x2.lat_radians)

->  * COS(x2.long_radians - x1.long_radians)) * 3956 AS "Distance"

->  FROM ZCTA x1, ZCTA x2

->  WHERE x1.zcta = '21236'

->  AND ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

->  + COS(x1.lat_radians) * COS(x2.lat_radians)

->  * COS(x2.long_radians - x1.long_radians)) * 3956 <= 5

->  ORDER BY Distance;

+-------+-----------------+

| Zip   | Distance        |

+-------+-----------------+

| 21236 |               0 |

| 21128 | 2.2986385889254 |

| 21234 | 2.9331244776703 |

| 21162 | 3.9927939103667 |

| 21237 | 4.0496936110152 |

| 21206 | 4.4020674824977 |

| 21057 | 4.5535837161195 |

| 21214 | 4.8578974381478 |

+-------+-----------------+

8 rows in set (0.11 sec)


C H A P T E R   8   ■ S Q L   S C E N A R I O S

This looks about right. We know that the 21236 zip code distance should indeed be 0,

since that is the home zip code. But, back to our original request, we wanted to find the stores

located within five miles of the customer’s home zip code. All we’ve done so far is return the

zip codes within five miles of the customer’s home zip code.

Assume we have a StoreLocation table containing around 10,000 stores, structured as

shown in Listing 8-46.

Listing 8-46. StoreLocation Table Definition

CREATE TABLE StoreLocation (

store_id INT NOT NULL AUTO_INCREMENT

, address VARCHAR(100) NOT NULL

, city VARCHAR(35) NOT NULL

, state CHAR(2) NOT NULL

, zip VARCHAR(6) NOT NULL

, PRIMARY KEY (store_id)

, KEY (zip));

We have a number of ways in which we can use the SQL from Listing 8-44 in order to

retrieve records from our StoreLocation table that match the zip codes within our search

radius. In our first attempt, we’ll use a non-correlated subquery on the StoreLocation.zip

field to match records returned in our resultset from Listing 8-44. In Listing 8-47, we’ve itali-

cized the duplicated code from Listing 8-44, and bolded the new code using a non-correlated

subquery to find StoreLocation records.

Listing 8-47. Non-Correlated Subquery to Find StoreLocation Records Within Zip Radius

mysql> SELECT

->  LEFT(address, 30) as address

-> , city

-> , state

-> , zip

-> FROM StoreLocation

-> WHERE zip IN (

->  SELECT x2.zcta

->  FROM ZCTA x1, ZCTA x2

->  WHERE x1.zcta = '21236'

->  AND ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

->  + COS(x1.lat_radians) * COS(x2.lat_radians)

->  * COS(x2.long_radians - x1.long_radians)) * 3956 <= 5

-> );

+--------------------------------+-------------+-------+-------+

| address                        | city        | state | zip   |

+--------------------------------+-------------+-------+-------+

| WHITE MARSH MALL  8200 PERRY H | BALTIMORE   | MD    | 21236 |

| 8200 PERRY HALL BOULEVARD  WHI | WHITE MARSH | MD    | 21236 |

| 8641 PHILADELPIA ROAD          | BALTIMORE   | MD    | 21237 |

| 2401 CLEANLEIGH DRIVE          | PARKVILLE   | MD    | 21234 |


C H A P T E R   8   ■ S Q L   S C E N A R I O S

| 1971 EAST JOPPA ROAD           | TOWSON      | MD    | 21234 |

| 4921 CAMPBELL ROAD             | WHITE MARSH | MD    | 21162 |

| 7400 EAST BELAIR ROAD          | BALTIMORE   | MD    | 21236 |

| 5246 HARFORD ROAD              | HAMILTON    | MD    | 21214 |

| 9103 BELAIR ROAD               | PERRY HALL  | MD    | 21236 |

+--------------------------------+-------------+-------+-------+

9 rows in set (0.17 sec)

The SQL is not really all that complicated when you break the request into its requisite

parts. We’ve added a very simple IN expression to fulfill the non-correlated subquery matching

zip codes in the StoreLocation table to zip codes returned from the matched records in the

ZCTA table x2. Let’s take a look at the EXPLAIN to verify the optimizer is working as expected.

Listing 8-48 shows the output.

Listing 8-48. EXPLAIN Output from Listing 8-47

mysql> EXPLAIN

-> SELECT

->  LEFT(address, 30) as address

-> , city

-> , state

-> , zip

-> FROM StoreLocation

-> WHERE zip IN (

->  SELECT x2.zcta

->  FROM ZCTA x1, ZCTA x2

->  WHERE x1.zcta = '21236'

->  AND ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

->  + COS(x1.lat_radians) * COS(x2.lat_radians)

->  * COS(x2.long_radians - x1.long_radians)) * 3956 <= 5

-> ) \G

*************************** 1. row ***************************

id: 1

select_type: PRIMARY

table: StoreLocation

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 9640

Extra: Using where

select_type: DEPENDENT SUBQUERY

id: 2

table: x1

type: const

possible_keys: PRIMARY

*************************** 2. row ***************************


*************************** 3. row ***************************

id: 2

select_type: DEPENDENT SUBQUERY

C H A P T E R   8   ■ S Q L   S C E N A R I O S

key: PRIMARY

key_len: 6

ref: const

rows: 1

Extra:

table: x2

type: eq_ref

possible_keys: PRIMARY

key: PRIMARY

key_len: 6

ref: func

rows: 1

Extra: Using where

3 rows in set (0.00 sec)

From the EXPLAIN output, we see that our index on StoreLocation.zip is not being used.

In fact, MySQL doesn’t even consider it an option, as the zip key isn’t listed in possible_keys.

Instead, MySQL has chosen to do a full table scan (ALL). For each record in the StoreLocation

result, MySQL is using a WHERE expression to look for any returned values in the subquery that

match the zip field value in StoreLocation. Since the query apparently isn’t using an index,

perhaps there is a way in which we could rewrite the query so that an index is used.

Let’s try rewriting the non-correlated subquery as a single derived table joined on the zip

column of StoreLocation. Listing 8-49 shows our revised SQL. We’ve bolded the changes.

Listing 8-49. Revised Query to Use a Single Derived Table

mysql> SELECT

->  LEFT(address, 30) as address

-> , city

-> , state

-> , zip

-> FROM StoreLocation sl

-> INNER JOIN (

->  SELECT x2.zcta

->  FROM ZCTA x1, ZCTA x2

->  WHERE x1.zcta = '21236'

->  AND ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

->  + COS(x1.lat_radians) * COS(x2.lat_radians)

->  * COS(x2.long_radians - x1.long_radians)) * 3956 <= 5

-> ) AS zips

->  ON sl.zip = zips.zcta;

+--------------------------------+-------------+-------+-------+

| address                        | city        | state | zip   |

+--------------------------------+-------------+-------+-------+

| 4921 CAMPBELL ROAD             | WHITE MARSH | MD    | 21162 |


C H A P T E R   8   ■ S Q L   S C E N A R I O S

| 5246 HARFORD ROAD              | HAMILTON    | MD    | 21214 |

| 2401 CLEANLEIGH DRIVE          | PARKVILLE   | MD    | 21234 |

| 1971 EAST JOPPA ROAD           | TOWSON      | MD    | 21234 |

| WHITE MARSH MALL  8200 PERRY H | BALTIMORE   | MD    | 21236 |

| 8200 PERRY HALL BOULEVARD  WHI | WHITE MARSH | MD    | 21236 |

| 7400 EAST BELAIR ROAD          | BALTIMORE   | MD    | 21236 |

| 9103 BELAIR ROAD               | PERRY HALL  | MD    | 21236 |

| 8641 PHILADELPIA ROAD          | BALTIMORE   | MD    | 21237 |

+--------------------------------+-------------+-------+-------+

9 rows in set (0.14 sec)

The results are almost identical to the first query, except that the order of the results has

now been changed to use the zip field value instead of the store_id field. Why is this? It has to

do with the order in which MySQL chooses to join the various resultsets together. In Listing 8-48,

you saw that MySQL chose to first do a table scan on the StoreLocation data set. It then found

matching rows in the ZCTA subquery. Since the natural order of the StoreLocation data is the

store_id value, that is what the eventual order of the results became. In Listing 8-49, MySQL

has chosen to perform a different join strategy, as evidenced by Listing 8-50.

Listing 8-50. EXPLAIN Results from Listing 8-49

mysql> EXPLAIN

-> SELECT

->  LEFT(address, 30) as address

-> , city

-> , state

-> , zip

-> FROM StoreLocation sl

-> INNER JOIN (

->  SELECT x2.zcta

->  FROM ZCTA x1, ZCTA x2

->  WHERE x1.zcta = '21236'

->  AND ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

->  + COS(x1.lat_radians) * COS(x2.lat_radians)

->  * COS(x2.long_radians - x1.long_radians)) * 3956 <= 5

-> ) AS zips

->  ON sl.zip = zips.zcta \G

*************************** 1. row ***************************

id: 1

select_type: PRIMARY

table: <derived2>

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 8

Extra:


C H A P T E R   8   ■ S Q L   S C E N A R I O S

*************************** 2. row ***************************

*************************** 3. row ***************************

*************************** 4. row ***************************

id: 1

select_type: PRIMARY

table: sl

type: ref

possible_keys: zip

key: zip

key_len: 8

ref: zips.zcta

rows: 2

Extra:

id: 2

select_type: DERIVED

table: x1

type: const

possible_keys: PRIMARY

key: PRIMARY

key_len: 6

ref:

rows: 1

Extra:

id: 2

select_type: DERIVED

table: x2

type: ALL

possible_keys: NULL

key: NULL

key_len: NULL

ref: NULL

rows: 32038

Extra: Using where

4 rows in set (0.12 sec)

As you can see, MySQL first executes the derived table SELECT statement, and then uses

the index on StoreLocation.zip to find the rows in StoreLocation that have a matching zip

code. MySQL uses the natural order of the StoreLocation.zip index in the output of the query.

But there is still one nagging performance consideration that we might address in this

query. Our derived table query execution plan has a table scan on the ZCTA x2 table. The pre-

vious subquery (Listing 8-47) had an eq_ref execution optimization performed from the main

x1 ZCTA table (having 1 const row), as you saw in Listing 8-48. Is it possible to get the best of

both worlds? Granted, 0.14 second isn’t a long execution time for such an in-depth SQL state-

ment, but this query might be run quite frequently. Using the knowledge you’ve gained so far,

do you think there is a way to perform this query that will use the eq_ref optimization from

the subquery, but have a chance to use the index on StoreLocation.zip?


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Give yourself two points if you thought, “I can do this without a subquery or a derived

table!” Indeed, you can. Listing 8-51 shows how we can simply join the x2 ZCTA subset to the

StoreLocation table itself, along the StoreLocation.zip index.

Listing 8-51. Removing the Derived Table in Favor of a Standard Inner Join

mysql> SELECT

->  LEFT(address, 30) as address

-> , city

-> , state

-> , zip

-> FROM ZCTA x1, ZCTA x2

-> INNER JOIN StoreLocation sl

->  ON x2.zcta = sl.zip

-> WHERE x1.zcta = '21236'

-> AND ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

-> + COS(x1.lat_radians) * COS(x2.lat_radians)

-> * COS(x2.long_radians - x1.long_radians)) * 3956 <= 5;

+--------------------------------+-------------+-------+-------+

| address                        | city        | state | zip   |

+--------------------------------+-------------+-------+-------+

| WHITE MARSH MALL  8200 PERRY H | BALTIMORE   | MD    | 21236 |

| 8200 PERRY HALL BOULEVARD  WHI | WHITE MARSH | MD    | 21236 |

| 8641 PHILADELPIA ROAD          | BALTIMORE   | MD    | 21237 |

| 2401 CLEANLEIGH DRIVE          | PARKVILLE   | MD    | 21234 |

| 1971 EAST JOPPA ROAD           | TOWSON      | MD    | 21234 |

| 4921 CAMPBELL ROAD             | WHITE MARSH | MD    | 21162 |

| 7400 EAST BELAIR ROAD          | BALTIMORE   | MD    | 21236 |

| 5246 HARFORD ROAD              | HAMILTON    | MD    | 21214 |

| 9103 BELAIR ROAD               | PERRY HALL  | MD    | 21236 |

+--------------------------------+-------------+-------+-------+

9 rows in set (0.12 sec)

Well, this variation was marginally faster. Let’s check out the EXPLAIN to see if what we

expected to happen actually did. Listing 8-52 shows the results.

Listing 8-52. EXPLAIN Output from Listing 8-51

mysql> EXPLAIN

-> SELECT

->  LEFT(address, 30) as address

-> , city

-> , state

-> , zip

-> FROM ZCTA x1, ZCTA x2

-> INNER JOIN StoreLocation sl

->  ON x2.zcta = sl.zip

-> WHERE x1.zcta = '21236'


C H A P T E R   8   ■ S Q L   S C E N A R I O S

-> AND ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

-> + COS(x1.lat_radians) * COS(x2.lat_radians)

-> * COS(x2.long_radians - x1.long_radians)) * 3956 <= 5 \G

*************************** 1. row ***************************

*************************** 2. row ***************************

*************************** 3. row ***************************

id: 1

select_type: SIMPLE

table: x1

type: const

possible_keys: PRIMARY

key: PRIMARY

key_len: 6

ref: const

rows: 1

Extra:

id: 1

select_type: SIMPLE

table: sl

type: ALL

possible_keys: zip

key: NULL

key_len: NULL

ref: NULL

rows: 9640

Extra:

id: 1

select_type: SIMPLE

table: x2

type: eq_ref

possible_keys: PRIMARY

key: PRIMARY

key_len: 6

ref: jobs.sl.zip

rows: 1

Extra: Using where

3 rows in set (0.00 sec)

Did it work? Well, almost. This time, MySQL at least gave itself the option of using the

index on StoreLocation.zip, but in the end, decided it was faster to simply use a table scan

of the StoreLocation data.

■Tip Take the time to consider if there is a better or faster way of doing things. Rewrite your SQL queries

to try other approaches, and do test iterations to see the results.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Finally, let’s wrap up our examination of distance calculations by combining two queries

from this section to output the stores located within five miles of the customer’s home zip

code, along with the distance to each store. Listing 8-53 shows this final report query.

Listing 8-53. Combining Two Queries for a Distance to Store Report

mysql> SELECT

->    LEFT(address, 30) AS address

->  , city

->  , state

->  , zip

->  , ROUND(ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

->  + COS(x1.lat_radians) * COS(x2.lat_radians)

->  * COS(x2.long_radians - x1.long_radians)) * 3956, 2) AS "Distance"

->  FROM ZCTA x1, ZCTA x2

->   INNER JOIN StoreLocation sl

->    ON x2.zcta = sl.zip

->  WHERE x1.zcta = '21236'

->  AND ACOS(SIN(x1.lat_radians) * SIN(x2.lat_radians)

->  + COS(x1.lat_radians) * COS(x2.lat_radians)

->  * COS(x2.long_radians - x1.long_radians)) * 3956 <= 5

-> ORDER BY Distance;

+--------------------------------+-------------+-------+-------+----------+

| address                        | city        | state | zip   | Distance |

+--------------------------------+-------------+-------+-------+----------+

| WHITE MARSH MALL  8200 PERRY H | BALTIMORE   | MD    | 21236 |     0.00 |

| 7400 EAST BELAIR ROAD          | BALTIMORE   | MD    | 21236 |     0.00 |

| 8200 PERRY HALL BOULEVARD  WHI | WHITE MARSH | MD    | 21236 |     0.00 |

| 9103 BELAIR ROAD               | PERRY HALL  | MD    | 21236 |     0.00 |

| 2401 CLEANLEIGH DRIVE          | PARKVILLE   | MD    | 21234 |     2.93 |

| 1971 EAST JOPPA ROAD           | TOWSON      | MD    | 21234 |     2.93 |

| 4921 CAMPBELL ROAD             | WHITE MARSH | MD    | 21162 |     3.99 |

| 8641 PHILADELPIA ROAD          | BALTIMORE   | MD    | 21237 |     4.05 |

| 5246 HARFORD ROAD              | HAMILTON    | MD    | 21214 |     4.86 |

+--------------------------------+-------------+-------+-------+----------+

9 rows in set (0.14 sec)

■Note Remember that the quality of the report is only as accurate as the data from which it is derived. The

more accurate your GIS data, the more accurate your distance calculations will be. For instance, if you have

GIS data specific not to a zip code, but to the latitude and longitude of your store locations, you could gener-

ate even more accurate calculations.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Generating Running Sums and Averages

Creating running sums and averages in reports is a common requirement. Running sums and

averages simply display totals or averages for certain fields in the resultset on a line-by-line

basis, with each line representing the “running,” or up-to-this-point, accumulation or average

of data.

To generate running sums in a report, you use a technique where a resultset is joined

against itself—a self join—using the greater-than or equal-to operator (>=). When doing this

type of join, the first instance of the resultset (call it set A) is referenced against itself to provide

a sum of all rows in a second instance of the resultset (call it set B) that are greater than or

equal to the row in the set A.

Recall from our earlier coverage of the nested set model for tree structures that we used

the BETWEEN predicate to gather information about the nodes under or above a specific node

in the tree. In the case of running sums and averages, you employ a similar concept, but using

the >= instead of the BETWEEN operator.

Imagine we want to fulfill the following request from our sales manager regarding our

online toy store sales: “Provide a report of all products along with total sales for each product.

Provide a column with a running sum of total sales.”

You already know how to complete the request without the running sum part, so let’s start

there. Listing 8-54 shows the piece of the request you already know how to fulfill.

Listing 8-54. Retrieving Total Sales for Each Product

mysql> SELECT p.name, SUM(coi.quantity * coi.price) AS total_sales

-> FROM Product p

->  INNER JOIN CustomerOrderItem coi

->   ON p.product_id = coi.product_id

-> GROUP BY p.name;

+---------------------------+-------------+

| name                      | total_sales |

+---------------------------+-------------+

| Action Figure - Football  |       11.95 |

| Action Figure - Gladiator |       15.95 |

| Action Figure - Tennis    |       12.95 |

| Doll                      |      119.98 |

| Soccer Ball               |       23.70 |

| Tennis Balls              |      270.75 |

| Tennis Racket             |      104.75 |

| Video Game - Football     |       46.99 |

+---------------------------+-------------+

8 rows in set (1.13 sec)

In order to produce the running sums, we must join the resultset from Listing 8-54 to

itself using a self join. But instead of using the standard equal-to operator, we use the greater-

than or equal-to operator, so that the right side of the join contains all rows up to or equal to

the comparison row on the left side of the join. Listing 8-55 shows how we accomplish this.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Listing 8-55. Creating a Running (Cumulative) Sum Column

mysql> SELECT

->  totals1.name AS Product

->  , totals1.total_sales AS "Product Sales"

->  , SUM(totals2.total_sales) AS "Cumulative Sales"

-> FROM (

->  SELECT

->   p.name

->  , SUM(coi.quantity * coi.price) AS total_sales

->  FROM Product p

->   INNER JOIN CustomerOrderItem coi

->    ON p.product_id = coi.product_id

->  GROUP BY p.name

->  ) AS totals1

-> INNER JOIN (

->  SELECT

->   p.name

->  , SUM(coi.quantity * coi.price) AS total_sales

->  FROM Product p

->   INNER JOIN CustomerOrderItem coi

->    ON p.product_id = coi.product_id

->  GROUP BY p.name

->  ) AS totals2

->   ON totals1.name >= totals2.name

-> GROUP BY totals1.name;

+---------------------------+---------------+------------------+

| Product                   | Product Sales | Cumulative Sales |

+---------------------------+---------------+------------------+

| Action Figure - Football  |         11.95 |            11.95 |

| Action Figure - Gladiator |         15.95 |            27.90 |

| Action Figure - Tennis    |         12.95 |            40.85 |

| Doll                      |        119.98 |           160.83 |

| Soccer Ball               |         23.70 |           184.53 |

| Tennis Balls              |        270.75 |           455.28 |

| Tennis Racket             |        104.75 |           560.03 |

| Video Game - Football     |         46.99 |           607.02 |

+---------------------------+---------------+------------------+

8 rows in set (0.00 sec)

We’ve used two derived tables of the resultset produced by Listing 8-54, and then used the

greater-than or equal-to predicate to join the two resultsets together. In the outermost SELECT

statement, notice that the Product Sales column comes straight from the first derived table,

while we used the matching rows from the joined table in order to produce the running sum

column.


C H A P T E R   8   ■ S Q L   S C E N A R I O S

But, do we need to join on the Product Name column? Actually, no. We join on the result-

set column we wish to order the results by. So, if we wanted to order the report by, for instance,

Product Sales, we would order the derived tables accordingly and change the ON expression to

use this field, as demonstrated in Listing 8-56. We’ve added a column for producing running

average columns, to show you that the same technique applies for generating averages.

Listing 8-56. Changing the Report Order and Generating Running Averages

mysql> SELECT

->  totals1.name AS Product

->  , totals1.total_sales AS "Product Sales"

->  , SUM(totals2.total_sales) AS "Cumulative Sales"

->  , ROUND(AVG(totals2.total_sales), 2) AS "Running Avg"

-> FROM (

->  SELECT

->   p.name

->  , SUM(coi.quantity * coi.price) AS total_sales

->  FROM Product p

->   INNER JOIN CustomerOrderItem coi

->    ON p.product_id = coi.product_id

->  GROUP BY p.name

->  ORDER BY total_sales

->  ) AS totals1

-> INNER JOIN (

->  SELECT

->   p.name

->  , SUM(coi.quantity * coi.price) AS total_sales

->  FROM Product p

->   INNER JOIN CustomerOrderItem coi

->    ON p.product_id = coi.product_id

->  GROUP BY p.name

->  ORDER BY total_sales

->  ) AS totals2

->   ON totals1.total_sales >= totals2.total_sales

-> GROUP BY totals1.name

-> ORDER BY totals1.total_sales;

+---------------------------+---------------+------------------+-------------+

| Product                   | Product Sales | Cumulative Sales | Running Avg |

+---------------------------+---------------+------------------+-------------+

| Action Figure - Football  |         11.95 |            11.95 |       11.95 |

| Action Figure - Tennis    |         12.95 |            24.90 |       12.45 |

| Action Figure - Gladiator |         15.95 |            40.85 |       13.62 |

| Soccer Ball               |         23.70 |            64.55 |       16.14 |

| Video Game - Football     |         46.99 |           111.54 |       22.31 |

| Tennis Racket             |        104.75 |           216.29 |       36.05 |

| Doll                      |        119.98 |           336.27 |       48.04 |

| Tennis Balls              |        270.75 |           607.02 |       75.88 |

+---------------------------+---------------+------------------+-------------+

8 rows in set (0.09 sec)


C H A P T E R   8   ■ S Q L   S C E N A R I O S

Summary

In this chapter, we’ve expounded on the basic principles you learned in Chapter 7, working

through a number of common scenarios. You may not have realized it, but in the examples in

this chapter, we used every join style covered in Chapter 7. Additionally, we practiced the art

of using derived tables and subqueries to produce exactly the results you need from your

schemata. You’ve sharpened your SQL skills considerably.

We started with a simple walk-through of how to rewrite OR expressions using UNION

queries in MySQL servers prior to 5.0. From there, we headed into the maintenance aspect of

removing duplicate entries and orphaned records from your databases.

Then the SQL started to fly as we examined the nested set model for tree structures in

SQL. You learned some nifty techniques for managing the metadata necessary to keep the

model accurate, and saw how the nested set model allows for aggregated reporting across

the tree without the need for recursion.

After that, we looked at a couple methods for retrieving randomized rows from a resultset,

and you saw the importance of always checking to see if one method of doing a task in SQL

will perform on different table sizes.

Next, we put on our math hats and generated a system capable of returning distance

calculations from GIS coordinates. You saw how using various derived table and subquery

techniques can alter the execution plan of reports. Finally, we went over how to create running

sums and averages to round out our coverage of SQL scenarios.

In the next chapters, you’re going to learn about the brand-new features available to you

in MySQL 5.0: stored procedures, stored functions, views, cursors, and triggers.


C H A P T E R   9

■ ■ ■

Stored Procedures

The wait is finally over. MySQL has long been criticized for its lack of stored procedures by

application developers, database administrators, business analysts, and rival databases. With

the announcement of version 5.0 came the news that stored procedures are now an option for

users of MySQL. This new functionality has generated some excitement in the MySQL com-

munity, as well as in the outlying database market. MySQL users who have wanted the ability

to use stored procedures but are living with MySQL for other reasons are rejoicing. Likewise,

folks who are using other databases because of a need for stored procedures are reevaluating

MySQL as a possible alternative to their current database choice.

In this chapter, we’ll cover the following topics related to stored procedures:

• The advantages and disadvantages of using stored procedures

• MySQL’s implementation of stored procedures

• How to create stored procedures

• How to view, alter, remove, and edit stored procedures

• How to call stored procedures

• Stored procedure permissions

Stored Procedure Considerations

A stored procedure is a collection of SQL statements used together. Stored procedures allow

you to go beyond the typical single-statement database query used to retrieve a set of records

or update a row. Stored procedure syntax supports variables, conditions, flow controls, and

cursors, so a stored procedure can perform complex processing within the database between

the database call and the resulting return. Stored procedures can consist of as little as one

statement, or they may contain hundreds or even thousands of lines.1

1. MySQL stores the procedure body in a BLOB column, which is limited to storing 64KB of data. If you

average 60 characters per line, you can store around 1,000 lines in a single procedure.


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

■Note As of the writing of this chapter, MySQL has released version 5.0.6, which is labeled a beta release.

While the stored procedure functionality in the database is stable enough to test and document, production

users are encouraged to wait until a release of the 5.0.x branch that is labeled production. With MySQL,

change is constant. Although the procedure syntax is fairly complete, we encourage you to refer to

the MySQL documentation on stored procedures at http://dev.mysql.com/doc/mysql/en/

stored-procedures.html for any updates.

With the ability to store complex processing inside the database, application developers and

database administrators find that, in certain cases, they prefer to have some of the processing

logic performed in the database before the data is returned to the client or application. Putting

logic into the database is a heavily debated topic, and should not be done without first consider-

ing the advantages and disadvantages of doing so.

The Debate Over Using Stored Procedures

As with many technologies that allow multiple approaches to solving a business problem, there

is passionate debate as to whether using stored procedures is a good thing, and if so, how they

should be used. Here, we’ll look at the arguments for and against using stored procedures, so

you can decide if stored procedures make sense for your application. As with all technology, it’s

important to consider if that technology best fills your need before rushing into deployment.

Stored Procedure Advantages

Since this chapter is about how to use stored procedures, let’s begin with a review of some of

the arguments for using them:

• Stored procedures allow you to combine multiple queries into a single trip to the data-

base. This means you can reduce traffic between the client and the database by not

needing to make multiple requests for multiple actions. Depending on your applica-

tion, saving network traffic can be significant enough to offset any counter argument.

• If you are grabbing many rows from the database and using business logic to limit the

results, a stored procedure may be able to encapsulate that logic and reduce the

amount of data returned to the client or application, as well as reduce the processing

needed in the application before presenting the results.

• Stored procedures provide a clean interface to the data. Rather than needing to build a

query in your code, you can reduce your SQL to a single, simple call statement.

• In some cases, having your SQL stored in the database makes managing queries much

easier, especially in distributed or compiled systems, where deploying new code with

embedded queries is very difficult.

• Keeping queries in the database allows the database administrator control over the

creation and optimization of queries, tables, and indexes used in returning data to

the calling client. The database administrator has a deeper understanding of the data

model, relationships, and performance of the database. SQL statements coming from


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

the database administrator will be optimized with the data model in mind, and perhaps

will spur tweaks in the database configuration and indexes.

• Stored procedures abstract the structure of the data from the application, which can

help when changes are needed in the data model by having a central location for all

query changes. In programming, this is referred to as class or package encapsulation.

The stored procedures represent a black box, where developers don’t need to be famil-

iar with the internals of the procedure. As long as developers know how to call the

procedure and how the results will come back, they can be ignorant about the proce-

dure details.

• Where security is important, stored procedures allow controlled access to viewing and

changing data. Callers do not need to have permission on specific tables; if their query

can be encapsulated in a stored procedure, they need only the ability to access that

procedure. Chapter 15 has more details about creating and managing permissions, and

database security is covered in Chapter 16.

• Using stored procedures means you are passing a single parameter or a small list of

parameters to the database. Compared with building SQL statements in your applica-

tion to pass to the database, the parameterized call is more secure. If you’re building

SQL on the fly in your code, you might be more open to attacks like SQL injection,

where attackers attempt to spoof your program and alter your dynamically built query

to expose, change, or destroy your data.

• Some databases optimize the statements of your stored procedure, parsing and organ-

izing the pieces of the procedure when it is created.2 This reduces the amount of work

necessary when the procedure is called, meaning that queries and operations in the pro-

cedure are faster than if they were sent from the client to parse and process at run time.

Stored Procedure Disadvantages

Before you decide that you should start moving all your scripts into the database, consider

some of the arguments against using stored procedures:

• Stored procedures put more load on the database server, for both processors and mem-

ory. Rather than being focused on the business of storing and retrieving data, you may

be asking the database to perform any number of logical operations, which detract

from the pure focus on representing data and data relationships.

• Working with stored procedures isn’t as simple as editing a piece of code. You need to

pull it out of the database, work on it, and then reinsert it into the database.

• Although using stored procedures can simplify the code, passing parameters can become

unwieldy. While it’s true that in any language, passing a lot of parameters gets ugly, in

many languages, you can pass references to data objects that simplify the interface.

2. As it happens, MySQL does not do this. However, queries within the procedure can benefit from the

query cache, which is discussed in Chapter 4.


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

• Needing to define an interface between the database and application adds an extra

layer of complexity and coordination. Rather than writing queries to grab the data

needed for a particular view, the developer must rely on the database administrator to

provide a procedure to get that data. Coordinating updates in the application with this

kind of reliance on an interface to the data, and on the database administrator, can add

unnecessary complexity.

• In many cases, sticking logic in stored procedures eliminates potential cross-vendor

database compatibility. Unless the syntax of your stored procedures is recognized by

another vendor’s database, the stored procedures will work only in your database.

• Using stored procedures in a database limits the processing to the databases on the

physical server. Sometimes, data needed for decisions is pulled from multiple servers or

locations—perhaps you need some pieces from databases on two different machines,

or you want to use data from a database in conjunction with data from a web service.

If you are pulling data from multiple machines or other services, you will be limited in

how much of your logic can be moved into a stored procedure. Moving pieces of your

system into procedures while leaving some in the application may add more confusion

than it’s worth.

• Debugging stored procedures can be a pain. Development and debugging tools typically

work much better for programming languages than they do for database procedures.

• Specific to MySQL, functionality for stored procedures is new and not yet production-

ready.

Having considered some of the major arguments against using stored procedures, we

suggest that you consider a few other things as a part of your decision on if and how stored

procedures fit into your application needs.

Other Considerations in Using Stored Procedures

Before we move into the implementation details for stored procedures in MySQL, you should

be thinking about how stored procedures will fit into your application design. As you look at

the possibilities for moving pieces of your application into the database, consider how you will

draw lines between layers in your application. Perhaps you want just a few procedures to run

some complex data manipulation, or maybe you are thinking about creating a complete data

abstraction layer.

If you plan on creating more than one or two procedures, you should also be thinking

about how you’ll break the functionality of your procedures into small, reusable chunks. You

may also consider creating a style guide and best-practices document to unify the interfaces

and internals of your procedures.


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

Stored Procedures in MySQL

Database vendors use a variety of programming languages and syntax for building and

managing stored procedures. Many of these databases share a set of core SQL commands,

but most of them have added extensions to facilitate the level of complexity that can be

attained within the stored procedure. Oracle procedures are written in PL/SQL. Microsoft SQL

Server 2000 procedures are written in Transact-SQL (T-SQL). To write procedures for PostgreSQL,

you use PL/psSQL. Each implementation includes some common commands, and then an

extended syntax for accomplishing more advanced logic.

MySQL developers have taken the expected approach in their implementation of stored

procedures. A database focused on simplicity and maximum performance would likely imple-

ment a simple set of features that supply the most amount of control to users wanting to move

logic into the database. MySQL has done this by implementing the SQL:2003 standard for

stored procedures and has added minimal MySQL-specific syntax. In the cases where MySQL

provides an extended use of a statement, the MySQL documentation (and this book) notes the

extension to the standard.

■Note The official standard for stored procedures is ISO/IEC 9075-x:2003, where x is a range of numbers

between 1 and 14 that indicate many different parts of the standard. For short, the standard is often referred

to as SQL:2003, SQL-2003, or SQL 2003. We refer to the standard a SQL:2003, since the official specifica-

tion uses the : as a separator, and MySQL documentation uses this format. The standard can be found on

the ISO web site (http://www.iso.org) by doing a search for 9075. The standard is available for a fee.

The SQL:2003 standard provides a basic set of commands for building multiple-statement

interactions with the database. SQL:2003 was published in 2003 as the replacement for the pre-

vious SQL standard, SQL:1999. These standards include specifications for syntax and behavior

for SQL commands that are used to build, create, and maintain stored procedures. MySQL’s

choice to stick to the SQL:2003 standard means that stored procedures created in MySQL can be

seamlessly used in other databases that support this standard. Currently, IBM’s DB2 and Oracle

Database 10g are compliant with SQL:2003. The success of moving a stored procedure from Ora-

cle or DB2 into MySQL will depend on whether any of the vendor extensions have been used.

Even if the vendor supports SQL:2003, if a stored procedure uses vendor-specific syntax, MySQL

will fail on an unrecognized command when attempting to create the procedure.

The MySQL implementation provides a wide array of controls for processing data and

logic in the database. It doesn’t have the extended syntax bells and whistles of other database

systems, but it does provide a rich set of basic commands that can create some incredibly

powerful procedures.


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

Stored procedures are processed by the MySQL server, and they are independent of the

storage engine used to store your data. If you use a feature of a particular storage engine in

your stored procedure statement, you will need to continue to use that table type to use the

stored procedure. MySQL stores the data for stored procedures in the proc table in the mysql

database. Even though procedures are all stored in one place, they are created and called by

either using the current database or by prepending a database name onto the various proce-

dure statements.

In the rest of this chapter, we’ll cover how to create, manage, and call MySQL stored

procedures.

Building Stored Procedures

SQL:2003 sets forth a set of commands to create procedures; declare variables, handlers, and

conditions; and set up cursors and constructs for flow control.

In its simplest form, you can create a stored procedure with a CREATE statement, procedure

name, and a single SQL statement. Listing 9-1 shows just how simple this can be.

Listing 9-1. Creating a Single-Statement Procedure

mysql> create procedure get_customers ()

SELECT customer_id,name FROM customer;

■Caution The stored procedure shown in Listing 9-1 has a SELECT statement as the last thing processed

in the procedure, which returns a resultset to the caller. This is really convenient, but it is a MySQL extension

to the SQL:2003 standard. The standard says you must put results into a variable or use a cursor to process

a set of results.

However frivolous Listing 9-1 may appear, it contains the required parts: a CREATE state-

ment with a procedure name and a SQL statement. Calling the stored procedure to get the

results is simple, as demonstrated in Listing 9-2.

Listing 9-2. Calling a Single-Statement Procedure

mysql> call get_customers ();

+-------------+---------+

| customer_id | name    |

+-------------+---------+

|           1 | Mike    |

|           2 | Jay     |

|           3 | Johanna |

|           4 | Michael |

|           5 | Heidi   |

|           6 | Ezra    |

+-------------+---------+

6 rows in set (0.00 sec)


C H A P T E R   9   ■ S TO R E D   P R O C E D U R E S

Other than abstracting the syntax of the query from the caller, this example doesn’t really

justify creating a procedure. The same result is just as easily available with a single query from

your application.

As a more realistic example, let’s consider the scenario of merging duplicate accounts in

your online ordering system. Your online store allows a user to create an account, with a user-

defined login and password, to use for placing orders. Suppose user Mike places an order or

two, and then doesn’t visit your site for a while. Then he returns and signs up again, inadver-

tently creating a second account. He places a few more orders. At some point, he realizes that

he has two accounts and puts in a request to have the old account removed. He says that he

would prefer to keep all the old orders on the newer account.

This means that in your database, you’ll need to find all the information associated with

the old account, move it into the new account, and delete the old account. The new account

record probably has core pieces of information like name, address, and phone, which won’t

need to change. The data to be moved may include address book and payment information,

as well as Mike’s orders. Anywhere in your system where a table has a relationship with your

customer, you’ll need to make a change. Of course, you should check for the existence of the

accounts, and the employee who makes that change may want to have a report of how many

records were changed.

Creating the series of statements to process this data merge in your code is possible, but

using a procedure to handle it would simplify your application. Listing 9-3 demonstrates how

a stored procedure might solve the requirements of this merge account request.

Listing 9-3. Creating a Multistatement Stored Procedure

DELIMITER //

CREATE PROCEDURE merge_customers

(IN old_id INT, IN new_id INT, OUT error VARCHAR(100))

SQL SECURITY DEFINER

COMMENT 'merge customer accounts'

BEGIN

DECLARE old_count INT DEFAULT 0;

DECLARE new_count INT DEFAULT 0;

DECLARE addresses_changed INT DEFAULT 0;

DECLARE payments_changed INT DEFAULT 0;

DECLARE orders_changed INT DEFAULT 0;
