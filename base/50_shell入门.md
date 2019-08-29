
参考地址：
-----------
https://www.cnblogs.com/clsn/p/8028337.html  
https://blog.csdn.net/yqxllwy/article/details/56670056 （条件判断）  


从一个简单的hello world开始
------------
vi hello.sh
```
#!/bin/bash 

echo "Hello World!"
```
注意：第一行 #!/bin/bash 标识该 Shell 脚本由哪个 Shell 解释。

执行：
```
# 赋予可执行权限
chmod a+x hello.sh

# 执行
./hello.sh

# 结果
Hello World!

或者执行
sh hello.sh
```


常用关键字
------------
```
1）echo：打印文字到屏幕 
2）exec：执行另一个 Shell 脚本 
3）read：读标准输入 
4）expr：对整数型变量进行算术运算 
5）test：用于测试变量是否相等、 是否为空、文件类型等 
6）exit：退出
```

例子：
```
#!/bin/bash 

echo "Hello Shell"

# 读入变量
read VAR
echo "VAR is $VAR"

# 计算变量
expr $VAR - 5

# 测试字符串
test "Hello"="HelloWorld"

# 测试整数
test $VAR -eq 10

# 测试目录
test -d ./Android

# 执行其他 Shell 脚本
exec ./othershell.sh

# 退出
exit
```
运行前，你需要新建一个 othershell.sh 的文件，让它输出 I'm othershell，并且中途需要一次输入，我这里输入的是 10：
```
Hello Shell
10
VAR is 10
5
I'm othershell
```

Shell 变量
============
Shell 变量分为 3 种： 
1）用户自定义变量 
2）预定义变量 
3）环境变量

定义变量需要注意下面 2 点： 
1）等号前后不要有空格：NUM=10 
2）一般变量名用大写：M=1

使用 $VAR 调用变量：
> echo $VAR


1）用户自定义变量
-------------
这种变量只支持字符串类型，不支持其他字符，浮点等类型，常见有这 3 个前缀： 
1）unset：删除变量 
2）readonly：标记只读变量 
3）export：指定全局变量

```
#!/bin/bash 

# 定义普通变量
CITY=SHENZHEN

# 定义全局变量
export NAME=cdeveloper

# 定义只读变量
readonly AGE=21

# 打印变量的值
echo $CITY
echo $NAME
echo $AGE

# 删除 CITY 变量
unset CITY
# 不会输出 SHENZHEN
echo $CITY
```

运行结果：
```
SHENZHEN
cdeveloper
21

```


2）预定义变量
--------------
预定义变量常用来获取命令行的输入，有下面这些：

$0 ：脚本文件名  
$1-9 ：第 1-9 个命令行参数名  
$# ：命令行参数个数  
$@ ：所有命令行参数  
$* ：所有命令行参数  
$? ：前一个命令的退出状态，可用于获取函数返回值；大部分命令执行成功会返回 0，失败返回 1。  
$$ ：执行的进程 ID  

```
#!/bin/bash 

echo "print $"
echo "\$0 = $0"
echo "\$1 = $1"
echo "\$2 = $2"
echo "\$# = $#"
echo "\$@ = $@"
echo "\$* = $*"
echo "\$$ = $$"
echo "\$? = $?"
```
执行./hello.sh 1 2 3 4 5 的结果：
```
print $

# 程序名
$0 = ./hello.sh

# 第一个参数
$1 = 1

# 第二个参数
$2 = 2

# 一共有 5 个参数
$# = 5

# 打印出所有参数
$@ = 1 2 3 4 5

# 打印出所有参数
$* = 1 2 3 4 5

# 进程 ID
$$ = 9450

# 之前没有执行其他命令或者函数
$? = 0
```


3）环境变量
-------------
环境变量默认就存在，常用的有下面这几个： 
1）HOME：用户主目录 
2）PATH：系统环境变量 PATH 
3）TERM：当前终端 
4）UID：当前用户 ID 
5）PWD：当前工作目录，绝对路径

```
#!/bin/bash

echo "print env"

echo $HOME
echo $PATH
echo $TERM
echo $PWD
echo $UID
```
结果：
```
print env

# 当前主目录
/home/orange

# PATH 环境变量
/home/orange/anaconda2/bin:后面还有很多

# 当前终端
xterm-256color

# 当前目录
/home/orange

# 用户 ID
1000
```


