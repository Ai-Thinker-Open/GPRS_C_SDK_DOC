开始第一份代码
=====

确保可以编译代码、下载固件到GPRS模块/开发板后，就可以开始了解如何写一份代码啦~~~~

以下的代码可以在工程目录[`demo/first`](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/tree/master/demo/first)中找到

作为第一份代码，当然是从我们熟悉的hello wold做起呀~~~

所以我们的**目标**：一个完整的代码架构，并能不断间隔打印`Hello GPRS`即可

## 目录

|  目录  |  描述  |
|  ---   |  ---  |
|app     |  程序主目录，应用代码放在这里  |
|build   |  编译生成的目录、中间文件      |
|demo    |  一些例程                    |
|doc     | 相关文档，Markdown格式        |
|hex     |  最后产生的可烧录文件         |
|include |  SDK头文件目录，可以在这里面找需要的API以及函数、参数注释 |
|init    |  系统初始化的目录，可以不用理会，不建议改动 |
|platform|  库文件等，请确保`platform/csdk`文件夹不为空|

## 建立文件夹、文件

* 新建`demo/fisrt `文件夹，并新建`Makefile`文件，注意只是首字母大写，或者全是小写
填入以下内容：

```c
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


## 代码

代码可以在工程目录`demo/first/src/demo_first.c`中找到

主要要做的事情是:编写程序入口，并创建主任务，用来接收来自底层的事件,同时建立一个任务,不停打印信息


### 入口及主任务

程序入口，创建主任务（这里使用到了操作系统相关的函数，如果没有接触过，请不要惧怕，可以先照着做）

```c

#include "stdbool.h"
#include "stdint.h"

#include "api_os.h"
#include "api_debug.h"
#include "api_event.h"

#define MAIN_TASK_STACK_SIZE    (2048 * 2)
#define MAIN_TASK_PRIORITY      0
#define MAIN_TASK_NAME          "Main Test Task"

static HANDLE mainTaskHandle = NULL;

void first_Main(void)
{
    mainTaskHandle = OS_CreateTask(MainTask,
        NULL, NULL, MAIN_TASK_STACK_SIZE, MAIN_TASK_PRIORITY, 0, 0, MAIN_TASK_NAME);
    OS_SetUserMainHandle(&mainTaskHandle);
}
```

每个程序都有一个入口，这里的入口是一个函数：
`void first_Main(void)`，返回值和参数都是void，下划线左边**必须**是文件夹的名字，这里是first，下划线右半边**必须**是Main，首字母大写。

调用`OS_CreateTask`来创建一个任务，具体参数含义可以见OS部分，这里先不阐述。调用`OS_SetUserMainHandle`将刚刚创建的任务指针（句柄）传给底层，让底层知道给那个任务发送事件，**这个是必须的**

### 主任务处理及打印任务

```c

#define SECOND_TASK_STACK_SIZE    (2048 * 2)
#define SECOND_TASK_PRIORITY      1
#define SECOND_TASK_NAME          "Second Test Task"

static HANDLE secondTaskHandle = NULL;

void SecondTask(void *pData)
{
    while(1)
    {
        Trace(1,"Hello GPRS ");
        OS_Sleep(3000);
    }
}

void EventDispatch(API_Event_t* pEvent)
{
    switch(pEvent->id)
    {
        default:
            break;
    }
}

void MainTask(void *pData)
{
    API_Event_t* event=NULL;

    secondTaskHandle = OS_CreateTask(SecondTask,
        NULL, NULL, SECOND_TASK_STACK_SIZE, SECOND_TASK_PRIORITY, 0, 0, SECOND_TASK_NAME);

    while(1)
    {
        if(OS_WaitEvent(mainTaskHandle, (void**)&event, OS_TIME_OUT_WAIT_FOREVER))
        {
            EventDispatch(event);
            OS_Free(event->pParam1);
            OS_Free(event->pParam2);
            OS_Free(event);
        }
    }
}

```

主任务`MainTask`中又新建了一个任务`SecondTask`，这个任务中做的事情就是每间隔3秒钟打印一句`Hello GPRS`，打印信息可以在coolwatcher的tracer工具中看到；

然后主任务阻塞等待来自底层的事件，并在`EventDispatch`函数中处理，这里暂时没有处理任何事件，所有事件可以在`api_event.h`中找到，每个事件的参数也有注释

## 编译并下载固件看验证

按照前面的编译、下载方法下载到开发板运行，打开调试工具可以看到打印的`Hello GPRS`

![](/assets/Hello GPRS.png)







