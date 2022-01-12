# tapset::kprocess(3stap) - systemtap kprocess tapset

SystemTap Tapset Reference, May 2021


<a name="description"></a>

# Description


  This family of probe points is used to probe process-related activities.


* 

* **kprocess.create**  
  Fires whenever a new process or thread is successfully created
*  See 
  _probe::kprocess.create_(3stap)
   for details.


* **kprocess.start**  
  Starting new process
*  See 
  _probe::kprocess.start_(3stap)
   for details.


* **kprocess.exec**  
  Attempt to exec to a new program
*  See 
  _probe::kprocess.exec_(3stap)
   for details.


* **kprocess.exec_complete**  
  Return from exec to a new program
*  See 
  _probe::kprocess.exec_complete_(3stap)
   for details.


* **kprocess.exit**  
  Exit from process
*  See 
  _probe::kprocess.exit_(3stap)
   for details.


* **kprocess.release**  
  Process released
*  See 
  _probe::kprocess.release_(3stap)
   for details.
  

<a name="see-also"></a>

# See Also
  
_probe::kprocess.create_(3stap),  
_probe::kprocess.start_(3stap),  
_probe::kprocess.exec_(3stap),  
_probe::kprocess.exec_complete_(3stap),  
_probe::kprocess.exit_(3stap),  
_probe::kprocess.release_(3stap),  
_stap_(1),
_stapprobes_(3stap)
