# systemd\&.directives(7)

systemd 241, ""

.ie \n(.g .ds Aq '
.el       .ds Aq '




.nh





<a name="name"></a>

# Name

systemd.directives - Index of configuration directives

<a name="unit-directives"></a>

# Unit Directives


Directives for configuring units, used in unit files.

_Accept=_
**systemd.socket**(5)

_AccuracySec=_
**systemd.timer**(5)

_After=_
**systemd.unit**(5)

_Alias=_
**systemd.unit**(5)

_AllowIsolate=_
**systemd.unit**(5)

_Also=_
**systemd.unit**(5)

_AmbientCapabilities=_
**systemd.exec**(5)

_AppArmorProfile=_
**systemd.exec**(5)

_AssertACPower=_
**systemd.unit**(5)

_AssertArchitecture=_
**systemd.unit**(5)

_AssertCapability=_
**systemd.unit**(5)

_AssertControlGroupController=_
**systemd.unit**(5)

_AssertDirectoryNotEmpty=_
**systemd.unit**(5)

_AssertFileIsExecutable=_
**systemd.unit**(5)

_AssertFileNotEmpty=_
**systemd.unit**(5)

_AssertFirstBoot=_
**systemd.unit**(5)

_AssertGroup=_
**systemd.unit**(5)

_AssertHost=_
**systemd.unit**(5)

_AssertKernelCommandLine=_
**systemd.unit**(5)

_AssertKernelVersion=_
**systemd.unit**(5)

_AssertNeedsUpdate=_
**systemd.unit**(5)

_AssertPathExists=_
**systemd.unit**(5)

_AssertPathExistsGlob=_
**systemd.unit**(5)

_AssertPathIsDirectory=_
**systemd.unit**(5)

_AssertPathIsMountPoint=_
**systemd.unit**(5)

_AssertPathIsReadWrite=_
**systemd.unit**(5)

_AssertPathIsSymbolicLink=_
**systemd.unit**(5)

_AssertSecurity=_
**systemd.unit**(5)

_AssertUser=_
**systemd.unit**(5)

_AssertVirtualization=_
**systemd.unit**(5)

_Backlog=_
**systemd.socket**(5)

_Before=_
**systemd.unit**(5)

_BindIPv6Only=_
**systemd.socket**(5)

_BindPaths=_
**systemd.exec**(5)

_BindReadOnlyPaths=_
**systemd.exec**(5)

_BindToDevice=_
**systemd.socket**(5)

_BindsTo=_
**systemd.unit**(5)

_BlockIOAccounting=_
**systemd.resource-control**(5)

_BlockIODeviceWeight=_
**systemd.resource-control**(5)

_BlockIOReadBandwidth=_
**systemd.resource-control**(5)

_BlockIOWeight=_
**systemd.resource-control**(5)

_BlockIOWriteBandwidth=_
**systemd.resource-control**(5)

_Broadcast=_
**systemd.socket**(5)

_BusName=_
**systemd.service**(5)

_CPUAccounting=_
**systemd.resource-control**(5)

_CPUAffinity=_
**systemd.exec**(5)

_CPUQuota=_
**systemd.resource-control**(5)

_CPUSchedulingPolicy=_
**systemd.exec**(5)

_CPUSchedulingPriority=_
**systemd.exec**(5)

_CPUSchedulingResetOnFork=_
**systemd.exec**(5)

_CPUShares=_
**systemd.resource-control**(5)

_CPUWeight=_
**systemd.resource-control**(5)

_CacheDirectory=_
**systemd.exec**(5)

_CacheDirectoryMode=_
**systemd.exec**(5)

_CapabilityBoundingSet=_
**systemd.exec**(5)

_CollectMode=_
**systemd.unit**(5)

_ConditionACPower=_
**systemd.unit**(5)

_ConditionArchitecture=_
**systemd.unit**(5)

_ConditionCapability=_
**systemd.unit**(5)

_ConditionControlGroupController=_
**systemd.unit**(5)

_ConditionDirectoryNotEmpty=_
**systemd.unit**(5)

_ConditionFileIsExecutable=_
**systemd.unit**(5)

_ConditionFileNotEmpty=_
**systemd.unit**(5)

_ConditionFirstBoot=_
**systemd.unit**(5)

_ConditionGroup=_
**systemd.unit**(5)

_ConditionHost=_
**systemd.unit**(5)

_ConditionKernelCommandLine=_
**systemd.unit**(5)

_ConditionKernelVersion=_
**systemd.unit**(5)

_ConditionNeedsUpdate=_
**systemd.unit**(5)

_ConditionPathExists=_
**systemd.unit**(5)

_ConditionPathExistsGlob=_
**systemd.unit**(5)

_ConditionPathIsDirectory=_
**systemd.unit**(5)

_ConditionPathIsMountPoint=_
**systemd.unit**(5)

_ConditionPathIsReadWrite=_
**systemd.unit**(5)

_ConditionPathIsSymbolicLink=_
**systemd.unit**(5)

_ConditionSecurity=_
**systemd.unit**(5)

_ConditionUser=_
**systemd.unit**(5)

_ConditionVirtualization=_
**systemd.unit**(5)

_ConfigurationDirectory=_
**systemd.exec**(5)

_ConfigurationDirectoryMode=_
**systemd.exec**(5)

_Conflicts=_
**systemd.unit**(5)

_DefaultDependencies=_
**systemd.unit**(5)

_DefaultInstance=_
**systemd.unit**(5)

_DeferAcceptSec=_
**systemd.socket**(5)

_Delegate=_
**systemd.resource-control**(5)

_Description=_
**systemd.unit**(5)

_DeviceAllow=_
**systemd.resource-control**(5)

_DevicePolicy=_
**systemd.resource-control**(5)

_DirectoryMode=_
**systemd.automount**(5),
**systemd.mount**(5),
**systemd.path**(5),
**systemd.socket**(5)

_DirectoryNotEmpty=_
**systemd.path**(5)

_DisableControllers=_
**systemd.resource-control**(5)

_Documentation=_
**systemd.unit**(5)

_DynamicUser=_
**systemd.exec**(5)

_Environment=_
**systemd.exec**(5)

_EnvironmentFile=_
**systemd.exec**(5)

_ExecReload=_
**systemd.service**(5)

_ExecStart=_
**systemd.service**(5)

_ExecStartPost=_
**systemd.service**(5),
**systemd.socket**(5)

_ExecStartPre=_
**systemd.service**(5),
**systemd.socket**(5)

**ExecStop=**
**systemd.service**(5)

_ExecStopPost=_
**systemd.service**(5),
**systemd.socket**(5)

_ExecStopPre=_
**systemd.socket**(5)

_FailureAction=_
**systemd.unit**(5)

_FailureActionExitStatus=_
**systemd.unit**(5)

_FileDescriptorName=_
**systemd.socket**(5)

_FileDescriptorStoreMax=_
**systemd.service**(5)

_FinalKillSignal=_
**systemd.kill**(5)

_ForceUnmount=_
**systemd.mount**(5)

_FreeBind=_
**systemd.socket**(5)

_Group=_
**systemd.exec**(5)

_GuessMainPID=_
**systemd.service**(5)

_IOAccounting=_
**systemd.resource-control**(5)

_IODeviceLatencyTargetSec=_
**systemd.resource-control**(5)

_IODeviceWeight=_
**systemd.resource-control**(5)

_IOReadBandwidthMax=_
**systemd.resource-control**(5)

_IOReadIOPSMax=_
**systemd.resource-control**(5)

_IOSchedulingClass=_
**systemd.exec**(5)

_IOSchedulingPriority=_
**systemd.exec**(5)

_IOWeight=_
**systemd.resource-control**(5)

_IOWriteBandwidthMax=_
**systemd.resource-control**(5)

_IOWriteIOPSMax=_
**systemd.resource-control**(5)

_IPAccounting=_
**systemd.resource-control**(5)

_IPAddressAllow=_
**systemd.resource-control**(5)

_IPAddressDeny=_
**systemd.resource-control**(5)

_IPTOS=_
**systemd.socket**(5)

_IPTTL=_
**systemd.socket**(5)

_IgnoreOnIsolate=_
**systemd.unit**(5)

_IgnoreSIGPIPE=_
**systemd.exec**(5)

_InaccessiblePaths=_
**systemd.exec**(5)

_JobRunningTimeoutSec=_
**systemd.unit**(5)

_JobTimeoutAction=_
**systemd.unit**(5)

_JobTimeoutRebootArgument=_
**systemd.unit**(5)

_JobTimeoutSec=_
**systemd.unit**(5)

_JoinsNamespaceOf=_
**systemd.unit**(5)

_KeepAlive=_
**systemd.socket**(5)

_KeepAliveIntervalSec=_
**systemd.socket**(5)

_KeepAliveProbes=_
**systemd.socket**(5)

_KeepAliveTimeSec=_
**systemd.socket**(5)

_KeyringMode=_
**systemd.exec**(5)

_KillMode=_
**systemd.kill**(5)

_KillSignal=_
**systemd.kill**(5)

_LazyUnmount=_
**systemd.mount**(5)

_LimitAS=_
**systemd.exec**(5)

_LimitCORE=_
**systemd.exec**(5)

_LimitCPU=_
**systemd.exec**(5)

_LimitDATA=_
**systemd.exec**(5)

_LimitFSIZE=_
**systemd.exec**(5)

_LimitLOCKS=_
**systemd.exec**(5)

_LimitMEMLOCK=_
**systemd.exec**(5)

_LimitMSGQUEUE=_
**systemd.exec**(5)

_LimitNICE=_
**systemd.exec**(5)

_LimitNOFILE=_
**systemd.exec**(5)

_LimitNPROC=_
**systemd.exec**(5)

_LimitRSS=_
**systemd.exec**(5)

_LimitRTPRIO=_
**systemd.exec**(5)

_LimitRTTIME=_
**systemd.exec**(5)

_LimitSIGPENDING=_
**systemd.exec**(5)

_LimitSTACK=_
**systemd.exec**(5)

_ListenDatagram=_
**systemd.socket**(5)

_ListenFIFO=_
**systemd.socket**(5)

_ListenMessageQueue=_
**systemd.socket**(5)

_ListenNetlink=_
**systemd.socket**(5)

_ListenSequentialPacket=_
**systemd.socket**(5)

_ListenSpecial=_
**systemd.socket**(5)

_ListenStream=_
**systemd.socket**(5)

_ListenUSBFunction=_
**systemd.socket**(5)

_LockPersonality=_
**systemd.exec**(5)

_LogExtraFields=_
**systemd.exec**(5)

_LogLevelMax=_
**systemd.exec**(5)

_LogRateLimitBurst=_
**systemd.exec**(5)

_LogRateLimitIntervalSec=_
**systemd.exec**(5)

_LogsDirectory=_
**systemd.exec**(5)

_LogsDirectoryMode=_
**systemd.exec**(5)

_MakeDirectory=_
**systemd.path**(5)

_Mark=_
**systemd.socket**(5)

_MaxConnections=_
**systemd.socket**(5)

_MaxConnectionsPerSource=_
**systemd.socket**(5)

_MemoryAccounting=_
**systemd.resource-control**(5)

_MemoryDenyWriteExecute=_
**systemd.exec**(5)

_MemoryHigh=_
**systemd.resource-control**(5)

_MemoryLimit=_
**systemd.resource-control**(5)

_MemoryLow=_
**systemd.resource-control**(5)

_MemoryMax=_
**systemd.resource-control**(5)

_MemoryMin=_
**systemd.resource-control**(5)

_MemorySwapMax=_
**systemd.resource-control**(5)

_MessageQueueMaxMessages=_
**systemd.socket**(5)

_MessageQueueMessageSize=_
**systemd.socket**(5)

_MountAPIVFS=_
**systemd.exec**(5)

_MountFlags=_
**systemd.exec**(5)

_Nice=_
**systemd.exec**(5)

_NoDelay=_
**systemd.socket**(5)

_NoNewPrivileges=_
**systemd.exec**(5)

_NonBlocking=_
**systemd.service**(5)

_NotifyAccess=_
**systemd.service**(5)

_OOMScoreAdjust=_
**systemd.exec**(5)

_OnActiveSec=_
**systemd.timer**(5)

_OnBootSec=_
**systemd.timer**(5)

_OnCalendar=_
**systemd.timer**(5)

_OnFailure=_
**systemd.unit**(5)

_OnFailureJobMode=_
**systemd.unit**(5)

_OnStartupSec=_
**systemd.timer**(5)

_OnUnitActiveSec=_
**systemd.timer**(5)

_OnUnitInactiveSec=_
**systemd.timer**(5)

_Options=_
**systemd.mount**(5),
**systemd.swap**(5)

_PAMName=_
**systemd.exec**(5)

_PIDFile=_
**systemd.service**(5)

_PartOf=_
**systemd.unit**(5)

_PassCredentials=_
**systemd.socket**(5)

_PassEnvironment=_
**systemd.exec**(5)

_PassSecurity=_
**systemd.socket**(5)

_PathChanged=_
**systemd.path**(5)

_PathExists=_
**systemd.path**(5)

_PathExistsGlob=_
**systemd.path**(5)

_PathModified=_
**systemd.path**(5)

_Persistent=_
**systemd.timer**(5)

_Personality=_
**systemd.exec**(5)

_PipeSize=_
**systemd.socket**(5)

_Priority=_
**systemd.socket**(5),
**systemd.swap**(5)

_PrivateDevices=_
**systemd.exec**(5)

_PrivateMounts=_
**systemd.exec**(5)

_PrivateNetwork=_
**systemd.exec**(5)

_PrivateTmp=_
**systemd.exec**(5)

_PrivateUsers=_
**systemd.exec**(5)

_PropagatesReloadTo=_
**systemd.unit**(5)

_ProtectControlGroups=_
**systemd.exec**(5)

_ProtectHome=_
**systemd.exec**(5)

_ProtectKernelModules=_
**systemd.exec**(5)

_ProtectKernelTunables=_
**systemd.exec**(5)

_ProtectSystem=_
**systemd.exec**(5)

_RandomizedDelaySec=_
**systemd.timer**(5)

_ReadOnlyPaths=_
**systemd.exec**(5)

_ReadWritePaths=_
**systemd.exec**(5)

_RebootArgument=_
**systemd.unit**(5)

_ReceiveBuffer=_
**systemd.socket**(5)

_RefuseManualStart=_
**systemd.unit**(5)

_RefuseManualStop=_
**systemd.unit**(5)

_ReloadPropagatedFrom=_
**systemd.unit**(5)

_RemainAfterElapse=_
**systemd.timer**(5)

_RemainAfterExit=_
**systemd.service**(5)

_RemoveIPC=_
**systemd.exec**(5)

_RemoveOnStop=_
**systemd.socket**(5)

_RequiredBy=_
**systemd.unit**(5)

_Requires=_
**systemd.unit**(5)

_RequiresMountsFor=_
**systemd.unit**(5)

_Requisite=_
**systemd.unit**(5)

_Restart=_
**systemd.service**(5)

_RestartForceExitStatus=_
**systemd.service**(5)

_RestartPreventExitStatus=_
**systemd.service**(5)

_RestartSec=_
**systemd.service**(5)

_RestrictAddressFamilies=_
**systemd.exec**(5)

_RestrictNamespaces=_
**systemd.exec**(5)

_RestrictRealtime=_
**systemd.exec**(5)

_RestrictSUIDSGID=_
**systemd.exec**(5)

_ReusePort=_
**systemd.socket**(5)

_RootDirectory=_
**systemd.exec**(5)

_RootDirectoryStartOnly=_
**systemd.service**(5)

_RootImage=_
**systemd.exec**(5)

_RuntimeDirectory=_
**systemd.exec**(5)

_RuntimeDirectoryMode=_
**systemd.exec**(5)

_RuntimeDirectoryPreserve=_
**systemd.exec**(5)

_RuntimeMaxSec=_
**systemd.service**(5)

_SELinuxContext=_
**systemd.exec**(5)

_SELinuxContextFromNet=_
**systemd.socket**(5)

_SecureBits=_
**systemd.exec**(5)

_SendBuffer=_
**systemd.socket**(5)

_SendSIGHUP=_
**systemd.kill**(5)

_SendSIGKILL=_
**systemd.kill**(5)

_Service=_
**systemd.socket**(5)

_Slice=_
**systemd.resource-control**(5)

_SloppyOptions=_
**systemd.mount**(5)

_SmackLabel=_
**systemd.socket**(5)

_SmackLabelIPIn=_
**systemd.socket**(5)

_SmackLabelIPOut=_
**systemd.socket**(5)

_SmackProcessLabel=_
**systemd.exec**(5)

_SocketGroup=_
**systemd.socket**(5)

_SocketMode=_
**systemd.socket**(5)

_SocketProtocol=_
**systemd.socket**(5)

_SocketUser=_
**systemd.socket**(5)

_Sockets=_
**systemd.service**(5)

_SourcePath=_
**systemd.unit**(5)

_StandardError=_
**systemd.exec**(5)

_StandardInput=_
**systemd.exec**(5)

_StandardInputData=_
**systemd.exec**(5)

_StandardInputText=_
**systemd.exec**(5)

_StandardOutput=_
**systemd.exec**(5)

_StartLimitAction=_
**systemd.unit**(5)

_StartLimitBurst=_
**systemd.unit**(5)

_StartLimitIntervalSec=_
**systemd.unit**(5)

_StartupBlockIOWeight=_
**systemd.resource-control**(5)

_StartupCPUShares=_
**systemd.resource-control**(5)

_StartupCPUWeight=_
**systemd.resource-control**(5)

_StartupIOWeight=_
**systemd.resource-control**(5)

_StateDirectory=_
**systemd.exec**(5)

_StateDirectoryMode=_
**systemd.exec**(5)

_StopWhenUnneeded=_
**systemd.unit**(5)

_SuccessAction=_
**systemd.unit**(5)

_SuccessActionExitStatus=_
**systemd.unit**(5)

_SuccessExitStatus=_
**systemd.service**(5)

_SupplementaryGroups=_
**systemd.exec**(5)

_Symlinks=_
**systemd.socket**(5)

_SyslogFacility=_
**systemd.exec**(5)

_SyslogIdentifier=_
**systemd.exec**(5)

_SyslogLevel=_
**systemd.exec**(5)

_SyslogLevelPrefix=_
**systemd.exec**(5)

_SystemCallArchitectures=_
**systemd.exec**(5)

_SystemCallErrorNumber=_
**systemd.exec**(5)

_SystemCallFilter=_
**systemd.exec**(5)

_TCPCongestion=_
**systemd.socket**(5)

_TTYPath=_
**systemd.exec**(5)

_TTYReset=_
**systemd.exec**(5)

_TTYVHangup=_
**systemd.exec**(5)

_TTYVTDisallocate=_
**systemd.exec**(5)

_TasksAccounting=_
**systemd.resource-control**(5)

_TasksMax=_
**systemd.resource-control**(5)

_TemporaryFileSystem=_
**systemd.exec**(5)

_TimeoutIdleSec=_
**systemd.automount**(5)

_TimeoutSec=_
**systemd.mount**(5),
**systemd.service**(5),
**systemd.socket**(5),
**systemd.swap**(5)

_TimeoutStartSec=_
**systemd.service**(5)

_TimeoutStopSec=_
**systemd.service**(5)

_TimerSlackNSec=_
**systemd.exec**(5)

_Transparent=_
**systemd.socket**(5)

_TriggerLimitBurst=_
**systemd.socket**(5)

_TriggerLimitIntervalSec=_
**systemd.socket**(5)

_Type=_
**systemd.mount**(5),
**systemd.service**(5)

_UMask=_
**systemd.exec**(5)

_USBFunctionDescriptors=_
**systemd.service**(5)

_USBFunctionStrings=_
**systemd.service**(5)

_Unit=_
**systemd.path**(5),
**systemd.timer**(5)

_UnsetEnvironment=_
**systemd.exec**(5)

_User=_
**systemd.exec**(5)

_UtmpIdentifier=_
**systemd.exec**(5)

_UtmpMode=_
**systemd.exec**(5)

_WakeSystem=_
**systemd.timer**(5)

_WantedBy=_
**systemd.unit**(5)

_Wants=_
**systemd.unit**(5)

_WatchdogSec=_
**systemd.service**(5)

_WatchdogSignal=_
**systemd.kill**(5)

_What=_
**systemd.mount**(5),
**systemd.swap**(5)

_Where=_
**systemd.automount**(5),
**systemd.mount**(5)

_WorkingDirectory=_
**systemd.exec**(5)

_Writable=_
**systemd.socket**(5)

<a name="options-on-the-kernel-command-line"></a>

# Options on the Kernel Command Line


Kernel boot options for configuring the behaviour of the systemd process.

**-b**
**kernel-command-line**(7),
**systemd**(1)

**1**
**kernel-command-line**(7),
**systemd**(1)

**2**
**kernel-command-line**(7),
**systemd**(1)

**3**
**kernel-command-line**(7),
**systemd**(1)

**4**
**kernel-command-line**(7),
**systemd**(1)

_5_
**kernel-command-line**(7),
**systemd**(1)

_S_
**kernel-command-line**(7),
**systemd**(1)

_debug_
**kernel-command-line**(7),
**systemd**(1)

_emergency_
**kernel-command-line**(7),
**systemd**(1)

_fsck.mode=_
**kernel-command-line**(7),
**systemd-fsck@.service**(8)

_fsck.repair=_
**kernel-command-line**(7),
**systemd-fsck@.service**(8)

_fstab=_
**kernel-command-line**(7),
**systemd-fstab-generator**(8)

_locale.LANG=_
**kernel-command-line**(7),
**systemd**(1)

_locale.LANGUAGE=_
**kernel-command-line**(7),
**systemd**(1)

_locale.LC\_ADDRESS=_
**kernel-command-line**(7),
**systemd**(1)

_locale.LC\_COLLATE=_
**kernel-command-line**(7),
**systemd**(1)

_locale.LC\_CTYPE=_
**kernel-command-line**(7),
**systemd**(1)

_locale.LC\_IDENTIFICATION=_
**kernel-command-line**(7),
**systemd**(1)

_locale.LC\_MEASUREMENT=_
**kernel-command-line**(7),
**systemd**(1)

_locale.LC\_MESSAGES=_
**kernel-command-line**(7),
**systemd**(1)

_locale.LC\_MONETARY=_
**kernel-command-line**(7),
**systemd**(1)

_locale.LC\_NAME=_
**kernel-command-line**(7),
**systemd**(1)

_locale.LC\_NUMERIC=_
**kernel-command-line**(7),
**systemd**(1)

_locale.LC\_PAPER=_
**kernel-command-line**(7),
**systemd**(1)

_locale.LC\_TELEPHONE=_
**kernel-command-line**(7),
**systemd**(1)

_locale.LC\_TIME=_
**kernel-command-line**(7),
**systemd**(1)

_luks.crypttab=_
**kernel-command-line**(7),
**systemd-cryptsetup-generator**(8)

_luks.key=_
**kernel-command-line**(7),
**systemd-cryptsetup-generator**(8)

_luks.name=_
**kernel-command-line**(7),
**systemd-cryptsetup-generator**(8)

_luks.options=_
**kernel-command-line**(7),
**systemd-cryptsetup-generator**(8)

_luks.uuid=_
**kernel-command-line**(7),
**systemd-cryptsetup-generator**(8)

_luks=_
**kernel-command-line**(7),
**systemd-cryptsetup-generator**(8)

_modules\_load=_
**kernel-command-line**(7),
**systemd-modules-load.service**(8)

_mount.usr=_
**kernel-command-line**(7),
**systemd-fstab-generator**(8)

_mount.usrflags=_
**kernel-command-line**(7),
**systemd-fstab-generator**(8)

_mount.usrfstype=_
**kernel-command-line**(7),
**systemd-fstab-generator**(8)

_net.ifnames=_
**kernel-command-line**(7),
**systemd-udevd.service**(8)

_net.naming-scheme=_
**kernel-command-line**(7),
**systemd-udevd.service**(8)

_noresume_
**systemd-hibernate-resume-generator**(8)

_plymouth.enable=_
**kernel-command-line**(7)

_quiet_
**kernel-command-line**(7),
**systemd**(1)

_quotacheck.mode=_
**kernel-command-line**(7),
**systemd-quotacheck.service**(8)

_rd.emergency_
**kernel-command-line**(7),
**systemd**(1)

_rd.fstab=_
**kernel-command-line**(7),
**systemd-fstab-generator**(8)

_rd.luks.crypttab=_
**kernel-command-line**(7),
**systemd-cryptsetup-generator**(8)

_rd.luks.key=_
**kernel-command-line**(7),
**systemd-cryptsetup-generator**(8)

_rd.luks.name=_
**kernel-command-line**(7),
**systemd-cryptsetup-generator**(8)

_rd.luks.options=_
**kernel-command-line**(7),
**systemd-cryptsetup-generator**(8)

_rd.luks.uuid=_
**kernel-command-line**(7),
**systemd-cryptsetup-generator**(8)

_rd.luks=_
**kernel-command-line**(7),
**systemd-cryptsetup-generator**(8)

_rd.modules\_load=_
**kernel-command-line**(7),
**systemd-modules-load.service**(8)

_rd.rescue_
**kernel-command-line**(7),
**systemd**(1)

_rd.systemd.gpt\_auto=_
**kernel-command-line**(7)

_rd.systemd.unit=_
**kernel-command-line**(7),
**systemd**(1)

_rd.systemd.verity=_
**kernel-command-line**(7),
**systemd-veritysetup-generator**(8)

_rd.udev.children\_max=_
**kernel-command-line**(7),
**systemd-udevd.service**(8)

_rd.udev.event\_timeout=_
**kernel-command-line**(7),
**systemd-udevd.service**(8)

_rd.udev.exec\_delay=_
**kernel-command-line**(7),
**systemd-udevd.service**(8)

_rd.udev.log\_priority=_
**kernel-command-line**(7),
**systemd-udevd.service**(8)

_rescue_
**kernel-command-line**(7),
**systemd**(1)

_resume=_
**kernel-command-line**(7),
**systemd-hibernate-resume-generator**(8)

_ro_
**kernel-command-line**(7)

_root=_
**kernel-command-line**(7),
**systemd-fstab-generator**(8)

_rootflags=_
**kernel-command-line**(7),
**systemd-fstab-generator**(8)

_rootfstype=_
**kernel-command-line**(7),
**systemd-fstab-generator**(8)

_roothash=_
**kernel-command-line**(7),
**systemd-veritysetup-generator**(8)

**rw**
**kernel-command-line**(7)

**s**
**kernel-command-line**(7),
**systemd**(1)

_single_
**kernel-command-line**(7),
**systemd**(1)

_systemd.confirm\_spawn_
**kernel-command-line**(7),
**systemd**(1)

_systemd.crash\_chvt_
**kernel-command-line**(7),
**systemd**(1)

_systemd.crash\_reboot_
**kernel-command-line**(7),
**systemd**(1)

_systemd.crash\_shell_
**kernel-command-line**(7),
**systemd**(1)

_systemd.debug\_shell_
**kernel-command-line**(7)

_systemd.default\_standard\_error=_
**kernel-command-line**(7),
**systemd**(1)

_systemd.default\_standard\_output=_
**kernel-command-line**(7),
**systemd**(1)

_systemd.default\_timeout\_start\_sec=_
**kernel-command-line**(7)

_systemd.dump\_core_
**kernel-command-line**(7),
**systemd**(1)

_systemd.early\_core\_pattern=_
**kernel-command-line**(7)

_systemd.firstboot=_
**kernel-command-line**(7),
**systemd-firstboot**(1)

_systemd.gpt\_auto=_
**kernel-command-line**(7)

_systemd.journald.forward\_to\_console=_
**kernel-command-line**(7),
**systemd-journald.service**(8)

_systemd.journald.forward\_to\_kmsg=_
**kernel-command-line**(7),
**systemd-journald.service**(8)

_systemd.journald.forward\_to\_syslog=_
**kernel-command-line**(7),
**systemd-journald.service**(8)

_systemd.journald.forward\_to\_wall=_
**kernel-command-line**(7),
**systemd-journald.service**(8)

_systemd.legacy\_systemd\_cgroup\_controller_
**kernel-command-line**(7),
**systemd**(1)

_systemd.log\_color_
**kernel-command-line**(7),
**systemd**(1)

_systemd.log\_level=_
**kernel-command-line**(7),
**systemd**(1)

_systemd.log\_location=_
**kernel-command-line**(7),
**systemd**(1)

_systemd.log\_target=_
**kernel-command-line**(7),
**systemd**(1)

_systemd.machine\_id=_
**kernel-command-line**(7),
**systemd**(1)

_systemd.mask=_
**kernel-command-line**(7)

_systemd.restore\_state=_
**kernel-command-line**(7),
**systemd-backlight@.service**(8),
**systemd-rfkill.service**(8)

_systemd.run=_
**kernel-command-line**(7)

_systemd.run\_failure\_action=_
**kernel-command-line**(7)

_systemd.run\_success\_action=_
**kernel-command-line**(7)

_systemd.service\_watchdogs_
**kernel-command-line**(7)

_systemd.service\_watchdogs=_
**systemd**(1)

_systemd.setenv=_
**kernel-command-line**(7),
**systemd**(1)

_systemd.show\_status_
**kernel-command-line**(7),
**systemd**(1)

_systemd.unified\_cgroup\_hierarchy_
**kernel-command-line**(7),
**systemd**(1)

_systemd.unit=_
**kernel-command-line**(7),
**systemd**(1)

_systemd.verity=_
**kernel-command-line**(7),
**systemd-veritysetup-generator**(8)

_systemd.verity\_root\_data=_
**kernel-command-line**(7),
**systemd-veritysetup-generator**(8)

_systemd.verity\_root\_hash=_
**kernel-command-line**(7),
**systemd-veritysetup-generator**(8)

_systemd.volatile=_
**kernel-command-line**(7),
**systemd-fstab-generator**(8)

_systemd.wants=_
**kernel-command-line**(7)

_systemd.watchdog\_device=_
**kernel-command-line**(7)

_udev.children\_max=_
**kernel-command-line**(7),
**systemd-udevd.service**(8)

_udev.event\_timeout=_
**kernel-command-line**(7),
**systemd-udevd.service**(8)

_udev.exec\_delay=_
**kernel-command-line**(7),
**systemd-udevd.service**(8)

_udev.log\_priority=_
**kernel-command-line**(7),
**systemd-udevd.service**(8)

_vconsole.font=_
**kernel-command-line**(7),
**vconsole.conf**(5)

_vconsole.font\_map=_
**kernel-command-line**(7),
**vconsole.conf**(5)

_vconsole.font\_unimap=_
**kernel-command-line**(7),
**vconsole.conf**(5)

_vconsole.keymap=_
**kernel-command-line**(7),
**vconsole.conf**(5)

_vconsole.keymap\_toggle=_
**kernel-command-line**(7),
**vconsole.conf**(5)

<a name="environment-variables"></a>

# Environment Variables


Environment variables understood by the systemd manager and other programs and environment variable-compatible settings.

_$EXIT\_CODE_
**systemd.exec**(5)

_$EXIT\_STATUS_
**systemd.exec**(5)

_$HOME_
**systemd.exec**(5)

_$INVOCATION\_ID_
**systemd.exec**(5)

_$JOURNAL\_STREAM_
**systemd.exec**(5)

_$LANG_
**systemd.exec**(5)

_$LISTEN\_FDNAMES_
**sd\_listen\_fds**(3),
**systemd**(1),
**systemd-socket-activate**(1),
**systemd.exec**(5)

_$LISTEN\_FDS_
**sd\_listen\_fds**(3),
**systemd**(1),
**systemd-socket-activate**(1),
**systemd.exec**(5)

_$LISTEN\_PID_
**sd\_listen\_fds**(3),
**systemd**(1),
**systemd-socket-activate**(1),
**systemd.exec**(5)

_$LOGNAME_
**systemd.exec**(5)

_$MAINPID_
**systemd.exec**(5)

_$MANAGERPID_
**systemd.exec**(5)

_$NOTIFY\_SOCKET_
**sd\_notify**(3),
**systemd**(1),
**systemd.exec**(5)

_$PATH_
**systemd.exec**(5)

_$PREVLEVEL_
**runlevel**(8)

_$RUNLEVEL_
**runlevel**(8)

_$SERVICE\_RESULT_
**systemd.exec**(5)

_$SHELL_
**systemd.exec**(5)

_$SYSTEMD\_COLORS_
**systemd**(1)

_$SYSTEMD\_DEBUGGER_
**coredumpctl**(1)

_$SYSTEMD\_EDITOR_
**systemctl**(1)

_$SYSTEMD\_LESS_
**journalctl**(1),
**localectl**(1),
**loginctl**(1),
**machinectl**(1),
**portablectl**(1),
**systemd-analyze**(1),
**systemd-inhibit**(1),
**timedatectl**(1)

_$SYSTEMD\_LESSCHARSET_
**journalctl**(1),
**localectl**(1),
**loginctl**(1),
**machinectl**(1),
**portablectl**(1),
**systemd-analyze**(1),
**systemd-inhibit**(1),
**timedatectl**(1)

_$SYSTEMD\_LOG\_COLOR_
**systemd**(1),
**systemd-socket-activate**(1)

_$SYSTEMD\_LOG\_LEVEL_
**systemd**(1),
**systemd-socket-activate**(1)

_$SYSTEMD\_LOG\_LOCATION_
**systemd**(1),
**systemd-socket-activate**(1)

_$SYSTEMD\_LOG\_TARGET_
**systemd**(1),
**systemd-socket-activate**(1)

_$SYSTEMD\_PAGER_
**journalctl**(1),
**localectl**(1),
**loginctl**(1),
**machinectl**(1),
**portablectl**(1),
**systemd-analyze**(1),
**systemd-inhibit**(1),
**timedatectl**(1)

_$SYSTEMD\_SYSVINIT\_PATH_
**systemd**(1)

_$SYSTEMD\_SYSVRCND\_PATH_
**systemd**(1)

_$SYSTEMD\_TIMEDATED\_NTP\_SERVICES_
**systemd-timedated.service**(8)

_$SYSTEMD\_UNIT\_PATH_
**systemd**(1)

_$SYSTEMD\_URLIFY_
**systemd**(1)

_$TERM_
**systemd.exec**(5)

_$USER_
**systemd.exec**(5)

_$WATCHDOG\_PID_
**sd\_watchdog\_enabled**(3),
**systemd.exec**(5)

_$WATCHDOG\_USEC_
**sd\_watchdog\_enabled**(3),
**systemd.exec**(5)

_$XDG\_CONFIG\_DIRS_
**systemd**(1)

_$XDG\_CONFIG\_HOME_
**systemd**(1)

_$XDG\_DATA\_DIRS_
**systemd**(1)

_$XDG\_DATA\_HOME_
**systemd**(1)

_$XDG\_RUNTIME\_DIR_
**pam\_systemd**(8),
**systemd.exec**(5)

_$XDG\_SEAT_
**pam\_systemd**(8)

_$XDG\_SESSION\_CLASS_
**pam\_systemd**(8)

_$XDG\_SESSION\_DESKTOP_
**pam\_systemd**(8)

_$XDG\_SESSION\_ID_
**pam\_systemd**(8)

_$XDG\_SESSION\_TYPE_
**pam\_systemd**(8)

_$XDG\_VTNR_
**pam\_systemd**(8)

_ANSI\_COLOR=_
**os-release**(5)

_BUG\_REPORT\_URL=_
**os-release**(5)

_BUILD\_ID=_
**os-release**(5)

_CHASSIS=_
**machine-info**(5)

_CPE\_NAME=_
**os-release**(5)

_DEPLOYMENT=_
**machine-info**(5)

_DOCUMENTATION\_URL=_
**os-release**(5)

_FONT=_
**vconsole.conf**(5)

_FONT\_MAP=_
**vconsole.conf**(5)

_FONT\_UNIMAP=_
**vconsole.conf**(5)

_HOME\_URL=_
**os-release**(5)

_ICON\_NAME=_
**machine-info**(5)

_ID=_
**os-release**(5)

_ID\_LIKE=_
**os-release**(5)

_KEYMAP=_
**vconsole.conf**(5)

_KEYMAP\_TOGGLE=_
**vconsole.conf**(5)

_LOCATION=_
**machine-info**(5)

_LOGO=_
**os-release**(5)

_NAME=_
**os-release**(5)

_PRETTY\_HOSTNAME=_
**machine-info**(5)

_PRETTY\_NAME=_
**os-release**(5)

_PRIVACY\_POLICY\_URL=_
**os-release**(5)

_SUPPORT\_URL=_
**os-release**(5)

_VARIANT=_
**os-release**(5)

_VARIANT\_ID=_
**os-release**(5)

_VERSION=_
**os-release**(5)

_VERSION\_CODENAME=_
**os-release**(5)

_VERSION\_ID=_
**os-release**(5)

<a name="efi-variables"></a>

# Efi Variables


EFI variables understood by
**systemd-boot**(7)
and other programs.

_LoaderBootCountPath_
**systemd-boot**(7)

_LoaderConfigTimeout_
**systemd-boot**(7)

_LoaderConfigTimeoutOneShot_
**systemd-boot**(7)

_LoaderDevicePartUUID_
**systemd-boot**(7)

_LoaderEntries_
**systemd-boot**(7)

_LoaderEntryDefault_
**systemd-boot**(7)

_LoaderEntryOneShot_
**systemd-boot**(7)

_LoaderEntrySelected_
**systemd-boot**(7)

_LoaderFeatures_
**systemd-boot**(7)

_LoaderFirmwareInfo_
**systemd-boot**(7)

_LoaderFirmwareType_
**systemd-boot**(7)

_LoaderImageIdentifier_
**systemd-boot**(7)

_LoaderInfo_
**systemd-boot**(7)

_LoaderTimeExecUSec_
**systemd-boot**(7)

_LoaderTimeInitUSec_
**systemd-boot**(7)

_LoaderTimeMenuUsec_
**systemd-boot**(7)

<a name="udev-directives"></a>

# Udev Directives


Directives for configuring systemd units through the udev database.

**$$**
**udev**(7)

**$attr{****file****}**
**udev**(7)

**$devnode**
**udev**(7)

**$devpath**
**udev**(7)

**$driver**
**udev**(7)

**$env{****key****}**
**udev**(7)

**$id**
**udev**(7)

**$kernel**
**udev**(7)

**$links**
**udev**(7)

**$major**
**udev**(7)

**$minor**
**udev**(7)

**$name**
**udev**(7)

**$number**
**udev**(7)

**$parent**
**udev**(7)

**$result**
**udev**(7)

**$root**
**udev**(7)

**$sys**
**udev**(7)

**%%**
**udev**(7)

**%E{****key****}**
**udev**(7)

**%M**
**udev**(7)

**%N**
**udev**(7)

**%P**
**udev**(7)

**%S**
**udev**(7)

**%b**
**udev**(7)

**%c**
**udev**(7)

**%k**
**udev**(7)

**%m**
**udev**(7)

**%n**
**udev**(7)

**%p**
**udev**(7)

**%r**
**udev**(7)

**%s{****file****}**
**udev**(7)

**ACTION**
**udev**(7)

_ATTRS{__filename__}_
**udev**(7)

_ATTR{__filename__}_
**udev**(7)

**DEVPATH**
**udev**(7)

_DRIVER_
**udev**(7)

_DRIVERS_
**udev**(7)

_ENV{__key__}_
**udev**(7)

_GOTO_
**udev**(7)

_GROUP_
**udev**(7)

_ID\_AUTOSEAT_
**sd-login**(3)

_ID\_FOR\_SEAT_
**sd-login**(3)

_ID\_MODEL=_
**systemd.device**(5)

_ID\_MODEL\_FROM\_DATABASE=_
**systemd.device**(5)

_ID\_SEAT_
**sd-login**(3)

_IMPORT{__type__}_
**udev**(7)

_KERNEL_
**udev**(7)

_KERNELS_
**udev**(7)

_LABEL_
**udev**(7)

_MODE_
**udev**(7)

_NAME_
**udev**(7)

_OPTIONS_
**udev**(7)

_OWNER_
**udev**(7)

_PROGRAM_
**udev**(7)

_RESULT_
**udev**(7)

_RUN{__type__}_
**udev**(7)

_SECLABEL{__module__}_
**udev**(7)

**SUBSYSTEM**
**udev**(7)

_SUBSYSTEMS_
**udev**(7)

_SYMLINK_
**udev**(7)

_SYSCTL{__kernel parameter__}_
**udev**(7)

_SYSTEMD\_ALIAS=_
**systemd.device**(5)

_SYSTEMD\_MOUNT\_OPTIONS=_
**systemd-mount**(1)

_SYSTEMD\_MOUNT\_WHERE=_
**systemd-mount**(1)

_SYSTEMD\_READY=_
**systemd.device**(5)

_SYSTEMD\_USER\_WANTS=_
**systemd.device**(5)

_SYSTEMD\_WANTS=_
**systemd.device**(5)

_TAG_
**udev**(7)

_TAGS_
**udev**(7)

_TEST{__octal mode mask__}_
**udev**(7)

**db\_persist**
**udev**(7)

**link\_priority=**
**udev**(7)

**nowatch**
**udev**(7)

**static\_node=**
**udev**(7)

**string\_escape=**
**udev**(7)

**watch**
**udev**(7)

<a name="network-directives"></a>

# Network Directives


Directives for configuring network links through the net-setup-link udev builtin and networks through systemd-networkd.

_ARP=_
**systemd.network**(5)

_ARPAllTargets=_
**systemd.netdev**(5)

_ARPIPTargets=_
**systemd.netdev**(5)

_ARPIntervalSec=_
**systemd.netdev**(5)

_ARPValidate=_
**systemd.netdev**(5)

_ActiveSlave=_
**systemd.network**(5)

_AdActorSystem=_
**systemd.netdev**(5)

_AdActorSystemPriority=_
**systemd.netdev**(5)

_AdSelect=_
**systemd.netdev**(5)

_AdUserPortKey=_
**systemd.netdev**(5)

_Address=_
**systemd.network**(5)

_AddressAutoconfiguration=_
**systemd.network**(5)

_Advertise=_
**systemd.link**(5)

_AgeingTimeSec=_
**systemd.netdev**(5)

_Alias=_
**systemd.link**(5)

_AllMulticast=_
**systemd.network**(5)

_AllSlavesActive=_
**systemd.netdev**(5)

_AllowLocalRemote=_
**systemd.netdev**(5)

_AllowPortToBeRoot=_
**systemd.network**(5)

_AllowedIPs=_
**systemd.netdev**(5)

_Anonymize=_
**systemd.network**(5)

_Architecture=_
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5)

