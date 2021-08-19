# file io
* open
* openat
* write
* read
* close
* lseek
* ioctl
* fcntl
* dup
* dup2
* dup3
* pread
* pwrite
* readv
* writev
* truncate
* ftruncate

# processes
* getpid
* getppid

# memory allocation
* brk
* sbrk

# user and group

# process credential
* setfsuid
* setfsgid
* getuid
* geteuid
* getgid
* getegid
* setuid
* setgid
* seteuid
* setegid
* setreuid
* setregid
* getresuid
* getresgid
* setresuid
* setresgid
* getgroups
* setgroups

# time
* gettimeofday
* time
* adjtimex
* times

# system limits
* getdtablesize
* getpagesize

# system process info
* uname
* gethostname
* getdomainname
* sethostname
* setdomainname

# file io buffering
* fsync
* fdatasync
* sync
* posix_fadvise

# file system
* mount
* umount
* umount2
* statvfs
* fstatvfs

# file attributes
* stat
* lstat
* fstat
* utime
* utimes
* utimensat
* chown
* fchown
* lchown
* access
* umask
* chmod
* fchmod

# extended attributes
* setxattr
* lsetxattr
* fsetxattr
* getxattr
* lgetxattr
* fgetxattr
* removexattr
* lremovexattr
* fremovexattr
* listxattr
* llistxattr
* flistxattr

# access control lists
# directories and links
* link
* unlink
* rename
* symlink
* readlink
* mkdir
* rmdir
* readdir
* getcwd
* chdir
* fchdir
* faccessat
* fchmodat
* fchownat
* fstatat
* linkat
* mkdirat
* mknod
* mknodat
* readlinkat
* renameat
* symlinkat
* unlinkat
* chroot

# file events
# signal fundamental
# signal handlers
# signal advanced features
# timers and sleeping
# process creation
# process termination
# monitoring child process
# program execution
# process creation and program execution
# threads introduction
# thread synchronization
# thread safety and per thread storage
# thread cancellation
# thread further details
# process groups, sessions, and job control
# process priorities and scheduling
# process resources
# daemons
# secure privileged program
# capabilities
# login accounting
# shared libraries fundamentals
# shared libraries advanced features
# interprocess communication overview
# pipes and fifos
# system v message queues
# system v semaphores
# system v shared memory
# memory mappings
# virtual memory operations
# posix IPC
# posix message queues
# posix semephores
# posix shared memory
# file lokcking
# sockets unix domain
# sockets tcpip networks
# sockets internet domains
# sockets server design
# sockets advanced topics
# terminals
# alternative io models
# pseudoterminals

