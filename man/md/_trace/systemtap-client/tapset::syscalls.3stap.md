# tapset::syscalls(3stap) - systemtap syscall tapset

Systemtap Tapset Reference, May 2021


<a name="description"></a>

# Description

Following is an overview of available syscall probes and
convenience variables they offer. By default, each syscall probe has name and
argstr convenience variables, which are not included in the overview in order
to keep it short. Non dwarf-based nd_syscall probes are supposed to have the
same convenience variables. 

* 

* 

* **syscall.accept**  
  addr_uaddr, addrlen_uaddr, sockfd


* **syscall.accept4**  
  addr_uaddr, addrlen_uaddr, flags, flags_str, sockfd


* **syscall.access**  
  mode, mode_str, pathname, pathname_unquoted


* **syscall.acct**  
  filename, filename_unquoted


* **syscall.add_key**  
  description_uaddr, payload_uaddr, plen, ringid, type_uaddr


* **syscall.adjtimex**  
  buf_str, buf_uaddr


* **syscall.alarm**  
  seconds


* **syscall.arch_prctl**  
  addr, code, code_str


* **syscall.bdflush**  
  data, data_str, func


* **syscall.bind**  
  addrlen, my_addr_uaddr, sockfd, uaddr_af, uaddr_ip, uaddr_ip_port, uaddr_ipv6_flowinfo, uaddr_ipv6_scope_id


* **syscall.bpf**  
  attr_uaddr, cmd, cmd_str, size


* **syscall.brk**  
  brk


* **syscall.capget**  
  data_uaddr, header_uaddr


* **syscall.capset**  
  data_uaddr, header_uaddr


* **syscall.chdir**  
  path, path_unquoted


* **syscall.chmod**  
  mode, path, path_unquoted


* **syscall.chown**  
  group, owner, path, path_unquoted


* **syscall.chown16**  
  group, owner, path, path_unquoted


* **syscall.chroot**  
  path, path_unquoted


* **syscall.clock_adjtime**  
  clk_id, clk_id_str, tx_uaddr, tx_uaddr_str


* **syscall.clock_getres**  
  clk_id, clk_id_str, res_uaddr


* **syscall.clock_gettime**  
  clk_id, clk_id_str, tp_uaddr


* **syscall.clock_nanosleep**  
  clk_id, clk_id_str, flags, flags_str, rem_uaddr, req_str, req_uaddr


* **syscall.clock_settime**  
  clk_id, clk_id_str, tp_uaddr, tp_uaddr_str


* **syscall.clone**  
  $id, $regs, child_tid_uaddr, clone_flags, int, parent_tid_uaddr, pt_regs*, stack_start


* **syscall.close**  
  fd


* **syscall.compat_adjtimex**  
  $id, $regs, buf_str, buf_uaddr, int, pt_regs*


* **syscall.compat_clock_nanosleep**  
  $id, $regs, clk_id, clk_id_str, flags, flags_str, int, pt_regs*, rem_uaddr, req_str, req_uaddr


* **syscall.compat_execve**  
  args, env_str, filename


* **syscall.compat_execveat**  
  args, dirfd, dirfd_str, env_str, filename, flags, flags_str


* **syscall.compat_fadvise64**  
  $id, $regs, advice, advice_str, fd, int, len, offset, pt_regs*


* **syscall.compat_fadvise64_64**  
  $id, $regs, advice, advice_str, fd, int, len, offset, pt_regs*


* **syscall.compat_fallocate**  
  $id, $regs, fd, int, len, mode, mode_str, offset, pt_regs*


* **syscall.compat_ftruncate64**  
  $id, $regs, fd, int, length, pt_regs*


* **syscall.compat_futex**  
  $id, $regs, futex_uaddr, int, op, pt_regs*, uaddr2_uaddr, utime_uaddr, val3, val


* **syscall.compat_futimesat**  
  $id, $regs, dirfd, dirfd_str, filename, filename_uaddr, filename_unquoted, int, pt_regs*, tvp_str, tvp_uaddr


* **syscall.compat_getitimer**  
  value_uaddr, which


* **syscall.compat_lookup_dcookie**  
  buffer_uaddr, cookie, len


* **syscall.compat_nanosleep**  
  $id, $regs, int, pt_regs*, rem_uaddr, req_str, req_uaddr