Shell 运算
============
我们经常需要在 Shell 脚本中计算，掌握基本的运算方法很有必要，下面就是 4 种比较常见的运算方法，功能都是将 m + 1： 
```
1）m=$[ m + 1 ] 
2）m=`expr $m + 1`  #用 `` 字符包起来 
3）let m=m+1 
4）m=$(( m + 1 ))
```

来看一个实际的例子：
```
#!/bin/bash 

m=1
m=$[ m + 1 ]
echo $m

m=`expr $m + 1`
echo $m

# 注意：+ 号左右不要加空格
let m=m+1
echo $m

m=$(( m + 1 ))
echo $m
```

```
2
3
4
5
```


Shell 基本运算符
=============
Shell 和其他编程语言一样，支持多种运算符，包括：

算数运算符  
关系运算符  
布尔运算符  
字符串运算符  
文件测试运算符  

原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如 awk 和 expr，expr 最常用。
expr 是一款表达式计算工具，使用它能完成表达式的求值操作。

```
例如，两个数相加(注意使用的是反引号 ` 而不是单引号 ')

#!/bin/bash

val=`expr 2 + 2`
echo "两数之和为 : $val"

结果：
两数之和为 : 4
```

两点注意：

1）表达式和运算符之间要有空格，例如 2+2 是不对的，必须写成 2 + 2，这与我们熟悉的大多数编程语言不一样。  
2）完整的表达式要被 ` ` 包含，（注意这个字符不是常用的单引号，在 Esc 键下边）  


算术运算符
--------------
下表列出了常用的算术运算符，假定变量 a 为 10，变量 b 为 20：

运算符	说明	举例
```
+	加法	`expr $a + $b` 结果为 30。
-	减法	`expr $a - $b` 结果为 -10。
*	乘法	`expr $a \* $b` 结果为  200。
/	除法	`expr $b / $a` 结果为 2。
%	取余	`expr $b % $a` 结果为 0。
=	赋值	a=$b 将把变量 b 的值赋给 a。
==	相等。用于比较两个数字，相同则返回 true。	[ $a == $b ] 返回 false。
!=	不相等。用于比较两个数字，不相同则返回 true。	[ $a != $b ] 返回 true。
注意：条件表达式要放在方括号之间，并且要有空格，例如: [$a==$b] 是错误的，必须写成 [ $a == $b ]。
```

实例
算术运算符实例如下：
```
#!/bin/bash

a=10
b=20

val=`expr $a + $b`
echo "a + b : $val"

val=`expr $a - $b`
echo "a - b : $val"

val=`expr $a \* $b`
echo "a * b : $val"

val=`expr $b / $a`
echo "b / a : $val"

val=`expr $b % $a`
echo "b % a : $val"

if [ $a == $b ]
then
   echo "a 等于 b"
fi
if [ $a != $b ]
then
   echo "a 不等于 b"
fi

执行脚本，输出结果如下所示：

a + b : 30
a - b : -10
a * b : 200
b / a : 2
b % a : 0
a 不等于 b
```

注意：

乘号(*)前边必须加反斜杠(\)才能实现乘法运算；  
if...then...fi 是条件语句，后续将会讲解。  
在 MAC 中 shell 的 expr 语法是：$((表达式))，此处表达式中的 "*" 不需要转义符号 "\" 。  



关系运算符
-------------
关系运算符只支持数字，不支持字符串，除非字符串的值是数字。

下表列出了常用的关系运算符，假定变量 a 为 10，变量 b 为 20：

运算符	说明	举例
```
-eq	检测两个数是否相等，相等返回 true。	[ $a -eq $b ] 返回 false。
-ne	检测两个数是否不相等，不相等返回 true。	[ $a -ne $b ] 返回 true。
-gt	检测左边的数是否大于右边的，如果是，则返回 true。	[ $a -gt $b ] 返回 false。
-lt	检测左边的数是否小于右边的，如果是，则返回 true。	[ $a -lt $b ] 返回 true。
-ge	检测左边的数是否大于等于右边的，如果是，则返回 true。	[ $a -ge $b ] 返回 false。
-le	检测左边的数是否小于等于右边的，如果是，则返回 true。	[ $a -le $b ] 返回 true。
```

关系运算符实例如下：
```
#!/bin/bash

a=10
b=20

if [ $a -eq $b ]
then
   echo "$a -eq $b : a 等于 b"
