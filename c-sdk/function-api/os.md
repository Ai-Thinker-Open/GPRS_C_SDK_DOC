操作系统(OS)
===

一个轻量级的操作系统，包含了基本的任务操作、消息机制等等

例程: [`demo/os`](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/os/src/demo_os.c)

---

## 宏定义

### OS_WAIT_FOREVER 

超时时间特殊值，阻塞等待（永远等待）

```c
#define OS_WAIT_FOREVER 0xFFFFFFFF
```

---

### OS_NO_WAIT 

超时时间特殊值，不等待

```
#define OS_NO_WAIT 0x0
```

---

### OS_EVENT_PRI_NORMAL 

事件优先级普通,`OS_SendEvent`的nOption参数的值

```c
#define OS_EVENT_PRI_NORMAL 0
```

---

### OS_EVENT_PRI_URGENT 

事件优先级紧急，`OS_SendEvent`的nOption参数的值


```c
#define OS_EVENT_PRI_URGENT 1
```

---

### OS_CREATE_DEFAULT   

函数`OS_CreateTask`的`nCreationFlags`参数的值，表示创建任务后自动开始执行任务

```c
#define OS_CREATE_DEFAULT   0
```

---

### OS_CREATE_SUSPENDED 

函数`OS_CreateTask`的`nCreationFlags`参数的值，表示创建任务后不自动开始执行任务

```c
#define OS_CREATE_SUSPENDED 1
```

---


## 结构体

### OS_Heap_Status_t

堆状态，包括总大小和已经使用了的大小

```c
typedef struct{
    uint32_t usedSize;
    uint32_t totalSize;
}OS_Heap_Status_t;
```

---

## Function

### PTASK_FUNC_T

```c
typedef void (*PTASK_FUNC_T)(PVOID pParameter);
```

#### Function

创建的任务主函数，由用户定义

#### Parameters

* pParameter:调用这个函数的时候传入的参数

#### Return

None

---


### OS_SetUserMainHandle

```c
void OS_SetUserMainHandle(HANDLE* appMainHandle);
```

#### Function

设置主任务，主任务用来接收来自底层的消息，这个函数必须在开机的时候创建主任务后立即调用，否则可能导致底层无法向应用层发布消息

#### Parameters

* appMainHandle:创建的主任务返回的指针（句柄）

#### Return

None

---

### OS_CreateTask

```c
HANDLE OS_CreateTask(
    PTASK_FUNC_T pTaskEntry,
    PVOID pParameter,
    PVOID pStackAddr,
    UINT16 nStackSize,
    UINT8 nPriority,
    UINT16 nCreationFlags,
    UINT16 nTimeSlice,
    PCSTR pTaskName);
```

#### Function

创建一个新的任务

#### Parameters

* pTaskEntry:任务执行函数，PTASK_FUNC_T 类型
* pParameter:需要传递给执行函数的参数
* pStackAddr:自定义栈的地址，暂时不支持自定义，即值只能为`NULL `
* nStackSize:栈大小
* nPriority:任务优先级，>=0，每个任务优先级不同，值越小任务优先级越大
* nCreationFlags: `OS_CREATE_DEFAULT `/`0`: 默认，创建任务后开始执行任务；`OS_CREATE_SUSPENDED`: 创建任务后不执行任务，需要手动调用start函数开启任务运行
* nTimeSlice:保留，值为0
* pTaskName:任务名称

#### Return

* 创建的任务的指针（句柄），如果创建任务失败，则返回`NULL`

---

### OS_StartTask

```c
void OS_StartTask(
    HANDLE pHTask,
    PVOID pParameter);
```

#### Function

开始执行任务

#### Parameters

* pHTask:任务句柄，`OS_CreateTask`的返回值
* pParameter:需要传给任务函数的参数

#### Return

None

---

### OS_StopTask

```c
void OS_StopTask(
    HANDLE pHTask);
```

#### Function

停止任务执行

#### Parameters

* pHTask:任务句柄，`OS_CreateTask`的返回值

#### Return

None

---

### OS_DeleteTask

```c
bool OS_DeleteTask(
    HANDLE hTask);
```

#### Function

删除任务

#### Parameters