* **syscall.compat_ppoll**  
  $id, $regs, fds_uaddr, int, nfds, pt_regs*, sigmask, sigsetsize, tsp, tsp_str


* **syscall.compat_pselect6**  
  $id, $regs, exceptfds, int, nfds, pt_regs*, readfds, sigmask, timeout, timeout_str, writefds


* **syscall.compat_readahead**  
  $id, $regs, count, fd, int, offset, pt_regs*


* **syscall.compat_recvmmsg**  
  $id, $regs, flags, flags_str, int, mmsg_uaddr, pt_regs*, s, timeout_str, timeout_uaddr, vlen


* **syscall.compat_select**  
  exceptfds_uaddr, n, readfds_uaddr, timeout_str, timeout_uaddr, writefds_uaddr


* **syscall.compat_setitimer**  
  ovalue_uaddr, value_str, value_uaddr, which, which_str


* **syscall.compat_signalfd**  
  flags


* **syscall.compat_sys_msgctl**  
  buf_uaddr, cmd, cmd_str, msqid


* **syscall.compat_sys_msgrcv**  
  msgflg, msgflg_str, msgp_uaddr, msgsz, msgtyp, msqid


* **syscall.compat_sys_msgsnd**  
  msgflg, msgflg_str, msgp_uaddr, msgsz, msqid


* **syscall.compat_sys_recvmsg**  
  flags, flags_str, msg_uaddr, s


* **syscall.compat_sys_semctl**  
  arg, cmd, cmdstr, semid, semnum


* **syscall.compat_sys_semtimedop**  
  nsops, semid, sops_uaddr, timeout_str, timeout_uaddr


* **syscall.compat_sys_sendmsg**  
  flags, flags_str, msg_uaddr, s


* **syscall.compat_sys_shmat**  
  shmaddr_uaddr, shmflg, shmflg_str, shmid


* **syscall.compat_sys_shmctl**  
  buf_uaddr, cmd, cmd_str, shmid


* **syscall.compat_sys_utimes**  
  $id, $regs, filename, filename_unquoted, int, pt_regs*, timeval, tvp_uaddr_str


* **syscall.compat_truncate64**  
  $id, $regs, int, length, path, path_uaddr, path_unquoted, pt_regs*


* **syscall.compat_utime**  
  $id, $regs, actime, buf_uaddr, filename, filename_uaddr, filename_unquoted, int, modtime, pt_regs*


* **syscall.compat_utimensat**  
  $id, $regs, dfd, dfd_str, filename, filename_uaddr, filename_unquoted, flags, flags_str, int, pt_regs*, tsp_str, tsp_uaddr


* **syscall.compat_vmsplice**  
  $id, $regs, fd, flags, flags_str, int, iov, nr_segs, pt_regs*


* **syscall.connect**  
  addrlen, serv_addr_uaddr, sockfd, uaddr_af, uaddr_ip, uaddr_ip_port, uaddr_ipv6_flowinfo, uaddr_ipv6_scope_id


* **syscall.copy_file_range**  
  fd_in, fd_out, flags, len, off_in, off_out


* **syscall.creat**  
  mode, pathname, pathname_unquoted


* **syscall.delete_module**  
  flags, flags_str, name_user, name_user_unquoted


* **syscall.dup**  
  oldfd


* **syscall.dup2**  
  flags, flags_str, newfd, oldfd


* **syscall.dup3**  
  flags, flags_str, newfd, oldfd


* **syscall.epoll_create**  
  flags, size


* **syscall.epoll_ctl**  
  epfd, event_uaddr, fd, op, op_str


* **syscall.epoll_pwait**  
  epfd, events_uaddr, maxevents, sigmask_uaddr, sigsetsize, timeout


* **syscall.epoll_wait**  
  epfd, events_uaddr, maxevents, timeout


* **syscall.eventfd**  
  count, flags, flags_str


* **syscall.execve**  
  args, env_str, filename


* **syscall.execveat**  
  args, dirfd, dirfd_str, env_str, filename, flags, flags_str


* **syscall.exit**  
  status


* **syscall.exit_group**  
  status


* **syscall.faccessat**  
  dirfd, dirfd_str, mode, mode_str, pathname, pathname_unquoted


* **syscall.fadvise64**  
  advice, advice_str, fd, len, offset


* **syscall.fadvise64_64**  
  $id, $regs, advice, advice_str, fd, int, len, offset, pt_regs*