_AutoJoin=_
**systemd.network**(5)

_AutoNegotiation=_
**systemd.link**(5)

_BindCarrier=_
**systemd.network**(5)

_BitRate=_
**systemd.network**(5)

_BitsPerSecond=_
**systemd.link**(5)

_Bond=_
**systemd.network**(5)

_Bridge=_
**systemd.network**(5)

_Broadcast=_
**systemd.network**(5)

_Cache=_
**resolved.conf**(5)

_ClientIdentifier=_
**systemd.network**(5)

_CombinedChannels=_
**systemd.link**(5)

_ConfigureWithoutCarrier=_
**systemd.network**(5)

_CopyDSCP=_
**systemd.netdev**(5)

_Cost=_
**systemd.network**(5)

_CriticalConnection=_
**systemd.network**(5)

_DHCP=_
**systemd.network**(5)

_DHCPServer=_
**systemd.network**(5)

_DNS=_
**resolved.conf**(5),
**systemd.network**(5)

_DNSDefaultRoute=_
**systemd.network**(5)

_DNSLifetimeSec=_
**systemd.network**(5)

_DNSOverTLS=_
**resolved.conf**(5),
**systemd.network**(5)

_DNSSEC=_
**resolved.conf**(5),
**systemd.network**(5)

_DNSSECNegativeTrustAnchors=_
**systemd.network**(5)

_DNSStubListener=_
**resolved.conf**(5)

_DUIDRawData=_
**networkd.conf**(5),
**systemd.network**(5)

_DUIDType=_
**networkd.conf**(5),
**systemd.network**(5)

_DefaultLeaseTimeSec=_
**systemd.network**(5)

_DefaultPVID=_
**systemd.netdev**(5)

_Description=_
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5)

_Destination=_
**systemd.network**(5)

_DestinationPort=_
**systemd.netdev**(5),
**systemd.network**(5)

_DiscoverPathMTU=_
**systemd.netdev**(5)

_Domains=_
**resolved.conf**(5),
**systemd.network**(5)

_DownDelaySec=_
**systemd.netdev**(5)

_Driver=_
**systemd.link**(5),
**systemd.network**(5)

_Duplex=_
**systemd.link**(5)

_DuplicateAddressDetection=_
**systemd.network**(5)

_DynamicTransmitLoadBalancing=_
**systemd.netdev**(5)

_ERSPANIndex=_
**systemd.netdev**(5)

_EgressUntagged=_
**systemd.network**(5)

_EmitDNS=_
**systemd.network**(5)

_EmitDomains=_
**systemd.network**(5)

_EmitLLDP=_
**systemd.network**(5)

_EmitNTP=_
**systemd.network**(5)

_EmitRouter=_
**systemd.network**(5)

_EmitTimezone=_
**systemd.network**(5)

_Encapsulation=_
**systemd.netdev**(5)

_EncapsulationLimit=_
**systemd.netdev**(5)

_Endpoint=_
**systemd.netdev**(5)

_FDBAgeingSec=_
**systemd.netdev**(5)

_FOUDestinationPort=_
**systemd.netdev**(5)

_FOUSourcePort=_
**systemd.netdev**(5)

_FailOverMACPolicy=_
**systemd.netdev**(5)

_FallbackDNS=_
**resolved.conf**(5)

_FallbackNTP=_
**timesyncd.conf**(5)

_FastLeave=_
**systemd.network**(5)

_FirewallMark=_
**systemd.network**(5)

_Flags=_
**systemd.netdev**(5)

_FlowLabel=_
**systemd.netdev**(5)

_FooOverUDP=_
**systemd.netdev**(5)

_ForceDHCPv6PDOtherInformation=_
**systemd.network**(5)

_ForwardDelaySec=_
**systemd.netdev**(5)

_From=_
**systemd.network**(5)

_FwMark=_
**systemd.netdev**(5)

_GVRP=_
**systemd.netdev**(5)

_Gateway=_
**systemd.network**(5)

_GatewayOnlink=_
**systemd.network**(5)

_GenericReceiveOffload=_
**systemd.link**(5)

_GenericSegmentationOffload=_
**systemd.link**(5)

_GratuitousARP=_
**systemd.netdev**(5)

_Group=_
**systemd.netdev**(5)

_GroupForwardMask=_
**systemd.netdev**(5)

_GroupPolicyExtension=_
**systemd.netdev**(5)

_HairPin=_
**systemd.network**(5)

_HelloTimeSec=_
**systemd.netdev**(5)

_HomeAddress=_
**systemd.network**(5)

_Host=_
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5)

_Hostname=_
**systemd.network**(5)

_IAID=_
**systemd.network**(5)

_IPForward=_
**systemd.network**(5)

_IPMasquerade=_
**systemd.network**(5)

_IPProtocol=_
**systemd.network**(5)

_IPVLAN=_
**systemd.network**(5)

_IPv4LLRoute=_
**systemd.network**(5)

_IPv4ProxyARP=_
**systemd.network**(5)

_IPv6AcceptRA=_
**systemd.network**(5)

_IPv6DuplicateAddressDetection=_
**systemd.network**(5)

_IPv6FlowLabel=_
**systemd.netdev**(5)

_IPv6HopLimit=_
**systemd.network**(5)

_IPv6MTUBytes=_
**systemd.network**(5)

_IPv6Preference=_
**systemd.network**(5)

_IPv6PrefixDelegation=_
**systemd.network**(5)

_IPv6PrivacyExtensions=_
**systemd.network**(5)

_IPv6ProxyNDP=_
**systemd.network**(5)

_IPv6ProxyNDPAddress=_
**systemd.network**(5)

_IPv6RapidDeploymentPrefix=_
**systemd.netdev**(5)

_IPv6Token=_
**systemd.network**(5)

_ISATAP=_
**systemd.netdev**(5)

_Id=_
**systemd.netdev**(5)

_IncomingInterface=_
**systemd.network**(5)

_Independent=_
**systemd.netdev**(5)

_InitialAdvertisedReceiveWindow=_
**systemd.network**(5)

_InitialCongestionWindow=_
**systemd.network**(5)

_InputKey=_
**systemd.netdev**(5)

_InvertRule=_
**systemd.network**(5)

_KernelCommandLine=_
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5)

_KernelVersion=_
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5)

_Key=_
**systemd.netdev**(5)

_Kind=_
**systemd.netdev**(5)

_L2MissNotification=_
**systemd.netdev**(5)

_L3MissNotification=_
**systemd.netdev**(5)

_LACPTransmitRate=_
**systemd.netdev**(5)

_LLDP=_
**systemd.network**(5)

_LLMNR=_
**resolved.conf**(5),
**systemd.network**(5)

_Label=_
**systemd.network**(5)

_LargeReceiveOffload=_
**systemd.link**(5)

_LearnPacketIntervalSec=_
**systemd.netdev**(5)

_LinkLocalAddressing=_
**systemd.network**(5)

_ListenPort=_
**systemd.netdev**(5),
**systemd.network**(5)

_Local=_
**systemd.netdev**(5)

_LooseBinding=_
**systemd.netdev**(5)

_MACAddress=_
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5)

_MACAddressPolicy=_
**systemd.link**(5)

_MACVLAN=_
**systemd.network**(5)

_MIIMonitorSec=_
**systemd.netdev**(5)

_MTUBytes=_
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5)

_MVRP=_
**systemd.netdev**(5)

_MacLearning=_
**systemd.netdev**(5)

_ManageTemporaryAddress=_
**systemd.network**(5)

_Managed=_
**systemd.network**(5)

_MaxAgeSec=_
**systemd.netdev**(5)

_MaxLeaseTimeSec=_
**systemd.network**(5)

_MaximumFDBEntries=_
**systemd.netdev**(5)

_Metric=_
**systemd.network**(5)

_MinLinks=_
**systemd.netdev**(5)

_Mode=_
**systemd.netdev**(5)

_MultiQueue=_
**systemd.netdev**(5)

_Multicast=_
**systemd.network**(5)

_MulticastDNS=_
**resolved.conf**(5),
**systemd.network**(5)

_MulticastQuerier=_
**systemd.netdev**(5)

_MulticastSnooping=_
**systemd.netdev**(5)

_MulticastToUnicast=_
**systemd.network**(5)

_NTP=_
**systemd.network**(5),
**timesyncd.conf**(5)

_Name=_
**systemd.dnssd**(5),
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5)

_NamePolicy=_
**systemd.link**(5)

_OnLink=_
**systemd.network**(5)

_OneQueue=_
**systemd.netdev**(5)

_OriginalName=_
**systemd.link**(5)

_OtherChannels=_
**systemd.link**(5)

_OtherInformation=_
**systemd.network**(5)

_OutgoingInterface=_
**systemd.network**(5)

_OutputKey=_
**systemd.netdev**(5)

_PVID=_
**systemd.network**(5)

_PacketInfo=_
**systemd.netdev**(5)

_PacketsPerSlave=_
**systemd.netdev**(5)

_Path=_
**systemd.link**(5),
**systemd.network**(5)

_Peer=_
**systemd.netdev**(5),
**systemd.network**(5)

_PersistentKeepalive=_
**systemd.netdev**(5)

_PollIntervalMaxSec=_
**timesyncd.conf**(5)

_PollIntervalMinSec=_
**timesyncd.conf**(5)

_PoolOffset=_
**systemd.network**(5)

_PoolSize=_
**systemd.network**(5)

_Port=_
**systemd.dnssd**(5),
**systemd.link**(5),
**systemd.netdev**(5)

_PortRange=_
**systemd.netdev**(5)

_PreferredLifetime=_
**systemd.network**(5)

_PreferredLifetimeSec=_
**systemd.network**(5)

_PreferredSource=_
**systemd.network**(5)

_Prefix=_
**systemd.network**(5)

_PrefixRoute=_
**systemd.network**(5)

_PresharedKey=_
**systemd.netdev**(5)

_PrimaryReselectPolicy=_
**systemd.netdev**(5)

_PrimarySlave=_
**systemd.network**(5)

_Priority=_
**systemd.dnssd**(5),
**systemd.netdev**(5),
**systemd.network**(5)

_PrivateKey=_
**systemd.netdev**(5)

_Protocol=_
**systemd.netdev**(5),
**systemd.network**(5)

_PublicKey=_
**systemd.netdev**(5)

_QuickAck=_
**systemd.network**(5)

_RapidCommit=_
**systemd.network**(5)

_ReadEtcHosts=_
**resolved.conf**(5)

_ReduceARPProxy=_
**systemd.netdev**(5)

_Remote=_
**systemd.netdev**(5)

_RemoteChecksumRx=_
**systemd.netdev**(5)

_RemoteChecksumTx=_
**systemd.netdev**(5)

_ReorderHeader=_
**systemd.netdev**(5)

_RequestBroadcast=_
**systemd.network**(5)

_RequiredForOnline=_
**systemd.network**(5)

_ResendIGMP=_
**systemd.netdev**(5)

_RestartSec=_
**systemd.network**(5)

_RootDistanceMaxSec=_
**timesyncd.conf**(5)

_RouteMetric=_
**systemd.network**(5)

_RouteShortCircuit=_
**systemd.netdev**(5)

_RouteTable=_
**systemd.network**(5)

_RouterLifetimeSec=_
**systemd.network**(5)

_RouterPreference=_
**systemd.network**(5)

_RxChannels=_
**systemd.link**(5)

_STP=_
**systemd.netdev**(5)

_SamplePoint=_
**systemd.network**(5)

_Scope=_
**systemd.network**(5)

_SendHostname=_
**systemd.network**(5)

_SerializeTunneledPackets=_
**systemd.netdev**(5)

_Source=_
**systemd.network**(5)

_SourcePort=_
**systemd.network**(5)

_TCP6SegmentationOffload=_
**systemd.link**(5)

_TCPSegmentationOffload=_
**systemd.link**(5)

_TOS=_
**systemd.netdev**(5)

_TTL=_
**systemd.netdev**(5)

_Table=_
**systemd.network**(5)

_Timezone=_
**systemd.network**(5)

_To=_
**systemd.network**(5)

_TransmitHashPolicy=_
**systemd.netdev**(5)

_Tunnel=_
**systemd.network**(5)

_TxChannels=_
**systemd.link**(5)

_TxtData=_
**systemd.dnssd**(5)

_TxtText=_
**systemd.dnssd**(5)

_Type=_
**systemd.dnssd**(5),
**systemd.link**(5),
**systemd.network**(5)

_TypeOfService=_
**systemd.network**(5)

_UDP6ZeroChecksumRx=_
**systemd.netdev**(5)

_UDP6ZeroChecksumTx=_
**systemd.netdev**(5)

_UDPChecksum=_
**systemd.netdev**(5)

_UnicastFlood=_
**systemd.network**(5)

