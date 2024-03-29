# title{ldconfig - 动态链接库管理命令}

ldconfig命令 的用途主要是在默认搜寻目录/lib和/usr/lib以及动态库配置文件/etc/ld.so.conf内所列的目录下，
搜索出可共享的动态链接库（格式如lib.so）,进而创建出动态装入程序(ld.so)所需的连接和缓存文件。缓存文件默
认为/etc/ld.so.cache，此文件保存已排好序的动态链接库名字列表，为了让动态链接库为系统所共享，需运行动态
链接库的管理命令ldconfig，此执行程序存放在/sbin目录下。

```bash
-v或--verbose：用此选项时，ldconfig将显示正在扫描的目录及搜索到的动态链接库，还有它所创建的连接的名字。
-n：用此选项时,ldconfig仅扫描命令行指定的目录，不扫描默认目录（/lib、/usr/lib），也不扫描配置文件/etc/ld.so.conf所列的目录。
-N：此选项指示ldconfig不重建缓存文件（/etc/ld.so.cache），若未用-X选项，ldconfig照常更新文件的连接。
-X：此选项指示ldconfig不更新文件的连接，若未用-N选项，则缓存文件正常更新。
-f CONF：此选项指定动态链接库的配置文件为CONF，系统默认为/etc/ld.so.conf。
-C CACHE：此选项指定生成的缓存文件为CACHE，系统默认的是/etc/ld.so.cache，此文件存放已排好序的可共享的动态链接库的列表。
-r ROOT：此选项改变应用程序的根目录为ROOT（是调用chroot函数实现的）。选择此项时，系统默认的配置文件/etc/ld.so.conf，
实际对应的为ROOT/etc/ld.so.conf。如用-r /usr/zzz时，打开配置文件/etc/ld.so.conf时，实际打开的是/usr/zzz/etc/ld.so.conf文件。
用此选项，可以大大增加动态链接库管理的灵活性。
-l：通常情况下,ldconfig搜索动态链接库时将自动建立动态链接库的连接，选择此项时，将进入专家模式，需要手工设置连接，一般用户不用此项。
-p或--print-cache：此选项指示ldconfig打印出当前缓存文件所保存的所有共享库的名字。
-c FORMAT 或 --format=FORMAT：此选项用于指定缓存文件所使用的格式，共有三种：old(老格式)，
  new(新格式)和compat（兼容格式，此为默认格式）。
-V：此选项打印出ldconfig的版本信息，而后退出。
-? 或 --help 或 --usage：这三个选项作用相同，都是让ldconfig打印出其帮助信息，而后退出。
```