* **syscall.fallocate**  
  fd, len, mode, mode_str, offset


* **syscall.fanotify_init**  
  event_f_flags, event_f_flags_str, flags, flags_str


* **syscall.fanotify_mark**  
  dirfd, dirfd_str, fanotify_fd, flags, flags_str, mask, mask_str, pathname, pathname_unquoted


* **syscall.fchdir**  
  fd


* **syscall.fchmod**  
  fildes, mode


* **syscall.fchmodat**  
  dirfd, dirfd_str, mode, pathname, pathname_unquoted


* **syscall.fchown**  
  fd, group, owner


* **syscall.fchown16**  
  fd, group, owner


* **syscall.fchownat**  
  dirfd, dirfd_str, flags, flags_str, group, owner, pathname, pathname_unquoted


* **syscall.fcntl**  
  arg, cmd, cmd_str, fd


* **syscall.fdatasync**  
  fd


* **syscall.fgetxattr**  
  filedes, name_str, name_str_unquoted, size, value_uaddr


* **syscall.finit_module**  
  fd, flags, flags_str, uargs, uargs_unquoted


* **syscall.flistxattr**  
  filedes, list_uaddr, size


* **syscall.flock**  
  fd, operation


* **syscall.fork**  
  


* **syscall.fremovexattr**  
  filedes, name_str, name_str_unquoted, name_uaddr


* **syscall.fsetxattr**  
  filedes, flags, flags_str, name_str, name_str_unquoted, name_uaddr, size, value_str, value_uaddr


* **syscall.fstat**  
  buf_uaddr, filedes


* **syscall.fstatat**  
  buf_uaddr, dirfd, dirfd_str, flags, flags_str, path, path_unquoted


* **syscall.fstatfs**  
  buf_uaddr, fd


* **syscall.fstatfs64**  
  buf_uaddr, fd, sz


* **syscall.fsync**  
  fd


* **syscall.ftruncate**  
  fd, length


* **syscall.ftruncate64**  
  $id, $regs, fd, int, length, pt_regs*


* **syscall.futex**  
  futex_uaddr, op, uaddr2_uaddr, utime_uaddr, val3, val


* **syscall.futimesat**  
  dirfd, dirfd_str, filename, filename_uaddr, filename_unquoted, tvp_str, tvp_uaddr


* **syscall.get_mempolicy**  
  addr, flags, flags_str, maxnode, nmask_uaddr, policy_uaddr


* **syscall.get_robust_list**  
  len_uaddr, list_head_uaddr, pid


* **syscall.get_thread_area**  
  u_info_str, u_info_uaddr


* **syscall.getcpu**  
  cpu_uaddr, node_uaddr, tcache_uaddr


* **syscall.getcwd**  
  buf_uaddr, size


* **syscall.getdents**  
  count, dirp_uaddr, fd


* **syscall.getegid**  
  


* **syscall.geteuid**  
  


* **syscall.getgid**  
  


* **syscall.getgroups**  
  list_uaddr, size


* **syscall.getitimer**  
  value_uaddr, which


* **syscall.getpeername**  
  name_uaddr, namelen_uaddr, s


* **syscall.getpgid**  
  pid


* **syscall.getpgrp**  
  


* **syscall.getpid**  
  


* **syscall.getppid**  
  


* **syscall.getpriority**  
  which, who


* **syscall.getrandom**  
  buf, buf_unquoted, count, flags, flags_str


* **syscall.getresgid**  
  egid_uaddr, rgid_uaddr, sgid_uaddr


* **syscall.getresuid**  
  euid_uaddr, ruid_uaddr, suid_uaddr


* **syscall.getrlimit**  
  resource, rlim_uaddr


* **syscall.getrusage**  
  usage_uaddr, who, who_str


* **syscall.getsid**  
  pid


* **syscall.getsockname**  
  name_uaddr, namelen_uaddr, s


* **syscall.getsockopt**  
  fd, level, level_str, optlen_uaddr, optname, optname_str, optval_uaddr


* **syscall.gettid**  
  


* **syscall.gettimeofday**  
  tv_uaddr, tz_uaddr


* **syscall.getuid**  
  


* **syscall.getxattr**  
  name_str, name_str_unquoted, path, path_unquoted, size, value_uaddr