else
   echo "$a -eq $b: a 不等于 b"
fi
if [ $a -ne $b ]
then
   echo "$a -ne $b: a 不等于 b"
else
   echo "$a -ne $b : a 等于 b"
fi
if [ $a -gt $b ]
then
   echo "$a -gt $b: a 大于 b"
else
   echo "$a -gt $b: a 不大于 b"
fi
if [ $a -lt $b ]
then
   echo "$a -lt $b: a 小于 b"
else
   echo "$a -lt $b: a 不小于 b"
fi
if [ $a -ge $b ]
then
   echo "$a -ge $b: a 大于或等于 b"
else
   echo "$a -ge $b: a 小于 b"
fi
if [ $a -le $b ]
then
   echo "$a -le $b: a 小于或等于 b"
else
   echo "$a -le $b: a 大于 b"
fi

执行脚本，输出结果如下所示：
10 -eq 20: a 不等于 b
10 -ne 20: a 不等于 b
10 -gt 20: a 不大于 b
10 -lt 20: a 小于 b
10 -ge 20: a 小于 b
10 -le 20: a 小于或等于 b
```


布尔运算符
-------------
下表列出了常用的布尔运算符，假定变量 a 为 10，变量 b 为 20：

运算符	说明	举例
```
!	非运算，表达式为 true 则返回 false，否则返回 true。	[ ! false ] 返回 true。
-o	或运算，有一个表达式为 true 则返回 true。	[ $a -lt 20 -o $b -gt 100 ] 返回 true。
-a	与运算，两个表达式都为 true 才返回 true。	[ $a -lt 20 -a $b -gt 100 ] 返回 false。
```

布尔运算符实例如下：
```
#!/bin/bash

a=10
b=20

if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
if [ $a -lt 100 -a $b -gt 15 ]
then
   echo "$a 小于 100 且 $b 大于 15 : 返回 true"
else
   echo "$a 小于 100 且 $b 大于 15 : 返回 false"
fi
if [ $a -lt 100 -o $b -gt 100 ]
then
   echo "$a 小于 100 或 $b 大于 100 : 返回 true"
else
   echo "$a 小于 100 或 $b 大于 100 : 返回 false"
fi
if [ $a -lt 5 -o $b -gt 100 ]
then
   echo "$a 小于 5 或 $b 大于 100 : 返回 true"
else
   echo "$a 小于 5 或 $b 大于 100 : 返回 false"
fi

执行脚本，输出结果如下所示：
10 != 20 : a 不等于 b
10 小于 100 且 20 大于 15 : 返回 true
10 小于 100 或 20 大于 100 : 返回 true
10 小于 5 或 20 大于 100 : 返回 false
```


逻辑运算符
--------------
以下介绍 Shell 的逻辑运算符，假定变量 a 为 10，变量 b 为 20:

运算符	说明	举例
```
&&	逻辑的 AND	[[ $a -lt 100 && $b -gt 100 ]] 返回 false
||	逻辑的 OR	[[ $a -lt 100 || $b -gt 100 ]] 返回 true
```

逻辑运算符实例如下：
```
#!/bin/bash

a=10
b=20

