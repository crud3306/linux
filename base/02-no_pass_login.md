
免密登录概述
===========
Public Key认证的主要魅力在于认证时承诺不必提供密码就能够同远程系统建立连接。

Public Key认证的基础在于一对密钥，public key和private key，public key对数据进行加密而且只能用于加密，private key 只能对所匹配的public key加密过的数据进行解密。

我们把public key放在远程系统合适的位置，然后从本地开始进行ssh连接。
此时，远程的sshd会产生一个随机数并用我们产生的public key进行加密后发给本地，本地会用private key进行解密并把这个随机数发回给远程系统。
最后，远程系统的sshd会得出结论我们拥有匹配的private key允许我们登录。



一、serverA 免密登录 serverB 原理
===========
配置过程
- 首先在 serverA 上生成一对秘钥（ssh-keygen）
- 将公钥拷贝到 serverB，重命名 authorized_keys

登录原理
- serverA 向 serverB 发送一个连接请求，信息包括用户名、ip
- serverB 接到请求，会从 authorized_keys 中查找，是否有相同的用户名、ip，如果有 serverB 会随机生成一个字符串
- 然后使用使用公钥进行加密，再发送到 serverA
- serverA 接到 serverB 发来的信息后，会使用私钥进行解密，然后将解密后的字符串发送给 serverB
- serverB 接到 serverA 发来的信息后，会成先前生成的字符串进行比对，如果相同，则允许免密登录。至止免密登录成功。



Centos7 默认安装了 ssh服务

二、启动 ssh 服务
===========
```sh
# 查看 ssh 状态
systemctl status sshd
# 启动 ssh
systemctl start sshd
# 停止 ssh
systemctl stop sshd
```



三、配置免密
===========
假设：需要serverA免密登录serverB

1、serverA 生成秘钥，遇到提示直接敲回车即可
-----------
CentOS7 默认使用RSA加密算法生成密钥对，保存在家目录中的.ssh目录下的id_rsa（私钥）和id_rsa.pub（公钥）。也可以使用“-t DSA”参数指定为DSA算法，对应文件为id_dsa和id_dsa.pub，密钥对生成过程会提示输入私钥加密密码，可以直接回车不使用密码保护。
```sh
ssh-keygen

#或者如下，不传-t，则默认即为RSA
#ssh-keygen -t RSA

ll ~/.ssh/
```


2、移动 id_rsa.pub 文件到 被登录的目标机 serverB
-----------
方法一
```sh
#查看生成的公钥内容
cat ~/.ssh/id_rsa.pub

#手动把公钥内容，拷贝粘贴到ServerB的authorized_keys文件中，里面可放多个公钥，把我们的公钥放在最后即可
vim ~/.ssh/authorized_keys
```

方法二
```sh
# 将 serverA ~/.ssh目录中的 id_rsa.pub 这个文件拷贝到你要登录的 serverB 的~目录中 
scp ~/.ssh/id_rsa.pub serverB地址:~/
#scp ~/.ssh/id_rsa.pub 用户名@serverB地址:~/

# 然后在 serverB 运行以下命令来将公钥导入到~/.ssh/authorized_keys这个文件中 
cat ~/id_rsa.pub >> ~/.ssh/authorized_keys 

# 另外要注意请务必要将服务器上 
#~/.ssh 权限设置为700 
#~/.ssh/authorized_keys 的权限设置为600 
#这是linux的安全要求，如果权限不对，自动登录将不会生效
```

方法三
```sh
# 用追加的方式
ssh-copy-id -i ~/.ssh/id_rsa.pub serverB地址

# 用覆盖的方式
# scp -r ~/.ssh/id_rsa.pub 用户名@serverB地址:~/.ssh/authorized_keys
```


3、在serverA验证免密登录
-----------
```sh
ssh 用户名@serverB地址

#也可不写用户名，这时会用当前登录用户
ssh serverB地址

#或者直接测试在远程机器上执行命令
ssh -l root 192.168.xx.xx 'df -h'
```


无法登陆原因分析
-----------
- 请检查文件和目录权限是否正确，我就遇到了一台服务器之前谁把root下的 .ssh 文件夹给了mysql用户和用户组不知道是什么操作，很无语..
- 查看配置文件 ，是不是没有启用秘钥登录。
- 查看日志 tail -f /var/log/secure , 定为错误原因




为Root用户配的免密登录不生效
===========
通常为了安全centos会禁用SSH Root登录，如果需要开启，需执行以下操作

centos.启用SSH Root登录
```sh
vi /etc/ssh/sshd_config  
#更改发下值为yes
PermitRootLogin yes

#重启SSH
service sshd restart
```

centos.禁用SSH Root登录
```sh
vi /etc/ssh/sshd_config  
#更改发下值为no
PermitRootLogin no

#重启SSH
service sshd restart
```

如果禁用了，即使设置了免密登录也登不上。