* **syscall.init_module**  
  len, uargs, uargs_unquoted, umod_uaddr


* **syscall.inotify_add_watch**  
  fd, mask, mask_str, path, path_uaddr, path_unquoted


* **syscall.inotify_init**  
  flags


* **syscall.inotify_rm_watch**  
  fd, wd


* **syscall.io_cancel**  
  ctx_id, iocb_uaddr, result_uaddr


* **syscall.io_destroy**  
  ctx


* **syscall.io_getevents**  
  ctx_id, events_uaddr, min_nr, nr, timeout_uaddr, timestr


* **syscall.io_setup**  
  ctxp_uaddr, maxevents


* **syscall.io_submit**  
  ctx_id, iocbpp_uaddr, nr


* **syscall.ioctl**  
  argp, fd, request


* **syscall.ioperm**  
  from, num, turn_on


* **syscall.iopl**  
  level


* **syscall.ioprio_get**  
  which, which_str, who


* **syscall.ioprio_set**  
  ioprio, ioprio_str, which, which_str, who


* **syscall.kcmp**  
  idx1, idx2, pid1, pid2, type, type_str


* **syscall.kexec_file_load**  
  cmdline, cmdline_len, cmdline_unquoted, flags, flags_str, initrd_fd, kernel_fd


* **syscall.kexec_load**  
  entry, flags, flags_str, nr_segments, segments_uaddr


* **syscall.keyctl**  
  arg2, arg3, arg4, arg5, option


* **syscall.kill**  
  pid, sig, sig_name


* **syscall.lchown**  
  group, owner, path, path_unquoted


* **syscall.lchown16**  
  group, owner, path, path_unquoted


* **syscall.lgetxattr**  
  name_str, name_str_unquoted, path, path_unquoted, size, value_uaddr


* **syscall.link**  
  newpath, newpath_unquoted, oldpath, oldpath_unquoted


* **syscall.linkat**  
  flags, flags_str, newdirfd, newdirfd_str, newpath, newpath_unquoted, olddirfd, olddirfd_str, oldpath, oldpath_unquoted


* **syscall.listen**  
  backlog, sockfd


* **syscall.listxattr**  
  list_uaddr, path, path_uaddr, path_unquoted, size


* **syscall.llistxattr**  
  list_uaddr, path, path_uaddr, path_unquoted, size


* **syscall.llseek**  
  fd, offset_high, offset_low, result_uaddr, whence, whence_str


* **syscall.lookup_dcookie**  
  buffer_uaddr, cookie, len


* **syscall.lremovexattr**  
  name_str, name_str_unquoted, name_uaddr, path, path_uaddr, path_unquoted


* **syscall.lseek**  
  fildes, offset, whence, whence_str


* **syscall.lsetxattr**  
  flags, flags_str, name_str, name_str_unquoted, name_uaddr, path, path_uaddr, path_unquoted, size, value_str, value_uaddr


* **syscall.lstat**  
  buf_uaddr, path, path_unquoted


* **syscall.madvise**  
  advice, advice_str, length, start


* **syscall.mbind**  
  flags, flags_str, len, maxnode, mode, mode_str, nmask_uaddr, start


* **syscall.membarrier**  
  cmd, cmd_str, flags


* **syscall.memfd_create**  
  flags, flags_str, uname, uname_unquoted


* **syscall.migrate_pages**  
  maxnode, new_nodes, old_nodes, pid


* **syscall.mincore**  
  length, start, vec_uaddr


* **syscall.mkdir**  
  mode, pathname, pathname_uaddr, pathname_unquoted


* **syscall.mkdirat**  
  dirfd, dirfd_str, mode, pahtname_unquoted, pathname


* **syscall.mknod**  
  dev, mode, mode_str, pathname, pathname_unquoted


* **syscall.mknodat**  
  dev, dirfd, dirfd_str, mode, mode_str, pathname, pathname_unquoted


* **syscall.mlock**  
  addr, len


* **syscall.mlock2**  
  addr, flags, flags_str, len


* **syscall.mlockall**  
  flags, flags_str


* **syscall.mmap2**  
  fd, flags, flags_str, length, pgoffset, prot, prot_str, start


* **syscall.modify_ldt**  
  bytecount, func, ptr_uaddr


* **syscall.mount**  
  data, data_unquoted, filesystemtype, filesystemtype_unquoted, mountflags, mountflags_str, source, source_unquoted, target, target_unquoted


