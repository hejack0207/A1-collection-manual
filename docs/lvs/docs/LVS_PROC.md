LVS PROC 参数

By  吴佳明_普空1 FULLNAT 相关

1.

/proc/sys/net/ipv4/vs/fullnat_timestamp_remove_entry    权限 0644，整型，默认 1

该接口是一个读写接口，控制”禁止 TCP timestamp option”功能是否打开

<table align="center">
</table>

2.

/proc/sys/net/ipv4/vs/ fullnat_mss_adjust_entry    权限 0644，整型，默认 1

该接口是一个读写接口，控制“调整 TCP mss option 大小”功能是否打开

<table align="center">
</table>

3.

/proc/sys/net/ipv4/vs/fullnat_conn_reused_entry    权限 0644，整型，默认 1

该接口是一个读写接口，控制“connection 复用”功能的是否打开

<table align="center">
</table>

4.

/proc/sys/net/ipv4/vs/ fullnat_toa_entry  权限 0644，整型，默认 1

该接口是一个读写接口，控制“在 TCP OPTION 中添加 client address”功能是否打开

<table align="center">
</table>

5.

/proc/sys/net/ipv4/vs/fullnat_lport_max    权限 0644，整型，默认 65535

该接口是一个读写接口，设置“local address 中 port 范围的最大值”

<table align="center">
</table>

6.

/proc/sys/net/ipv4/vs/ fullnat_lport_min    权限 0644，整型，默认 5000

该接口是一个读写接口，设置“local address 中 port 范围的最小值”

<table align="center">
</table>

7.

/proc/sys/net/ipv4/vs/ fullnat_lport_tries    权限 0644，整型，默认 10000

该接口是一个读写接口，设置“选择 local address”的最大尝试次数。

<table align="center">
</table>

8.

/proc/net/ip_vs_ext_stats    seq 类型

该接口是一个只读接口，用于获取 FULLNAT 运行状态

<table align="center">
</table>

<table align="center">
</table>

2 SYNPROXY 相关

9.

/proc/ sys/net/ipv4/vs/ synproxy_init_mss      权限 0644，整型，默认 1452

该接口是一个读写接口，表示 STEP1 中和 Client 协商时的初始 MSS

<table align="center">
</table>

10.  /proc/ sys/net/ipv4/vs/synproxy_ack_skb_store_thresh    权限 0644，整型，默认 3

该接口是一个读写接口，表示 client- lvs 已经完成 3 次握手，但 lvs-rs 间正在建立 3 次握手时，如果 client 有数据包过来，需要 buffer，本参数指定该 buffer 的长度，单位为 packet；

<table align="center">
</table>

11.  /proc/ sys/net/ipv4/vs/synproxy_syn_retry  权限 0644，整型，默认 3

该接口是一个读写接口，表示 step 3，lvs 发送 syn 包给 rs，如果丢包，重传的次数；

<table align="center">
</table>

<table align="center">
</table>

12.  /proc/ sys/net/ipv4/vs/synproxy_ack_storm_thresh    权限 0644，整型，默认 10

该接口是一个读写接口，表示 ack  storm 判断的条件（相同数据包重传个数），如果判定为ack storm，则丢弃所有该相同的数据包；

<table align="center">
</table>

13.  /proc/ sys/net/ipv4/vs/synproxy_synack_ttl    权限 0644，整型，默认 63

该接口是一个读写接口，表示 STEP1 中和 Client 协商时的初始 TTL

<table align="center">
</table>

14.  /proc/ sys/net/ipv4/vs/synproxy_conn_reuse，权限 0644，整型，默认 1

/proc/ sys/net/ipv4/vs/synproxy_conn_reuse_close，整型，默认 1

/proc/ sys/net/ipv4/vs/synproxy_conn_reuse_time_wait，整型，默认 1

/proc/ sys/net/ipv4/vs/synproxy_conn_reuse_fin_wait，整型，默认 0

/proc/ sys/net/ipv4/vs/synproxy_conn_reuse_close_wait，整型，默认 0

/proc/ sys/net/ipv4/vs/synproxy_conn_reuse_last_ack，整型，默认 0

该接口是一个读写接口，该数值表示是否复用 session，1 表示 true

<table align="center">
</table>

<table align="center">
</table>

15.  /proc/ sys/net/ipv4/vs/synproxy_defer 权限 0644，整型，默认 1

该接口是一个读写接口，该数值表示是否在 SYN-PROXY session 建立之前，是否丢弃空 ack包（等待 GET 请求到来时才建立 session），1 表示 true

<table align="center">
</table>

16.  /proc/ sys/net/ipv4/vs/synproxy_sack 权限 0644，整型，默认 1

