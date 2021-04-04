ipvsadm 使用手册

By  燕飞  (陈子昂)1.  在 LVS 上新增 Service

命令：

ipvsadm –A –t <VIP>:<Port> -s <schedule: rr|wrr|lc|wlc|lblc|lblcr|dh|sh|sed|nq>

实例:

在 LVS 中为 http 协议添加一个 VIP 为 1.1.1.1 的 service,  并设置调度方式为 Round Robin

ipvsadm –A –t 1.1.1.1:80 –s rr

2.  新增 Real Server

命令：

ipvsadm –a –t <VIP>:<Port> -r <VIP>:<Port> <Forward Mode: -b | -m | -g | -i >

实例:

以 FullNAT 方式为 VIP1.1.1.1 的 LVS 新增 Real IP 为 192.168.1.2 的 Real Server：

ipvsadm –a –t 1.1.1.1:80 –r 192.168.1.2:80 -b

以 NAT 方式为 VIP1.1.1.1 的 LVS 新增 Real IP 为 192.168.1.2 的 Real Server：

ipvsadm –a –t 1.1.1.1:80 –r 192.168.1.2:80 -m

以 DR 方式为 VIP1.1.1.1 的 LVS 新增 Real IP 为 192.168.1.2 的 Real Server：

ipvsadm –a –t 1.1.1.1:80 –r 192.168.1.2:80 -g

以 Tunnel 方式为 VIP1.1.1.1 的 LVS 新增 Real IP 为 192.168.1.2 的 Real Server：

ipvsadm –a –t 1.1.1.1:80 –r 192.168.1.2:80 -i

3.  新增 Local Address

命令：

ipvsadm –P –t <IP>:<PORT> –z <Local Address>

实例:

为 VIP 为 1.1.1.1 的 LVS 添加一个 IP 为  192.168.1.2  的 Local Address

ipvsadm –P –t 1.1.1.1:80 -z 192.168.1.2

4.  查看 Local Address

命令：

ipvsadm –G –t <VIP>:<PORT>

ipvsadm –G

实例:

查看所有的 VIP 对应的 Local Address

ipvsadm –G

查看所有的 VIP 为 1.1.1.1 的 LVS 对应的 Local Address

ipvsadm –G –t 1.1.1.1:80

5.  删除 Local Address

命令：

ipvsadm –Q –t <VIP>:<PORT> –z <Local Address>

实例:

删除 VIP 为 1.1.1.1 的 LVS 对应的 IP 为 192.168.1.2 的 Local Address

ipvsadm –Q –t 1.1.1.1:80 –z 192.168.1.2

6.  在 LVS 上修改存在的 Service

命令：

ipvsadm  –E  –t  <VIP>:<Port>  -s  <  schedule:  rr|wrr|lc|wlc|lblc|lblcr|dh|sh|sed|nq>  -j  <  syn:disable| enable> -p <Time Out> -M <Netmask>

实例:

修改 VIP 为 1.1.1.1 的 LVS 中  http 服务的调度算法为 Round Robin

ipvsadm –E –t 1.1.1.1:80 –s rr

修改 VIP 为 1.1.1.2 的  FTP 服务的 Time Out 时间为 60s,  并且打开 synproxy.

ipvsadm –E –t 1.1.1.2:21 –p 60 –j enable

注意:  命令-E 的选项支持全部指明或者部分指明。

7.  查看所有的 LVS 以及对应的 Real Server

命令：

ipvsadm –l

实例:

查看 LVS 以及对应的 Real Server

ipvsadm –l

查看 LVS 以及对应的 Real Server (不解析 IP 和 PORT)

ipvsadm -ln

8.  在 LVS 上删除一个 Service

命令：

ipvsadm –D –t <VIP>:<PORT>

实例:

删除 VIP 为 1.1.1.1 的 Service

ipvsadm -D -t 1.1.1.1:80

9.  在 LVS 上删除一个 Real Server

命令：

ipvsadm -d -t <VIP>:<PORT> -r <RIP>:<PORT>

实例:

删除 VIP 为 1.1.1.1 对应的 Real Server 192.168.1.1

ipvsadm -d -t 1.1.1.2:80 -r 192.168.1.1:80

命令：

ipvsadm –C

实例:

ipvsadm –C

10.  在 LVS 上清空所有的 Service 以及所有的 Real Server