* **syscall.move_pages**  
  flags, flags_str, nodes, nr_pages, pages, pid, status


* **syscall.mprotect**  
  addr, len, prot, prot_str


* **syscall.mq_getsetattr**  
  mqdes, u_mqstat_uaddr, u_omqstat_uaddr


* **syscall.mq_notify**  
  mqdes, notification_uaddr


* **syscall.mq_open**  
  filename, filename_unquoted, mode, name_uaddr, oflag, oflag_str, u_attr_uaddr


* **syscall.mq_timedreceive**  
  abs_timeout_uaddr, mqdes, msg_len, msg_prio_uaddr, msg_ptr_uaddr


* **syscall.mq_timedsend**  
  abs_timeout_uaddr, mqdes, msg_len, msg_prio, msg_ptr_uaddr


* **syscall.mq_unlink**  
  u_name, u_name_uaddr, u_name_unquoted


* **syscall.mremap**  
  flags, flags_str, new_address, new_size, old_address, old_size


* **syscall.msgctl**  
  buf_uaddr, cmd, cmd_str, msqid


* **syscall.msgget**  
  key, key_str, msgflg, msgflg_str


* **syscall.msgrcv**  
  msgflg, msgflg_str, msgp_uaddr, msgsz, msgtyp, msqid


* **syscall.msgsnd**  
  msgflg, msgflg_str, msgp_uaddr, msgsz, msqid


* **syscall.msync**  
  flags, flags_str, length, start


* **syscall.munlock**  
  addr, len


* **syscall.munlockall**  
  


* **syscall.munmap**  
  length, start


* **syscall.name_to_handle_at**  
  dfd, dfd_str, flags, flags_str, handle_uaddr, mnt_id_uaddr, pathname, pathname_unquoted


* **syscall.nanosleep**  
  rem_uaddr, req_str, req_uaddr


* **syscall.ni_syscall**  
  


* **syscall.nice**  
  inc


* **syscall.open**  
  filename, filename_unquoted, flags, flags_str, mode


* **syscall.open_by_handle_at**  
  flags, flags_str, handle_uaddr, mount_dfd, mount_dfd_str


* **syscall.openat**  
  dfd, dfd_str, filename, filename_unquoted, flags, flags_str, mode


* **syscall.pause**  
  


* **syscall.perf_event_open**  
  attr_uaddr, cpu, flags, flags_str, group_fd, pid


* **syscall.personality**  
  persona


* **syscall.pipe**  
  fildes_uaddr, flag_str, flags, pipe0, pipe1


* **syscall.pivot_root**  
  new_root_str, new_root_str_unquoted, old_root_str, old_root_str_unquoted


* **syscall.pkey_alloc**  
  flags, init_val, init_val_str


* **syscall.pkey_free**  
  pkey


* **syscall.pkey_mprotect**  
  addr, len, pkey, prot, prot_str


* **syscall.poll**  
  nfds, timeout, ufds_uaddr


* **syscall.ppoll**  
  fds_uaddr, nfds, sigmask, sigsetsize, tsp, tsp_str


* **syscall.prctl**  
  arg2, arg3, arg4, arg5, option


* **syscall.pread**  
  buf_uaddr, count, fd, offset


* **syscall.preadv**  
  count, fd, offset, vector_uaddr


* **syscall.preadv2**  
  count, fd, flags, flags_str, offset, vector_uaddr


* **syscall.prlimit64**  
  new_rlim_str, new_rlim_uaddr, old_rlim_uaddr, pid, resource, resource_str


* **syscall.process_vm_readv**  
  flags, liovcnt, local_iov_uaddr, pid, remote_iov_uaddr, riovcnt


* **syscall.process_vm_writev**  
  flags, liovcnt, local_iov_uaddr, pid, remote_iov_uaddr, riovcnt


* **syscall.pselect6**  
  exceptfds, nfds, readfds, sigmask, timeout, timeout_str, writefds


* **syscall.ptrace**  
  addr, data, pid, request


* **syscall.pwrite**  
  buf_str, buf_uaddr, count, fd, offset


* **syscall.pwrite32**  
  $id, $regs, buf_str, buf_uaddr, count, fd, int, offset, pt_regs*


* **syscall.pwritev**  
  count, fd, offset, vector_uaddr


