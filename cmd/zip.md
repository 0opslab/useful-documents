# title{zip - 用于压缩文件}

### 选项
```bash
-A 调整可执行的自动解压缩文件。
-b<工作目录> 指定暂时存放文件的目录。
-c 替每个被压缩的文件加上注释。
-d 从压缩文件内删除指定的文件。
-D 压缩文件内不建立目录名称。
-f 此参数的效果和指定”-u”参数类似，但不仅更新既有文件，如果某些文件原本不存在于压缩文件内，使用本参数会一并将其加入压缩文件中。
-F 尝试修复已损坏的压缩文件。
-g 将文件压缩后附加在既有的压缩文件之后，而非另行建立新的压缩文件。
-h 在线帮助。
-i<范本样式> 只压缩符合条件的文件。
-j 只保存文件名称及其内容，而不存放任何目录名称。
-J 删除压缩文件前面不必要的数据。
-k 使用MS-DOS兼容格式的文件名称。
-l 压缩文件时，把LF字符置换成LF+CR字符。
-ll 压缩文件时，把LF+CR字符置换成LF字符。
-L 显示版权信息。
-m 将文件压缩并加入压缩文件后，删除原始文件，即把文件移到压缩文件中。
-n<字尾字符串> 不压缩具有特定字尾字符串的文件。
-o 以压缩文件内拥有最新更改时间的文件为准，将压缩文件的更改时间设成和该文件相同。
-q 不显示指令执行过程。
-r 递归处理，将指定目录下的所有文件和子目录一并处理。
-S 包含系统和隐藏文件。
-t<日期时间> 把压缩文件的日期设成指定的日期。
-T 检查备份文件内的每个文件是否正确无误。
-u 更换较新的文件到压缩文件内。
-v 显示指令执行过程或显示版本信息。
-V 保存VMS操作系统的文件属性。
-w 在文件名称里假如版本编号，本参数仅在VMS操作系统下有效。
-x<范本样式> 压缩时排除符合条件的文件。
-X 不保存额外的文件属性。
-y 直接保存符号连接，而非该连接所指向的文件，本参数仅在UNIX之类的系统下有效。
-z 替压缩文件加上注释。
-$ 保存第一个被压缩文件所在磁盘的卷册名称。
-<压缩效率> 压缩效率是一个介于1-9的数值。
```

### 常用命令
```bash
# Create zip file
#创建zip文件
zip archive.zip file1 directory/

# Create zip file with password
#使用密码创建zip文件
zip -P password archive.zip file1

# To list, test and extract zip archives, see unzip
#要列出，测试和提取zip存档，请参阅解压缩
cheat unzip
```

```bash
# Extract archive
#提取存档
unzip archive.zip

# Test integrity of archive
#测试存档的完整性
unzip -tq archive.zip

# List files and directories in a file
#列出文件中的文件和目录
unzip -l archive.zip
```