_Unmanaged=_
**systemd.network**(5)

_UpDelaySec=_
**systemd.netdev**(5)

_UseBPDU=_
**systemd.network**(5)

_UseDNS=_
**systemd.network**(5)

_UseDomains=_
**systemd.network**(5)

_UseHostname=_
**systemd.network**(5)

_UseMTU=_
**systemd.network**(5)

_UseNTP=_
**systemd.network**(5)

_UseRoutes=_
**systemd.network**(5)

_UseTimezone=_
**systemd.network**(5)

_User=_
**systemd.netdev**(5)

_UserClass=_
**systemd.network**(5)

_VLAN=_
**systemd.network**(5)

_VLANFiltering=_
**systemd.netdev**(5)

_VLANId=_
**systemd.network**(5)

_VNetHeader=_
**systemd.netdev**(5)

_VRF=_
**systemd.network**(5)

_VXLAN=_
**systemd.network**(5)

_ValidLifetimeSec=_
**systemd.network**(5)

_VendorClassIdentifier=_
**systemd.network**(5)

_Virtualization=_
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5)

_WakeOnLan=_
**systemd.link**(5)

_Weight=_
**systemd.dnssd**(5)

<a name="journal-fields"></a>

# Journal Fields


Fields in the journal events with a well known meaning.

_CODE\_FILE=_
**systemd.journal-fields**(7)

_CODE\_FUNC=_
**systemd.journal-fields**(7)

_CODE\_LINE=_
**systemd.journal-fields**(7)

_COREDUMP\_UNIT=_
**systemd.journal-fields**(7)

_COREDUMP\_USER\_UNIT=_
**systemd.journal-fields**(7)

_ERRNO=_
**systemd.journal-fields**(7)

_MESSAGE=_
**systemd.journal-fields**(7)

_MESSAGE\_ID=_
**systemd.journal-fields**(7)

_OBJECT\_AUDIT\_LOGINUID=_
**systemd.journal-fields**(7)

_OBJECT\_AUDIT\_SESSION=_
**systemd.journal-fields**(7)

_OBJECT\_CMDLINE=_
**systemd.journal-fields**(7)

_OBJECT\_COMM=_
**systemd.journal-fields**(7)

_OBJECT\_EXE=_
**systemd.journal-fields**(7)

_OBJECT\_GID=_
**systemd.journal-fields**(7)

_OBJECT\_PID=_
**systemd.journal-fields**(7)

_OBJECT\_SYSTEMD\_CGROUP=_
**systemd.journal-fields**(7)

_OBJECT\_SYSTEMD\_OWNER\_UID=_
**systemd.journal-fields**(7)

_OBJECT\_SYSTEMD\_SESSION=_
**systemd.journal-fields**(7)

_OBJECT\_SYSTEMD\_UNIT=_
**systemd.journal-fields**(7)

_OBJECT\_SYSTEMD\_USER\_UNIT=_
**systemd.journal-fields**(7)

_OBJECT\_UID=_
**systemd.journal-fields**(7)

_PRIORITY=_
**systemd.journal-fields**(7)

_SYSLOG\_FACILITY=_
**systemd.journal-fields**(7)

_SYSLOG\_IDENTIFIER=_
**systemd.journal-fields**(7)

_SYSLOG\_PID=_
**systemd.journal-fields**(7)

_SYSLOG\_RAW=_
**systemd.journal-fields**(7)

_SYSLOG\_TIMESTAMP=_
**systemd.journal-fields**(7)

_\_AUDIT\_LOGINUID=_
**systemd.journal-fields**(7)

_\_AUDIT\_SESSION=_
**systemd.journal-fields**(7)

_\_BOOT\_ID=_
**systemd.journal-fields**(7)

_\_CAP\_EFFECTIVE=_
**systemd.journal-fields**(7)

_\_CMDLINE=_
**systemd.journal-fields**(7)

_\_COMM=_
**systemd.journal-fields**(7)

_\_EXE=_
**systemd.journal-fields**(7)

_\_GID=_
**systemd.journal-fields**(7)

_\_HOSTNAME=_
**systemd.journal-fields**(7)

_\_KERNEL\_DEVICE=_
**systemd.journal-fields**(7)

_\_KERNEL\_SUBSYSTEM=_
**systemd.journal-fields**(7)

_\_LINE\_BREAK=_
**systemd.journal-fields**(7)

_\_MACHINE\_ID=_
**systemd.journal-fields**(7)

_\_PID=_
**systemd.journal-fields**(7)

_\_SELINUX\_CONTEXT=_
**systemd.journal-fields**(7)

_\_SOURCE\_REALTIME\_TIMESTAMP=_
**systemd.journal-fields**(7)

_\_STREAM\_ID=_
**systemd.journal-fields**(7)

_\_SYSTEMD\_CGROUP=_
**systemd.journal-fields**(7)

_\_SYSTEMD\_INVOCATION\_ID=_
**systemd.journal-fields**(7)

_\_SYSTEMD\_OWNER\_UID=_
**systemd.journal-fields**(7)

_\_SYSTEMD\_SESSION=_
**systemd.journal-fields**(7)

_\_SYSTEMD\_SLICE=_
**systemd.journal-fields**(7)

_\_SYSTEMD\_UNIT=_
**systemd.journal-fields**(7)

_\_SYSTEMD\_USER\_UNIT=_
**systemd.journal-fields**(7)

_\_TRANSPORT=_
**systemd.journal-fields**(7)

_\_UDEV\_DEVLINK=_
**systemd.journal-fields**(7)

_\_UDEV\_DEVNODE=_
**systemd.journal-fields**(7)

_\_UDEV\_SYSNAME=_
**systemd.journal-fields**(7)

_\_UID=_
**systemd.journal-fields**(7)

_\_\_CURSOR=_
**systemd.journal-fields**(7)

_\_\_MONOTONIC\_TIMESTAMP=_
**systemd.journal-fields**(7)

_\_\_REALTIME\_TIMESTAMP=_
**systemd.journal-fields**(7)

<a name="pam-configuration-directives"></a>

# Pam Configuration Directives


Directives for configuring PAM behaviour.

_class=_
**pam\_systemd**(8)

_debug_
**pam\_systemd**(8)

_desktop=_
**pam\_systemd**(8)

_systemd.cpu\_weight_
**pam\_systemd**(8)

_systemd.io\_weight_
**pam\_systemd**(8)

_systemd.memory\_max_
**pam\_systemd**(8)

_systemd.tasks\_max_
**pam\_systemd**(8)

_type=_
**pam\_systemd**(8)

<a name="etccrypttab-and-etcfstab-options"></a>

# /Etc/Crypttab and /Etc/Fstab Options


Options which influence mounted filesystems and encrypted volumes.

**\_netdev**
**crypttab**(5),
**systemd.mount**(5)

**auto**
**systemd.mount**(5),
**systemd.swap**(5)

**cipher=**
**crypttab**(5)

**discard**
**crypttab**(5)

**hash=**
**crypttab**(5)

**header=**
**crypttab**(5)

**key-slot=**
**crypttab**(5)

**keyfile-offset=**
**crypttab**(5)

**keyfile-size=**
**crypttab**(5)

**luks**
**crypttab**(5)

**noauto**
**crypttab**(5),
**systemd.mount**(5),
**systemd.swap**(5)

**nofail**
**crypttab**(5),
**systemd.mount**(5),
**systemd.swap**(5)

**offset=**
**crypttab**(5)

**plain**
**crypttab**(5)

**read-only**
**crypttab**(5)

**readonly**
**crypttab**(5)

**sector-size=**
**crypttab**(5)

**size=**
**crypttab**(5)

**skip=**
**crypttab**(5)

**swap**
**crypttab**(5)

**tcrypt**
**crypttab**(5)

**tcrypt-hidden**
**crypttab**(5)

**tcrypt-keyfile=**
**crypttab**(5)

**tcrypt-system**
**crypttab**(5)

**tcrypt-veracrypt**
**crypttab**(5)

**timeout=**
**crypttab**(5)

**tmp**
**crypttab**(5)

**tries=**
**crypttab**(5)

**verify**
**crypttab**(5)

**x-initrd.mount**
**systemd.mount**(5)

**x-systemd.after=**
**systemd.mount**(5)

**x-systemd.automount**
**systemd.mount**(5)

**x-systemd.before=**
**systemd.mount**(5)

**x-systemd.device-bound**
**systemd.mount**(5)

**x-systemd.device-timeout=**
**crypttab**(5),
**systemd.mount**(5),
**systemd.swap**(5)

**x-systemd.growfs**
**systemd.mount**(5)

**x-systemd.idle-timeout=**
**systemd.mount**(5)

**x-systemd.makefs**
**systemd.mount**(5),
**systemd.swap**(5)

**x-systemd.mount-timeout=**
**systemd.mount**(5)

**x-systemd.requires-mounts-for=**
**systemd.mount**(5)

**x-systemd.requires=**
**systemd.mount**(5)

<a name="systemdnspawn5-directives"></a>

# Systemd.Nspawn(5) Directives


Directives for configuring systemd-nspawn containers.

_Bind=_
**systemd.nspawn**(5)

_BindReadOnly=_
**systemd.nspawn**(5)

_Boot=_
**systemd.nspawn**(5)

_Bridge=_
**systemd.nspawn**(5)

_CPUAffinity=_
**systemd.nspawn**(5)

_Capability=_
**systemd.nspawn**(5)

_DropCapability=_
**systemd.nspawn**(5)

_Environment=_
**systemd.nspawn**(5)

_Ephemeral=_
**systemd.nspawn**(5)

_Hostname=_
**systemd.nspawn**(5)

_IPVLAN=_
**systemd.nspawn**(5)

_Interface=_
**systemd.nspawn**(5)

_KillSignal=_
**systemd.nspawn**(5)

_LimitAS=_
**systemd.nspawn**(5)

_LimitCORE=_
**systemd.nspawn**(5)

_LimitCPU=_
**systemd.nspawn**(5)

_LimitDATA=_
**systemd.nspawn**(5)

_LimitFSIZE=_
**systemd.nspawn**(5)

_LimitLOCKS=_
**systemd.nspawn**(5)

_LimitMEMLOCK=_
**systemd.nspawn**(5)

_LimitMSGQUEUE=_
**systemd.nspawn**(5)

_LimitNICE=_
**systemd.nspawn**(5)

_LimitNOFILE=_
**systemd.nspawn**(5)

_LimitNPROC=_
**systemd.nspawn**(5)

_LimitRSS=_
**systemd.nspawn**(5)

_LimitRTPRIO=_
**systemd.nspawn**(5)

_LimitRTTIME=_
**systemd.nspawn**(5)

_LimitSIGPENDING=_
**systemd.nspawn**(5)

_LimitSTACK=_
**systemd.nspawn**(5)

_LinkJournal=_
**systemd.nspawn**(5)

_MACVLAN=_
**systemd.nspawn**(5)

_MachineID=_
**systemd.nspawn**(5)

_NoNewPrivileges=_
**systemd.nspawn**(5)

_NotifyReady=_
**systemd.nspawn**(5)

_OOMScoreAdjust=_
**systemd.nspawn**(5)

_Overlay=_
**systemd.nspawn**(5)

_OverlayReadOnly=_
**systemd.nspawn**(5)

_Parameters=_
**systemd.nspawn**(5)

_Personality=_
**systemd.nspawn**(5)

_PivotRoot=_
**systemd.nspawn**(5)

_Port=_
**systemd.nspawn**(5)

_Private=_
**systemd.nspawn**(5)

_PrivateUsers=_
**systemd.nspawn**(5)

_PrivateUsersChown=_
**systemd.nspawn**(5)

_ProcessTwo=_
**systemd.nspawn**(5)

_ReadOnly=_
**systemd.nspawn**(5)

_ResolvConf=_
**systemd.nspawn**(5)

_SystemCallFilter=_
**systemd.nspawn**(5)

_TemporaryFileSystem=_
**systemd.nspawn**(5)

_Timezone=_
**systemd.nspawn**(5)

_User=_
**systemd.nspawn**(5)

_VirtualEthernet=_
**systemd.nspawn**(5)

_VirtualEthernetExtra=_
**systemd.nspawn**(5)

_Volatile=_
**systemd.nspawn**(5)

_WorkingDirectory=_
**systemd.nspawn**(5)

_Zone=_
**systemd.nspawn**(5)

<a name="program-configuration-options"></a>

# Program Configuration Options


Directives for configuring the behaviour of the systemd process and other tools through configuration files.

_AllowHibernation=_
**systemd-sleep.conf**(5)

_AllowHybridSleep=_
**systemd-sleep.conf**(5)

_AllowSuspend=_
**systemd-sleep.conf**(5)

_AllowSuspendThenHibernate=_
**systemd-sleep.conf**(5)

_CPUAffinity=_
**systemd-system.conf**(5)

_CapabilityBoundingSet=_
**systemd-system.conf**(5)

_Compress=_
**coredump.conf**(5),
**journald.conf**(5)

_CrashChangeVT=_
**systemd-system.conf**(5)

_CrashReboot=_
**systemd-system.conf**(5)

_CrashShell=_
**systemd-system.conf**(5)

_CtrlAltDelBurstAction=_
**systemd-system.conf**(5)

_DefaultBlockIOAccounting=_
**systemd-system.conf**(5)

_DefaultCPUAccounting=_
**systemd-system.conf**(5)

_DefaultEnvironment=_
**systemd-system.conf**(5)

_DefaultIOAccounting=_
**systemd-system.conf**(5)

_DefaultIPAccounting=_
**systemd-system.conf**(5)

_DefaultLimitAS=_
**systemd-system.conf**(5)

_DefaultLimitCORE=_
**systemd-system.conf**(5)

_DefaultLimitCPU=_
**systemd-system.conf**(5)

_DefaultLimitDATA=_
**systemd-system.conf**(5)

_DefaultLimitFSIZE=_
**systemd-system.conf**(5)

_DefaultLimitLOCKS=_
**systemd-system.conf**(5)

_DefaultLimitMEMLOCK=_
**systemd-system.conf**(5)

_DefaultLimitMSGQUEUE=_
**systemd-system.conf**(5)

_DefaultLimitNICE=_
**systemd-system.conf**(5)

_DefaultLimitNOFILE=_
**systemd-system.conf**(5)

_DefaultLimitNPROC=_
**systemd-system.conf**(5)

_DefaultLimitRSS=_
**systemd-system.conf**(5)

_DefaultLimitRTPRIO=_
**systemd-system.conf**(5)

_DefaultLimitRTTIME=_
**systemd-system.conf**(5)

_DefaultLimitSIGPENDING=_
**systemd-system.conf**(5)

_DefaultLimitSTACK=_
**systemd-system.conf**(5)

_DefaultMemoryAccounting=_
**systemd-system.conf**(5)

_DefaultRestartSec=_
**systemd-system.conf**(5)

_DefaultStandardError=_
**systemd-system.conf**(5)

_DefaultStandardOutput=_
**systemd-system.conf**(5)

_DefaultStartLimitBurst=_
**systemd-system.conf**(5)

_DefaultStartLimitIntervalSec=_
**systemd-system.conf**(5)

_DefaultTasksAccounting=_
**systemd-system.conf**(5)

_DefaultTasksMax=_
**systemd-system.conf**(5)

_DefaultTimeoutStartSec=_
**systemd-system.conf**(5)

_DefaultTimeoutStopSec=_
**systemd-system.conf**(5)

_DefaultTimerAccuracySec=_
**systemd-system.conf**(5)

_DumpCore=_
**systemd-system.conf**(5)

_ExternalSizeMax=_
**coredump.conf**(5)

_ForwardToConsole=_
**journald.conf**(5)

_ForwardToKMsg=_
**journald.conf**(5)

_ForwardToSyslog=_
**journald.conf**(5)

_ForwardToWall=_
**journald.conf**(5)

_HandleHibernateKey=_
**logind.conf**(5)

_HandleLidSwitch=_
**logind.conf**(5)

_HandleLidSwitchDocked=_
**logind.conf**(5)

_HandleLidSwitchExternalPower=_
**logind.conf**(5)

_HandlePowerKey=_
**logind.conf**(5)

_HandleSuspendKey=_
**logind.conf**(5)

_HibernateDelaySec=_
**systemd-sleep.conf**(5)

_HibernateKeyIgnoreInhibited=_
**logind.conf**(5)

_HibernateMode=_
**systemd-sleep.conf**(5)

_HibernateState=_
**systemd-sleep.conf**(5)

_HoldoffTimeoutSec=_
**logind.conf**(5)

_HybridSleepMode=_
**systemd-sleep.conf**(5)

_HybridSleepState=_
**systemd-sleep.conf**(5)

_IdleAction=_
**logind.conf**(5)

_IdleActionSec=_
**logind.conf**(5)

_InhibitDelayMaxSec=_
**logind.conf**(5)

_InhibitorsMax=_
**logind.conf**(5)

_JournalSizeMax=_
**coredump.conf**(5)

_KeepFree=_
**coredump.conf**(5)

_KillExcludeUsers=_
**logind.conf**(5)

_KillOnlyUsers=_
**logind.conf**(5)

_KillUserProcesses=_
**logind.conf**(5)

_LidSwitchIgnoreInhibited=_
**logind.conf**(5)

_LineMax=_
**journald.conf**(5)

_LogColor=_
**systemd-system.conf**(5)

_LogLevel=_
**systemd-system.conf**(5)

_LogLocation=_
**systemd-system.conf**(5)

_LogTarget=_
**systemd-system.conf**(5)

_MaxFileSec=_
**journald.conf**(5)

_MaxLevelConsole=_
**journald.conf**(5)

_MaxLevelKMsg=_
**journald.conf**(5)

_MaxLevelStore=_
**journald.conf**(5)

_MaxLevelSyslog=_
**journald.conf**(5)

_MaxLevelWall=_
**journald.conf**(5)

_MaxRetentionSec=_
**journald.conf**(5)

_MaxUse=_
**coredump.conf**(5)

_NAutoVTs=_
**logind.conf**(5)

_NoNewPrivileges=_
**systemd-system.conf**(5)

_PowerKeyIgnoreInhibited=_
**logind.conf**(5)

_ProcessSizeMax=_
**coredump.conf**(5)

_RateLimitBurst=_
**journald.conf**(5)

_RateLimitIntervalSec=_
**journald.conf**(5)

_ReadKMsg=_
**journald.conf**(5)

_RemoveIPC=_
**logind.conf**(5)

_ReserveVT=_
**logind.conf**(5)

_RuntimeDirectorySize=_
**logind.conf**(5)

_RuntimeKeepFree=_
**journald.conf**(5)

_RuntimeMaxFileSize=_
**journald.conf**(5)

_RuntimeMaxFiles=_
**journald.conf**(5)

_RuntimeMaxUse=_
**journald.conf**(5)

_RuntimeWatchdogSec=_
**systemd-system.conf**(5)

_Seal=_
**journal-remote.conf**(5),
**journald.conf**(5)

_ServerCertificateFile=_
**journal-remote.conf**(5),
**journal-upload.conf**(5)

_ServerKeyFile=_
**journal-remote.conf**(5),
**journal-upload.conf**(5)

_SessionsMax=_
**logind.conf**(5)

_ShowStatus=_
**systemd-system.conf**(5)

_ShutdownWatchdogSec=_
**systemd-system.conf**(5)

_SplitMode=_
**journal-remote.conf**(5),
**journald.conf**(5)

_Storage=_
**coredump.conf**(5),
**journald.conf**(5)

_SuspendKeyIgnoreInhibited=_
**logind.conf**(5)

_SuspendMode=_
**systemd-sleep.conf**(5)

_SuspendState=_
**systemd-sleep.conf**(5)

_SyncIntervalSec=_
**journald.conf**(5)

_SystemCallArchitectures=_
**systemd-system.conf**(5)

_SystemKeepFree=_
**journald.conf**(5)

_SystemMaxFileSize=_
**journald.conf**(5)

_SystemMaxFiles=_
**journald.conf**(5)

_SystemMaxUse=_
**journald.conf**(5)

_TTYPath=_
**journald.conf**(5)

_TimerSlackNSec=_
**systemd-system.conf**(5)

_TrustedCertificateFile=_
**journal-remote.conf**(5),
**journal-upload.conf**(5)

_URL=_
**journal-upload.conf**(5)

_UserStopDelaySec=_
**logind.conf**(5)

_WatchdogDevice=_
**systemd-system.conf**(5)

_children\_max=_
**udev.conf**(5)

_event\_timeout=_
**udev.conf**(5)

_exec\_delay=_
**udev.conf**(5)

_resolve\_names=_
**udev.conf**(5)

_udev\_log=_
**udev.conf**(5)

<a name="command-line-options"></a>

# Command Line Options


Command-line options accepted by programs in the systemd suite.

**--accept**
**systemd-socket-activate**(1)

**--accept-cached**
**systemd-ask-password**(1)

**--acquired**
**busctl**(1)

**--action=**
**udevadm**(8)

**--activatable**
**busctl**(1)

**--address=**
**busctl**(1)

**--adjust-system-clock**
**timedatectl**(1)

**--after**
**systemctl**(1)

**--after-cursor=**
**journalctl**(1),
**systemd-journal-upload.service**(8)

**--all**
**journalctl**(1),
**loginctl**(1),
**machinectl**(1),
**networkctl**(1),
**systemctl**(1),
**systemd-cgls**(1),
**timedatectl**(1)

**--allow-interactive-authorization=**
**busctl**(1)

**--app-specific=**
**systemd-id128**(1)

**--are-updates-enabled**
**resolvectl**(1)

**--as-pid2**
**systemd-nspawn**(1)

**--attr-match=**
**udevadm**(8)

**--attr-nomatch=**
**udevadm**(8)

**--attribute-walk**
**udevadm**(8)

**--augment-creds=**
**busctl**(1)

**--auto-start=**
**busctl**(1)

**--automount-property=**
**systemd-mount**(1)

**--automount=**
**systemd-mount**(1)

**--batch**
**systemd-cgtop**(1)

**--before**
**systemctl**(1)

**--bind-device=**
**systemd-mount**(1)

**--bind-ro=**
**systemd-nspawn**(1)

**--bind=**
**systemd-nspawn**(1)

**--boot**
**systemd-nspawn**(1),
**systemd-tmpfiles**(8)

**--boot=**
**journalctl**(1)

**--booted**
**systemd-notify**(1)

**--capability=**
**systemd-nspawn**(1)

**--case-sensitive****[=BOOLEAN]**
**journalctl**(1)

**--cat**
**portablectl**(1)

**--cat-config**
**systemd-binfmt.service**(8),
**systemd-sysctl.service**(8),
**systemd-sysusers**(8),
**systemd-tmpfiles**(8)

**--catalog**
**journalctl**(1)

**--cert=**
**systemd-journal-gatewayd.service**(8),
**systemd-journal-remote.service**(8),
**systemd-journal-upload.service**(8)

**--chdir=**
**systemd-nspawn**(1)

**--children-max=**
**systemd-udevd.service**(8),
**udevadm**(8)

**--chroot**
**systemd-detect-virt**(1)

**--class=**
**resolvectl**(1)

**--clean**
**systemd-tmpfiles**(8)

**--cleanup-db**
**udevadm**(8)

**--cname=**
**resolvectl**(1)

**--collect**
**systemd-mount**(1),
**systemd-run**(1)

**--commit**
**systemd-machine-id-setup**(1)

**--compress**
**systemd-journal-remote.service**(8)

**--confirm-spawn**
**systemd**(1)

**--connections-max=**
**systemd-socket-proxyd**(8)

**--console**
**systemd-tty-ask-password-agent**(1)

**--container**
**systemd-detect-virt**(1)

**--copy**
**systemd-firstboot**(1)

**--copy-keymap**
**systemd-firstboot**(1)

**--copy-locale**
**systemd-firstboot**(1)

**--copy-root-password**
**systemd-firstboot**(1)

**--copy-timezone**
**systemd-firstboot**(1)

**--copy=**
**portablectl**(1)

**--cpu-affinity=**
**systemd-nspawn**(1)

**--cpu=**
**systemd-cgtop**(1)

**--crash-reboot**
**systemd**(1)

**--crash-shell**
**systemd**(1)

**--crash-vt=**
**systemd**(1)

**--create**
**systemd-tmpfiles**(8)

**--cursor=**
**journalctl**(1),
**systemd-journal-upload.service**(8)

**--daemon**
**systemd-udevd.service**(8)

**--datagram**
**systemd-socket-activate**(1)

**--debug**
**systemd-udevd.service**(8),
**udevadm**(8)

**--debugger=**
**coredumpctl**(1)

**--default-standard-error=**
**systemd**(1)

**--default-standard-output=**
**systemd**(1)

**--delay=**
**systemd-cgtop**(1)

**--depth=**
**systemd-cgtop**(1)

**--description=**
**systemd-mount**(1),
**systemd-run**(1)

**--device-id-of-file=**
**udevadm**(8)

**--diff=**
**systemd-delta**(1)

**--directory=**
**coredumpctl**(1),
**journalctl**(1),
**systemd-journal-gatewayd.service**(8),
**systemd-journal-upload.service**(8),
**systemd-nspawn**(1)

**--disable-updates**
**resolvectl**(1)

**--discover**
**systemd-mount**(1)

**--disk-usage**
**journalctl**(1)

**--dmesg**
**journalctl**(1)

**--drop-capability=**
**systemd-nspawn**(1)

**--dry-run**
**systemctl**(1),
**udevadm**(8)

**--dump-bus-properties**
**systemd**(1)

**--dump-catalog**
**journalctl**(1)

**--dump-configuration-items**
**systemd**(1)

**--dump-core**
**systemd**(1)

**--echo**
**systemd-ask-password**(1)

**--enable-updates**
**resolvectl**(1)

**--ephemeral**
**systemd-nspawn**(1)

**--event-timeout=**
**systemd-udevd.service**(8)

**--exclude-prefix=**
**systemd-tmpfiles**(8)

**--exec-delay=**
**systemd-udevd.service**(8)

**--exit**
**udevadm**(8)

**--exit-if-exists=**
**udevadm**(8)

**--expect-reply=**
**busctl**(1)

**--export**
**udevadm**(8)

**--export-db**
**udevadm**(8)

**--export-prefix=**
**udevadm**(8)

**--fail**
**systemctl**(1)

**--failed**
**systemctl**(1)

**--fdname=**
**systemd-socket-activate**(1)

**--field=**
**coredumpctl**(1),
**journalctl**(1)

**--fields**
**journalctl**(1)

**--file=**
**journalctl**(1),
**systemd-journal-upload.service**(8)

**--firmware-setup**
**systemctl**(1)

**--flush**
**journalctl**(1)

**--follow**
**journalctl**(1),
**systemd-journal-upload.service**(8)

**--force**
**halt**(8),
**journalctl**(1),
**machinectl**(1),
**systemctl**(1)

**--format=**
**machinectl**(1)

**--from-pattern=**
**systemd-analyze**(1)

**--fsck=**
**systemd-mount**(1)

**--full**
**journalctl**(1),
**loginctl**(1),
**machinectl**(1),
**systemctl**(1),
**systemd-cgls**(1)

**--fuzz=**
**systemd-analyze**(1)

**--generators**
**systemd-analyze**(1)

**--getter=****PROG**** ****[OPTIONS...]******
**systemd-journal-remote.service**(8)

**--gid=**
**systemd-run**(1)

**--global**
**systemctl**(1),
**systemd-analyze**(1)

**--gnutls-log=**
**systemd-journal-remote.service**(8)

**--grep=**
**journalctl**(1)

**--halt**
**halt**(8),
**shutdown**(8)

**--header**
**journalctl**(1)