* **syscall.pwritev2**  
  count, fd, flags, flags_str, offset, vector_uaddr


* **syscall.quotactl**  
  addr_uaddr, cmd, cmd_str, id, special, special_str, special_str_unquoted


* **syscall.read**  
  buf_uaddr, count, fd


* **syscall.readahead**  
  count, fd, offset


* **syscall.readdir**  
  count, dirent, fd


* **syscall.readlink**  
  buf_uaddr, bufsiz, path, path_unquoted


* **syscall.readlinkat**  
  buf_uaddr, bufsiz, dfd, dfd_str, path, path_unquoted


* **syscall.readv**  
  count, fd, vector_uaddr


* **syscall.reboot**  
  arg_uaddr, flag, flag_str, magic2, magic2_str, magic, magic_str


* **syscall.recv**  
  buf_uaddr, flags, flags_str, len, s


* **syscall.recvfrom**  
  addr_uaddr, addrlen_uaddr, buf_uaddr, flags, flags_str, len, s


* **syscall.recvmmsg**  
  flags, flags_str, mmsg_uaddr, s, timeout_str, timeout_uaddr, vlen


* **syscall.recvmsg**  
  flags, flags_str, msg_uaddr, s


* **syscall.remap_file_pages**  
  flags, flags_str, pgoff, prot, prot_str, size, start


* **syscall.removexattr**  
  name_str, name_str_unquoted, path, path_unquoted


* **syscall.rename**  
  newpath, newpath_unquoted, oldpath, oldpath_unquoted


* **syscall.renameat**  
  newdfd, newdfd_str, newname, newname_str, newname_str_unquoted, olddfd, olddfd_str, oldname, oldname_str, oldname_str_unquoted


* **syscall.renameat2**  
  flags, flags_str, newdfd, newdfd_str, newname, newname_str, newname_str_unquoted, olddfd, olddfd_str, oldname, oldname_str, oldname_str_unquoted


* **syscall.request_key**  
  callout_info_uaddr, description_str, description_str_unquoted, description_uaddr, destringid, type_str, type_str_unquoted, type_uaddr


* **syscall.restart_syscall**  
  


* **syscall.rmdir**  
  pathname, pathname_unquoted


* **syscall.rt_sigaction**  
  act_str, act_uaddr, oact_uaddr, sig, sig_str, sigsetsize


* **syscall.rt_sigaction32**  
  act_str, act_uaddr, oact_uaddr, sig, sig_str, sigsetsize


* **syscall.rt_sigpending**  
  set_uaddr, sigsetsize


* **syscall.rt_sigprocmask**  
  how, how_str, oldset_uaddr, set_str, set_uaddr, sigsetsize


* **syscall.rt_sigqueueinfo**  
  pid, sig, sig_name, siginfo_str, uinfo_uaddr


* **syscall.rt_sigsuspend**  
  set_str, set_uaddr, sigsetsize


* **syscall.rt_sigtimedwait**  
  sigsetsize, uinfo_str, uinfo_uaddr, uthese_str, uthese_uaddr, uts_str, uts_uaddr


* **syscall.rt_tgsigqueueinfo**  
  sig, sig_str, tgid, tid, uinfo_str, uinfo_uaddr


* **syscall.sched_get_priority_max**  
  policy, policy_str


* **syscall.sched_get_priority_min**  
  policy, policy_str


* **syscall.sched_getaffinity**  
  len, mask_uaddr, pid


* **syscall.sched_getattr**  
  flags, pid, sched_attr_str, sched_attr_uaddr, size


* **syscall.sched_getparam**  
  p_uaddr, pid


* **syscall.sched_getscheduler**  
  pid


* **syscall.sched_rr_get_interval**  
  pid, tp_uaddr


* **syscall.sched_setaffinity**  
  len, mask_uaddr, pid


* **syscall.sched_setattr**  
  flags, pid, sched_attr_str, sched_attr_uaddr


* **syscall.sched_setparam**  
  p_uaddr, pid


* **syscall.sched_setscheduler**  
  p_uaddr, pid, policy, policy_str


* **syscall.sched_yield**  
  


* **syscall.seccomp**  
  flags, flags_str, op, op_str, uargs_uaddr


* **syscall.select**  
  exceptfds_uaddr, n, readfds_uaddr, timeout_str, timeout_uaddr, writefds_uaddr


