#
# 用户通过shell和内核沟通
# shell命令分 内部和外部，可以通过type命令查看
# 内部可以直接在内核上找到并执行，外部需要shell解释器进行转译s


# tar
# ==============
# 压缩 tar -zcvf 生成的压缩包路径与文件名 要压缩的目录或文件
# tar -zcvf /xxx/xx.tar.gz /xxx/xx
# tar -g /xxx/xxxsnapshot -zcvf /xxx/xx.tar.gz /xxx/xx
# 上面的-g是指定一个快照，这个只有首次执行该命令时是全部备份，以后执行时都是增量备份
# 增量备份：要保证快照路径与名字不变，如果变了还是全部备份。但增量生成的压缩文件名字要变，不然会被覆盖
#
# 解压 tar -zxvf 要解压的文件 -C 要解压到哪里去（注：也可以不指定-C，这样解压在当前目录下）
# tar -zxvf xxx.tar.gz -C /xxx/xxx


# tree
# ==============
# 如果命令不存在，yum -y insall tree
# tree -L 1 /


# |xargs 与 -exec 的区别
# ==============
# |xargs 积攒到一起，然后一起执行
# -exec 逐条匹配，逐条执行 


# rsync 同步
# ==============
# 如果命令不存在，yum -y insall rsync
# 





# ==============
# shell 四剑客
# ==============

# find 命令
# ==============
# 作用：
# 用于查找文件/目录，然后可以对整体进行相关操作（删除、复制等等）
# find 查找路径 参数 值
# 参数：
# -name 文件名
# -type 文件类型
# -size 文件大小
# -atime -mtime -ctime 修改时间 （-1 是最近一天以内的；+1 一天以前的）
# -access 访问时间
# -modify 内容被修改的修改时间
# -change 权限被修改的修改时间
# ---------
# 例子：
# find /tmp -name "test.txt" // 查找文件名为test.txt的
# find /tmp -name "*.txt"   // 查找文件名以.txt结尾的
# find /tmp -name "*.txt" -type f // 仅查找文件名以.txt结尾的文件，不含目录
# find /tmp -name "*.txt" -type d // 仅查找文件名以.txt结尾的目录，不含普通文件
# find /tmp -mtime -1 // 查找最近一天以内有修改的文件
# find /tmp -name "*.txt" -mtime -1 |xargs rm -rf {} \; // 查找最近一天以内有修改的文件，并删除掉
# find /tmp -name "*.txt" -mtime -1 -exec rm -rf {} \; // 查找最近一天以内有修改的文件，并删除掉，同上面的作用一样


# grep 命令
# ==============
# 作用：
# 用于查找文本内容，过滤、去重等等
# 参数：
# -v 取反(排除匹配出的元素)
# -c 计算找到的符合行的次数
# --color 匹配的元素高亮显示
# -n 显示匹配元素所在的行号
# -i 忽略大小写
# -E 允许使用扩展模式匹配 （grep -E == egrep）
# 例：
# grep root /etc/passwd
# cat /etc/passwd | grep root
# grep -i -n --color "^root" /etc/passwd	// 以root开头的，且root不区分大小写
# grep -n --color "/sbin/nologin$" /etc/passwd  // 以/sbin/nologin结尾的
#
# grep "^(s|S)" /proc/meminfo  // 显示/proc/meminfo文件中以s开头的行，且s不区分大小写
# grep -i "^s" /proc/meminfo  // 作用同上
#
# grep -v "^;" /etc/php.ini |grep -v "^$"  // 过滤掉字某文件内容中的注释和空行
#
# grep "[0-9]\{1\}" ip.txt  
# grep -E "[0-9]{1}" ip.txt // 同上面的命令做对比，发现加上-E后，后面的正则不用加转义符，这就是-E的作用
# egrep "[0-9]{1}" ip.txt // 同上面的一样（grep -E == egrep）
#
# grep -E "([0-9]{1,3}\.){3}[0-9]{1,3}$" ip.txt 
# 


# awk 命令 
# ==============
# awk '{pattern + action}' {filenames}
# 作用：
# 在文件或字符串中，基于指定的规则浏览和抽取信息，抽取信息后才能进行文本操作
# 参数：
# -F 以什么字符来拆分
# awk内置变量：
# $0 当前记录
# $1~$n 当前记录的第n个字段
# FS 输入字段分隔符，默认是空格
# RS 输入记录分割符，默认是换行符
# NF 当前记录中的字段个数，就是有多少列
# NR 已经读出的记录数，就是行号，从1开始
# OFS 输出字段分隔符，默认也是空格
# ORS 输出的记录分隔符，默认为换行符
# 
# 例：
# awk -F ":" '{print $1}' /etc/passwd
# awk -F ":" '{print $1" "$3}' /etc/passwd
# awk -F ":" '{print "username:"$1" uid:"$3}' /etc/passwd
# awk -F ":" '{if (NR>=10&&NR<=20) print $1}' /etc/passwd	// 查找10-20行的内容
# awk -F ":" '{if (NR>=10&&NR<=20) print NR" "$1}' /etc/passwd
#


# sed 命令 
# ==============
# 
# 作用：主要用于内内替换
# 参数：
# -i 替换后写入原文件
#
# 例子：
# sed 's/www.baidu.com/www.tpl.cn/' domain.txt
# sed 's/www.baidu.com/www.tpl.cn/' domain.txt
# sed 's/www.baidu.com/www.tpl.cn/g' domain.txt
# sed -i 's/www.baidu.com/www.tpl.cn/g' domain.txt
# sed 's#www.baidu.com#www.tpl.cn#' domain.txt  // 可以用#代替/


