if [[ $a -lt 100 && $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi

if [[ $a -lt 100 || $b -gt 100 ]]
then
   echo "返回 true"
else
   echo "返回 false"
fi

执行脚本，输出结果如下所示：
返回 false
返回 true
```



字符串运算符
-------------
下表列出了常用的字符串运算符，假定变量 a 为 "abc"，变量 b 为 "efg"：

运算符	说明	举例
```
=	检测两个字符串是否相等，相等返回 true。	[ $a = $b ] 返回 false。
!=	检测两个字符串是否相等，不相等返回 true。	[ $a != $b ] 返回 true。
-z	检测字符串长度是否为0，为0返回 true。	[ -z $a ] 返回 false。
-n	检测字符串长度是否为0，不为0返回 true。	[ -n "$a" ] 返回 true。
str	检测字符串是否为空，不为空返回 true。	[ $a ] 返回 true。
```

字符串运算符实例如下：
```
#!/bin/bash

a="abc"
b="efg"

if [ $a = $b ]
then
   echo "$a = $b : a 等于 b"
else
   echo "$a = $b: a 不等于 b"
fi
if [ $a != $b ]
then
   echo "$a != $b : a 不等于 b"
else
   echo "$a != $b: a 等于 b"
fi
if [ -z $a ]
then
   echo "-z $a : 字符串长度为 0"
else
   echo "-z $a : 字符串长度不为 0"
fi
if [ -n "$a" ]
then
   echo "-n $a : 字符串长度不为 0"
else
   echo "-n $a : 字符串长度为 0"
fi
if [ $a ]
then
   echo "$a : 字符串不为空"
else
   echo "$a : 字符串为空"
fi


执行脚本，输出结果如下所示：
abc = efg: a 不等于 b
abc != efg : a 不等于 b
-z abc : 字符串长度不为 0
-n abc : 字符串长度不为 0
abc : 字符串不为空
```


文件测试运算符
------------
文件测试运算符用于检测 Unix 文件的各种属性。

属性检测描述如下：

操作符	说明	举例
```
-b file	检测文件是否是块设备文件，如果是，则返回 true。	[ -b $file ] 返回 false。
-c file	检测文件是否是字符设备文件，如果是，则返回 true。	[ -c $file ] 返回 false。
-d file	检测文件是否是目录，如果是，则返回 true。	[ -d $file ] 返回 false。
-f file	检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。	[ -f $file ] 返回 true。
-g file	检测文件是否设置了 SGID 位，如果是，则返回 true。	[ -g $file ] 返回 false。
-k file	检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true。	[ -k $file ] 返回 false。
-p file	检测文件是否是有名管道，如果是，则返回 true。	[ -p $file ] 返回 false。
-u file	检测文件是否设置了 SUID 位，如果是，则返回 true。	[ -u $file ] 返回 false。
-r file	检测文件是否可读，如果是，则返回 true。	[ -r $file ] 返回 true。
-w file	检测文件是否可写，如果是，则返回 true。	[ -w $file ] 返回 true。
-x file	检测文件是否可执行，如果是，则返回 true。	[ -x $file ] 返回 true。
-s file	检测文件是否为空（文件大小是否大于0），不为空返回 true。	[ -s $file ] 返回 true。
-e file	检测文件（包括目录）是否存在，如果是，则返回 true。	[ -e $file ] 返回 true。
```

实例
变量 file 表示文件"/var/www/runoob/test.sh"，它的大小为100字节，具有 rwx 权限。下面的代码，将检测该文件的各种属性：
```
#!/bin/bash

file="/var/www/runoob/test.sh"
if [ -r $file ]
then
   echo "文件可读"
else
   echo "文件不可读"
fi
if [ -w $file ]
then
   echo "文件可写"
else
   echo "文件不可写"
fi
if [ -x $file ]
then
   echo "文件可执行"
else
   echo "文件不可执行"
fi
if [ -f $file ]
then
   echo "文件为普通文件"
else
   echo "文件为特殊文件"
fi
if [ -d $file ]
then
   echo "文件是个目录"
else
   echo "文件不是个目录"
fi
if [ -s $file ]
then
   echo "文件不为空"
else
   echo "文件为空"
fi
if [ -e $file ]
then
   echo "文件存在"
else
   echo "文件不存在"
fi


执行脚本，输出结果如下所示：

文件可读
文件可写
文件可执行
文件为普通文件
文件不是个目录
文件不为空
文件存在
```





Shell 语句
=============
Shell 语句跟高级语言有些类似，也包括分支，跳转，循环。

1）if 语句
-------------
这个跟高级语言的 if - else - if 类似，只是格式有些不同而已，也来看个例子吧：
```
#!/bin/bash 

read VAR

# 下面这两种判断方法都可以，使用 [] 注意左右加空格
#if test $VAR -eq 10
if [ $VAR -eq 10 ]
then
    echo "true"
else
    echo "false"
fi  
```

2）case 语句
-------------
case 语句有些复杂，要注意格式：
```
#!/bin/bash 

read NAME
# 格式有点复杂，一定要注意
case $NAME in
    "Linux")
        echo "Linux"
        ;;
    "cdeveloper")
        echo "cdeveloper"
        ;;
    *)
        echo "other"
        ;;
esac
```
结果：
```
# 输入 Linux
Linux

# 输入 cdeveloper
cdeveloper

# 输入其他的字符串
other
```

3）for 循环
-------------
这是一个 for 循环基本使用例子，挺简单的，有点类似 Python：
```
#!/bin/bash 