* **syscall.semctl**  
  arg, cmd, cmdstr, semid, semnum


* **syscall.semget**  
  key, key_str, nsems, semflg, semflg_str


* **syscall.semop**  
  nsops, semid, sops_uaddr


* **syscall.semtimedop**  
  nsops, semid, sops_uaddr, timeout_str, timeout_uaddr


* **syscall.send**  
  buf, buf_uaddr, flags, flags_str, len, s


* **syscall.sendfile**  
  count, in_fd, offset_uaddr, out_fd


* **syscall.sendmmsg**  
  flags, flags_str, mmsg_uaddr, s, vlen


* **syscall.sendmsg**  
  flags, flags_str, msg_uaddr, s


* **syscall.sendto**  
  buf, buf_uaddr, flags, flags_str, len, s, to_str, to_uaddr, tolen


* **syscall.set_mempolicy**  
  maxnode, mode, mode_str, nmask_uaddr


* **syscall.set_robust_list**  
  len, list_head_uaddr


* **syscall.set_thread_area**  
  u_info_str, u_info_uaddr


* **syscall.set_tid_address**  
  tidptr_uaddr


* **syscall.setdomainname**  
  domainname_str, domainname_str_unquoted, domainname_uaddr, len


* **syscall.setfsgid**  
  fsgid


* **syscall.setfsuid**  
  fsuid


* **syscall.setgid**  
  gid


* **syscall.setgroups**  
  list_uaddr, size


* **syscall.sethostname**  
  hostname_uaddr, len, name_str, name_str_unquoted


* **syscall.setitimer**  
  ovalue_uaddr, value_str, value_uaddr, which, which_str


* **syscall.setns**  
  fd, nstype, nstype_str


* **syscall.setpgid**  
  pgid, pid


* **syscall.setpriority**  
  prio, which, which_str, who


* **syscall.setregid**  
  egid, rgid


* **syscall.setregid16**  
  egid, rgid


* **syscall.setresgid**  
  egid, rgid, sgid


* **syscall.setresgid16**  
  egid, rgid, sgid


* **syscall.setresuid**  
  euid, ruid, suid


* **syscall.setresuid16**  
  euid, ruid, suid


* **syscall.setreuid**  
  euid, ruid


* **syscall.setreuid16**  
  euid, ruid


* **syscall.setrlimit**  
  resource, resource_str, rlim_str, rlim_uaddr


* **syscall.setsid**  
  


* **syscall.setsockopt**  
  fd, level, level_str, optlen, optname, optname_str, optval_uaddr


* **syscall.settimeofday**  
  tv_str, tv_uaddr, tz_str, tz_uaddr


* **syscall.settimeofday32**  
  tv_str, tv_uaddr, tz_str, tz_uaddr


* **syscall.setuid**  
  uid


* **syscall.setxattr**  
  flags, flags_str, name_str, name_str_unquoted, name_uaddr, path, path_uaddr, path_unquoted, size, value_str, value_uaddr


* **syscall.sgetmask**  
  


* **syscall.shmat**  
  shmaddr_uaddr, shmflg, shmflg_str, shmid


* **syscall.shmctl**  
  buf_uaddr, cmd, cmd_str, shmid


* **syscall.shmdt**  
  shmaddr_uaddr


* **syscall.shmget**  
  key, shmflg, shmflg_str, size


* **syscall.shutdown**  
  how, how_str, s


* **syscall.sigaction**  
  $id, $regs, act_str, act_uaddr, int, oact_uaddr, pt_regs*, sig, sig_str


* **syscall.sigaction32**  
  act_str, act_uaddr, oact_uaddr, sig, sig_str


* **syscall.sigaltstack**  
  uoss_uaddr, uss_str, uss_uaddr


* **syscall.signal**  
  handler, handler_str, sig, sig_str


* **syscall.signalfd**  
  flags


* **syscall.sigpending**  
  set


* **syscall.sigprocmask**  
  how, how_str, oldset_uaddr, set_uaddr


* **syscall.sigsuspend**  
  mask, mask_str


* **syscall.socket**  
  family, family_str, protocol, protocol_str, type, type_str


* **syscall.socketpair**  
  family, family_str, protocol, protocol_str, sv_uaddr, type, type_str


* **syscall.splice**  
  fd_in, fd_out, flags, flags_str, len, off_in, off_out