**--help**
**bootctl**(1),
**busctl**(1),
**coredumpctl**(1),
**halt**(8),
**hostnamectl**(1),
**journalctl**(1),
**kernel-install**(8),
**localectl**(1),
**loginctl**(1),
**machinectl**(1),
**networkctl**(1),
**portablectl**(1),
**resolvectl**(1),
**runlevel**(8),
**shutdown**(8),
**systemctl**(1),
**systemd**(1),
**systemd-analyze**(1),
**systemd-ask-password**(1),
**systemd-binfmt.service**(8),
**systemd-bless-boot.service**(8),
**systemd-cat**(1),
**systemd-cgls**(1),
**systemd-cgtop**(1),
**systemd-delta**(1),
**systemd-detect-virt**(1),
**systemd-escape**(1),
**systemd-firstboot**(1),
**systemd-hwdb**(8),
**systemd-id128**(1),
**systemd-inhibit**(1),
**systemd-journal-gatewayd.service**(8),
**systemd-journal-remote.service**(8),
**systemd-journal-upload.service**(8),
**systemd-machine-id-setup**(1),
**systemd-mount**(1),
**systemd-notify**(1),
**systemd-nspawn**(1),
**systemd-path**(1),
**systemd-run**(1),
**systemd-socket-activate**(1),
**systemd-socket-proxyd**(8),
**systemd-suspend.service**(8),
**systemd-sysctl.service**(8),
**systemd-sysusers**(8),
**systemd-tmpfiles**(8),
**systemd-tty-ask-password-agent**(1),
**systemd-udevd.service**(8),
**telinit**(8),
**timedatectl**(1),
**udevadm**(8)

**--host=**
**busctl**(1),
**hostnamectl**(1),
**localectl**(1),
**loginctl**(1),
**machinectl**(1),
**portablectl**(1),
**systemctl**(1),
**systemd-analyze**(1),
**systemd-mount**(1),
**systemd-run**(1),
**timedatectl**(1)

**--hostname=**
**systemd-firstboot**(1),
**systemd-nspawn**(1)

**--icon=**
**systemd-ask-password**(1)

**--id=**
**systemd-ask-password**(1)

**--identifier=**
**journalctl**(1),
**systemd-cat**(1)

**--ignore-inhibitors**
**systemctl**(1)

**--ignore=**
**systemd-networkd-wait-online.service**(8)

**--image=**
**systemd-nspawn**(1)

**--inetd**
**systemd-socket-activate**(1)

**--inline**
**systemd-sysusers**(8)

**--instance**
**systemd-escape**(1)

**--interface=**
**resolvectl**(1),
**systemd-networkd-wait-online.service**(8)

**--interval=**
**journalctl**(1)

**--iterations=**
**systemd-cgtop**(1)

**--job-mode=**
**systemctl**(1)

**--json=**
**busctl**(1)

**--keep-unit**
**systemd-nspawn**(1)

**--kernel**
**udevadm**(8)

**--key=**
**systemd-journal-gatewayd.service**(8),
**systemd-journal-remote.service**(8),
**systemd-journal-upload.service**(8)

**--keymap=**
**systemd-firstboot**(1)

**--keyname=**
**systemd-ask-password**(1)

**--kill-signal=**
**systemd-nspawn**(1)

**--kill-who=**
**loginctl**(1),
**machinectl**(1),
**systemctl**(1)

**--legend=**
**resolvectl**(1)

**--level-prefix=**
**systemd-cat**(1)

**--lines=**
**journalctl**(1),
**loginctl**(1),
**machinectl**(1),
**systemctl**(1)

**--link-journal=**
**systemd-nspawn**(1)

**--list**
**busctl**(1),
**systemd-detect-virt**(1),
**systemd-inhibit**(1),
**systemd-mount**(1),
**systemd-tty-ask-password-agent**(1)

**--list-boots**
**journalctl**(1)

**--list-catalog**
**journalctl**(1)

**--listen-http=**
**systemd-journal-remote.service**(8)

**--listen-https=**
**systemd-journal-remote.service**(8)

**--listen-raw=**
**systemd-journal-remote.service**(8)

**--listen=**
**systemd-socket-activate**(1)

**--locale-messages=**
**systemd-firstboot**(1)

**--locale=**
**systemd-firstboot**(1)

**--log-color=**
**systemd**(1)

**--log-level=**
**systemd**(1)

**--log-location=**
**systemd**(1)

**--log-priority=**
**udevadm**(8)

**--log-target=**
**systemd**(1)

**--machine-id=**
**systemd**(1),
**systemd-firstboot**(1)

**--machine=**
**busctl**(1),
**hostnamectl**(1),
**journalctl**(1),
**localectl**(1),
**loginctl**(1),
**machinectl**(1),
**portablectl**(1),
**systemctl**(1),
**systemd-analyze**(1),
**systemd-cgls**(1),
**systemd-cgtop**(1),
**systemd-mount**(1),
**systemd-nspawn**(1),
**systemd-run**(1),
**timedatectl**(1)

**--man=**
**systemd-analyze**(1)

**--mangle**
**systemd-escape**(1)

**--match=**
**busctl**(1)

**--max-addresses=**
**machinectl**(1)

**--merge**
**journalctl**(1),
**systemd-journal-upload.service**(8)

**--message=**
**systemctl**(1)

**--mkdir**
**machinectl**(1)

**--mode=**
**systemd-inhibit**(1)

**--monitor**
**timedatectl**(1)

**--multiple**
**systemd-ask-password**(1)

**--name-match=**
**udevadm**(8)

**--name=**
**udevadm**(8)

**--network-bridge=**
**systemd-nspawn**(1)

**--network-interface=**
**systemd-nspawn**(1)

**--network-ipvlan=**
**systemd-nspawn**(1)

**--network-macvlan=**
**systemd-nspawn**(1)

**--network-namespace-path=**
**systemd-nspawn**(1)

**--network-veth**
**systemd-nspawn**(1)

**--network-veth-extra=**
**systemd-nspawn**(1)

**--network-zone=**
**systemd-nspawn**(1)

**--nice=**
**systemd-run**(1)

**--no-ask-password**
**hostnamectl**(1),
**localectl**(1),
**loginctl**(1),
**machinectl**(1),
**portablectl**(1),
**systemctl**(1),
**systemd-mount**(1),
**systemd-run**(1),
**timedatectl**(1)

**--no-block**
**systemctl**(1),
**systemd-mount**(1),
**systemd-run**(1)

**--no-convert**
**localectl**(1)

**--no-full**
**journalctl**(1)

**--no-hostname**
**journalctl**(1)

**--no-legend**
**busctl**(1),
**coredumpctl**(1),
**loginctl**(1),
**machinectl**(1),
**networkctl**(1),
**portablectl**(1),
**systemctl**(1),
**systemd-inhibit**(1)

**--no-new-privileges=**
**systemd-nspawn**(1)

**--no-output**
**systemd-ask-password**(1)

**--no-pager**
**bootctl**(1),
**busctl**(1),
**coredumpctl**(1),
**journalctl**(1),
**localectl**(1),
**loginctl**(1),
**machinectl**(1),
**networkctl**(1),
**portablectl**(1),
**resolvectl**(1),
**systemctl**(1),
**systemd-analyze**(1),
**systemd-binfmt.service**(8),
**systemd-cgls**(1),
**systemd-delta**(1),
**systemd-inhibit**(1),
**systemd-mount**(1),
**systemd-sysctl.service**(8),
**systemd-sysusers**(8),
**systemd-tmpfiles**(8),
**timedatectl**(1)

**--no-reload**
**portablectl**(1),
**systemctl**(1)

**--no-sync**
**halt**(8)

**--no-tail**
**journalctl**(1)

**--no-tty**
**systemd-ask-password**(1)

**--no-variables**
**bootctl**(1)

**--no-wall**
**halt**(8),
**shutdown**(8),
**systemctl**(1),
**telinit**(8)

**--no-wtmp**
**halt**(8)

**--notify-ready=**
**systemd-nspawn**(1)

**--now**
**systemctl**(1)

**--on-active=**
**systemd-run**(1)

**--on-boot=**
**systemd-run**(1)

**--on-calendar=**
**systemd-run**(1)

**--on-startup=**
**systemd-run**(1)

**--on-unit-active=**
**systemd-run**(1)

**--on-unit-inactive=**
**systemd-run**(1)

**--oom-score-adjust=**
**systemd-nspawn**(1)

**--options=**
**systemd-mount**(1)

**--order**
**systemd-analyze**(1)

**--order=**
**systemd-cgtop**(1)

**--output-fields=**
**journalctl**(1)

**--output=**
**coredumpctl**(1),
**journalctl**(1),
**loginctl**(1),
**machinectl**(1),
**systemctl**(1),
**systemd-journal-remote.service**(8)

**--overlay-ro=**
**systemd-nspawn**(1)

**--overlay=**
**systemd-nspawn**(1)

**--owner=**
**systemd-mount**(1)

**--pager-end**
**journalctl**(1)

**--parent-match=**
**udevadm**(8)

**--path**
**systemd-escape**(1)

**--path-property=**
**systemd-run**(1)

**--path=**
**bootctl**(1),
**udevadm**(8)

**--personality=**
**systemd-nspawn**(1)

**--pid=**
**systemd-notify**(1)

**--ping**
**udevadm**(8)

**--pipe**
**systemd-run**(1)

**--pivot-root=**
**systemd-nspawn**(1)

**--plain**
**systemctl**(1)

**--plymouth**
**systemd-tty-ask-password-agent**(1)

**--port=**
**systemd-nspawn**(1)

**--poweroff**
**halt**(8),
**shutdown**(8)

**--prefix=**
**systemd-sysctl.service**(8),
**systemd-tmpfiles**(8)

**--preset-mode=**
**systemctl**(1)

**--pretty**
**hostnamectl**(1),
**systemd-id128**(1)

**--print**
**systemd-machine-id-setup**(1)

**--print-path**
**bootctl**(1)

**--priority=**
**journalctl**(1),
**systemd-cat**(1)

**--private-network**
**systemd-nspawn**(1)

**--private-users**
**systemd-detect-virt**(1)

**--private-users-chown**
**systemd-nspawn**(1)

**--private-users=**
**systemd-nspawn**(1)

**--profile=**
**portablectl**(1)

**--prompt**
**systemd-firstboot**(1)

**--prompt-hostname**
**systemd-firstboot**(1)

**--prompt-keymap**
**systemd-firstboot**(1)

**--prompt-locale**
**systemd-firstboot**(1)

**--prompt-root-password**
**systemd-firstboot**(1)

**--prompt-timezone**
**systemd-firstboot**(1)

**--property**
**udevadm**(8)

**--property-match=**
**udevadm**(8)

**--property=**
**loginctl**(1),
**machinectl**(1),
**systemctl**(1),
**systemd-mount**(1),
**systemd-nspawn**(1),
**systemd-run**(1),
**timedatectl**(1),
**udevadm**(8)

**--protocol=**
**resolvectl**(1)

**--pty**
**systemd-run**(1)

**--query**
**systemd-tty-ask-password-agent**(1)

**--query=**
**udevadm**(8)

**--quiet**
**busctl**(1),
**coredumpctl**(1),
**journalctl**(1),
**machinectl**(1),
**portablectl**(1),
**systemctl**(1),
**systemd-detect-virt**(1),
**systemd-mount**(1),
**systemd-nspawn**(1),
**systemd-run**(1)

**--raw**
**resolvectl**(1),
**systemd-cgtop**(1)

**--read-only**
**machinectl**(1),
**systemd-nspawn**(1)

**--ready**
**systemd-notify**(1)

**--reboot**
**halt**(8),
**shutdown**(8)

**--recursive**
**systemctl**(1)

**--recursive=**
**systemd-cgtop**(1)

**--register=**
**systemd-nspawn**(1)

**--reload**
**udevadm**(8)

**--remain-after-exit**
**systemd-run**(1)

**--remove**
**systemd-tmpfiles**(8)

**--replace=**
**systemd-sysusers**(8),
**systemd-tmpfiles**(8)

**--require**
**systemd-analyze**(1)

**--resolv-conf=**
**systemd-nspawn**(1)

**--resolve-names=**
**systemd-udevd.service**(8),
**udevadm**(8)

**--reverse**
**coredumpctl**(1),
**journalctl**(1),
**systemctl**(1)

**--rlimit=**
**systemd-nspawn**(1)

**--root**
**udevadm**(8)

**--root-hash=**
**systemd-nspawn**(1)

**--root-password-file=**
**systemd-firstboot**(1)

**--root-password=**
**systemd-firstboot**(1)

**--root=**
**journalctl**(1),
**systemctl**(1),
**systemd-analyze**(1),
**systemd-firstboot**(1),
**systemd-hwdb**(8),
**systemd-machine-id-setup**(1),
**systemd-sysusers**(8),
**systemd-tmpfiles**(8)

**--rotate**
**journalctl**(1)

**--runtime**
**portablectl**(1),
**systemctl**(1)

**--same-dir**
**systemd-run**(1)

**--save-state**
**systemd-journal-upload.service**(8)

**--scope**
**systemd-run**(1)

**--seal**
**systemd-journal-remote.service**(8)

**--search=**
**resolvectl**(1)

**--selinux-apifs-context=**
**systemd-nspawn**(1)

**--selinux-context=**
**systemd-nspawn**(1)

**--send-sighup**
**systemd-run**(1)

**--seqpacket**
**systemd-socket-activate**(1)

**--service-address=**
**resolvectl**(1)

**--service-txt=**
**resolvectl**(1)

**--service-type=**
**systemd-run**(1)

**--service-watchdogs=**
**systemd**(1)

**--setenv=**
**machinectl**(1),
**systemd-nspawn**(1),
**systemd-run**(1),
**systemd-socket-activate**(1)

**--settings=**
**systemd-nspawn**(1)

**--settle**
**udevadm**(8)

**--setup-keys**
**journalctl**(1)

**--setup-machine-id**
**systemd-firstboot**(1)

**--shell**
**systemd-run**(1)

**--show-cursor**
**journalctl**(1)

**--show-machine**
**busctl**(1)

**--show-status=**
**systemd**(1)

**--show-types**
**systemctl**(1)

**--signal=**
**loginctl**(1),
**machinectl**(1),
**systemctl**(1)

**--since**
**coredumpctl**(1)

**--since=**
**journalctl**(1)

**--size=**
**busctl**(1)

**--slice=**
**systemd-nspawn**(1),
**systemd-run**(1)

**--socket-property=**
**systemd-run**(1)

**--split-mode**
**systemd-journal-remote.service**(8)

**--start-exec-queue**
**udevadm**(8)

**--state=**
**systemctl**(1)

**--static**
**hostnamectl**(1)

**--status=**
**systemd-notify**(1)

**--stderr-priority=**
**systemd-cat**(1)

**--stop-exec-queue**
**udevadm**(8)

**--strict**
**systemd-hwdb**(8)

**--subsystem-match=**
**udevadm**(8)

**--subsystem-nomatch=**
**udevadm**(8)

**--suffix=**
**systemd-escape**(1),
**systemd-path**(1)

**--sync**
**journalctl**(1)

**--sysname-match=**
**udevadm**(8)

**--system**
**busctl**(1),
**journalctl**(1),
**systemctl**(1),
**systemd**(1),
**systemd-analyze**(1),
**systemd-journal-upload.service**(8),
**systemd-mount**(1),
**systemd-run**(1)

**--system-call-filter=**
**systemd-nspawn**(1)

**--tag-match=**
**udevadm**(8)

**--template=**
**systemd-escape**(1),
**systemd-nspawn**(1)

**--test**
**systemd**(1)

**--timeout-idle-sec=**
**systemd-mount**(1)

**--timeout=**
**busctl**(1),
**systemd-ask-password**(1),
**systemd-networkd-wait-online.service**(8),
**udevadm**(8)

**--timer-property=**
**systemd-run**(1)

**--timezone=**
**systemd-firstboot**(1),
**systemd-nspawn**(1)

**--tmpfs=**
**systemd-nspawn**(1)

**--to-pattern=**
**systemd-analyze**(1)

**--transient**
**hostnamectl**(1)

**--trust=**
**systemd-journal-gatewayd.service**(8),
**systemd-journal-remote.service**(8),
**systemd-journal-upload.service**(8)

**--type=**
**resolvectl**(1),
**systemctl**(1),
**systemd-delta**(1),
**systemd-mount**(1),
**udevadm**(8)

**--udev**
**udevadm**(8)

**--uid=**
**machinectl**(1),
**systemd-notify**(1),
**systemd-run**(1)

**--umount**
**systemd-mount**(1)

**--unescape**
**systemd-escape**(1)

**--unique**
**busctl**(1)

**--unit**
**systemd-cgls**(1)

**--unit=**
**journalctl**(1),
**systemd**(1),
**systemd-run**(1)

**--until**
**coredumpctl**(1)

**--until=**
**journalctl**(1)

**--update-catalog**
**journalctl**(1)

**--url=**
**systemd-journal-remote.service**(8),
**systemd-journal-upload.service**(8)

**--user**
**busctl**(1),
**journalctl**(1),
**systemctl**(1),
**systemd**(1),
**systemd-analyze**(1),
**systemd-journal-upload.service**(8),
**systemd-mount**(1),
**systemd-run**(1),
**systemd-tmpfiles**(8)

**--user-unit**
**systemd-cgls**(1)

**--user-unit=**
**journalctl**(1)

**--user=**
**systemd-nspawn**(1)

**--usr**
**systemd-hwdb**(8)

**--utc**
**journalctl**(1)

**--uuid=**
**systemd-nspawn**(1)

**--vacuum-files=**
**journalctl**(1)

**--vacuum-size=**
**journalctl**(1)

**--vacuum-time=**
**journalctl**(1)

**--value**
**loginctl**(1),
**machinectl**(1),
**systemctl**(1),
**timedatectl**(1)

**--verbose**
**busctl**(1),
**kernel-install**(8),
**udevadm**(8)

**--verify**
**journalctl**(1)

**--verify-key=**
**journalctl**(1)

**--verify=**
**machinectl**(1)

**--version**
**bootctl**(1),
**busctl**(1),
**coredumpctl**(1),
**hostnamectl**(1),
**journalctl**(1),
**localectl**(1),
**loginctl**(1),
**machinectl**(1),
**networkctl**(1),
**portablectl**(1),
**resolvectl**(1),
**systemctl**(1),
**systemd**(1),
**systemd-analyze**(1),
**systemd-binfmt.service**(8),
**systemd-bless-boot.service**(8),
**systemd-cat**(1),
**systemd-cgls**(1),
**systemd-cgtop**(1),
**systemd-delta**(1),
**systemd-detect-virt**(1),
**systemd-escape**(1),
**systemd-firstboot**(1),
**systemd-id128**(1),
**systemd-inhibit**(1),
**systemd-journal-gatewayd.service**(8),
**systemd-journal-remote.service**(8),
**systemd-journal-upload.service**(8),
**systemd-machine-id-setup**(1),
**systemd-mount**(1),
**systemd-notify**(1),
**systemd-nspawn**(1),
**systemd-path**(1),
**systemd-run**(1),
**systemd-socket-activate**(1),
**systemd-socket-proxyd**(8),
**systemd-suspend.service**(8),
**systemd-sysctl.service**(8),
**systemd-sysusers**(8),
**systemd-tmpfiles**(8),
**systemd-tty-ask-password-agent**(1),
**systemd-udevd.service**(8),
**timedatectl**(1)

**--vm**
**systemd-detect-virt**(1)

**--volatile**
**systemd-nspawn**(1)

**--volatile=**
**systemd-nspawn**(1)

**--wait**
**systemctl**(1),
**systemd-run**(1)

**--wait-daemon[=**
**udevadm**(8)

**--wall**
**systemd-tty-ask-password-agent**(1)

**--watch**
**systemd-tty-ask-password-agent**(1)

**--watch-bind=**
**busctl**(1)

**--what=**
**systemd-inhibit**(1)

**--who=**
**systemd-inhibit**(1)

**--why=**
**systemd-inhibit**(1)

**--working-directory=**
**systemd-run**(1)

**--wtmp-only**
**halt**(8)

**-1**
**coredumpctl**(1),
**systemd-cgtop**(1)

**-4**
**resolvectl**(1)

**-6**
**resolvectl**(1)

**-A**
**systemd-mount**(1),
**udevadm**(8)

**-D**
**coredumpctl**(1),
**journalctl**(1),
**systemd-journal-gatewayd.service**(8),
**systemd-journal-upload.service**(8),
**systemd-nspawn**(1),
**systemd-udevd.service**(8)

**-E**
**machinectl**(1),
**systemd-nspawn**(1),
**systemd-run**(1),
**systemd-socket-activate**(1),
**udevadm**(8)

**-F**
**coredumpctl**(1),
**journalctl**(1)

**-G**
**systemd-mount**(1),
**systemd-run**(1)

**-H**
**busctl**(1),
**hostnamectl**(1),
**localectl**(1),
**loginctl**(1),
**machinectl**(1),
**portablectl**(1),
**shutdown**(8),
**systemctl**(1),
**systemd-analyze**(1),
**systemd-mount**(1),
**systemd-run**(1),
**timedatectl**(1)

**-I**
**resolvectl**(1)

**-L**
**systemd-nspawn**(1)

**-M**
**busctl**(1),
**hostnamectl**(1),
**journalctl**(1),
**localectl**(1),
**loginctl**(1),
**machinectl**(1),
**portablectl**(1),
**systemctl**(1),
**systemd-analyze**(1),
**systemd-cgls**(1),
**systemd-cgtop**(1),
**systemd-mount**(1),
**systemd-nspawn**(1),
**systemd-run**(1),
**timedatectl**(1)

**-N**
**journalctl**(1),
**udevadm**(8)

**-N=**
**systemd-udevd.service**(8)

**-P**
**shutdown**(8),
**systemd-cgtop**(1),
**systemd-run**(1),
**udevadm**(8)

**-R**
**resolvectl**(1),
**udevadm**(8)

**-S**
**coredumpctl**(1),
**journalctl**(1),
**systemd-nspawn**(1),
**systemd-run**(1),
**udevadm**(8)

**-U**
**coredumpctl**(1),
**journalctl**(1),
**systemd-nspawn**(1)

**-V**
**resolvectl**(1)

**-Z**
**systemd-nspawn**(1)

**-a**
**journalctl**(1),
**loginctl**(1),
**machinectl**(1),
**networkctl**(1),
**resolvectl**(1),
**systemctl**(1),
**systemd-id128**(1),
**systemd-nspawn**(1),
**systemd-socket-activate**(1),
**timedatectl**(1),
**udevadm**(8)

**-b**
**journalctl**(1),
**systemd-cgtop**(1),
**systemd-nspawn**(1),
**udevadm**(8)

**-c**
**journalctl**(1),
**resolvectl**(1),
**shutdown**(8),
**systemd-cgtop**(1),
**systemd-detect-virt**(1),
**systemd-socket-proxyd**(8),
**udevadm**(8)

**-c=**
**systemd-udevd.service**(8)

**-d**
**halt**(8),
**resolvectl**(1),
**systemd-cgtop**(1),
**systemd-run**(1),
**systemd-socket-activate**(1),
**systemd-udevd.service**(8),
**udevadm**(8)

**-e**
**journalctl**(1),
**udevadm**(8)

**-e=**
**systemd-udevd.service**(8)

**-f**
**halt**(8),
**journalctl**(1),
**resolvectl**(1),
**systemctl**(1)

**-g**
**journalctl**(1),
**udevadm**(8)

**-h**
**bootctl**(1),
**busctl**(1),
**coredumpctl**(1),
**hostnamectl**(1),
**journalctl**(1),
**kernel-install**(8),
**localectl**(1),
**loginctl**(1),
**machinectl**(1),
**networkctl**(1),
**portablectl**(1),
**resolvectl**(1),
**shutdown**(8),
**systemctl**(1),
**systemd**(1),
**systemd-analyze**(1),
**systemd-ask-password**(1),
**systemd-binfmt.service**(8),
**systemd-bless-boot.service**(8),
**systemd-cat**(1),
**systemd-cgls**(1),
**systemd-cgtop**(1),
**systemd-delta**(1),
**systemd-detect-virt**(1),
**systemd-escape**(1),
**systemd-firstboot**(1),
**systemd-hwdb**(8),
**systemd-id128**(1),
**systemd-inhibit**(1),
**systemd-journal-gatewayd.service**(8),
**systemd-journal-remote.service**(8),
**systemd-journal-upload.service**(8),
**systemd-machine-id-setup**(1),
**systemd-mount**(1),
**systemd-notify**(1),
**systemd-nspawn**(1),
**systemd-path**(1),
**systemd-run**(1),
**systemd-socket-activate**(1),
**systemd-socket-proxyd**(8),
**systemd-suspend.service**(8),
**systemd-sysctl.service**(8),
**systemd-sysusers**(8),
**systemd-tmpfiles**(8),
**systemd-tty-ask-password-agent**(1),
**systemd-udevd.service**(8),
**timedatectl**(1),
**udevadm**(8)

**-i**
**resolvectl**(1),
**systemctl**(1),
**systemd-cgtop**(1),
**systemd-networkd-wait-online.service**(8),
**systemd-nspawn**(1)

**-j**
**busctl**(1),
**systemd-nspawn**(1)

**-k**
**journalctl**(1),
**shutdown**(8),
**systemd-cgls**(1),
**systemd-cgtop**(1),
**udevadm**(8)

**-l**
**journalctl**(1),
**loginctl**(1),
**machinectl**(1),
**resolvectl**(1),
**systemctl**(1),
**systemd-cgls**(1),
**systemd-socket-activate**(1),
**udevadm**(8)

**-m**
**journalctl**(1),
**resolvectl**(1),
**systemd-cgtop**(1),
**systemd-escape**(1),
**systemd-journal-upload.service**(8),
**udevadm**(8)

**-n**
**halt**(8),
**journalctl**(1),
**loginctl**(1),
**machinectl**(1),
**systemctl**(1),
**systemd-cgtop**(1),
**systemd-nspawn**(1),
**udevadm**(8)

**-o**
**coredumpctl**(1),
**journalctl**(1),
**loginctl**(1),
**machinectl**(1),
**systemctl**(1),
**systemd-mount**(1)

**-p**
**bootctl**(1),
**halt**(8),
**journalctl**(1),
**loginctl**(1),
**machinectl**(1),
**portablectl**(1),
**resolvectl**(1),
**systemctl**(1),
**systemd-cat**(1),
**systemd-cgtop**(1),
**systemd-escape**(1),
**systemd-id128**(1),
**systemd-mount**(1),
**systemd-nspawn**(1),
**systemd-run**(1),
**timedatectl**(1),
**udevadm**(8)

**-q**
**busctl**(1),
**coredumpctl**(1),
**journalctl**(1),
**machinectl**(1),
**portablectl**(1),
**systemctl**(1),
**systemd-detect-virt**(1),
**systemd-mount**(1),
**systemd-nspawn**(1),
**systemd-run**(1),
**udevadm**(8)

**-r**
**coredumpctl**(1),
**journalctl**(1),
**resolvectl**(1),
**shutdown**(8),
**systemctl**(1),
**systemd-cgtop**(1),
**systemd-detect-virt**(1),
**systemd-hwdb**(8),
**systemd-run**(1),
**udevadm**(8)

**-s**
**loginctl**(1),
**machinectl**(1),
**systemctl**(1),
**systemd-hwdb**(8),
**udevadm**(8)

**-t**
**journalctl**(1),
**resolvectl**(1),
**systemctl**(1),
**systemd-cat**(1),
**systemd-cgtop**(1),
**systemd-delta**(1),
**systemd-mount**(1),
**systemd-run**(1),
**udevadm**(8)

**-t=**
**systemd-udevd.service**(8)

**-u**
**journalctl**(1),
**resolvectl**(1),
**systemd-cgls**(1),
**systemd-escape**(1),
**systemd-journal-upload.service**(8),
**systemd-mount**(1),
**systemd-nspawn**(1),
**udevadm**(8)

**-v**
**kernel-install**(8),
**resolvectl**(1),
**systemd-detect-virt**(1),
**udevadm**(8)

**-w**
**halt**(8),
**udevadm**(8)

**-x**
**journalctl**(1),
**resolvectl**(1),
**systemd-nspawn**(1),
**udevadm**(8)

**-y**
**udevadm**(8)

**CPU**
**systemd.resource-control**(5)

**IO**
**systemd.resource-control**(5)

**Memory**
**systemd.resource-control**(5)

**arp**
**systemd.link**(5)

**audit**
**systemd.journal-fields**(7)

**aui**
**systemd.link**(5)

**auto**
**systemd.resource-control**(5)

**bad**
**systemd-bless-boot.service**(8)

**bnc**
**systemd.link**(5)

**broadcast**
**systemd.link**(5)

**cat**
**journalctl**(1)

**closed**
**systemd.resource-control**(5)

**database**
**systemd.link**(5)

**default-route****LINK**** [****BOOL****...]]**
**resolvectl**(1)

