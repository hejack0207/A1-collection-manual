# tapset::signal(3stap) - systemtap signal tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


  This family of probe points is used to probe signal activities.
  Since there are so many signals sent to processes at any given
  point, it is advisable to filter the information according to the
  requirements.  For example, filter only for a particular signal
  (if sig==2) or for a particular process (if pid_name==stap).


* 

* **signal.send**  
  Signal being sent to a process
*  See 
  _probe::signal.send_(3stap)
   for details.


* **signal.send.return**  
  Signal being sent to a process completed (deprecated in SystemTap 2.1)
*  See 
  _probe::signal.send.return_(3stap)
   for details.


* **signal.checkperm**  
  Check being performed on a sent signal
*  See 
  _probe::signal.checkperm_(3stap)
   for details.


* **signal.checkperm.return**  
  Check performed on a sent signal completed
*  See 
  _probe::signal.checkperm.return_(3stap)
   for details.


* **signal.wakeup**  
  Sleeping process being wakened for signal
*  See 
  _probe::signal.wakeup_(3stap)
   for details.


* **signal.check_ignored**  
  Checking to see signal is ignored
*  See 
  _probe::signal.check_ignored_(3stap)
   for details.


* **signal.check_ignored.return**  
  Check to see signal is ignored completed
*  See 
  _probe::signal.check_ignored.return_(3stap)
   for details.


* **signal.force_segv**  
  Forcing send of SIGSEGV
*  See 
  _probe::signal.force_segv_(3stap)
   for details.


* **signal.force_segv.return**  
  Forcing send of SIGSEGV complete
*  See 
  _probe::signal.force_segv.return_(3stap)
   for details.


* **signal.syskill**  
  Sending kill signal to a process
*  See 
  _probe::signal.syskill_(3stap)
   for details.


* **signal.syskill.return**  
  Sending kill signal completed
*  See 
  _probe::signal.syskill.return_(3stap)
   for details.


* **signal.sys_tkill**  
  Sending a kill signal to a thread
*  See 
  _probe::signal.sys_tkill_(3stap)
   for details.


* **signal.systkill.return**  
  Sending kill signal to a thread completed
*  See 
  _probe::signal.systkill.return_(3stap)
   for details.


* **signal.sys_tgkill**  
  Sending kill signal to a thread group
*  See 
  _probe::signal.sys_tgkill_(3stap)
   for details.


* **signal.sys_tgkill.return**  
  Sending kill signal to a thread group completed
*  See 
  _probe::signal.sys_tgkill.return_(3stap)
   for details.


* **signal.send_sig_queue**  
  Queuing a signal to a process
*  See 
  _probe::signal.send_sig_queue_(3stap)
   for details.


* **signal.send_sig_queue.return**  
  Queuing a signal to a process completed
*  See 
  _probe::signal.send_sig_queue.return_(3stap)
   for details.


* **signal.pending**  
  Examining pending signal
*  See 
  _probe::signal.pending_(3stap)
   for details.


* **signal.pending.return**  
  Examination of pending signal completed
*  See 
  _probe::signal.pending.return_(3stap)
   for details.


* **signal.handle**  
  Signal handler being invoked
*  See 
  _probe::signal.handle_(3stap)
   for details.


* **signal.handle.return**  
  Signal handler invocation completed
*  See 
  _probe::signal.handle.return_(3stap)
   for details.


* **signal.do_action**  
  Examining or changing a signal action
*  See 
  _probe::signal.do_action_(3stap)
   for details.


* **signal.do_action.return**  
  Examining or changing a signal action completed
*  See 
  _probe::signal.do_action.return_(3stap)
   for details.


* **signal.procmask**  
  Examining or changing blocked signals
*  See 
  _probe::signal.procmask_(3stap)
   for details.


* **signal.procmask.return**  
  Examining or changing blocked signals completed
*  See 
  _probe::signal.procmask.return_(3stap)
   for details.


* **signal.flush**  
  Flushing all pending signals for a task
*  See 
  _probe::signal.flush_(3stap)
   for details.


* **get_sa_flags**  
  Returns the numeric value of sa_flags
* See 
  _function::get_sa_flags_(3stap)
   for details.


* **get_sa_handler**  
  Returns the numeric value of sa_handler
* See 
  _function::get_sa_handler_(3stap)
   for details.


* **sigset_mask_str**  
  Returns the string representation of a sigset
* See 
  _function::sigset_mask_str_(3stap)
   for details.


* **is_sig_blocked**  
  Returns 1 if the signal is currently blocked, or 0 if it is not
* See 
  _function::is_sig_blocked_(3stap)
   for details.


* **sa_flags_str**  
  Returns the string representation of sa_flags
* See 
  _function::sa_flags_str_(3stap)
   for details.


* **sa_handler**  
  Returns the string representation of an sa_handler
* See 
  _function::sa_handler_(3stap)
   for details.


* **signal_str**  
  Returns the string representation of a signal number
* See 
  _function::signal_str_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_function::get_sa_flags_(3stap),  
_function::get_sa_handler_(3stap),  
_function::sigset_mask_str_(3stap),  
_function::is_sig_blocked_(3stap),  
_function::sa_flags_str_(3stap),  
_function::sa_handler_(3stap),  
_function::signal_str_(3stap),  
_probe::signal.send_(3stap),  
_probe::signal.send.return_(3stap),  
_probe::signal.checkperm_(3stap),  
_probe::signal.checkperm.return_(3stap),  
_probe::signal.wakeup_(3stap),  
_probe::signal.check_ignored_(3stap),  
_probe::signal.check_ignored.return_(3stap),  
_probe::signal.force_segv_(3stap),  
_probe::signal.force_segv.return_(3stap),  
_probe::signal.syskill_(3stap),  
_probe::signal.syskill.return_(3stap),  
_probe::signal.sys_tkill_(3stap),  
_probe::signal.systkill.return_(3stap),  
_probe::signal.sys_tgkill_(3stap),  
_probe::signal.sys_tgkill.return_(3stap),  
_probe::signal.send_sig_queue_(3stap),  
_probe::signal.send_sig_queue.return_(3stap),  
_probe::signal.pending_(3stap),  
_probe::signal.pending.return_(3stap),  
_probe::signal.handle_(3stap),  
_probe::signal.handle.return_(3stap),  
_probe::signal.do_action_(3stap),  
_probe::signal.do_action.return_(3stap),  
_probe::signal.procmask_(3stap),  
_probe::signal.procmask.return_(3stap),  
_probe::signal.flush_(3stap),  
_stap_(1),
_stapprobes_(3stap)