* hTask:任务句柄，`OS_CreateTask`的返回值

#### Return

* 删除任务是否成功

---

### OS_SuspendTask

```c
bool OS_SuspendTask(
    HANDLE hTask);
```

#### Function

挂起线程

#### Parameters

* hTask:任务句柄，`OS_CreateTask`的返回值

#### Return

* 挂起是否成功

---

### OS_ResumeTask

```c
bool OS_ResumeTask(
    HANDLE hTask);
```

#### Function

继续任务

#### Parameters

* hTask:任务句柄，`OS_CreateTask`的返回值

#### Return

* 是否成功

---

### OS_Sleep

```c
bool OS_Sleep(UINT32 nMillisecondes);
```

#### Function

阻塞毫秒级延时

#### Parameters

* nMillisecondes:阻塞延迟时间，单位毫秒

#### Return

* 是否成功（始终为true）

---

### OS_SleepUs

```c
void OS_SleepUs(UINT32 us);
```

#### Function

阻塞微妙级延时

#### Parameters

* us: 延时时间，单位微妙

#### Return

None

---

### OS_WaitEvent

```c
bool OS_WaitEvent(
    HANDLE   hTask,
    PVOID*   pEvent,
    UINT32   nTimeOut);
```

#### Function

阻塞等待事件

#### Parameters

* hTask:任务句柄，`OS_CreateTask`的返回值
* pEvent:事件值，来自`OS_SendEvent`的参数
* nTimeOut:等待超时时间，目前只支持阻塞等待，即值必须为`OS_WAIT_FOREVER`

#### Return

* 成功等待到事件

---

### OS_SendEvent

```c
bool OS_SendEvent(
    HANDLE hTask,
    PVOID  pEvent,
    UINT32 nTimeOut,
    UINT16 nOption);
```

#### Function

向某个任务发送事件

#### Parameters

* hTask:任务句柄，`OS_CreateTask`的返回值
* pEvent: 事件发送的数据（指针）
* nTimeOut:超时时间，目前只支持阻塞等待，即值必须为`OS_WAIT_FOREVER`
* nOption:事件选项，`OS_EVENT_PRI_NORMAL`: 普通优先级，`OS_EVENT_PRI_URGENT`:紧急优先级

#### Return

* 事件是否发送成功

---

### OS_ResetEventQueue

```c
bool OS_ResetEventQueue(
    HANDLE hTask);
```

#### Function

重置事件队列

#### Parameters

* hTask:任务句柄，`OS_CreateTask`的返回值

#### Return

* 是否重置成功

---

### OS_IsEventAvailable

```c
bool OS_IsEventAvailable(
    HANDLE hTask);
```

#### Function

判断某个任务是否有事件可以接收

#### Parameters

* hTask:任务句柄，`OS_CreateTask`的返回值

#### Return

* 是否有事件可以接收

---

### OS_Malloc 

```c
PVOID OS_Malloc (UINT32 nSize);
```

#### Function

动态分配内存

#### Parameters

* nSize:动态分配内存长度，单位是字节

#### Return

* 动态分配内存块的首地址，若分配失败，则返回`NULL`

---

### OS_Realloc

```c
PVOID OS_Realloc(VOID *ptr, UINT32 nSize);
```

#### Function

重新分配内存

#### Parameters

* ptr:动态分配的内存块首地址
* nSize:新动态分配的内存块长度

#### Return

* 成功分配的内存块首地址，若为`NULL`，则分配失败

---

### OS_Free   

```c
bool  OS_Free   (PVOID pMemBlock);
```

#### Function

释放动态分配的内存

#### Parameters

* pMemBlock:动态分配的内存块首地址

#### Return

* 是否释放成功

---

### OS_GetHeapUsageStatus

```c
bool OS_GetHeapUsageStatus(OS_Heap_Status_t* pOsHeapStatus);
```

#### Function

获取堆的使用情况

#### Parameters

* pOsHeapStatus:堆使用情况

#### Return

* 是否获取堆状态成功

---

### OS_CreateSemaphore

```c
HANDLE OS_CreateSemaphore(
    UINT32 nInitCount // Specify the initial count of the semaphore
    );
```

#### Function

创建一个信号量