**dns****LINK**** [****SERVER****...]]**
**resolvectl**(1)

**dnsovertls****LINK**** [****MODE****]]**
**resolvectl**(1)

**dnssec****LINK**** [****MODE****]]**
**resolvectl**(1)

**domain****LINK**** [****DOMAIN****...]]**
**resolvectl**(1)

**driver**
**systemd.journal-fields**(7)

**export**
**journalctl**(1)

**fibre**
**systemd.link**(5)

**flush-caches**
**resolvectl**(1)

**good**
**systemd-bless-boot.service**(8)

**hibernate**
**systemd-suspend.service**(8)

**hybrid-sleep**
**systemd-suspend.service**(8)

**indeterminate**
**systemd-bless-boot.service**(8)

**install**
**bootctl**(1)

**journal**
**systemd.journal-fields**(7)

**json**
**journalctl**(1)

**json-pretty**
**journalctl**(1)

**json-seq**
**journalctl**(1)

**json-sse**
**journalctl**(1)

**keep**
**systemd.link**(5)

**kernel**
**systemd.journal-fields**(7),
**systemd.link**(5)

**link-layer**
**networkd.conf**(5)

**link-layer-time[:****TIME****]**
**networkd.conf**(5)

**list**
**bootctl**(1)

**llmnr****LINK**** [****MODE****]]**
**resolvectl**(1)

**mac**
**systemd.link**(5)

**magic**
**systemd.link**(5)

**mdns****LINK**** [****MODE****]]**
**resolvectl**(1)

**mii**
**systemd.link**(5)

**multicast**
**systemd.link**(5)

**none**
**systemd.link**(5)

**nta****LINK**** [****DOMAIN****...]]**
**resolvectl**(1)

**off**
**systemd.link**(5)

**onboard**
**systemd.link**(5)

**openpgp**
**resolvectl**(1)

**path**
**systemd.link**(5)

**persistent**
**systemd.link**(5)

**phy**
**systemd.link**(5)

**query**
**resolvectl**(1)

**random**
**systemd.link**(5)

**remove**
**bootctl**(1)

**reset-server-features**
**resolvectl**(1)

**reset-statistics**
**resolvectl**(1)

**revert**
**resolvectl**(1)

**secureon**
**systemd.link**(5)

**service****NAME****] ****TYPE****] ****DOMAIN**
**resolvectl**(1)

**set-default**
**bootctl**(1)

**set-oneshot**
**bootctl**(1)

**short**
**journalctl**(1)

**short-full**
**journalctl**(1)

**short-iso**
**journalctl**(1)

**short-iso-precise**
**journalctl**(1)

**short-monotonic**
**journalctl**(1)

**short-precise**
**journalctl**(1)

**short-unix**
**journalctl**(1)

**slot**
**systemd.link**(5)

**statistics**
**resolvectl**(1)

**status**
**bootctl**(1),
**resolvectl**(1),
**systemd-bless-boot.service**(8)

**stdout**
**systemd.journal-fields**(7)

**strict**
**systemd.resource-control**(5)

**suspend**
**systemd-suspend.service**(8)

**suspend-then-hibernate**
**systemd-suspend.service**(8)

**syslog**
**systemd.journal-fields**(7)

**tlsa****FAMILY****] ****DOMAIN****[:****PORT****]...**
**resolvectl**(1)

**tp**
**systemd.link**(5)

**unicast**
**systemd.link**(5)

**update**
**bootctl**(1)

**uuid**
**networkd.conf**(5)

**vendor**
**networkd.conf**(5)

**verbose**
**journalctl**(1)

**with-unit**
**journalctl**(1)

<a name="constants"></a>

# Constants


Various constant used and/or defined by systemd.

** -1**
**sd\_journal\_get\_fd**(3),
**sd\_login\_monitor\_new**(3)

**s\*(Aq**
**sd\_bus\_message\_read\_basic**(3)

**y\*(Aq**
**sd\_bus\_message\_read\_basic**(3)

**-0**
**journalctl**(1)

**-1**
**journalctl**(1),
**sd\_event\_run**(3),
**sd\_event\_wait**(3),
**sd\_journal\_get\_fd**(3)

**-EADDRINUSE**
**sd\_bus\_request\_name**(3)

**-EALREADY**
**sd\_bus\_request\_name**(3)

**-EBADF**
**sd\_pid\_get\_owner\_uid**(3)

**-EBADMSG**
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_array**(3),
**sd\_bus\_message\_read\_basic**(3),
**sd\_bus\_message\_skip**(3)

**-EBUSY**
**sd\_bus\_process**(3),
**sd\_bus\_track\_new**(3),
**sd\_event\_add\_child**(3),
**sd\_event\_add\_signal**(3),
**sd\_event\_run**(3),
**sd\_event\_wait**(3)

**-ECHILD**
**sd\_bus\_attach\_event**(3),
**sd\_bus\_close**(3),
**sd\_bus\_get\_fd**(3),
**sd\_bus\_get\_n\_queued\_read**(3),
**sd\_bus\_is\_open**(3),
**sd\_bus\_process**(3),
**sd\_bus\_request\_name**(3),
**sd\_bus\_set\_close\_on\_exit**(3),
**sd\_bus\_set\_connected\_signal**(3),
**sd\_bus\_set\_description**(3),
**sd\_bus\_set\_sender**(3),
**sd\_bus\_set\_watch\_bind**(3),
**sd\_bus\_slot\_set\_floating**(3),
**sd\_bus\_wait**(3),
**sd\_event\_add\_child**(3),
**sd\_event\_add\_defer**(3),
**sd\_event\_add\_inotify**(3),
**sd\_event\_add\_io**(3),
**sd\_event\_add\_signal**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_exit**(3),
**sd\_event\_get\_fd**(3),
**sd\_event\_now**(3),
**sd\_event\_run**(3),
**sd\_event\_set\_watchdog**(3),
**sd\_event\_source\_get\_pending**(3),
**sd\_event\_source\_set\_description**(3),
**sd\_event\_source\_set\_enabled**(3),
**sd\_event\_source\_set\_prepare**(3),
**sd\_event\_source\_set\_priority**(3),
**sd\_event\_wait**(3),
**sd\_journal\_open**(3)

**-ECONNRESET**
**sd\_bus\_process**(3)

**-EDOM**
**sd\_event\_add\_child**(3),
**sd\_event\_add\_inotify**(3),
**sd\_event\_add\_io**(3),
**sd\_event\_add\_signal**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_source\_get\_pending**(3),
**sd\_event\_source\_set\_prepare**(3)

**-EEXIST**
**sd\_bus\_message\_set\_destination**(3),
**sd\_bus\_request\_name**(3)

**-EINVAL**
**sd\_bus\_creds\_get\_pid**(3),
**sd\_bus\_creds\_new\_from\_pid**(3),
**sd\_bus\_default**(3),
**sd\_bus\_error**(3),
**sd\_bus\_error\_add\_map**(3),
**sd\_bus\_get\_fd**(3),
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_array**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_append\_string\_memfd**(3),
**sd\_bus\_message\_append\_strv**(3),
**sd\_bus\_message\_copy**(3),
**sd\_bus\_message\_get\_cookie**(3),
**sd\_bus\_message\_get\_monotonic\_usec**(3),
**sd\_bus\_message\_get\_signature**(3),
**sd\_bus\_message\_get\_type**(3),
**sd\_bus\_message\_new**(3),
**sd\_bus\_message\_new\_method\_call**(3),
**sd\_bus\_message\_new\_method\_error**(3),
**sd\_bus\_message\_new\_signal**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_array**(3),
**sd\_bus\_message\_read\_basic**(3),
**sd\_bus\_message\_rewind**(3),
**sd\_bus\_message\_set\_destination**(3),
**sd\_bus\_message\_set\_expect\_reply**(3),
**sd\_bus\_message\_skip**(3),
**sd\_bus\_message\_verify\_type**(3),
**sd\_bus\_process**(3),
**sd\_bus\_reply\_method\_error**(3),
**sd\_bus\_request\_name**(3),
**sd\_bus\_set\_description**(3),
**sd\_bus\_slot\_set\_description**(3),
**sd\_bus\_slot\_set\_destroy\_callback**(3),
**sd\_bus\_slot\_set\_floating**(3),
**sd\_bus\_track\_add\_name**(3),
**sd\_bus\_track\_new**(3),
**sd\_bus\_wait**(3),
**sd\_event\_add\_child**(3),
**sd\_event\_add\_defer**(3),
**sd\_event\_add\_inotify**(3),
**sd\_event\_add\_io**(3),
**sd\_event\_add\_signal**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_exit**(3),
**sd\_event\_get\_fd**(3),
**sd\_event\_now**(3),
**sd\_event\_run**(3),
**sd\_event\_set\_watchdog**(3),
**sd\_event\_source\_get\_pending**(3),
**sd\_event\_source\_set\_description**(3),
**sd\_event\_source\_set\_destroy\_callback**(3),
**sd\_event\_source\_set\_enabled**(3),
**sd\_event\_source\_set\_prepare**(3),
**sd\_event\_source\_set\_priority**(3),
**sd\_event\_wait**(3),
**sd\_login\_monitor\_new**(3),
**sd\_machine\_get\_class**(3),
**sd\_pid\_get\_owner\_uid**(3),
**sd\_seat\_get\_active**(3),
**sd\_session\_is\_active**(3),
**sd\_uid\_get\_state**(3)

**-EIO**
**sd\_bus\_error**(3)

**-EMFILE**
**sd\_event\_new**(3)

**-ENODATA**
**sd\_bus\_creds\_get\_pid**(3),
**sd\_bus\_message\_get\_cookie**(3),
**sd\_bus\_message\_get\_monotonic\_usec**(3),
**sd\_bus\_negotiate\_fds**(3),
**sd\_event\_exit**(3),
**sd\_pid\_get\_owner\_uid**(3),
**sd\_seat\_get\_active**(3),
**sd\_session\_is\_active**(3),
**sd\_uid\_get\_state**(3)

**-ENOENT**
**sd\_id128\_get\_machine**(3)

**-ENOMEDIUM**
**sd\_id128\_get\_machine**(3)

**-ENOMEM**
**sd\_bus\_creds\_get\_pid**(3),
**sd\_bus\_creds\_new\_from\_pid**(3),
**sd\_bus\_default**(3),
**sd\_bus\_error**(3),
**sd\_bus\_error\_add\_map**(3),
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_array**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_append\_string\_memfd**(3),
**sd\_bus\_message\_append\_strv**(3),
**sd\_bus\_message\_copy**(3),
**sd\_bus\_message\_new**(3),
**sd\_bus\_message\_new\_method\_call**(3),
**sd\_bus\_message\_new\_method\_error**(3),
**sd\_bus\_message\_new\_signal**(3),
**sd\_bus\_message\_skip**(3),
**sd\_bus\_new**(3),
**sd\_bus\_reply\_method\_error**(3),
**sd\_bus\_set\_description**(3),
**sd\_bus\_slot\_set\_description**(3),
**sd\_bus\_track\_add\_name**(3),
**sd\_bus\_track\_new**(3),
**sd\_event\_add\_child**(3),
**sd\_event\_add\_defer**(3),
**sd\_event\_add\_inotify**(3),
**sd\_event\_add\_io**(3),
**sd\_event\_add\_signal**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_new**(3),
**sd\_event\_source\_get\_pending**(3),
**sd\_event\_source\_set\_description**(3),
**sd\_event\_source\_set\_enabled**(3),
**sd\_event\_source\_set\_prepare**(3),
**sd\_event\_source\_set\_priority**(3),
**sd\_get\_seats**(3),
**sd\_login\_monitor\_new**(3),
**sd\_machine\_get\_class**(3),
**sd\_pid\_get\_owner\_uid**(3),
**sd\_seat\_get\_active**(3),
**sd\_session\_is\_active**(3),
**sd\_uid\_get\_state**(3)

**-ENOPKG**
**sd\_bus\_set\_description**(3)

**-ENOTCONN**
**sd\_bus\_get\_fd**(3),
**sd\_bus\_message\_new**(3),
**sd\_bus\_message\_new\_method\_call**(3),
**sd\_bus\_message\_new\_method\_error**(3),
**sd\_bus\_message\_new\_signal**(3),
**sd\_bus\_process**(3),
**sd\_bus\_reply\_method\_error**(3),
**sd\_bus\_request\_name**(3),
**sd\_bus\_wait**(3)

**-ENXIO**
**sd\_bus\_creds\_get\_pid**(3),
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_array**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_append\_string\_memfd**(3),
**sd\_bus\_message\_append\_strv**(3),
**sd\_bus\_message\_copy**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3),
**sd\_bus\_message\_skip**(3),
**sd\_bus\_slot\_set\_description**(3),
**sd\_event\_new**(3),
**sd\_event\_source\_set\_description**(3),
**sd\_machine\_get\_class**(3),
**sd\_seat\_get\_active**(3),
**sd\_session\_is\_active**(3),
**sd\_uid\_get\_state**(3)

**-EOPNOTSUPP**
**sd\_bus\_creds\_new\_from\_pid**(3),
**sd\_bus\_message\_new\_method\_call**(3),
**sd\_bus\_message\_read\_array**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_now**(3)

**-EPERM**
**sd\_bus\_get\_fd**(3),
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_array**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_append\_string\_memfd**(3),
**sd\_bus\_message\_append\_strv**(3),
**sd\_bus\_message\_copy**(3),
**sd\_bus\_message\_new\_method\_call**(3),
**sd\_bus\_message\_new\_method\_error**(3),
**sd\_bus\_message\_read\_array**(3),
**sd\_bus\_message\_rewind**(3),
**sd\_bus\_message\_set\_destination**(3),
**sd\_bus\_message\_set\_expect\_reply**(3),
**sd\_bus\_message\_skip**(3),
**sd\_bus\_message\_verify\_type**(3),
**sd\_bus\_negotiate\_fds**(3),
**sd\_bus\_reply\_method\_error**(3),
**sd\_bus\_set\_description**(3),
**sd\_bus\_set\_sender**(3)

**-ESOCKTNOSUPPORT**
**sd\_bus\_default**(3)

**-ESRCH**
**sd\_bus\_creds\_new\_from\_pid**(3),
**sd\_bus\_request\_name**(3),
**sd\_pid\_get\_owner\_uid**(3)

**-ESTALE**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_array**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_append\_string\_memfd**(3),
**sd\_bus\_message\_append\_strv**(3),
**sd\_bus\_message\_copy**(3),
**sd\_bus\_slot\_set\_floating**(3),
**sd\_event\_add\_child**(3),
**sd\_event\_add\_defer**(3),
**sd\_event\_add\_inotify**(3),
**sd\_event\_add\_io**(3),
**sd\_event\_add\_signal**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_exit**(3),
**sd\_event\_run**(3),
**sd\_event\_source\_get\_pending**(3),
**sd\_event\_source\_set\_prepare**(3),
**sd\_event\_source\_set\_priority**(3),
**sd\_event\_wait**(3),
**sd\_journal\_get\_realtime\_usec**(3)

**-EUNATCH**
**sd\_bus\_track\_add\_name**(3)

**0**
**kernel-install**(8),
**sd\_event\_add\_time**(3),
**sd\_journal\_add\_match**(3),
**systemctl**(1),
**systemd.netdev**(5),
**tmpfiles.d**(5),
**udev\_device\_get\_syspath**(3),
**udev\_device\_has\_tag**(3),
**udev\_enumerate\_add\_match\_subsystem**(3),
**udev\_enumerate\_scan\_devices**(3),
**udev\_monitor\_filter\_update**(3),
**udev\_monitor\_receive\_device**(3)

**0755**
**systemd.exec**(5)

**1**
**journalctl**(1),
**systemctl**(1),
**systemd-tmpfiles**(8),
**systemd.network**(5),
**udev\_device\_get\_syspath**(3),
**udev\_device\_has\_tag**(3)

**10**
**systemd-journald.service**(8)

**19532**
**systemd-journal-upload.service**(8)

**2**
**journalctl**(1),
**systemctl**(1),
**systemd.network**(5)

**3**
**systemctl**(1)

**4**
**systemctl**(1)

**443**
**resolvectl**(1)

**4a67b082-0a4c-41cf-b6c7-440b29bb8c4**
**systemd-bless-boot.service**(8)

**65**
**systemd-tmpfiles**(8)

**73**
**systemd-tmpfiles**(8)

**77**
**kernel-install**(8)

**ACTION**
**udev\_device\_new\_from\_syspath**(3)

**AF\_INET**
**journald.conf**(5),
**sd\_is\_fifo**(3),
**systemd.exec**(5)

**AF\_INET6**
**sd\_is\_fifo**(3),
**systemd.exec**(5)

**AF\_NETLINK**
**systemd.exec**(5),
**systemd.socket**(5)

**AF\_PACKET**
**systemd.exec**(5)

**AF\_UNIX**
**busctl**(1),
**daemon**(7),
**journald.conf**(5),
**machinectl**(1),
**pam\_systemd**(8),
**sd\_is\_fifo**(3),
**sd\_notify**(3),
**systemd**(1),
**systemd.exec**(5),
**systemd.socket**(5)

**AF\_UNSPEC**
**sd\_is\_fifo**(3)

**AF\_VSOCK**
**systemd.socket**(5)

**ALLOW\_INTERACTIVE\_AUTHORIZATION**
**sd\_bus\_set\_description**(3)

**AND**
**systemd.exec**(5)

**CAP\_A**
**systemd.exec**(5)

**CAP\_B**
**systemd.exec**(5)

**CAP\_C**
**systemd.exec**(5)

**CAP\_DAC\_OVERRIDE**
**systemd.exec**(5)

**CAP\_FOWNER**
**systemd-tmpfiles**(8)

**CAP\_MKNOD**
**systemd.exec**(5)

**CAP\_SYS\_ADMIN**
**systemd.exec**(5)

**CAP\_SYS\_MODULE**
**systemd.exec**(5)

**CAP\_SYS\_PTRACE**
**systemd.exec**(5)

**CAP\_SYS\_RAWIO**
**systemd.exec**(5)

**CLOCK\_BOOTIME**
**sd-event**(3)

**CLOCK\_BOOTTIME**
**sd\_event\_add\_time**(3),
**sd\_event\_now**(3)

**CLOCK\_BOOTTIME\_ALARM**
**sd-event**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_now**(3)

**CLOCK\_MONOTONIC**
**sd-event**(3),
**sd\_bus\_message\_get\_monotonic\_usec**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_now**(3),
**sd\_journal\_get\_cutoff\_realtime\_usec**(3),
**sd\_journal\_get\_fd**(3),
**sd\_journal\_get\_realtime\_usec**(3),
**sd\_journal\_seek\_head**(3),
**sd\_login\_monitor\_new**(3),
**systemd.journal-fields**(7)

**CLOCK\_REALTIME**
**sd-event**(3),
**sd\_bus\_message\_get\_monotonic\_usec**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_now**(3),
**sd\_journal\_get\_cutoff\_realtime\_usec**(3),
**sd\_journal\_get\_realtime\_usec**(3),
**sd\_journal\_seek\_head**(3),
**systemd.journal-fields**(7)

**CLOCK\_REALTIME\_ALARM**
**sd-event**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_now**(3)

**CLONE\_NEWNS**
**systemd.exec**(5)

**DEVPATH**
**udev\_device\_new\_from\_syspath**(3)

**EACCES**
**systemd.exec**(5)

**EPERM**
**systemd.exec**(5)

**EPIPE**
**systemd-journald.service**(8)

**EPOLLERR**
**sd\_event\_add\_io**(3),
**sd\_notify**(3)

**EPOLLET**
**sd-event**(3),
**sd\_event\_add\_io**(3)

**EPOLLHUP**
**sd\_event\_add\_io**(3),
**sd\_notify**(3)

**EPOLLIN**
**sd\_event\_add\_io**(3),
**sd\_event\_get\_fd**(3)

**EPOLLOUT**
**sd\_event\_add\_io**(3)

**EPOLLPRI**
**sd\_event\_add\_io**(3)

**EPOLLRDHUP**
**sd\_event\_add\_io**(3)

**EUCLEAN**
**sd-bus-errors**(3),
**systemd.exec**(5)

**EXIT\_ADDRESS\_FAMILIES**
**systemd.exec**(5)

**EXIT\_APPARMOR\_PROFILE**
**systemd.exec**(5)

**EXIT\_CACHE\_DIRECTORY**
**systemd.exec**(5)

**EXIT\_CAPABILITIES**
**systemd.exec**(5)

**EXIT\_CGROUP**
**systemd.exec**(5)

**EXIT\_CHDIR**
**systemd.exec**(5)

**EXIT\_CHOWN**
**systemd.exec**(5)

**EXIT\_CHROOT**
**systemd.exec**(5)

**EXIT\_CONFIGURATION\_DIRECTORY**
**systemd.exec**(5)

**EXIT\_CONFIRM**
**systemd.exec**(5)

**EXIT\_CPUAFFINITY**
**systemd.exec**(5)

**EXIT\_EXEC**
**systemd.exec**(5)

**EXIT\_FAILURE**
**systemd-tmpfiles**(8),
**systemd.exec**(5)

**EXIT\_FDS**
**systemd.exec**(5)

**EXIT\_GROUP**
**systemd.exec**(5)

**EXIT\_INVALIDARGUMENT**
**systemd.exec**(5)

**EXIT\_IOPRIO**
**systemd.exec**(5)

**EXIT\_KEYRING**
**systemd.exec**(5)

**EXIT\_LIMITS**
**systemd.exec**(5)

**EXIT\_LOGS\_DIRECTORY**
**systemd.exec**(5)

**EXIT\_MEMORY**
**systemd.exec**(5)

**EXIT\_NAMESPACE**
**systemd.exec**(5)

**EXIT\_NETWORK**
**systemd.exec**(5)

**EXIT\_NICE**
**systemd.exec**(5)

**EXIT\_NOPERMISSION**
**systemd.exec**(5)

**EXIT\_NOTCONFIGURED**
**systemd.exec**(5)

**EXIT\_NOTIMPLEMENTED**
**systemd.exec**(5)

**EXIT\_NOTINSTALLED**
**systemd.exec**(5)

**EXIT\_NOTRUNNING**
**systemd.exec**(5)

**EXIT\_NO\_NEW\_PRIVILEGES**
**systemd.exec**(5)

**EXIT\_OOM\_ADJUST**
**systemd.exec**(5)

**EXIT\_PAM**
**systemd.exec**(5)

**EXIT\_PERSONALITY**
**systemd.exec**(5)

**EXIT\_RUNTIME\_DIRECTORY**
**systemd.exec**(5)

**EXIT\_SECCOMP**
**systemd.exec**(5)

**EXIT\_SECUREBITS**
**systemd.exec**(5)

**EXIT\_SELINUX\_CONTEXT**
**systemd.exec**(5)

**EXIT\_SETSCHEDULER**
**systemd.exec**(5)

**EXIT\_SETSID**
**systemd.exec**(5)

**EXIT\_SIGNAL\_MASK**
**systemd.exec**(5)

**EXIT\_SMACK\_PROCESS\_LABEL**
**systemd.exec**(5)

**EXIT\_STATE\_DIRECTORY**
**systemd.exec**(5)

**EXIT\_STDERR**
**systemd.exec**(5)

**EXIT\_STDIN**
**systemd.exec**(5)

**EXIT\_STDOUT**
**systemd.exec**(5)

**EXIT\_SUCCESS**
**systemd.exec**(5)

**EXIT\_TIMERSLACK**
**systemd.exec**(5)

**EXIT\_USER**
**systemd.exec**(5)

**EX\_CANTCREAT**
**systemd-tmpfiles**(8),
**systemd.exec**(5)

**EX\_CONFIG**
**systemd.exec**(5)

**EX\_DATAERR**
**systemd-tmpfiles**(8),
**systemd.exec**(5)

**EX\_IOERR**
**systemd.exec**(5)

**EX\_NOHOST**
**systemd.exec**(5)

**EX\_NOINPUT**
**systemd.exec**(5)

**EX\_NOPERM**
**systemd.exec**(5)

**EX\_NOUSER**
**systemd.exec**(5)

**EX\_OSERR**
**systemd.exec**(5)

**EX\_OSFILE**
**systemd.exec**(5)

**EX\_PROTOCOL**
**systemd.exec**(5)

**EX\_SOFTWARE**
**systemd.exec**(5)

**EX\_TEMPFAIL**
**systemd.exec**(5)

**EX\_UNAVAILABLE**
**systemd.exec**(5)

**EX\_USAGE**
**systemd.exec**(5)

**ExecStop=**
**systemd.service**(5)

**GPT\_FLAG\_NO\_AUTO**
**systemd-gpt-auto-generator**(8)

**GPT\_FLAG\_NO\_BLOCK\_IO\_PROTOCOL**
**systemd-gpt-auto-generator**(8)

**GPT\_FLAG\_READ\_ONLY**
**systemd-gpt-auto-generator**(8)

**INIT\_PROCESS**
**systemd.exec**(5)

**IN\_ACCESS**
**sd\_event\_add\_inotify**(3)

**IN\_ATTRIB**
**sd\_event\_add\_inotify**(3)

**IN\_CLOSE\_WRITE**
**sd\_event\_add\_inotify**(3)

**IN\_MASK\_ADD**
**sd\_event\_add\_inotify**(3)

**IN\_ONESHOT**
**sd\_event\_add\_inotify**(3)

**IPPROTO\_SCTP**
**systemd.socket**(5)

**IPPROTO\_UDPLITE**
**systemd.socket**(5)

**IP\_FREEBIND**
**daemon**(7)

**LOGIN\_PROCESS**
**systemd.exec**(5)

**LOG\_ALERT**
**sd\_journal\_print**(3),
**sd\_journal\_stream\_fd**(3)

**LOG\_CRIT**
**sd\_journal\_print**(3),
**sd\_journal\_stream\_fd**(3)

**LOG\_DEBUG**
**sd\_journal\_print**(3),
**sd\_journal\_stream\_fd**(3)

**LOG\_EMERG**
**sd\_journal\_print**(3),
**sd\_journal\_stream\_fd**(3)

**LOG\_ERR**
**sd\_journal\_print**(3),
**sd\_journal\_stream\_fd**(3)

**LOG\_INFO**
**sd\_journal\_print**(3),
**sd\_journal\_stream\_fd**(3)

**LOG\_NOTICE**
**sd\_journal\_print**(3),
**sd\_journal\_stream\_fd**(3)

**LOG\_WARNING**
**sd\_journal\_print**(3),
**sd\_journal\_stream\_fd**(3)

**MAP\_ANON**
**systemd.exec**(5)

**MSDOS\_SUPER\_MAGIC**
**file-hierarchy**(7)

**MS\_SLAVE**
**systemd.exec**(5)

**NO\_AUTO\_START**
**sd\_bus\_message\_set\_expect\_reply**(3)

**NO\_REPLY\_EXPECTED**
**sd\_bus\_message\_set\_expect\_reply**(3)

**NUL**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_append\_string\_memfd**(3),
**sd\_bus\_message\_append\_strv**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_array**(3),
**sd\_bus\_path\_encode**(3),
**sd\_event\_source\_set\_description**(3),
**sd\_id128\_to\_string**(3),
**sd\_journal\_add\_match**(3),
**systemd-journald.service**(8),
**systemd.journal-fields**(7),
**systemd.socket**(5),
**udev\_device\_has\_tag**(3)

**NULL**
**sd-login**(3),
**sd\_bus\_add\_match**(3),
**sd\_bus\_attach\_event**(3),
**sd\_bus\_close**(3),
**sd\_bus\_creds\_get\_pid**(3),
**sd\_bus\_creds\_new\_from\_pid**(3),
**sd\_bus\_default**(3),
**sd\_bus\_error**(3),
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_array**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_append\_strv**(3),
**sd\_bus\_message\_copy**(3),
**sd\_bus\_message\_get\_signature**(3),
**sd\_bus\_message\_get\_type**(3),
**sd\_bus\_message\_new**(3),
**sd\_bus\_message\_new\_method\_call**(3),
**sd\_bus\_message\_new\_method\_error**(3),
**sd\_bus\_message\_new\_signal**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_array**(3),
**sd\_bus\_message\_read\_basic**(3),
**sd\_bus\_message\_rewind**(3),
**sd\_bus\_message\_set\_destination**(3),
**sd\_bus\_message\_set\_expect\_reply**(3),
**sd\_bus\_message\_skip**(3),
**sd\_bus\_message\_verify\_type**(3),
**sd\_bus\_new**(3),
**sd\_bus\_path\_encode**(3),
**sd\_bus\_process**(3),
**sd\_bus\_reply\_method\_error**(3),
**sd\_bus\_request\_name**(3),
**sd\_bus\_set\_description**(3),
**sd\_bus\_set\_sender**(3),
**sd\_bus\_slot\_ref**(3),
**sd\_bus\_slot\_set\_description**(3),
**sd\_bus\_slot\_set\_destroy\_callback**(3),
**sd\_bus\_slot\_set\_floating**(3),
**sd\_bus\_slot\_set\_userdata**(3),
**sd\_bus\_track\_add\_name**(3),
**sd\_bus\_track\_new**(3),
**sd\_event\_add\_io**(3),
**sd\_event\_add\_signal**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_new**(3),
**sd\_event\_run**(3),
**sd\_event\_source\_set\_description**(3),
**sd\_event\_source\_set\_destroy\_callback**(3),
**sd\_event\_source\_set\_enabled**(3),
**sd\_event\_source\_set\_userdata**(3),
**sd\_event\_source\_unref**(3),
**sd\_event\_wait**(3),
**sd\_get\_seats**(3),
**sd\_is\_fifo**(3),
**sd\_journal\_get\_cutoff\_realtime\_usec**(3),
**sd\_journal\_get\_realtime\_usec**(3),
**sd\_journal\_open**(3),
**sd\_journal\_print**(3),
**sd\_login\_monitor\_new**(3),
**sd\_seat\_get\_active**(3),
**sd\_session\_is\_active**(3),
**sd\_uid\_get\_state**(3),
**udev\_device\_get\_syspath**(3),
**udev\_device\_has\_tag**(3),
**udev\_device\_new\_from\_syspath**(3),
**udev\_enumerate\_new**(3),
**udev\_enumerate\_scan\_devices**(3),
**udev\_list\_entry**(3),
**udev\_monitor\_new\_from\_netlink**(3),
**udev\_monitor\_receive\_device**(3),
**udev\_new**(3)

**OR**
**systemd.exec**(5)

**O\_NONBLOCK**
**sd\_event\_add\_io**(3),
**sd\_journal\_stream\_fd**(3),
**systemd.service**(5)

**PAM\_SUCCESS**
**pam\_systemd**(8)

**POLLERR**
**systemd.service**(5)

**POLLHUP**
**systemd.service**(5)

**POLLIN**
**sd\_bus\_get\_fd**(3),
**sd\_event\_get\_fd**(3),
**sd\_journal\_get\_fd**(3),
**sd\_login\_monitor\_new**(3)

**POLLOUT**
**sd\_bus\_get\_fd**(3),
**sd\_journal\_get\_fd**(3),
**sd\_login\_monitor\_new**(3)

**PROT\_EXEC**
**systemd.exec**(5)

**PROT\_WRITE**
**systemd.exec**(5)

**PR\_SET\_NO\_NEW\_PRIVS**
**systemd-nspawn**(1),
**systemd.nspawn**(5)

**RLIMIT\_NICE**
**systemd-nspawn**(1)

**RLIMIT\_NOFILE**
**daemon**(7),
**systemd-nspawn**(1)

**RLIMIT\_NPROC**
**systemd-nspawn**(1)

**SCHED\_DEADLINE**
**systemd.exec**(5)

**SCHED\_FIFO**
**systemd.exec**(5)

**SCHED\_RR**
**systemd.exec**(5)

**SD\_BUS\_CREDS\_AUDIT\_LOGIN\_UID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_AUDIT\_SESSION\_ID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_AUGMENT**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_BOUNDING\_CAPS**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_CGROUP**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_CMDLINE**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_COMM**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_DESCRIPTION**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_EFFECTIVE\_CAPS**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_EGID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_EUID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_EXE**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_FSGID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_FSUID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_GID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_INHERITABLE\_CAPS**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_OWNER\_UID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_PERMITTED\_CAPS**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_PID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_PPID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_SELINUX\_CONTEXT**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_SESSION**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_SGID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_SLICE**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_SUID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_SUPPLEMENTARY\_GIDS**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_TID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_TID\_COMM**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_TTY**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_UID**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_UNIQUE\_NAME**
**sd\_bus\_creds\_new\_from\_pid**(3),
**sd\_bus\_negotiate\_fds**(3)

**SD\_BUS\_CREDS\_UNIT**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_USER\_SLICE**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_USER\_UNIT**
**sd\_bus\_creds\_new\_from\_pid**(3)

**SD\_BUS\_CREDS\_WELL\_KNOWN\_NAMES**
**sd\_bus\_creds\_new\_from\_pid**(3),
**sd\_bus\_negotiate\_fds**(3)

**SD\_BUS\_ERROR\_ACCESS\_DENIED**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_ADDRESS\_IN\_USE**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_AUTH\_FAILED**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_BAD\_ADDRESS**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_DISCONNECTED**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_FAILED**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_FILE\_EXISTS**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_FILE\_NOT\_FOUND**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_INCONSISTENT\_MESSAGE**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_INTERACTIVE\_AUTHORIZATION\_REQUIRED**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_INVALID\_ARGS**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_INVALID\_SIGNATURE**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_IO\_ERROR**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_LIMITS\_EXCEEDED**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_MAKE\_CONST(****name****, ****message****)**
**sd\_bus\_error**(3)

**SD\_BUS\_ERROR\_MAKE\_CONST()**
**sd\_bus\_error**(3)

**SD\_BUS\_ERROR\_MAP(****name****, ****code****)**
**sd\_bus\_error\_add\_map**(3)

**SD\_BUS\_ERROR\_MAP()**
**sd\_bus\_error\_add\_map**(3)

**SD\_BUS\_ERROR\_MAP\_END**
**sd\_bus\_error\_add\_map**(3)

**SD\_BUS\_ERROR\_MATCH\_RULE\_INVALID**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_MATCH\_RULE\_NOT\_FOUND**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_NAME\_HAS\_NO\_OWNER**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_NOT\_SUPPORTED**
**sd-bus-errors**(3),
**sd\_bus\_message\_new\_method\_error**(3)

**SD\_BUS\_ERROR\_NO\_MEMORY**
**sd-bus-errors**(3),
**sd\_bus\_error**(3)

**SD\_BUS\_ERROR\_NO\_NETWORK**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_NO\_REPLY**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_NO\_SERVER**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_NULL**
**sd\_bus\_error**(3)

**SD\_BUS\_ERROR\_PROPERTY\_READ\_ONLY**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_SERVICE\_UNKNOWN**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_TIMEOUT**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_UNIX\_PROCESS\_ID\_UNKNOWN**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_UNKNOWN\_INTERFACE**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_UNKNOWN\_METHOD**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_UNKNOWN\_OBJECT**
**sd-bus-errors**(3)

**SD\_BUS\_ERROR\_UNKNOWN\_PROPERTY**
**sd-bus-errors**(3)

**SD\_BUS\_MESSAGE\_METHOD\_CALL**
**sd\_bus\_message\_get\_type**(3),
**sd\_bus\_message\_new**(3)

**SD\_BUS\_MESSAGE\_METHOD\_ERROR**
**sd\_bus\_message\_get\_type**(3),
**sd\_bus\_message\_new**(3)

**SD\_BUS\_MESSAGE\_METHOD\_RETURN**
**sd\_bus\_message\_get\_type**(3),
**sd\_bus\_message\_new**(3)

**SD\_BUS\_MESSAGE\_SIGNAL**
**sd\_bus\_message\_get\_type**(3),
**sd\_bus\_message\_new**(3)

**SD\_BUS\_NAME\_ALLOW\_REPLACEMENT**
**sd\_bus\_request\_name**(3)

**SD\_BUS\_NAME\_QUEUE**
**sd\_bus\_request\_name**(3)

**SD\_BUS\_NAME\_REPLACE\_EXISTING**
**sd\_bus\_request\_name**(3)

**SD\_BUS\_TYPE\_ARRAY**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_read**(3)

**SD\_BUS\_TYPE\_BOOLEAN**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3)

