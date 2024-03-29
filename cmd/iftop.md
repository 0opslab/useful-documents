# title{iftop - 主要用来显示本机网络流量情及各相互通信的流量集合 }
Linux/unix系统中可以使用top命令来查看系统资源，进程，内存等信信息。查看网络状态可以使用
netstat,nmap等工具，若要查看实时的网络流量，监控TCP/IP链接等，则可以使用iftop工具。
iftop主要用来显示本机网络流量情及各相互通信的流量集合，非常时候在小型网络中做代理服务器
和iptables服务器使用。iftop可以用来监控网卡的实时流浪（可以制定网段） 反向解析ip，显示
端口信息等。官方网站：http://www.ex-parrot.com/~pdw/iftop/
# 安装
如果采用源码包的安装方式，在安装前需要一些环境比如要案子libpcap和ibcurses
	或者直接使用yum或apt-get安装
	#yum install iftop
	#apt-get install iftop
如果安装iftop时没有自定义路径，那么直接运行iftop就可以查看流量统计了，例如：iftop或者iftop -i eth0 -n
![linux-iftop](image/linux/linux-iftop.png)
相关说明
## iftop界面相关说明
界面上面显示的是类似刻度尺的刻度范围，为显示流量图形的长条作标尺用的。中间的<= =>这两个左右箭头，
表示的是流量的方向。
	TX：发送流量
	RX：接收流量
	TOTAL：总流量
	Cumm：运行iftop到目前时间的总流量
	peak：流量峰值
	rates：分别表示过去 2s 10s 40s 的平均流量
## iftop相关参数
	常用的参数
-i设定监测的网卡，如：# iftop -i eth1
-B 以bytes为单位显示流量(默认是bits)，如：# iftop -B
-n使host信息默认直接都显示IP，如：# iftop -n
-N使端口信息默认直接都显示端口号，如: # iftop -N
-F显示特定网段的进出流量，如# iftop -F 10.10.1.0/24或# iftop -F 10.10.1.0/255.255.255.0
-h（display this message），帮助，显示参数信息
-p使用这个参数后，中间的列表显示的本地主机信息，出现了本机以外的IP信息;
-b使流量图形条默认就显示;
-f这个暂时还不太会用，过滤计算包用的;
-P使host信息及端口信息默认就都显示;
-m设置界面最上边的刻度的最大值，刻度分五个大段显示，例：# iftop -m 100M
## 操作命令
进入iftop画面后的一些操作命令(注意大小写)
	按h切换是否显示帮助;
	按n切换显示本机的IP或主机名;
	按s切换是否显示本机的host信息;
	按d切换是否显示远端目标主机的host信息;
	按t切换显示格式为2行/1行/只显示发送流量/只显示接收流量;
	按N切换显示端口号或端口服务名称;
	按S切换是否显示本机的端口信息;
	按D切换是否显示远端目标主机的端口信息;
	按p切换是否显示端口信息;
	按P切换暂停/继续显示;
	按b切换是否显示平均流量图形条;
	按B切换计算2秒或10秒或40秒内的平均流量;
	按T切换是否显示每个连接的总流量;
	按l打开屏幕过滤功能，输入要过滤的字符，比如ip,按回车后，屏幕就只显示这个IP相关的流量信息;
	按L切换显示画面上边的刻度;刻度不同，流量图形条会有变化;
	按j或按k可以向上或向下滚动屏幕显示的连接记录;
	按1或2或3可以根据右侧显示的三列流量数据进行排序;
	按<根据左边的本机名或IP排序;
	按>根据远端目标主机的主机名或IP排序;
	按o切换是否固定只显示当前的连接;
	按f可以编辑过滤代码，这是翻译过来的说法，我还没用过这个！
	按!可以使用Shell命令，这个没用过！没搞明白啥命令在这好用呢！