#### Parameters

* nInitCount:信号量初始化值，0表示资源被占用，n表示有n个资源值，每次wait将会等待资源值并减一，release操作将会将资源值加一

#### 返回值

* 信号量句柄，如果失败，返回`NULL`

---

### OS_DeleteSemaphore

```c
bool OS_DeleteSemaphore(
    HANDLE hSem);
```

#### Function

删除信号量

#### Parameters

* hSem:信号量句柄，`OS_CreateSemaphore`的返回值

#### Return

* 信号量是否删除成功

---

### OS_WaitForSemaphore

```c
bool OS_WaitForSemaphore(
    HANDLE hSem,    // Specify the handle to a counting semaphore
    UINT32 nTimeOut // the time-out value
    );
```

#### Function

等待信号量知道资源值大于0，并将资源值减一

#### Parameters

* hSem:信号量句柄，`OS_CreateSemaphore`的返回值
* nTimeOut:超时值，暂时保留，即值为`OS_WAIT_FOREVER`

#### Return

* 是否成功获取到信号量（资源值）

---

### OS_ReleaseSemaphore

```c
bool OS_ReleaseSemaphore(
    HANDLE hSem //Specify the counting semaphore
    );
```

#### Function

释放信号量，即资源值加一

#### Parameters

* hSem:信号量句柄，`OS_CreateSemaphore`的返回值

#### Return

* 是否释放信号量（资源值）成功

---

### OS_CreateMutex

```c
HANDLE OS_CreateMutex(void);
```

#### Function

创建一个互斥量

#### Parameters

None

#### Return

* 互斥量句柄，如果失败，返回`NULL`

---

### OS_DeleteMutex

```c
void OS_DeleteMutex(HANDLE mutex);
```

#### Function

删除互斥量

#### Parameters

* mutex:互斥量句柄，`OS_CreateMutex`的返回值

#### Return

None

---

### OS_LockMutex

```c
void OS_LockMutex(HANDLE mutex);
```

#### Function

锁互斥量，即占用资源

#### Parameters

* mutex:互斥量句柄，`OS_CreateMutex`的返回值

#### Return

None

---

### OS_UnlockMutex

```c
void OS_UnlockMutex(HANDLE mutex);
```

#### Function

释放互斥量，即释放资源

#### Parameters

* mutex:互斥量句柄，`OS_CreateMutex`的返回值

#### Return
None

---

### OS_CALLBACK_FUNC_T

```c
typedef void (*OS_CALLBACK_FUNC_T)(void* param);
```

#### Function

回调函数，由用户定义

#### Parameters

* param: 用户传入的参数

#### Return

None

---

### OS_StartCallbackTimer

```c
bool OS_StartCallbackTimer(HANDLE hTask, UINT32 ms, OS_CALLBACK_FUNC_T callback, void* param);
```

#### Function

开始软件计时器，设定时间到了后会触发回调函数

#### Parameters

* hTask:任务句柄，这个指定的任务里必须包含`OS_WaitEvent`函数调用（比如可以传主任务），否则不会触发回调
* ms: 定时时间
* callback: 回调函数
* param: 传入回调函数的参数

#### Return

* 创建定时器是否成功

---

### OS_StopCallbackTimer

```c
bool OS_StopCallbackTimer(HANDLE hTask, OS_CALLBACK_FUNC_T callback, void *param);
```

#### Function

停止软件计时器

#### Parameters

* hTask:任务句柄，这个指定的任务里必须包含`OS_WaitEvent`函数调用（比如可以传主任务），否则不会触发回调
* callback: 回调函数
* param: 传入回调函数的参数

#### Return

* 停止定时器是否成功

---

### OS_QueryCallbackTimer

```c
uint32_t OS_QueryCallbackTimer(HANDLE hTask, OS_CALLBACK_FUNC_T callback, void *param);
```

#### Function

查询软件计时器还剩多少时间结束

#### Parameters

* hTask:任务句柄，这个指定的任务里必须包含`OS_WaitEvent`函数调用（比如可以传主任务），否则不会触发回调
* callback: 回调函数
* param: 传入回调函数的参数

#### Return

* 定时器离结束剩余的时间

---







