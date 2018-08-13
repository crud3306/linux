#!/bin/sh

# 进入家目录
cd ~
# 输入以下命令，然后一直回车，生成公钥与私钥 id_rsa，id_rsa.pub
ssh-keygen

#把生成的公钥拷贝到目标机子上，执行下面的命令，然后回车输入密码
# 用追加的方式
ssh-copy-id -i /root/.ssh/id_rsa.pub 192.168.xx.xx
# 用覆盖的方式
# scp -r /root/.ssh/id_rsa.pub root@192.168.xx.xx:/root/.ssh/authorized_keys

#测试
ssh -l root 192.168.xx.xx 'df -h'


#测试
ssh 192.168.xx.xx