# 普通 for 循环
for ((i = 1; i <= 3; i++))
do
    echo $i
done


# VAR 依次代表每个元素 
for VAR in 1 2 3
do
    echo $VAR
done

执行结果：
1
2
3
```

4）while 循环
-------------
注意与 for 循环的区别：
```
#!/bin/bash 

VAR=1

# 如果 VAR 小于 10，就打印出来
while [ $VAR -lt 10 ]
do
    echo $VAR
#   VAR 自增 1
    VAR=$[ $VAR + 1 ]
done

执行结果：
1
2
3
4
5
6
7
8
9
```


5）until 循环
-------------
until 语句与上面的循环的不同点是它的结束条件为 1：
```
#!/bin/bash 

i=0  

# i 大于 5 时，循环结束 
until [[ "$i" -gt 5 ]]     
do  
    echo $i
    i=$[ $i + 1 ]
done
```

6）break
-------------
Shell 中的 break 用法与高级语言相同，都是跳出循环，来看个例子：
```
#!/bin/bash 

for VAR in 1 2 3
do
#   如何 VAR 等于 2 就跳出循环
    if [ $VAR -eq 2 ]
    then
        break
    fi

    echo $VAR
done

运行结果：
1
```


7）continue
-------------
continue 用来跳过本次循环，进入下一次循环，再来看看上面的例子：
```
#!/bin/bash 

for VAR in 1 2 3
do
#   如果 VAR 等于 2，就跳过，直接进入下一次 VAR = 3 的循环 
    if [ $VAR -eq 2 ]
    then
        continue    
    fi

    echo $VAR
done

运行结果：
1
3
```


Shell 函数
============
函数可以用一句话解释：带有输入输出的具有一定功能的黑盒子，相信有过编程经验的同学不会陌生。那么，我们先来看看 Shell 中函数定义的格式。

1）定义函数
-------------
有 2 种常见格式：
```
function fun_name()
{

}

fun_name()
{

}
```

一个实例：
```
#!/bin/bash 

function hello_world()
{
    echo "hello world fun"
    echo $1 $2
    return 1
}

hello()
{
    echo "hello fun"
}
```

2）调用函数
-------------
如何调用上面的 2 个函数呢？
```
# 1）直接用函数名调用 hello 函数
hello

# 2）使用「函数名 函数参数」来传递参数
hello_world 1 2

# 3）使用「FUN=`函数名 函数参数`」 来间接调用
FUN=`hello_world 1 2`
echo $FUN
```

3）获取返回值
-------------
如何获取 hello_world 函数的返回值呢？还记得 $? 吗？
```
hello_world 1 2
# $? 可用于获取前一个函数的返回值，这里结果是 1 
echo $?
```


4）定义本地变量
-------------
使用 local 来在函数中定义本地变量：
```
fun()
{
    local x=1
    echo $x
}
```

俗话说，程序 3 分靠写，7 分靠调，下面我们就来看看如何调试 Shell 程序。



Shell 调试
==============
使用下面的命令来检查是否有语法错误：
> sh -n script_name.sh

使用下面的命令来执行并调试 Shell 脚本：
> sh -x script_name.sh

来看个实际的例子，我们来调试下面这个 test.sh 程序：
```
#!/bin/bash

for VAR in 1 2 3
do
    if [ $VAR -eq 2 ]
    then
        continue    
    fi
    echo $VAR
done
```
首先检查有无语法错误：
> sh -n test.sh

没有输出，说明没有错误，开始实际调试：
> sh -x test.sh

```
调试结果如下：  
+ [ 1 -eq 2 ]
+ echo 1
1
+ [ 2 -eq 2 ]
+ continue
+ [ 3 -eq 2 ]
+ echo 3
3
```
其中带有 + 表示的是 Shell 调试器的输出，不带 + 表示我们程序的输出。



Shell 易错点
============
一些初学 Shell 编程容易犯的错误，大多都是语法错误：
```
1）[] 内不能嵌套 ()，可以嵌套 [] 
2）$[ val + 1 ] 是变量加 1 的常用方法 
3）[] 在测试或者计算中里面的内容最好都加空格 
4）单引号和双引号差不多，单引号更加严格，双引号可以嵌套单引号 
5）一定要注意语句的格式，例如缩进
6）使用运算符时要注意，比如：数字和字符串的比较送算符是不一样的
```


