开始第一份代码
=====

确保可以编译代码、下载固件到GPRS模块/开发板后，就可以开始了解如何写一份代码啦~~~~

以下的代码可以在工程目录`demo/first`中找到

## 一：建立文件夹、文件

* 新建`demo/fisrt `文件夹，并新建`Makefile`文件，注意只是首字母大写，或者全是小写
填入以下内容：

```
# Name of the module
LOCAL_NAME := demo/first

# List of submodules which contain code we need to include in the final lib
LOCAL_API_DEPENDS := \

LOCAL_ADD_INCLUDE := include\
                    include/std_inc \
                    include/api_inc \


# Set this to any non-null string to signal a module which 
# generates a binary (must contain a "main" entry point). 
# If left null, only a library will be generated.
IS_ENTRY_POINT := no

## ------------------------------------ ##
## 	Add your custom flags here          ##
## ------------------------------------ ##
MYCFLAGS += 

## ------------------------------------- ##
##	List all your sources here           ##
## ------------------------------------- ##
C_SRC := ${notdir ${wildcard src/*.c}}

## ------------------------------------- ##
##  Do Not touch below this line         ##
## ------------------------------------- ##
include ${SOFT_WORKDIR}/platform/compilation/cust_rules.mk
```

这里`LOCAL_NAME := demo/first`填文件夹路径，`LOCAL_ADD_INCLUDE`是包含的头文件路径

* 新建`demo/first/src`文件夹,并新建`demo_first.c`文件


## 二：代码

代码可以在工程目录`demo/first/src/demo_first.c`中找到

每个程序都有一个入口，这里的入口是一个函数：
`void first_Main(void)`，返回值和参数都是void，下划线左边**必须**是文件夹的名字，这里是first，下划线右半边**必须**是Main，首字母大写。

#### （1）编写程序入口，并创建主任务，用来接收来自底层的事件

* 程序入口，创建主任务

```
void first_Main(void)
{
    mainTaskHandle = OS_CreateTask(MainTask,
        NULL, NULL, MAIN_TASK_STACK_SIZE, MAIN_TASK_PRIORITY, 0, 0, MAIN_TASK_NAME);
    OS_SetUserMainHandle(&mainTaskHandle);
}
```