该接口是一个读写接口，该数值表示是否提供 sack 支持，1 表示 true

<table align="center">
</table>

17.  /proc/ sys/net/ipv4/vs/synproxy_wscale 权限 0644，整型，默认 1

该数值表示是否支持 wscale，1 表示 true

<table align="center">
</table>

18.  /proc/net/ip_vs_ext_stats    权限 0644，seq 类型

该接口是一个只读接口，用于获取 SYNPROXY 运行状态

<table align="center">
</table>

<table align="center">
</table>

3 DEFENCE 相关

19.  /proc/sys/net/ipv4/vs/defence_tcp_drop    权限 0644，整型，默认 1

该接口是一个读写接口，控制”丢弃 VIP+！VPORT 的 TCP 数据包”功能是否打开

<table align="center">
</table>

20.  /proc/sys/net/ipv4/vs/defence_udp_drop    权限 0644，整型，默认 1

该接口是一个读写接口，控制”丢弃 VIP UDP 包”功能是否打开

<table align="center">
</table>

21.  /proc/sys/net/ipv4/vs/defence_frag_drop    权限 0644，整型，默认 1

该接口是一个读写接口，控制”丢弃所有 IP 分片包（ospf 除外）”功能是否打开

<table align="center">
</table>

22.  /proc/net/ip_vs_ext_stats    权限 0644，seq 类型

该接口是一个只读接口，用于获取 DEFNECE 运行状态

<table align="center">
</table>

4 session 超时相关

23.  /proc/sys/net/ipv4/vs/tcp_timeout_established    权限 0644，整型，默认值为：900000ms

该接口是一个读写接口，表示 session 处于 IP_VS_TCP_S_ESTABLISHED 状态的超时

时间：

<table align="center">
</table>

24.  /proc/sys/net/ipv4/vs/ tcp_timeout_syn_sent    权限 0644，整型，默认值为：120000ms

该接口是一个读写接口，表示 session 处于 IP_VS_TCP_S_SYN_SENT 状态的超时时间：<table align="center">
</table>

<table align="center">
</table>

25.  /proc/sys/net/ipv4/vs/ tcp_timeout_syn_recv    权限 0644，整型，默认值为：60000ms

该接口是一个读写接口，表示 session 处于 IP_VS_TCP_S_SYN_RECV 状态的超时时间：<table align="center">
</table>

26.  /proc/sys/net/ipv4/vs/ tcp_timeout_fin_wait    权限 0644，整型，默认值为：120000ms

该接口是一个读写接口，表示 session 处于 IP_VS_TCP_S_FIN_WAIT 状态的超时时间：<table align="center">
</table>

27.  /proc/sys/net/ipv4/vs/ tcp_timeout_time_wait    权限 0644，整型，默认值为：120000ms

该接口是一个读写接口，表示 session 处于 IP_VS_TCP_S_TIME_WAIT 状态的超时时间：<table align="center">
</table>

28.  /proc/sys/net/ipv4/vs/ tcp_timeout_close    权限 0644，整型，默认值为：10000ms

该接口是一个读写接口，表示 session 处于 IP_VS_TCP_S_CLOSE 状态的超时时间：

<table align="center">
</table>

29.  /proc/sys/net/ipv4/vs/ tcp_timeout_close_wait    权限 0644，整型，默认值为：60000ms

该接口是一个读写接口，表示 session 处于 IP_VS_TCP_S_CLOSE_WAIT 状态的超时时间：

<table align="center">
</table>

30.  /proc/sys/net/ipv4/vs/ tcp_timeout_last_ack    权限 0644，整型，默认值为：30000ms

该接口是一个读写接口，表示 session 处于 IP_VS_TCP_S_LAST_ACK 状态的超时时间：<table align="center">
</table>

31.  /proc/sys/net/ipv4/vs/ tcp_timeout_listen    权限 0644，整型，默认值为：120000ms

该接口是一个读写接口，表示 session 处于 IP_VS_TCP_S_LISTEN 状态的超时时间：<table align="center">
</table>

<table align="center">
</table>

32.  /proc/sys/net/ipv4/vs/ tcp_timeout_synack    权限 0644，整型，默认值为：120000ms

该接口是一个读写接口，表示 session 处于 IP_VS_TCP_S_SYNACK 状态的超时时间：<table align="center">
</table>

4 LVS 原有

33.  /proc/net/ip_vs

Virtual server 和 realserver 的信息，同 ipvsadm –ln;

34.  /proc/net/ip_vs_stats

整个 LVS 上 total conn/packet/bytes  和 cps/pps/bps 的信息；