**SD\_BUS\_TYPE\_BYTE**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3)

**SD\_BUS\_TYPE\_DICT\_ENTRY\_BEGIN**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_read**(3)

**SD\_BUS\_TYPE\_DICT\_ENTRY\_END**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_read**(3)

**SD\_BUS\_TYPE\_DOUBLE**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3)

**SD\_BUS\_TYPE\_INT16**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3)

**SD\_BUS\_TYPE\_INT32**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3)

**SD\_BUS\_TYPE\_INT64**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3)

**SD\_BUS\_TYPE\_OBJECT\_PATH**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3)

**SD\_BUS\_TYPE\_SIGNATURE**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3)

**SD\_BUS\_TYPE\_STRING**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3)

**SD\_BUS\_TYPE\_STRUCT\_BEGIN**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_read**(3)

**SD\_BUS\_TYPE\_STRUCT\_END**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_read**(3)

**SD\_BUS\_TYPE\_UINT16**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3)

**SD\_BUS\_TYPE\_UINT32**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3)

**SD\_BUS\_TYPE\_UINT64**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3)

**SD\_BUS\_TYPE\_UNIX\_FD**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_read\_basic**(3),
**sd\_bus\_negotiate\_fds**(3)

**SD\_BUS\_TYPE\_VARIANT**
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_read**(3)

**SD\_EVENT\_ARMED**
**sd\_event\_wait**(3)

**SD\_EVENT\_EXITING**
**sd\_event\_wait**(3)

**SD\_EVENT\_FINISHED**
**sd\_event\_wait**(3)

**SD\_EVENT\_INITIAL**
**sd\_event\_wait**(3)

**SD\_EVENT\_OFF**
**sd\_event\_add\_child**(3),
**sd\_event\_add\_defer**(3),
**sd\_event\_add\_io**(3),
**sd\_event\_add\_signal**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_source\_set\_enabled**(3),
**sd\_event\_source\_unref**(3)

**SD\_EVENT\_ON**
**sd\_event\_add\_child**(3),
**sd\_event\_add\_defer**(3),
**sd\_event\_add\_inotify**(3),
**sd\_event\_add\_io**(3),
**sd\_event\_add\_signal**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_source\_set\_enabled**(3)

**SD\_EVENT\_ONESHOT**
**sd\_event\_add\_child**(3),
**sd\_event\_add\_defer**(3),
**sd\_event\_add\_inotify**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_source\_set\_enabled**(3)

**SD\_EVENT\_PENDING**
**sd\_event\_wait**(3)

**SD\_EVENT\_PREPARING**
**sd\_event\_wait**(3)

**SD\_EVENT\_PRIORITY\_IDLE**
**sd\_event\_source\_set\_priority**(3)

**SD\_EVENT\_PRIORITY\_IMPORTANT**
**sd\_event\_source\_set\_priority**(3)

**SD\_EVENT\_PRIORITY\_NORMAL**
**sd\_event\_source\_set\_priority**(3)

**SD\_EVENT\_RUNNING**
**sd\_event\_wait**(3)

**SD\_JOURNAL\_APPEND**
**sd\_journal\_get\_fd**(3)

**SD\_JOURNAL\_CURRENT\_USER**
**sd\_journal\_open**(3)

**SD\_JOURNAL\_INVALIDATE**
**sd\_journal\_get\_fd**(3)

**SD\_JOURNAL\_LOCAL\_ONLY**
**sd\_journal\_get\_usage**(3),
**sd\_journal\_open**(3)

**SD\_JOURNAL\_NOP**
**sd\_journal\_get\_fd**(3)

**SD\_JOURNAL\_OS\_ROOT**
**sd\_journal\_open**(3)

**SD\_JOURNAL\_RUNTIME\_ONLY**
**sd\_journal\_open**(3)

**SD\_JOURNAL\_SYSTEM**
**sd\_journal\_open**(3)

**SD\_LISTEN\_FDS\_START**
**sd\_listen\_fds**(3)

**SD\_WARNING**
**sd\_journal\_stream\_fd**(3)

**SEQNUM**
**udev\_device\_new\_from\_syspath**(3)

**SHM\_EXEC**
**systemd.exec**(5)

**SIGABRT**
**systemd.kill**(5),
**systemd.service**(5)

**SIGCHLD**
**sd\_event\_add\_child**(3)

**SIGCONT**
**systemd.kill**(5)

**SIGHUP**
**daemon**(7),
**systemd**(1),
**systemd.kill**(5),
**systemd.service**(5)

**SIGINT**
**loginctl**(1),
**machinectl**(1),
**systemctl**(1),
**systemd**(1),
**systemd.service**(5),
**systemd.special**(7)

**SIGKILL**
**systemd-nspawn**(1),
**systemd.kill**(5),
**systemd.mount**(5),
**systemd.service**(5),
**systemd.socket**(5),
**systemd.swap**(5)

**SIGPIPE**
**systemd-journald.service**(8),
**systemd.exec**(5),
**systemd.service**(5)

**SIGPWR**
**systemd**(1)

**SIGQUIT**
**systemd.kill**(5)

**SIGRTMIN+0**
**systemd**(1)

**SIGRTMIN+1**
**resolvectl**(1),
**systemd**(1),
**systemd-resolved.service**(8)

**SIGRTMIN+13**
**systemd**(1)

**SIGRTMIN+14**
**systemd**(1)

**SIGRTMIN+15**
**systemd**(1)

**SIGRTMIN+16**
**systemd**(1)

**SIGRTMIN+2**
**systemd**(1)

**SIGRTMIN+20**
**systemd**(1)

**SIGRTMIN+21**
**systemd**(1)

**SIGRTMIN+22**
**systemd**(1)

**SIGRTMIN+23**
**systemd**(1)

**SIGRTMIN+24**
**systemd**(1)

**SIGRTMIN+26**
**systemd**(1)

**SIGRTMIN+27**
**systemd**(1)

**SIGRTMIN+28**
**systemd**(1)

**SIGRTMIN+3**
**systemd**(1),
**systemd-nspawn**(1)

**SIGRTMIN+4**
**systemd**(1)

**SIGRTMIN+5**
**systemd**(1)

**SIGRTMIN+6**
**systemd**(1)

**SIGSTOP**
**loginctl**(1),
**machinectl**(1),
**systemctl**(1)

**SIGSYS**
**systemd.exec**(5)

**SIGTERM**
**daemon**(7),
**loginctl**(1),
**machinectl**(1),
**systemctl**(1),
**systemd**(1),
**systemd-nspawn**(1),
**systemd.kill**(5),
**systemd.mount**(5),
**systemd.service**(5),
**systemd.socket**(5),
**systemd.special**(7),
**systemd.swap**(5)

**SIGUSR1**
**systemd**(1),
**systemd-resolved.service**(8)

**SIGUSR2**
**resolvectl**(1),
**systemd**(1),
**systemd-resolved.service**(8)

**SIGWINCH**
**systemd**(1)

**SIG\_DFL**
**daemon**(7)

**SOCK\_DGRAM**
**sd\_is\_fifo**(3),
**systemd-socket-activate**(1),
**systemd.socket**(5)

**SOCK\_SEQPACKET**
**systemd-socket-activate**(1),
**systemd.socket**(5)

**SOCK\_STREAM**
**sd\_is\_fifo**(3),
**systemd-socket-activate**(1),
**systemd.socket**(5)

**SUBSYSTEM**
**udev\_device\_new\_from\_syspath**(3)

**TCP\_DEFER\_ACCEPT**
**systemd.socket**(5)

**UINT64\_MAX**
**sd\_bus\_get\_fd**(3),
**sd\_bus\_wait**(3),
**sd\_event\_add\_time**(3)

**USER\_PROCESS**
**systemd.exec**(5)

**WCONTINUED**
**sd\_event\_add\_child**(3)

**WEXITED**
**sd\_event\_add\_child**(3)

**WSTOPPED**
**sd\_event\_add\_child**(3)

**\_NSIG**
**daemon**(7)

**\_SD\_BUS\_CREDS\_ALL**
**sd\_bus\_creds\_new\_from\_pid**(3)

**activating**
**systemctl**(1)

**active**
**systemctl**(1)

**all**
**udevadm**(8)

**any**
**systemd.resource-control**(5)

**application/json**
**systemd-journal-gatewayd.service**(8)

**application/vnd.fdo.journal**
**systemd-journal-gatewayd.service**(8)

**auto**
**systemd**(1)

**b**
**udev\_device\_new\_from\_syspath**(3)

**bad-setting**
**systemctl**(1)

**c**
**udev\_device\_new\_from\_syspath**(3)

**cgroup**
**systemd.exec**(5)

**d**
**tmpfiles.d**(5)

**deactivating**
**systemctl**(1)

**early**
**udevadm**(8)

**error**
**sd\_bus\_message\_new\_method\_error**(3),
**systemctl**(1)

**failed**
**systemctl**(1),
**systemd.unit**(5)

**false**
**sd\_bus\_error**(3)

**h**
**tmpfiles.d**(5)

**host**
**systemd-journal-remote.service**(8)

**https**
**systemd-journal-upload.service**(8)

**inactive**
**systemctl**(1),
**systemd.unit**(5)

**ipc**
**systemd.exec**(5)

**keep-caps**
**systemd.exec**(5)

**kernel.modules\_disabled**
**systemd.exec**(5)

**late**
**udevadm**(8)

**libsystemd**
**sd-bus**(3),
**sd-bus-errors**(3),
**sd-daemon**(3),
**sd-event**(3),
**sd-id128**(3),
**sd-journal**(3),
**sd-login**(3),
**sd\_booted**(3),
**sd\_bus\_add\_match**(3),
**sd\_bus\_attach\_event**(3),
**sd\_bus\_close**(3),
**sd\_bus\_creds\_get\_pid**(3),
**sd\_bus\_creds\_new\_from\_pid**(3),
**sd\_bus\_default**(3),
**sd\_bus\_error**(3),
**sd\_bus\_error\_add\_map**(3),
**sd\_bus\_get\_fd**(3),
**sd\_bus\_is\_open**(3),
**sd\_bus\_message\_append**(3),
**sd\_bus\_message\_append\_array**(3),
**sd\_bus\_message\_append\_basic**(3),
**sd\_bus\_message\_append\_string\_memfd**(3),
**sd\_bus\_message\_append\_strv**(3),
**sd\_bus\_message\_copy**(3),
**sd\_bus\_message\_get\_cookie**(3),
**sd\_bus\_message\_get\_monotonic\_usec**(3),
**sd\_bus\_message\_get\_signature**(3),
**sd\_bus\_message\_get\_type**(3),
**sd\_bus\_message\_new**(3),
**sd\_bus\_message\_new\_method\_call**(3),
**sd\_bus\_message\_new\_method\_error**(3),
**sd\_bus\_message\_new\_signal**(3),
**sd\_bus\_message\_read**(3),
**sd\_bus\_message\_rewind**(3),
**sd\_bus\_message\_set\_destination**(3),
**sd\_bus\_message\_set\_expect\_reply**(3),
**sd\_bus\_message\_skip**(3),
**sd\_bus\_message\_verify\_type**(3),
**sd\_bus\_negotiate\_fds**(3),
**sd\_bus\_new**(3),
**sd\_bus\_path\_encode**(3),
**sd\_bus\_process**(3),
**sd\_bus\_reply\_method\_error**(3),
**sd\_bus\_request\_name**(3),
**sd\_bus\_set\_close\_on\_exit**(3),
**sd\_bus\_set\_connected\_signal**(3),
**sd\_bus\_set\_description**(3),
**sd\_bus\_set\_sender**(3),
**sd\_bus\_set\_watch\_bind**(3),
**sd\_bus\_slot\_ref**(3),
**sd\_bus\_slot\_set\_description**(3),
**sd\_bus\_slot\_set\_destroy\_callback**(3),
**sd\_bus\_slot\_set\_floating**(3),
**sd\_bus\_slot\_set\_userdata**(3),
**sd\_bus\_track\_add\_name**(3),
**sd\_bus\_track\_new**(3),
**sd\_bus\_wait**(3),
**sd\_event\_add\_child**(3),
**sd\_event\_add\_defer**(3),
**sd\_event\_add\_inotify**(3),
**sd\_event\_add\_io**(3),
**sd\_event\_add\_signal**(3),
**sd\_event\_add\_time**(3),
**sd\_event\_exit**(3),
**sd\_event\_get\_fd**(3),
**sd\_event\_new**(3),
**sd\_event\_now**(3),
**sd\_event\_run**(3),
**sd\_event\_set\_watchdog**(3),
**sd\_event\_source\_get\_event**(3),
**sd\_event\_source\_get\_pending**(3),
**sd\_event\_source\_set\_description**(3),
**sd\_event\_source\_set\_destroy\_callback**(3),
**sd\_event\_source\_set\_enabled**(3),
**sd\_event\_source\_set\_prepare**(3),
**sd\_event\_source\_set\_priority**(3),
**sd\_event\_source\_set\_userdata**(3),
**sd\_event\_source\_unref**(3),
**sd\_event\_wait**(3),
**sd\_get\_seats**(3),
**sd\_id128\_get\_machine**(3),
**sd\_id128\_randomize**(3),
**sd\_id128\_to\_string**(3),
**sd\_is\_fifo**(3),
**sd\_journal\_add\_match**(3),
**sd\_journal\_enumerate\_fields**(3),
**sd\_journal\_get\_catalog**(3),
**sd\_journal\_get\_cursor**(3),
**sd\_journal\_get\_cutoff\_realtime\_usec**(3),
**sd\_journal\_get\_data**(3),
**sd\_journal\_get\_fd**(3),
**sd\_journal\_get\_realtime\_usec**(3),
**sd\_journal\_get\_usage**(3),
**sd\_journal\_has\_runtime\_files**(3),
**sd\_journal\_next**(3),
**sd\_journal\_open**(3),
**sd\_journal\_print**(3),
**sd\_journal\_query\_unique**(3),
**sd\_journal\_seek\_head**(3),
**sd\_journal\_stream\_fd**(3),
**sd\_listen\_fds**(3),
**sd\_login\_monitor\_new**(3),
**sd\_machine\_get\_class**(3),
**sd\_notify**(3),
**sd\_pid\_get\_owner\_uid**(3),
**sd\_seat\_get\_active**(3),
**sd\_session\_is\_active**(3),
**sd\_uid\_get\_state**(3),
**sd\_watchdog\_enabled**(3)

**link-local**
**systemd.resource-control**(5)

**loaded**
**systemctl**(1)

**localhost**
**systemd.resource-control**(5)

**m**
**systemd.resource-control**(5),
**tmpfiles.d**(5)

**masked**
**systemctl**(1)

**min**
**tmpfiles.d**(5)

**mips64-le-n32**
**systemd.exec**(5)

**mips64-n32**
**systemd.exec**(5)

**mnt**
**systemd.exec**(5)

**ms**
**tmpfiles.d**(5)

**multicast**
**systemd.resource-control**(5)

**name**
**udevadm**(8)

**native**
**systemd.exec**(5)

**net**
**systemd.exec**(5)

**never**
**udevadm**(8)

**no**
**systemd**(1)

**nobody**
**systemd-nspawn**(1)

**noexec**
**systemd.exec**(5)

**none**
**systemd-journal-remote.service**(8)

**not-found**
**systemctl**(1)

**null**
**journalctl**(1)

**path**
**udevadm**(8)

**pid**
**systemd.exec**(5)

**ppc**
**systemd.exec**(5)

**ppc-le**
**systemd.exec**(5)

**ppc64**
**systemd.exec**(5)

**ppc64-le**
**systemd.exec**(5)

**property**
**udevadm**(8)

**r**
**systemd.resource-control**(5)

**reloading**
**systemctl**(1)

**rw**
**systemd.exec**(5)

**rwm**
**systemd.exec**(5)

**s**
**tmpfiles.d**(5)

**s390**
**systemd.exec**(5)

**s390x**
**systemd.exec**(5)

**simple**
**systemd-run**(1)

**symlink**
**udevadm**(8)

**tcp**
**resolvectl**(1)

**text/event-stream**
**systemd-journal-gatewayd.service**(8)

**text/plain**
**systemd-journal-gatewayd.service**(8)

**udev\_hwdb**
**libudev**(3)

**udev\_queue**
**libudev**(3)

**us**
**tmpfiles.d**(5)

**user**
**systemd.exec**(5)

**uts**
**systemd.exec**(5)

**w**
**systemd.resource-control**(5),
**tmpfiles.d**(5)

**x32**
**systemd.exec**(5)

**x86**
**systemd.exec**(5)

**x86-64**
**systemd.exec**(5)

**yes**
**systemd**(1)

**~**
**systemd.exec**(5)

<a name="miscellaneous-options-and-directives"></a>

# Miscellaneous Options and Directives


Other configuration elements which dont fit in any of the above groups.

_$LISTEN\_FDS_
**systemd-journal-remote.service**(8)

_A_
**tmpfiles.d**(5)

_A+_
**tmpfiles.d**(5)

_C_
**tmpfiles.d**(5)

_D_
**tmpfiles.d**(5)

_F_
**tmpfiles.d**(5)

_H_
**tmpfiles.d**(5)

_L_
**tmpfiles.d**(5)

_L+_
**tmpfiles.d**(5)

_Q_
**tmpfiles.d**(5)

_R_
**tmpfiles.d**(5)

_T_
**tmpfiles.d**(5)

_X_
**tmpfiles.d**(5)

_Z_
**tmpfiles.d**(5)

_a_
**tmpfiles.d**(5)

_a+_
**tmpfiles.d**(5)

**b**
**tmpfiles.d**(5)

_b+_
**tmpfiles.d**(5)

**c**
**tmpfiles.d**(5)

_c+_
**tmpfiles.d**(5)

**d**
**tmpfiles.d**(5)

_e_
**tmpfiles.d**(5)