* **syscall.ssetmask**  
  newmask, newmask_str


* **syscall.stat**  
  buf_uaddr, filename, filename_uaddr, filename_unquoted


* **syscall.statfs**  
  buf_uaddr, path, path_unquoted


* **syscall.statfs64**  
  buf_uaddr, path, path_unquoted, sz


* **syscall.statx**  
  buf_uaddr, dfd, dfd_str, filename, filename_uaddr, filename_unquoted, flags, flags_str, mask, mask_str


* **syscall.stime**  
  t_uaddr


* **syscall.swapoff**  
  path, path_uaddr, path_unquoted


* **syscall.swapon**  
  path, path_uaddr, path_unquoted, swapflags, swapflags_str


* **syscall.symlink**  
  newpath, oldpath, oldpath_unquoted


* **syscall.symlinkat**  
  newdfd, newdfd_str, newname, newname_str, newname_str_unquoted, oldname, oldname_str, oldname_str_unquoted


* **syscall.sync**  
  


* **syscall.sync_file_range**  
  fd, flags, flags_str, nbytes, offset


* **syscall.syncfs**  
  fd


* **syscall.sysctl**  
  $id, $regs, args, int, pt_regs*


* **syscall.sysfs**  
  arg1, arg2, option


* **syscall.sysinfo**  
  info_str, info_uaddr


* **syscall.syslog**  
  bufp_uaddr, len, type


* **syscall.tee**  
  fdin, fdout, flags, len


* **syscall.tgkill**  
  pid, sig, sig_str, tgid


* **syscall.time**  
  t_uaddr


* **syscall.timer_create**  
  clockid, clockid_str, evp_uaddr, timerid_uaddr


* **syscall.timer_delete**  
  timerid


* **syscall.timer_getoverrun**  
  timerid


* **syscall.timer_gettime**  
  timerid, value_uaddr


* **syscall.timer_settime**  
  flags, ovalue_uaddr, timerid, value_str, value_uaddr


* **syscall.timerfd_create**  
  clockid, clockid_str, flags, flags_str


* **syscall.timerfd_gettime**  
  fd, value_uaddr


* **syscall.timerfd_settime**  
  fd, flags, flags_str, ovalue_uaddr, value_str, value_uaddr


* **syscall.times**  
  buf_str, buf_uaddr


* **syscall.tkill**  
  pid, sig, sig_str


* **syscall.truncate**  
  length, path, path_uaddr, path_unquoted


* **syscall.umask**  
  mask


* **syscall.umount**  
  flags, flags_str, target, target_unquoted


* **syscall.uname**  
  name_uaddr


* **syscall.unlink**  
  pathname, pathname_uaddr, pathname_unquoted


* **syscall.unlinkat**  
  dfd, dfd_str, flag, flag_str, pathname, pathname_str, pathname_str_unquoted


* **syscall.unshare**  
  unshare_flags, unshare_flags_str


* **syscall.uselib**  
  $id, $regs, int, library, library_uaddr, library_unquoted, pt_regs*


* **syscall.userfaultfd**  
  flags, flags_str


* **syscall.ustat**  
  dev, ubuf_uaddr


* **syscall.ustat32**  
  dev, ubuf_uaddr


* **syscall.utime**  
  actime, buf_uaddr, filename, filename_uaddr, filename_unquoted, modtime


* **syscall.utimensat**  
  dfd, dfd_str, filename, filename_uaddr, filename_unquoted, flags, flags_str, tsp_str, tsp_uaddr


* **syscall.utimes**  
  filename, filename_uaddr, filename_unquoted, tvp_uaddr, tvp_uaddr_str


* **syscall.vfork**  
  


* **syscall.vhangup**  
  


* **syscall.vmsplice**  
  fd, flags, flags_str, iov, nr_segs


* **syscall.wait4**  
  options, options_str, pid, rusage_uaddr, status_uaddr


* **syscall.waitid**  
  infop_uaddr, options, options_str, pid, rusage_uaddr, which, which_str


* **syscall.waitpid**  
  options, options_str, pid, status_uaddr


* **syscall.write**  
  buf_str, buf_uaddr, count, fd


* **syscall.writev**  
  count, fd, vector_uaddr
  

<a name="see-also"></a>

# See Also
  
_stap_(1),
_stapprobes_(3stap)
