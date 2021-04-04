Keepalived 使用手册

莫凡(陈家军)###   基本操作

1.  系统服务方式

2.  通过命令行

A.  常用参数

启动：service keepalived start

停止：service keepalived stop

重启：service keepalived restart

更新：service keepalived reload

注：

使用默认配置文件“/etc/keepalived/keepalived.conf”。

更改配置文件后，推荐使用“reload”重新加载配置文件  ，该操作对服务影响较小。

“restart”相当于“stop”后再“start”。

keepalived 常用的参数如下：

-P        Only run with VRRP subsystem.

-C        Only run with Health-checker subsystem.

-V        Dont remove VRRP VIPs & VROUTEs on daemon stop.

-I        Dont remove IPVS topology on daemon stop.

-f        Use the specified configuration file.    Default is /etc/keepalived/keepalived.conf.

例如，使用指定的配置文件。

keepalived    -d    -f    ~/my_keepalived.conf

B.  stop、reload

停止和重载都是通过发信号告诉 keepalived 的。

停止：kill -TERM    <keepalived  主进程 pid>

重载：kill -HUP    <keepalived  主进程 pid>

注：

不推荐使用“killall keepalived”和“kill -9  ”等来杀掉 keepalived，因为这样 keepalived不会做相应的 lvs 内核清理操作。

###   配置

keepalived 默认的配置文件为/etc/keepalived/keepalived.conf。  例如：

gl obal _defs  {

...

}

…

}

…

}

…

vi rtual_server_group taobao {

1.1.1.1 80    #vi p1

1.1.2.1-2 80    #vi p2,vip3

local _address_group laddr_g1 {

192.168.100.1

192.168.100.5-254      #支持 i p 范围，注不要超过 254

vi rtual_server group taobao {

dela y_loop 7

lb_algo rr

lb_kind FNAT

protocol  TCP

s yn_proxy

persistence_ti meout 50        #默认为 0

laddr_group_na me laddr_g1

alpha               #开启 alpha 模式：启动时默认 rs 是 down 的状态，健康检查通过后才会添加到 vs  pool

omega             #开启 omega 模式，清除 rs 时会执行相应的脚本（rs 的 noti fy_up，quorum_up）

quorum 1        #服务是否有效的阀值（正常工作 rs 的 wi ght 值）

hys teresis 0      #延迟系数跟 quorum 配合使用

#高于或低于阀值时会执行以下脚本。

quorum_up " ip addr add 1.1.1.1/32 dev lo; ip addr add 1.1.2.1/32 dev lo; ip addr add 1.1.2.2/32 dev lo;"

quorum_down " ip addr del  1.1.1.1/32 dev lo; ip addr del  1.1.2.1/32 dev lo; ip addr del  1.1.2.2/32 dev lo;"

real_server 192.168.100.1 80 {

wei ght 1

inhibi t_on_failure

TCP_CHECK {

connect_timeout 4

}

}

1.  synproxy 和 fullnat（local address）配置

如红色字体所示。其他配置跟官方一致。

A.

B.

C.

syn_proxy 的配置在文件中写上，为打开 syn_proxy。在配置文件中不写，则关闭 syn_proxyFULLNAT 模式的配置方式跟 NAT、DR 和 TUN 类似，在配置文件 lb_kind 字段后写上 FNAT。

Local address 在 fullnat 模式下配置才有效，否则会被忽略。Local address 的 group name是字符串。local_address_group 跟 virtual_server_group 类似，配置放在 global_defs 外面，支持 ip 范围配置方式。

D.  目前在 fullnat 模式下暂不支持 fwmark。

2.  quorum、hysteresis

“可用 rs 的权值总和”  大于等于  “quorum+ hysteresis”认为服务有效（up）；“可用 rs 的权值总和”  小于  “quorum - hysteresis”整个集群不可用（down）。

配置文件支持 include，需注意语义的完整，不要挎“{”或“}”。正确的配置，如下所示

#/etc/keepali ved/keepali ved.conf

……

}

…

…

…

…

}

}

3.  include 配置文件

include /etc/keepali ved/test/laddr.conf

vi rtual_server 192.168.1.1 80 {

include /etc/keepali ved/test/rs .conf

#/etc/keepali ved/test/laddr.conf

local _address_group laddr_g1 {

192.168.100.1

192.168.100.5-254

#/etc/keepali ved/test/rs .conf

real_server 192.168.1.1 80 {

wei ght 1

TCP_CHECK {

connect_timeout 4

}

}

###   注意事项

1.  更新配置文件后，可通过 reload 更新，很多情况下 reload 只会加载不同之处（如增删2.

rs/local address），不会重启 keepalived，不会清除 vs，即不影响当前 LVS 运行配置；

vs 的 vip:port、fwmark、vs group name、lb_algo、lb_kind、persistence_timeout、protocol、persistence_granularity、nat_mask、syn_proxy 和 laddr_group_name 字段更改时，reload会先清除 vs，再重新加载 vs，即会影响当前 LVS 运行配置；