* accept
* accept4
* acct
* add_key
* afs_syscall
* alarm
* alloc_hugepages
* arch_prctl
* arm_fadvise
* arm_fadvise64_64
* arm_sync_file_range
* bdflush
* bind
* bpf
* break
* cacheflush
* capget
* capset
* chown32
* clock_getres
* clock_gettime
* clock_nanosleep
* clock_settime
* __clone2
* clone2
* clone
* connect
* copy_file_range
* creat
* create_module
* delete_module
* epoll_create1
* epoll_create
* epoll_ctl
* epoll_pwait
* epoll_wait
* eventfd2
* eventfd
* execve
* execveat
* _exit
* exit
* exit_group
* fadvise64
* fadvise64_64
* fallocate
* fanotify_init
* fanotify_mark
* fattach
* fchown32
* fcntl64
* fdetach
* finit_module
* flock
* fork
* free_hugepages
* fstat64
* fstatat64
* fstatfs
* fstatfs64
* ftruncate64
* futex
* futimesat
* getcontext
* getcpu
* getdents
* getdents64
* getegid32
* geteuid32
* getgid32
* getgroups32
* gethostid
* getitimer
* get_kernel_syms
* get_mempolicy
* getmsg
* getpeername
* getpgid
* getpgrp
* getpmsg
* getpriority
* getrandom
* getresgid32
* getresuid32
* getrlimit
* get_robust_list
* getrusage
* getsid
* getsockname
* getsockopt
* get_thread_area
* gettid
* getuid32
* getunwind
* gtty
* idle
* inb
* inb_p
* init_module
* inl
* inl_p
* inotify_add_watch
* inotify_init1
* inotify_init
* inotify_rm_watch
* insb
* insl
* insw
* intro
* inw
* inw_p
* io_cancel
* ioctl_console
* ioctl_fat
* ioctl_ficlone
* ioctl_ficlonerange
* ioctl_fideduperange
* ioctl_getfsmap
* ioctl_iflags
* ioctl_list
* ioctl_ns
* ioctl_tty
* ioctl_userfaultfd
* io_destroy
* io_getevents
* ioperm
* iopl
* ioprio_get
* ioprio_set
* io_setup
* io_submit
* ipc
* isastream
* kcmp
* kexec_file_load
* kexec_load
* keyctl
* kill
* killpg
* lchown32
* listen
* _llseek
* llseek
* lock
* lookup_dcookie
* lstat64
* madvise1
* madvise
* mbind
* membarrier
* memfd_create
* migrate_pages
* mincore
* mknod
* mlock2
* mlock
* mlockall
* mmap2
* mmap
* modify_ldt
* move_pages
* mprotect
* mpx
* mq_getsetattr
* mq_notify
* mq_open
* mq_timedreceive
* mq_timedsend
* mq_unlink
* mremap
* msgctl
* msgget
* msgop
* msgrcv
* msgsnd
* msync
* munlock
* munlockall
* munmap
* name_to_handle_at
* nanosleep
* newfstatat
* _newselect
* nfsservctl
* nice
* oldfstat
* oldlstat
* oldolduname
* oldstat
* olduname
* openat
* open_by_handle_at
* outb
* outb_p
* outl
* outl_p
* outsb
* outsl
* outsw
* outw
* outw_p
* pause
* perf_event_open
* perfmonctl
* personality
* phys
* pipe2
* pipe
* pivot_root
* pkey_alloc
* pkey_free
* pkey_mprotect
* poll
* ppoll
* prctl
* pread64
* preadv2
* preadv
* prlimit
* prlimit64
* process_vm_readv
* process_vm_writev
* prof
* pselect
* pselect6
* ptrace
* putmsg
* putpmsg
* pwrite64
* pwritev2
* pwritev
* query_module
* quotactl
* readahead
* reboot
* recv
* recvfrom
* recvmmsg
* recvmsg
* remap_file_pages
* renameat2
* request_key
* restart_syscall
* rtas
* rt_sigaction
* rt_sigpending
* rt_sigprocmask
* rt_sigqueueinfo
* rt_sigreturn
* rt_sigsuspend
* rt_sigtimedwait
* rt_tgsigqueueinfo
* s390_pci_mmio_read
* s390_pci_mmio_write
* s390_runtime_instr
* s390_sthyi
* sched_getaffinity
* sched_getattr
* sched_getparam
* sched_get_priority_max
* sched_get_priority_min
* sched_getscheduler
* sched_rr_get_interval
* sched_setaffinity
* sched_setattr
* sched_setparam
* sched_setscheduler
* sched_yield
* seccomp
* security
* select
* select_tut
* semctl
* semget
* semop
* semtimedop
* send
* sendfile
* sendfile64
* sendmmsg
* sendmsg
* sendto
* setcontext
* setfsgid32
* setfsuid32
* setgid32
* setgroups32
* sethostid
* setitimer
* set_mempolicy
* setns
* setpgid
* setpgrp
* setpriority
* setregid32
* setresgid32
* setresuid32
* setreuid32
* setrlimit
* set_robust_list
* setsid
* setsockopt
* set_thread_area
* set_tid_address
* settimeofday
* setuid32
* setup
* sgetmask
* shmat
* shmctl
* shmdt
* shmget
* shmop
* shutdown
* sigaction
* sigaltstack
* signal
* signalfd
* signalfd4
* sigpending
* sigprocmask
* sigqueue
* sigreturn
* sigsuspend
* sigtimedwait
* sigwaitinfo
* socket
* socketcall
* socketpair
* splice
* spu_create
* spu_run
* ssetmask
* stat64
* statfs
* statfs64
* statx
* stime
* stty
* subpage_prot
* swapcontext
* swapoff
* swapon
* sync_file_range2
* sync_file_range
* syncfs
* _syscall
* syscall
* syscalls
* _sysctl
* sysctl
* sysfs
* sysinfo
* syslog
* tee
* tgkill
* timer_create
* timer_delete
* timerfd_create
* timerfd_gettime
* timerfd_settime
* timer_getoverrun
* timer_gettime
* timer_settime
* tkill
* truncate64
* tuxcall
* ugetrlimit
* unimplemented
* unshare
* uselib
* userfaultfd
* ustat
* vfork
* vhangup
* vm86
* vm86old
* vmsplice
* vserver
* wait
* wait3
* wait4
* waitid
* waitpid