_equivalent_
**systemd-delta**(1)

_extended_
**systemd-delta**(1)

_f_
**tmpfiles.d**(5)

_g_
**sysusers.d**(5)

**h**
**tmpfiles.d**(5)

**m**
**sysusers.d**(5)

**masked**
**systemd-delta**(1)

_overridden_
**systemd-delta**(1)

_p_
**tmpfiles.d**(5)

_p+_
**tmpfiles.d**(5)

_q_
**tmpfiles.d**(5)

**r**
**sysusers.d**(5),
**tmpfiles.d**(5)

_redirected_
**systemd-delta**(1)

_t_
**tmpfiles.d**(5)

_u_
**sysusers.d**(5)

_unchanged_
**systemd-delta**(1)

_v_
**tmpfiles.d**(5)

**w**
**tmpfiles.d**(5)

_x_
**tmpfiles.d**(5)

_z_
**tmpfiles.d**(5)

<a name="files-and-directories"></a>

# Files and Directories


Paths and file names referred to in the documentation.

/
**file-hierarchy**(7),
**systemd-gpt-auto-generator**(8),
**systemd-nspawn**(1),
**systemd-remount-fs.service**(8),
**systemd.nspawn**(5),
**systemd.special**(7),
**systemd.unit**(5),
**tmpfiles.d**(5)

$XDG_RUNTIME_DIR/systemd/generator/
**systemd.unit**(5)

$XDG_RUNTIME_DIR/systemd/generator.early/
**systemd.unit**(5)

$XDG_RUNTIME_DIR/systemd/generator.late/
**systemd.unit**(5)

$XDG_RUNTIME_DIR/systemd/transient/
**systemd.unit**(5)

$XDG_RUNTIME_DIR/systemd/user/
**systemd.unit**(5)

$XDG_RUNTIME_DIR/systemd/user.control/
**systemd.unit**(5)

$XDG_RUNTIME_DIR/user-tmpfiles.d/*.conf
**tmpfiles.d**(5)

-.mount
**systemd.special**(7)

-.slice
**systemd.special**(7)

/EFI/Linux/
**systemd-boot**(7)

/bin/
**file-hierarchy**(7),
**systemd.exec**(5),
**systemd.service**(5)

/bin/bash
**systemd-run**(1)

/bin/echo
**systemd.service**(5)

/bin/ls
**systemd-cat**(1)

/bin/sh
**machinectl**(1),
**sysusers.d**(5)

/boot
**bootctl**(1),
**file-hierarchy**(7),
**kernel-install**(8),
**systemd-boot**(7),
**systemd-gpt-auto-generator**(8),
**systemd-nspawn**(1),
**systemd.exec**(5)

/boot/efi
**bootctl**(1),
**kernel-install**(8),
**systemd-boot**(7)

/dev/
**file-hierarchy**(7),
**systemd-nspawn**(1),
**systemd-remount-fs.service**(8),
**systemd.device**(5),
**systemd.exec**(5),
**systemd.generator**(7),
**systemd.journal-fields**(7),
**systemd.resource-control**(5),
**udev**(7),
**udevadm**(8)

/dev/console
**journald.conf**(5),
**systemd-getty-generator**(8),
**systemd-tty-ask-password-agent**(1),
**systemd.exec**(5)

/dev/disk/by-foo/bar
**systemd-hibernate-resume-generator**(8)

/dev/full
**systemd.resource-control**(5)

/dev/hw_random
**crypttab**(5)

/dev/initctl
**systemd**(1),
**systemd-initctl.service**(8)

/dev/kmsg
**journald.conf**(5),
**systemd-journald.service**(8),
**systemd.generator**(7)

/dev/log
**systemd-journald.service**(8)

/dev/loop-control
**systemd.exec**(5)

/dev/mapper/
**crypttab**(5)

/dev/mapper/home
**systemd-gpt-auto-generator**(8)

/dev/mapper/srv
**systemd-gpt-auto-generator**(8)

/dev/mem
**systemd.exec**(5)

/dev/net/tun
**systemd.netdev**(5)

/dev/null
**binfmt.d**(5),
**coredump.conf**(5),
**daemon**(7),
**dnssec-trust-anchors.d**(5),
**environment.d**(5),
**hwdb**(7),
**journal-remote.conf**(5),
**journal-upload.conf**(5),
**journald.conf**(5),
**kernel-install**(8),
**logind.conf**(5),
**modules-load.d**(5),
**networkd.conf**(5),
**resolved.conf**(5),
**sysctl.d**(5),
**systemctl**(1),
**systemd-sleep.conf**(5),
**systemd-system.conf**(5),
**systemd.environment-generator**(7),
**systemd.exec**(5),
**systemd.generator**(7),
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5),
**systemd.preset**(5),
**systemd.resource-control**(5),
**systemd.unit**(5),
**sysusers.d**(5),
**timesyncd.conf**(5),
**tmpfiles.d**(5),
**udev**(7)

/dev/port
**systemd.exec**(5)

/dev/random
**crypttab**(5),
**systemd.exec**(5),
**systemd.resource-control**(5)

/dev/sda
**systemd.exec**(5)

/dev/sda5
**systemd.resource-control**(5)

/dev/shm/
**file-hierarchy**(7),
**systemd.exec**(5)

/dev/urandom
**crypttab**(5),
**sd\_id128\_randomize**(3),
**systemd.resource-control**(5)

/dev/watchdog
**systemd-system.conf**(5)

/dev/zero
**systemd.exec**(5),
**systemd.resource-control**(5)

/efi
**bootctl**(1),
**file-hierarchy**(7),
**kernel-install**(8),
**systemd-boot**(7),
**systemd-gpt-auto-generator**(8),
**systemd-nspawn**(1)

/etc/
**binfmt.d**(5),
**coredump.conf**(5),
**environment.d**(5),
**file-hierarchy**(7),
**hwdb**(7),
**journal-remote.conf**(5),
**journal-upload.conf**(5),
**journald.conf**(5),
**kernel-command-line**(7),
**logind.conf**(5),
**machine-id**(5),
**machinectl**(1),
**modules-load.d**(5),
**networkd.conf**(5),
**nss-myhostname**(8),
**os-release**(5),
**portablectl**(1),
**resolved.conf**(5),
**sysctl.d**(5),
**systemctl**(1),
**systemd-delta**(1),
**systemd-firstboot**(1),
**systemd-fstab-generator**(8),
**systemd-machine-id-commit.service**(8),
**systemd-machine-id-setup**(1),
**systemd-nspawn**(1),
**systemd-sleep.conf**(5),
**systemd-system.conf**(5),
**systemd-update-done.service**(8),
**systemd-volatile-root.service**(8),
**systemd.dnssd**(5),
**systemd.environment-generator**(7),
**systemd.exec**(5),
**systemd.generator**(7),
**systemd.link**(5),
**systemd.mount**(5),
**systemd.netdev**(5),
**systemd.network**(5),
**systemd.preset**(5),
**systemd.unit**(5),
**timesyncd.conf**(5),
**tmpfiles.d**(5),
**udev**(7)

/etc/.updated
**systemd-update-done.service**(8)

/etc/adjtime
**timedatectl**(1)

/etc/binfmt.d/*.conf
**binfmt.d**(5)

/etc/crypttab
**crypttab**(5),
**systemd-cryptsetup-generator**(8),
**systemd-cryptsetup@.service**(8),
**systemd-gpt-auto-generator**(8)

/etc/dnssec-trust-anchors.d/
**dnssec-trust-anchors.d**(5)

/etc/dnssec-trust-anchors.d/*.negative
**dnssec-trust-anchors.d**(5)

/etc/dnssec-trust-anchors.d/*.positive
**dnssec-trust-anchors.d**(5)

/etc/environment
**environment.d**(5)

/etc/environment.d/*.conf
**environment.d**(5)

/etc/environment.d/60-foo.conf
**environment.d**(5)

/etc/fstab
**kernel-command-line**(7),
**systemd**(1),
**systemd-fsck@.service**(8),
**systemd-fstab-generator**(8),
**systemd-gpt-auto-generator**(8),
**systemd-mount**(1),
**systemd-remount-fs.service**(8),
**systemd.automount**(5),
**systemd.generator**(7),
**systemd.mount**(5),
**systemd.special**(7),
**systemd.swap**(5)

/etc/group
**nss-mymachines**(8),
**nss-systemd**(8),
**systemd-nspawn**(1),
**systemd.exec**(5),
**sysusers.d**(5)

/etc/hostname
**hostname**(5),
**hostnamectl**(1),
**machine-info**(5)

/etc/hosts
**nss-myhostname**(8),
**nss-mymachines**(8),
**resolvectl**(1),
**resolved.conf**(5),
**systemd-resolved.service**(8)

/etc/init.d/
**systemd-sysv-generator**(8)

/etc/initrd-release
**bootup**(7)

/etc/kernel/cmdline
**kernel-install**(8)

/etc/kernel/install.d/
**kernel-install**(8)

/etc/kernel/install.d/*.install
**kernel-install**(8)

/etc/kernel/tries
**kernel-install**(8),
**systemd-boot**(7)

/etc/locale.conf
**locale.conf**(5),
**localectl**(1),
**systemd**(1)

/etc/localtime
**localtime**(5),
**systemd-nspawn**(1),
**systemd.network**(5),
**systemd.nspawn**(5),
**timedatectl**(1)

/etc/machine-id
**kernel-install**(8),
**machine-id**(5),
**sd\_id128\_get\_machine**(3),
**systemd-machine-id-commit.service**(8),
**systemd-machine-id-setup**(1),
**systemd-nspawn**(1),
**systemd.unit**(5)

/etc/machine-info
**hostnamectl**(1),
**machine-info**(5)

/etc/modules-load.d/_program_.conf
**modules-load.d**(5)

/etc/modules-load.d/*.conf
**modules-load.d**(5)

/etc/modules-load.d/bridge.conf
**sysctl.d**(5)

/etc/nsswitch.conf
**nss-myhostname**(8),
**nss-mymachines**(8),
**nss-resolve**(8),
**nss-systemd**(8)

/etc/os-release
**kernel-install**(8),
**os-release**(5),
**systemd-nspawn**(1)

/etc/passwd
**nss-mymachines**(8),
**nss-systemd**(8),
**systemd-nspawn**(1),
**systemd.exec**(5),
**sysusers.d**(5)

/etc/portables/
**portablectl**(1)

/etc/rc.local
**systemd-rc-local-generator**(8)

/etc/resolv.conf
**resolvectl**(1),
**resolved.conf**(5),
**systemd-nspawn**(1),
**systemd-resolved.service**(8),
**systemd.network**(5),
**systemd.nspawn**(5)

/etc/ssl/ca/trusted.pem
**systemd-journal-remote.service**(8),
**systemd-journal-upload.service**(8)

/etc/ssl/certs/journal-remote.pem
**systemd-journal-remote.service**(8)

/etc/ssl/certs/journal-upload.pem
**systemd-journal-upload.service**(8)

/etc/ssl/private/journal-remote.pem
**systemd-journal-remote.service**(8)

/etc/ssl/private/journal-upload.pem
**systemd-journal-upload.service**(8)

/etc/sysctl.d/*.conf
**sysctl.d**(5)

/etc/sysctl.d/50-coredump.conf
**systemd-sysctl.service**(8)

/etc/sysctl.d/bridge.conf
**sysctl.d**(5)

/etc/sysctl.d/domain-name.conf
**sysctl.d**(5)

/etc/systemd/
**coredump.conf**(5),
**journal-remote.conf**(5),
**journal-upload.conf**(5),
**journald.conf**(5),
**logind.conf**(5),
**networkd.conf**(5),
**resolved.conf**(5),
**systemd-sleep.conf**(5),
**systemd-system.conf**(5),
**timesyncd.conf**(5)

/etc/systemd/coredump.conf
**coredump.conf**(5),
**systemd-coredump**(8)

/etc/systemd/coredump.conf.d/*.conf
**coredump.conf**(5),
**systemd-coredump**(8)

/etc/systemd/dnssd
**systemd.dnssd**(5)

/etc/systemd/import-pubring.gpg
**machinectl**(1)

/etc/systemd/journal-remote.conf
**journal-remote.conf**(5),
**systemd-journal-upload.service**(8)

/etc/systemd/journal-remote.conf.d/*.conf
**journal-remote.conf**(5)

/etc/systemd/journal-upload.conf
**journal-upload.conf**(5),
**systemd-journal-upload.service**(8)

/etc/systemd/journal-upload.conf.d/*.conf
**journal-upload.conf**(5)

/etc/systemd/journald.conf
**journald.conf**(5),
**systemd-journald.service**(8)

/etc/systemd/journald.conf.d/*.conf
**journald.conf**(5)

/etc/systemd/logind.conf
**logind.conf**(5),
**systemd-analyze**(1)

/etc/systemd/logind.conf.d/*.conf
**logind.conf**(5)

/etc/systemd/network
**systemd-networkd.service**(8),
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5)

/etc/systemd/network/*.network
**systemd-resolved.service**(8)

/etc/systemd/networkd.conf
**networkd.conf**(5)

/etc/systemd/networkd.conf.d/*.conf
**networkd.conf**(5)

/etc/systemd/nspawn/
**systemd-nspawn**(1),
**systemd.nspawn**(5)

/etc/systemd/portable/profile/
**portablectl**(1)

/etc/systemd/resolve.conf
**resolvectl**(1)

/etc/systemd/resolved.conf
**resolved.conf**(5),
**systemd-resolved.service**(8)

/etc/systemd/resolved.conf.d/*.conf
**resolved.conf**(5)

/etc/systemd/sleep.conf
**systemd-sleep.conf**(5),
**systemd-suspend.service**(8)

/etc/systemd/sleep.conf.d/*.conf
**systemd-sleep.conf**(5)

/etc/systemd/system/
**systemctl**(1),
**systemd.unit**(5)

/etc/systemd/system-environment-generators/
**systemd.environment-generator**(7)

/etc/systemd/system-generators/
**systemd.generator**(7)

/etc/systemd/system-preset/
**systemd.preset**(5)

/etc/systemd/system-preset/*.preset
**systemd.preset**(5)

/etc/systemd/system.attached/
**portablectl**(1)

/etc/systemd/system.conf
**systemd-system.conf**(5)

/etc/systemd/system.conf.d/*.conf
**systemd-system.conf**(5)

/etc/systemd/system.control/
**systemd.unit**(5)

/etc/systemd/system/httpd.service
**systemd.unit**(5)

/etc/systemd/system/httpd.service.d/local.conf
**systemd.unit**(5)

/etc/systemd/system/multi-user.target.wants/foo.service
**systemd.unit**(5)

/etc/systemd/systemd.attached/
**systemd.unit**(5)

/etc/systemd/systemd/ctrl-alt-del.service
**systemd.unit**(5)

/etc/systemd/timesyncd.conf
**timesyncd.conf**(5)

/etc/systemd/timesyncd.conf.d/*.conf
**timesyncd.conf**(5)

/etc/systemd/user/
**systemd.unit**(5)

/etc/systemd/user-environment-generators/
**systemd.environment-generator**(7)

/etc/systemd/user-generators/
**systemd.generator**(7)

/etc/systemd/user-preset/*.preset
**systemd.preset**(5)

/etc/systemd/user.conf
**systemd-system.conf**(5)

/etc/systemd/user.conf.d/*.conf
**systemd-system.conf**(5)

/etc/sysusers.d
**sysusers.d**(5)

/etc/sysusers.d/*.conf
**sysusers.d**(5)

/etc/sysusers.d/00-overrides.conf
**systemd-sysusers**(8)

/etc/sysusers.d/radvd.conf
**systemd-sysusers**(8)

/etc/tmpfiles.d
**tmpfiles.d**(5)

/etc/tmpfiles.d/*.conf
**tmpfiles.d**(5)

/etc/udev/hwdb.bin
**hwdb**(7)

/etc/udev/hwdb.d
**hwdb**(7)

/etc/udev/rules.d
**udev**(7)

/etc/udev/rules.d/99-bridge.rules
**sysctl.d**(5)

/etc/udev/udev.conf
**udev.conf**(5)

/etc/vconsole.conf
**localectl**(1),
**systemd-vconsole-setup.service**(8),
**vconsole.conf**(5)

/foo//bar/baz/
**systemd.unit**(5)

/home/
**file-hierarchy**(7),
**systemctl**(1),
**systemd-gpt-auto-generator**(8),
**systemd.exec**(5),
**systemd.generator**(7),
**tmpfiles.d**(5)

/home/lennart
**systemd.automount**(5)

/lib/
**file-hierarchy**(7)

/lib64/
**file-hierarchy**(7)

/loader/entries/
**systemd-boot**(7)

/loader/loader.conf
**systemd-boot**(7)

/log
**systemd.exec**(5)

**/path/to/generator**
**systemd.generator**(7)

/proc
**busctl**(1),
**file-hierarchy**(7),
**sd-login**(3),
**sd\_bus\_creds\_get\_pid**(3),
**sd\_bus\_creds\_new\_from\_pid**(3),
**sd\_is\_fifo**(3),
**sd\_pid\_get\_owner\_uid**(3),
**systemd**(1),
**systemd-remount-fs.service**(8),
**systemd.exec**(5),
**systemd.generator**(7),
**systemd.socket**(5),
**tmpfiles.d**(5)

/proc/$PID/ns/net
**systemd-nspawn**(1)

/proc/acpi
**systemd.exec**(5)

/proc/cmdline
**kernel-command-line**(7),
**kernel-install**(8),
**systemd**(1)

/proc/devices
**systemd.resource-control**(5)

/proc/fs
**systemd.exec**(5)

/proc/irq
**systemd.exec**(5)

/proc/latency_stats
**systemd.exec**(5)

/proc/self/fd
**daemon**(7)

/proc/self/mountinfo
**systemd.mount**(5)

/proc/self/oom_score_adj
**systemd-nspawn**(1)

/proc/self/sessionid
**pam\_systemd**(8)

/proc/sys/
**file-hierarchy**(7),
**systemd-nspawn**(1),
**systemd-sysctl.service**(8),
**systemd.exec**(5)

/proc/sys/kernel/core_pattern
**systemd-sysctl.service**(8)

/proc/sys/kernel/domainname
**sysctl.d**(5)

/proc/sys/kernel/modules_disabled
**systemd.exec**(5)

/proc/sys/kernel/random/boot_id
**sd\_id128\_get\_machine**(3)

/proc/sys/net/ipv4/conf/enp3s0.200/forwarding
**sysctl.d**(5)

/proc/sys/net/ipv4/tcp_keepalive_time
**systemd.socket**(5)

/proc/sys/net/ipv6/bindv6only
**systemd.socket**(5)

/proc/sys/net/ipv6/conf/_ifname_/disable_ipv6
**systemd.network**(5)

/proc/sysrq-trigger
**systemd.exec**(5)

/proc/timer_stats
**systemd.exec**(5)

/root/
**file-hierarchy**(7),
**systemd.exec**(5)

/run/
**binfmt.d**(5),
**environment.d**(5),
**file-hierarchy**(7),
**modules-load.d**(5),
**sd-login**(3),
**sd\_notify**(3),
**sysctl.d**(5),
**systemctl**(1),
**systemd-delta**(1),
**systemd-journald.service**(8),
**systemd-nspawn**(1),
**systemd.dnssd**(5),
**systemd.environment-generator**(7),
**systemd.exec**(5),
**systemd.generator**(7),
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5),
**systemd.preset**(5),
**systemd.service**(5),
**systemd.unit**(5),
**tmpfiles.d**(5),
**udev**(7)

/run/baz
**systemd.exec**(5)

/run/binfmt.d/*.conf
**binfmt.d**(5)

/run/dnssec-trust-anchors.d/
**dnssec-trust-anchors.d**(5)

/run/dnssec-trust-anchors.d/*.negative
**dnssec-trust-anchors.d**(5)

/run/dnssec-trust-anchors.d/*.positive
**dnssec-trust-anchors.d**(5)

/run/environment.d/*.conf
**environment.d**(5)

/run/foo
**systemd.exec**(5)

/run/foo/bar
**systemd.exec**(5)

/run/foobar.pid
**daemon**(7)

/run/log/
**file-hierarchy**(7)

/run/log/journal
**journalctl**(1),
**journald.conf**(5),
**sd\_journal\_open**(3),
**systemd-journald.service**(8)

/run/media/system/
**systemd-mount**(1)

/run/modules-load.d/*.conf
**modules-load.d**(5)

/run/netns
**systemd-nspawn**(1)

/run/nologin
**shutdown**(8),
**systemd-user-sessions.service**(8)

/run/portables/
**portablectl**(1)

/run/screens
**tmpfiles.d**(5)

/run/sysctl.d/*.conf
**sysctl.d**(5)

/run/sysctl.d/50-coredump.conf
**systemd-sysctl.service**(8)

/run/system/nspawn/
**systemd.nspawn**(5)

/run/systemd/coredump.conf.d/*.conf
**coredump.conf**(5)

/run/systemd/dnssd
**systemd.dnssd**(5)

/run/systemd/generator
**systemd.generator**(7),
**systemd.unit**(5)

/run/systemd/generator.early
**systemd.generator**(7),
**systemd.unit**(5)

/run/systemd/generator.late
**systemd.generator**(7),
**systemd.unit**(5)

/run/systemd/journal-remote.conf.d/*.conf
**journal-remote.conf**(5)

/run/systemd/journal-upload.conf.d/*.conf
**journal-upload.conf**(5)

/run/systemd/journal/dev-log
**systemd-journald.service**(8)

/run/systemd/journal/socket
**systemd-journald.service**(8)

/run/systemd/journal/stdout
**systemd-journald.service**(8)

/run/systemd/journal/syslog
**journald.conf**(5)

/run/systemd/journald.conf.d/*.conf
**journald.conf**(5)

/run/systemd/logind.conf.d/*.conf
**logind.conf**(5)

/run/systemd/network
**systemd-networkd.service**(8),
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5)

/run/systemd/notify
**systemd**(1)

/run/systemd/nspawn/
**systemd-nspawn**(1),
**systemd.nspawn**(5)

/run/systemd/portables/
**portablectl**(1)

/run/systemd/private
**systemd**(1)

/run/systemd/resolve/resolv.conf
**systemd-resolved.service**(8)

/run/systemd/resolve/stub-resolv.conf
**systemd-resolved.service**(8)

/run/systemd/resolved.conf.d/*.conf
**resolved.conf**(5)

/run/systemd/sleep.conf.d/*.conf
**systemd-sleep.conf**(5)

/run/systemd/system/
**sd\_booted**(3),
**systemctl**(1),
**systemd.unit**(5)

/run/systemd/system-environment-generators/
**systemd.environment-generator**(7)

/run/systemd/system-generators/
**systemd.generator**(7)

/run/systemd/system-preset/*.preset
**systemd.preset**(5)

/run/systemd/system.attached/
**portablectl**(1)

/run/systemd/system.conf.d/*.conf
**systemd-system.conf**(5)

/run/systemd/system.control/
**systemd.unit**(5)

/run/systemd/systemd/
**systemctl**(1)

/run/systemd/systemd.attached/
**systemd.unit**(5)

/run/systemd/timesync/synchronized
**systemd-time-wait-sync.service**(8),
**systemd-timesyncd.service**(8)

/run/systemd/timesyncd.conf.d/*.conf
**timesyncd.conf**(5)

/run/systemd/transient/
**systemd.unit**(5)

/run/systemd/user/
**systemd.unit**(5)

/run/systemd/user-environment-generators/
**systemd.environment-generator**(7)

/run/systemd/user-generators/
**systemd.generator**(7)

/run/systemd/user-preset/*.preset
**systemd.preset**(5)

/run/systemd/user.conf.d/*.conf
**systemd-system.conf**(5)

/run/sysusers.d
**sysusers.d**(5)

/run/sysusers.d/*.conf
**sysusers.d**(5)

/run/tmpfiles.d
**tmpfiles.d**(5)

/run/tmpfiles.d/*.conf
**tmpfiles.d**(5)

/run/udev/rules.d
**udev**(7)

/run/udev/static\_node-tags/_tag_
**udev**(7)

/run/user/
**file-hierarchy**(7),
**systemd.exec**(5),
**user@.service**(5)

/run/user/$UID
**pam\_systemd**(8)

/run/utmp
**runlevel**(8)

/sbin/
**file-hierarchy**(7),
**systemd.exec**(5)

/sbin/fsck.
**systemd-fsck@.service**(8)

/sbin/mkfs.
**systemd-makefs@.service**(8)

/sbin/nologin
**sysusers.d**(5)

/srv/
**file-hierarchy**(7),
**systemd-gpt-auto-generator**(8)

/srv/webserver
**systemd.unit**(5)

/srv/www
**systemd.unit**(5)

/sys/
**file-hierarchy**(7),
**loginctl**(1),
**sd\_is\_fifo**(3),
**systemd**(1),
**systemd-nspawn**(1),
**systemd-remount-fs.service**(8),
**systemd-tmpfiles**(8),
**systemd.device**(5),
**systemd.exec**(5),
**systemd.generator**(7),
**systemd.journal-fields**(7),
**systemd.socket**(5),
**tmpfiles.d**(5),
**udev\_device\_new\_from\_syspath**(3),
**udevadm**(8)

/sys/devices
**udev\_device\_new\_from\_syspath**(3)

/sys/fs/cgroup
**sd-login**(3),
**sd\_pid\_get\_owner\_uid**(3),
**systemd-cgls**(1),
**systemd.exec**(5)

/sys/fs/cgroup/systemd/
**systemd**(1)

/sys/fs/selinux
**systemd-nspawn**(1)

/sys/power/disk
**systemd-sleep.conf**(5)

/sys/power/resume
**systemd-hibernate-resume@.service**(8)

/sys/power/state
**systemd-sleep.conf**(5),
**systemd-suspend.service**(8)

/sysroot
**bootup**(7)

/sysroot/etc/fstab
**bootup**(7)

/system-update
**systemd-system-update-generator**(8),
**systemd.offline-updates**(7),
**systemd.special**(7)

/tmp
**crypttab**(5),
**file-hierarchy**(7),
**systemd.exec**(5),
**systemd.special**(7),
**systemd.unit**(5),
**sysusers.d**(5),
**tmpfiles.d**(5)

/upload
**systemd-journal-remote.service**(8)

/usr
**bootup**(7),
**file-hierarchy**(7),
**kernel-command-line**(7),
**machinectl**(1),
**portablectl**(1),
**systemctl**(1),
**systemd-fstab-generator**(8),
**systemd-nspawn**(1),
**systemd-remount-fs.service**(8),
**systemd-update-done.service**(8),
**systemd-volatile-root.service**(8),
**systemd.exec**(5),
**systemd.generator**(7),
**systemd.mount**(5),
**systemd.unit**(5)

/usr/bin/
**file-hierarchy**(7),
**systemd.exec**(5),
**systemd.service**(5)

/usr/bin/mount
**systemctl**(1)

/usr/bin/umount
**systemctl**(1)

/usr/include/
**file-hierarchy**(7)

/usr/include/stdlib.h
**systemd-tmpfiles**(8)

/usr/include/sysexits.h
**systemd-tmpfiles**(8)

/usr/lib/
**binfmt.d**(5),
**environment.d**(5),
**file-hierarchy**(7),
**hwdb**(7),
**modules-load.d**(5),
**sysctl.d**(5),
**systemd-delta**(1),
**systemd.dnssd**(5),
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5),
**systemd.preset**(5),
**systemd.unit**(5),
**udev**(7)

/usr/lib/binfmt.d/*.conf
**binfmt.d**(5)

/usr/lib/dnssec-trust-anchors.d/
**dnssec-trust-anchors.d**(5)

/usr/lib/dnssec-trust-anchors.d/*.negative
**dnssec-trust-anchors.d**(5)

/usr/lib/dnssec-trust-anchors.d/*.positive
**dnssec-trust-anchors.d**(5)

/usr/lib/environment.d/*.conf
**environment.d**(5)

/usr/lib/kernel/install.d/
**kernel-install**(8)

/usr/lib/kernel/install.d/*.install
**kernel-install**(8)

/usr/lib/machines/
**machinectl**(1)

/usr/lib/modules
**systemd.exec**(5)

/usr/lib/modules-load.d/*.conf
**modules-load.d**(5)

/usr/lib/os-release
**kernel-install**(8),
**os-release**(5),
**systemd-nspawn**(1)

/usr/lib/portables/
**portablectl**(1)

/usr/lib/sysctl.d/*.conf
**sysctl.d**(5)

/usr/lib/sysctl.d/50-coredump.conf
**systemd-coredump**(8),
**systemd-sysctl.service**(8)

/usr/lib/systemd/*.conf.d/
**coredump.conf**(5),
**journal-remote.conf**(5),
**journal-upload.conf**(5),
**journald.conf**(5),
**logind.conf**(5),
**networkd.conf**(5),
**resolved.conf**(5),
**systemd-sleep.conf**(5),
**systemd-system.conf**(5),
**timesyncd.conf**(5)

/usr/lib/systemd/coredump.conf.d/*.conf
**coredump.conf**(5)

/usr/lib/systemd/dnssd
**systemd.dnssd**(5)

/usr/lib/systemd/import-pubring.gpg
**machinectl**(1)

/usr/lib/systemd/journal-remote.conf.d/*.conf
**journal-remote.conf**(5)

/usr/lib/systemd/journal-upload.conf.d/*.conf
**journal-upload.conf**(5)

/usr/lib/systemd/journald.conf.d/*.conf
**journald.conf**(5)

/usr/lib/systemd/logind.conf
**systemd-analyze**(1)

/usr/lib/systemd/logind.conf.d/*.conf
**logind.conf**(5)

/usr/lib/systemd/network
**systemd-networkd.service**(8),
**systemd.link**(5),
**systemd.netdev**(5),
**systemd.network**(5)

/usr/lib/systemd/network/80-container-host0.network
**systemd-nspawn**(1)

/usr/lib/systemd/network/80-container-ve.network
**systemd-nspawn**(1)

/usr/lib/systemd/network/80-container-vz.network
**systemd-nspawn**(1)

/usr/lib/systemd/networkd.conf.d/*.conf
**networkd.conf**(5)

/usr/lib/systemd/portable/profile/
**portablectl**(1)

/usr/lib/systemd/portable/profile/default/service.conf
**portablectl**(1)

/usr/lib/systemd/random-seed
**systemd-random-seed.service**(8)

/usr/lib/systemd/resolv.conf
**systemd-resolved.service**(8)

/usr/lib/systemd/resolved.conf.d/*.conf
**resolved.conf**(5)

/usr/lib/systemd/sleep.conf.d/*.conf
**systemd-sleep.conf**(5)

/usr/lib/systemd/system
**systemd**(1),
**systemd.unit**(5)

/usr/lib/systemd/system-bless-boot
**systemd-bless-boot.service**(8)

/usr/lib/systemd/system-boot-check-no-failures
**systemd-boot-check-no-failures.service**(8)

/usr/lib/systemd/system-environment-generators/
**systemd.environment-generator**(7)

**/usr/lib/systemd/system-environment-generators/some-generator**
**systemd.environment-generator**(7)

