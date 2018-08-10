
# ========================
# expect 安装
# ========================

#查看/usr/bin/下是否有expect，如果没有，要安装expect,linux expect的安装

# 1.安装相应的包
# -------------
#yum install -y tcl tclx tcl-devel

# 2.下载expect-5.45.xx.tar.gz包，编译安装。（文件在：我的工具包和我的网盘）
# -------------
#tar -zxvf expect-5.45.xx.tar.gz
#cd expect-5.45.xx
#./configure --with-tcl=/usr/lib --with-tclinclude=/usr/include/tcl-private/generic
#make && make install

#如果共享库文件安装到了/lib或/usr/lib目录下, 那么需执行一下ldconfig命令
#ldconfig



#常见问题注意：
# -------------
#1 需要sh脚本头部加上 #!/usr/bin/expect

#2 如果报tmux: error while loading shared libraries: libevent-1.4.so.2: cannot open shared object file: No such file or directory
#如果共享库文件安装到了/lib或/usr/lib目录下
#如果/lib或/usr/lib目录下有xx.so，还报错：那么需执行一下ldconfig命令
#具体参考：https://www.cnblogs.com/SZxiaochun/p/7685499.html



# ========================
# 脚本示例：
# ========================

#!/usr/bin/expect
# 指定shebang

# /usr/bin/expect模式下，
# 变量的定义需用 (set 变量名 变量值) 的方值；直接用 (变量名=变量名) 的方式报错
set user qianm
set host 10.211.55.5
set password 123456

set timeout 3
spawn ssh $user@$host
expect {
        "(yes/no)?" {
                send "yes\n"

                expect "*assword:*"
                send "$password\n"
        }
        "assword:" {
                send "$password\n"

        } timeout {
                exit
        } eof{
                exit
        }
}

expect "Last login:*"
send "sudo -s\r"
expect "*password*"
send "$password\n"

#帮我切换到常用的工作目录
expect "#"
send "cd /data/log\n"

#允许用户与命令行交互
interact


更多例子，见：
https://www.cnblogs.com/jason2013/articles/4356352.html
https://blog.csdn.net/augusdi/article/details/45692391