/usr/lib/systemd/system-generators/
**systemd.generator**(7)

/usr/lib/systemd/system-generators/systemd-bless-boot-generator
**systemd-bless-boot-generator**(8)

/usr/lib/systemd/system-generators/systemd-cryptsetup-generator
**systemd-cryptsetup-generator**(8)

/usr/lib/systemd/system-generators/systemd-debug-generator
**systemd-debug-generator**(8)

/usr/lib/systemd/system-generators/systemd-fstab-generator
**systemd-fstab-generator**(8)

/usr/lib/systemd/system-generators/systemd-getty-generator
**systemd-getty-generator**(8)

/usr/lib/systemd/system-generators/systemd-gpt-auto-generator
**systemd-gpt-auto-generator**(8)

/usr/lib/systemd/system-generators/systemd-hibernate-resume-generator
**systemd-hibernate-resume-generator**(8)

/usr/lib/systemd/system-generators/systemd-rc-local-generator
**systemd-rc-local-generator**(8)

/usr/lib/systemd/system-generators/systemd-run-generator
**systemd-run-generator**(8)

/usr/lib/systemd/system-generators/systemd-system-update-generator
**systemd-system-update-generator**(8)

/usr/lib/systemd/system-generators/systemd-sysv-generator
**systemd-sysv-generator**(8)

/usr/lib/systemd/system-generators/systemd-veritysetup-generator
**systemd-veritysetup-generator**(8)

/usr/lib/systemd/system-preset/*.preset
**systemd.preset**(5)

/usr/lib/systemd/system-shutdown/
**systemd-halt.service**(8)

/usr/lib/systemd/system-sleep
**systemd-suspend.service**(8)

/usr/lib/systemd/system.conf.d/*.conf
**systemd-system.conf**(5)

/usr/lib/systemd/system/httpd.service
**systemd.unit**(5)

**/usr/lib/systemd/systemd**
**systemd**(1)

/usr/lib/systemd/systemd-backlight
**systemd-backlight@.service**(8)

/usr/lib/systemd/systemd-binfmt
**systemd-binfmt.service**(8)

/usr/lib/systemd/systemd-coredump
**systemd-coredump**(8)

/usr/lib/systemd/systemd-cryptsetup
**systemd-cryptsetup@.service**(8)

/usr/lib/systemd/systemd-fsck
**systemd-fsck@.service**(8)

/usr/lib/systemd/systemd-growfs
**systemd-makefs@.service**(8)

/usr/lib/systemd/systemd-hibernate-resume
**systemd-hibernate-resume@.service**(8)

/usr/lib/systemd/systemd-hostnamed
**systemd-hostnamed.service**(8)

/usr/lib/systemd/systemd-importd
**systemd-importd.service**(8)

/usr/lib/systemd/systemd-initctl
**systemd-initctl.service**(8)

**/usr/lib/systemd/systemd-journal-gatewayd**
**systemd-journal-gatewayd.service**(8)

**/usr/lib/systemd/systemd-journal-remote**
**systemd-journal-remote.service**(8)

**/usr/lib/systemd/systemd-journal-upload**
**systemd-journal-upload.service**(8)

/usr/lib/systemd/systemd-journald
**systemd-journald.service**(8)

/usr/lib/systemd/systemd-localed
**systemd-localed.service**(8)

/usr/lib/systemd/systemd-logind
**systemd-logind.service**(8)

/usr/lib/systemd/systemd-machined
**systemd-machined.service**(8)

/usr/lib/systemd/systemd-makefs
**systemd-makefs@.service**(8)

/usr/lib/systemd/systemd-modules-load
**systemd-modules-load.service**(8)

/usr/lib/systemd/systemd-networkd
**systemd-networkd.service**(8)

/usr/lib/systemd/systemd-networkd-wait-online
**systemd-networkd-wait-online.service**(8)

/usr/lib/systemd/systemd-portabled
**systemd-portabled.service**(8)

/usr/lib/systemd/systemd-quotacheck
**systemd-quotacheck.service**(8)

/usr/lib/systemd/systemd-remount-fs
**systemd-remount-fs.service**(8)

/usr/lib/systemd/systemd-resolved
**systemd-resolved.service**(8)

/usr/lib/systemd/systemd-rfkill
**systemd-rfkill.service**(8)

/usr/lib/systemd/systemd-shutdown
**systemd-halt.service**(8)

**/usr/lib/systemd/systemd-sysctl**
**systemd-sysctl.service**(8)

/usr/lib/systemd/systemd-time-wait-sync
**systemd-time-wait-sync.service**(8)

/usr/lib/systemd/systemd-timedated
**systemd-timedated.service**(8)

/usr/lib/systemd/systemd-timesyncd
**systemd-timesyncd.service**(8)

**/usr/lib/systemd/systemd-udevd**
**systemd-udevd.service**(8)

/usr/lib/systemd/systemd-update-done
**systemd-update-done.service**(8)

/usr/lib/systemd/systemd-update-utmp
**systemd-update-utmp.service**(8)

/usr/lib/systemd/systemd-user-sessions
**systemd-user-sessions.service**(8)

**/usr/lib/systemd/systemd-vconsole-setup**
**systemd-vconsole-setup.service**(8)

/usr/lib/systemd/systemd-veritysetup
**systemd-veritysetup@.service**(8)

/usr/lib/systemd/systemd-volatile-root
**systemd-volatile-root.service**(8)

/usr/lib/systemd/timesyncd.conf.d/*.conf
**timesyncd.conf**(5)

/usr/lib/systemd/user/
**systemd.unit**(5)

/usr/lib/systemd/user-environment-generators/
**systemd.environment-generator**(7)

/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator
**systemd-environment-d-generator**(8)

**/usr/lib/systemd/user-environment-generators/some-generator**
**systemd.environment-generator**(7)

/usr/lib/systemd/user-generators/
**systemd.generator**(7)

/usr/lib/systemd/user-preset/*.preset
**systemd.preset**(5)

/usr/lib/systemd/user.conf.d/*.conf
**systemd-system.conf**(5)

/usr/lib/sysusers.d
**sysusers.d**(5)

/usr/lib/sysusers.d/*.conf
**sysusers.d**(5)

/usr/lib/sysusers.d/radvd.conf
**systemd-sysusers**(8)

/usr/lib/tmpfiles.d
**tmpfiles.d**(5)

/usr/lib/tmpfiles.d/*.conf
**tmpfiles.d**(5)

/usr/lib/tmpfiles.d/systemd.conf
**systemd-coredump**(8)

/usr/lib/udev
**udev**(7)

/usr/lib/udev/hwdb.bin
**hwdb**(7)

/usr/lib/udev/hwdb.d
**hwdb**(7)

/usr/lib/udev/rules.d
**udev**(7)

/usr/lib64/
**file-hierarchy**(7)

/usr/local/bin
**systemd.exec**(5),
**systemd.service**(5)

/usr/local/lib/machines/
**machinectl**(1)

/usr/local/lib/portables/
**portablectl**(1)

/usr/local/lib/systemd/system
**systemd**(1),
**systemd.unit**(5)

/usr/local/lib/systemd/system-environment-generators/
**systemd.environment-generator**(7)

/usr/local/lib/systemd/system-generators/
**systemd.generator**(7)

/usr/local/lib/systemd/user
**systemd.unit**(5)

/usr/local/lib/systemd/user-environment-generators/
**systemd.environment-generator**(7)

/usr/local/lib/systemd/user-generators/
**systemd.generator**(7)

/usr/local/sbin
**systemd.exec**(5)

/usr/sbin/
**file-hierarchy**(7),
**systemd.exec**(5)

/usr/sbin/foo-daemon
**systemd.service**(5)

/usr/sbin/halt.local
**systemd-rc-local-generator**(8)

/usr/share/
**file-hierarchy**(7)

/usr/share/dbus-1/system-services/org.example.simple-dbus-service.service
**systemd.service**(5)

/usr/share/doc/
**file-hierarchy**(7)

/usr/share/factory/
**file-hierarchy**(7),
**tmpfiles.d**(5)

/usr/share/factory/etc/
**file-hierarchy**(7)

/usr/share/factory/var/
**file-hierarchy**(7)

/usr/share/user-tmpfiles.d/*.conf
**tmpfiles.d**(5)

/usr/share/zoneinfo/
**localtime**(5)

/var/
**file-hierarchy**(7),
**journald.conf**(5),
**kernel-command-line**(7),
**systemctl**(1),
**systemd-fstab-generator**(8),
**systemd-journald.service**(8),
**systemd-nspawn**(1),
**systemd-update-done.service**(8),
**systemd-volatile-root.service**(8),
**systemd.exec**(5),
**systemd.generator**(7),
**systemd.offline-updates**(7),
**systemd.special**(7),
**systemd.unit**(5),
**tmpfiles.d**(5)

/var/.updated
**systemd-update-done.service**(8)

/var/cache/
**file-hierarchy**(7),
**systemd.exec**(5),
**systemd.unit**(5),
**tmpfiles.d**(5)

/var/cache/dnf/
**tmpfiles.d**(5)

/var/cache/krb5rcache/
**tmpfiles.d**(5)

/var/cache/private
**systemd.exec**(5)

/var/lib/
**file-hierarchy**(7),
**systemd.exec**(5),
**systemd.unit**(5),
**tmpfiles.d**(5)

/var/lib/container/
**machinectl**(1)

/var/lib/dbus/machine-id
**machine-id**(5)

/var/lib/machines/
**machinectl**(1),
**systemd-nspawn**(1),
**systemd.nspawn**(5),
**tmpfiles.d**(5)

/var/lib/portables/
**portablectl**(1)

/var/lib/private
**systemd.exec**(5)

/var/lib/systemd
**systemd.exec**(5)

/var/lib/systemd/backlight/
**systemd-backlight@.service**(8)

/var/lib/systemd/coredump/
**coredump.conf**(5),
**coredumpctl**(1),
**systemd-coredump**(8)

/var/lib/systemd/journal-upload/state
**systemd-journal-upload.service**(8)

/var/lib/systemd/random-seed
**systemd-random-seed.service**(8)

/var/lib/systemd/rfkill/
**systemd-rfkill.service**(8)

/var/lib/systemd/timesync/clock
**systemd-timesyncd.service**(8)

/var/lock
**systemctl**(1)

/var/log/
**file-hierarchy**(7),
**systemd.exec**(5),
**systemd.unit**(5),
**tmpfiles.d**(5)

/var/log/journal
**journalctl**(1),
**journald.conf**(5),
**sd\_journal\_open**(3),
**systemd-journald.service**(8),
**systemd-nspawn**(1)

/var/log/journal/remote/
**systemd-journal-remote.service**(8)

/var/log/journal/remote/remote-some.host.journal
**systemd-journal-remote.service**(8)

/var/log/private
**systemd.exec**(5)

/var/run/
**file-hierarchy**(7),
**systemctl**(1),
**tmpfiles.d**(5)

/var/spool/
**file-hierarchy**(7)

/var/tmp/
**file-hierarchy**(7),
**systemd-nspawn**(1),
**systemd.exec**(5),
**systemd.special**(7),
**systemd.unit**(5),
**sysusers.d**(5),
**tmpfiles.d**(5)

_ESP_/loader/entries/*.conf
**loader.conf**(5)

_ESP_/loader/loader.conf
**loader.conf**(5)

_automount_.automount
**systemd.automount**(5),
**systemd.unit**(5)

basic.target
**systemd.special**(7)

bluetooth.target
**systemd.special**(7)

boot-complete.target
**systemd.special**(7)

**bootctl**
**bootctl**(1)

**busctl**
**busctl**(1)

**coredumpctl**
**coredumpctl**(1)

cryptsetup-pre.target
**systemd.special**(7)

cryptsetup.target
**systemd.special**(7)

ctrl-alt-del.target
**systemd.special**(7)

dbus.service
**systemd.special**(7)

dbus.socket
**systemd.special**(7)

default.target
**systemd.special**(7)

_device_.device
**systemd.device**(5),
**systemd.unit**(5)

display-manager.service
**systemd.special**(7)

emergency.target
**systemd.special**(7)

exit.target
**systemd.special**(7)

final.target
**systemd.special**(7)

getty-pre.target
**systemd.special**(7)

getty.target
**systemd.special**(7)

graphical.target
**systemd.special**(7)

**halt**
**halt**(8)

halt.target
**systemd.special**(7)

hibernate.target
**systemd.special**(7)

**hostnamectl**
**hostnamectl**(1)

hybrid-sleep.target
**systemd.special**(7)

**init**
**systemd**(1)

init.scope
**systemd.special**(7)

initrd-fs.target
**systemd.special**(7)

initrd-root-device.target
**systemd.special**(7)

initrd-root-fs.target
**systemd.special**(7)

**journalctl**
**journalctl**(1)

kbrequest.target
**systemd.special**(7)

**kernel-install**
**kernel-install**(8)

kexec.target
**systemd.special**(7)

libnss_myhostname.so.2
**nss-myhostname**(8)

libnss_mymachines.so.2
**nss-mymachines**(8)

libnss_resolve.so.2
**nss-resolve**(8)

libnss_systemd.so.2
**nss-systemd**(8)

_link_.link
**systemd.link**(5)

local-fs-pre.target
**systemd.special**(7)

local-fs.target
**systemd.special**(7)

**localectl**
**localectl**(1)

**loginctl**
**loginctl**(1)

machine.slice
**systemd.special**(7)

**machinectl**
**machinectl**(1)

machines.target
**systemd.special**(7)

_mount_.mount
**systemd.exec**(5),
**systemd.kill**(5),
**systemd.mount**(5),
**systemd.resource-control**(5),
**systemd.unit**(5)

multi-user.target
**systemd.special**(7)

_netdev_.netdev
**systemd.netdev**(5)

_network_.network
**systemd.network**(5)

network-online.target
**systemd.special**(7)

network-pre.target
**systemd.special**(7)

network.target
**systemd.special**(7)

_network\_service_.dnssd
**systemd.dnssd**(5)

**networkctl**
**networkctl**(1)

nss-lookup.target
**systemd.special**(7)

nss-user-lookup.target
**systemd.special**(7)

pam_systemd.so
**pam\_systemd**(8)

_path_.path
**systemd.path**(5),
**systemd.unit**(5)

paths.target
**systemd.special**(7)

**pkg-config**
**libudev**(3),
**sd-bus**(3),
**sd-daemon**(3),
**sd-event**(3),
**sd-id128**(3),
**sd-journal**(3),
**sd-login**(3)

**portablectl**
**portablectl**(1)

**poweroff**
**halt**(8)

poweroff.target
**systemd.special**(7)

printer.target
**systemd.special**(7)

**reboot**
**halt**(8)

reboot.target
**systemd.special**(7)

remote-cryptsetup.target
**systemd.special**(7)

remote-fs-pre.target
**systemd.special**(7)

remote-fs.target
**systemd.special**(7)

rescue.target
**systemd.special**(7)

**resolvectl**
**resolvectl**(1)

rpcbind.target
**systemd.special**(7)

**runlevel**
**runlevel**(8)

runlevel2.target
**systemd.special**(7)

runlevel3.target
**systemd.special**(7)

runlevel4.target
**systemd.special**(7)

runlevel5.target
**systemd.special**(7)

_scope_.scope
**systemd.kill**(5),
**systemd.resource-control**(5),
**systemd.scope**(5),
**systemd.unit**(5)

_service_.service
**systemd.exec**(5),
**systemd.kill**(5),
**systemd.resource-control**(5),
**systemd.service**(5),
**systemd.unit**(5)

**shutdown**
**shutdown**(8)

shutdown.target
**systemd.special**(7)

sigpwr.target
**systemd.special**(7)

sleep.target
**systemd.special**(7)

_slice_.slice
**systemd.resource-control**(5),
**systemd.slice**(5),
**systemd.unit**(5)

slices.target
**systemd.special**(7)

smartcard.target
**systemd.special**(7)

_socket_.socket
**systemd.exec**(5),
**systemd.kill**(5),
**systemd.resource-control**(5),
**systemd.socket**(5),
**systemd.unit**(5)

sockets.target
**systemd.special**(7)

sound.target
**systemd.special**(7)

suspend-then-hibernate.target
**systemd.special**(7)

suspend.target
**systemd.special**(7)

_swap_.swap
**systemd.exec**(5),
**systemd.kill**(5),
**systemd.resource-control**(5),
**systemd.swap**(5),
**systemd.unit**(5)

swap.target
**systemd.special**(7)

sysinit.target
**systemd.special**(7)

syslog.socket
**systemd.special**(7)

system-update-cleanup.service
**systemd.special**(7)

system-update-pre.target
**systemd.special**(7)

system-update.target
**systemd.special**(7)

system.slice
**systemd.special**(7)

**systemctl**
**systemctl**(1)

**systemd-analyze**
**systemd-analyze**(1)

**systemd-ask-password**
**systemd-ask-password**(1)

systemd-ask-password-console.path
**systemd-ask-password-console.service**(8)

systemd-ask-password-console.service
**systemd-ask-password-console.service**(8)

systemd-ask-password-wall.path
**systemd-ask-password-console.service**(8)

systemd-ask-password-wall.service
**systemd-ask-password-console.service**(8)

systemd-backlight@.service
**systemd-backlight@.service**(8)

systemd-binfmt.service
**systemd-binfmt.service**(8)

systemd-bless-boot.service
**systemd-bless-boot.service**(8)

systemd-boot-check-no-failures.service
**systemd-boot-check-no-failures.service**(8)

**systemd-cat**
**systemd-cat**(1)

**systemd-cgls**
**systemd-cgls**(1)

**systemd-cgtop**
**systemd-cgtop**(1)

systemd-coredump.socket
**systemd-coredump**(8)

systemd-coredump@.service
**systemd-coredump**(8)

systemd-cryptsetup@.service
**systemd-cryptsetup@.service**(8)

**systemd-delta**
**systemd-delta**(1)

**systemd-detect-virt**
**systemd-detect-virt**(1)

**systemd-escape**
**systemd-escape**(1)

**systemd-firstboot**
**systemd-firstboot**(1)

systemd-firstboot.service
**systemd-firstboot**(1)

systemd-fsck-root.service
**systemd-fsck@.service**(8)

systemd-fsck@.service
**systemd-fsck@.service**(8)

systemd-growfs@_mountpoint_.service
**systemd-makefs@.service**(8)

systemd-halt.service
**systemd-halt.service**(8)

systemd-hibernate-resume@.service
**systemd-hibernate-resume@.service**(8)

systemd-hibernate.service
**systemd-suspend.service**(8)

systemd-hostnamed.service
**systemd-hostnamed.service**(8)

**systemd-hwdb**
**systemd-hwdb**(8)

systemd-hybrid-sleep.service
**systemd-suspend.service**(8)

**systemd-id128**
**systemd-id128**(1)

systemd-importd.service
**systemd-importd.service**(8)

**systemd-inhibit**
**systemd-inhibit**(1)

systemd-initctl.service
**systemd-initctl.service**(8)

systemd-initctl.socket
**systemd-initctl.service**(8)

systemd-journal-gatewayd.service
**systemd-journal-gatewayd.service**(8)

systemd-journal-gatewayd.socket
**systemd-journal-gatewayd.service**(8)

systemd-journal-remote.service
**systemd-journal-remote.service**(8)

systemd-journal-remote.socket
**systemd-journal-remote.service**(8)

systemd-journal-upload.service
**systemd-journal-upload.service**(8)

systemd-journald-audit.socket
**systemd-journald.service**(8)

systemd-journald-dev-log.socket
**systemd-journald.service**(8)

systemd-journald.service
**systemd-journald.service**(8)

systemd-journald.socket
**systemd-journald.service**(8)

systemd-kexec.service
**systemd-halt.service**(8)

systemd-localed.service
**systemd-localed.service**(8)

systemd-logind.service
**systemd-logind.service**(8)

systemd-machine-id-commit.service
**systemd-machine-id-commit.service**(8)

**systemd-machine-id-setup**
**systemd-machine-id-setup**(1)

systemd-machined.service
**systemd-machined.service**(8)

systemd-makefs@_device_.service
**systemd-makefs@.service**(8)

systemd-makeswap@_device_.service
**systemd-makefs@.service**(8)

systemd-modules-load.service
**systemd-modules-load.service**(8)

**systemd-mount**
**systemd-mount**(1)

systemd-networkd-wait-online.service
**systemd-networkd-wait-online.service**(8)

systemd-networkd.service
**systemd-networkd.service**(8)

**systemd-notify**
**systemd-notify**(1)

**systemd-nspawn**
**systemd-nspawn**(1)

**systemd-path**
**systemd-path**(1)

systemd-portabled.service
**systemd-portabled.service**(8)

systemd-poweroff.service
**systemd-halt.service**(8)

systemd-quotacheck.service
**systemd-quotacheck.service**(8)

systemd-random-seed.service
**systemd-random-seed.service**(8)

systemd-reboot.service
**systemd-halt.service**(8)

systemd-remount-fs.service
**systemd-remount-fs.service**(8)

systemd-resolved.service
**systemd-resolved.service**(8)

systemd-rfkill.service
**systemd-rfkill.service**(8)

systemd-rfkill.socket
**systemd-rfkill.service**(8)

**systemd-run**
**systemd-run**(1)

**systemd-socket-activate**
**systemd-socket-activate**(1)

**systemd-socket-proxyd**
**systemd-socket-proxyd**(8)

systemd-suspend-then-hibernate.service
**systemd-suspend.service**(8)

systemd-suspend.service
**systemd-suspend.service**(8)

systemd-sysctl.service
**systemd-sysctl.service**(8)

**systemd-sysusers**
**systemd-sysusers**(8)

systemd-sysusers.service
**systemd-sysusers**(8)

systemd-time-wait-sync.service
**systemd-time-wait-sync.service**(8)

systemd-timedated.service
**systemd-timedated.service**(8)

systemd-timesyncd.service
**systemd-timesyncd.service**(8)

**systemd-tmpfiles**
**systemd-tmpfiles**(8)

systemd-tmpfiles-clean.service
**systemd-tmpfiles**(8)

systemd-tmpfiles-clean.timer
**systemd-tmpfiles**(8)

systemd-tmpfiles-setup-dev.service
**systemd-tmpfiles**(8)

systemd-tmpfiles-setup.service
**systemd-tmpfiles**(8)

**systemd-tty-ask-password-agent**
**systemd-tty-ask-password-agent**(1)

systemd-udevd-control.socket
**systemd-udevd.service**(8)

systemd-udevd-kernel.socket
**systemd-udevd.service**(8)

systemd-udevd.service
**systemd-udevd.service**(8)

systemd-update-done.service
**systemd-update-done.service**(8)

systemd-update-utmp-runlevel.service
**systemd-update-utmp.service**(8)

systemd-update-utmp.service
**systemd-update-utmp.service**(8)

systemd-user-sessions.service
**systemd-user-sessions.service**(8)

systemd-vconsole-setup.service
**systemd-vconsole-setup.service**(8)

systemd-veritysetup@.service
**systemd-veritysetup@.service**(8)

systemd-volatile-root.service
**systemd-volatile-root.service**(8)

_target_.target
**systemd.target**(5),
**systemd.unit**(5)

**telinit**
**telinit**(8)

time-sync.target
**systemd.special**(7)

**timedatectl**
**timedatectl**(1)

_timer_.timer
**systemd.timer**(5),
**systemd.unit**(5)

timers.target
**systemd.special**(7)

**udevadm**
**udevadm**(8)

umount.target
**systemd.special**(7)

user-_UID_.slice
**user@.service**(5)

user-runtime-dir@_UID_.service
**user@.service**(5)

user.slice
**systemd.special**(7)

user@_UID_.service
**user@.service**(5)

~/.config/environment.d/*.conf
**environment.d**(5)

~/.config/systemd/user/
**systemd.unit**(5)

~/.config/systemd/user.control/
**systemd.unit**(5)

~/.config/user-tmpfiles.d/*.conf
**tmpfiles.d**(5)

~/.local/share/systemd/user/
**systemd.unit**(5)

~/.local/share/user-tmpfiles.d/*.conf
**tmpfiles.d**(5)

...
**systemd.unit**(5),
**tmpfiles.d**(5)

<a name="colophon"></a>

# Colophon


This index contains 2823 entries in 15 sections, referring to 289 individual manual pages.
