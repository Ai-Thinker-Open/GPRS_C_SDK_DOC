操作系统(OS)
===

A lightweight operating system that includes basic task operations, message mechanisms, and so on.

example: [`demo/os`](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/os/src/demo_os.c)

---

## Macro definition

### OS_WAIT_FOREVER 

Timeout time special value, blocking wait (always waiting)

```c
#define OS_WAIT_FOREVER 0xFFFFFFFF
```

---

### OS_NO_WAIT 

Timeout time special value, not waiting

```
#define OS_NO_WAIT 0x0
```

---

### OS_EVENT_PRI_NORMAL 

Event priority is common, the value of nOption parameter of `OS_SendEvent`.

```c
#define OS_EVENT_PRI_NORMAL 0
```

---

### OS_EVENT_PRI_URGENT 

Event priority is urgent, the value of nOption parameter of `OS_SendEvent`.


```c
#define OS_EVENT_PRI_URGENT 1
```

---

### OS_CREATE_DEFAULT   

The value of the `nCreationFlags` parameter of the function `OS_CreateTask` indicates that the task is automatically started after the creation of the task.

```c
#define OS_CREATE_DEFAULT   0
```

---

### OS_CREATE_SUSPENDED 

The value of the `nCreationFlags` parameter of the function `OS_CreateTask` indicates that the task is not automatically started after the creation of the task.

```c
#define OS_CREATE_SUSPENDED 1
```

---


## Struct

### OS_Heap_Status_t

Heap status, including the total size and the size that has been used.

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

The created task master function, defined by the user

#### Parameters

* pParameter:Parameters passed in when this function is called

#### Return

None

---


### OS_SetUserMainHandle

```c
void OS_SetUserMainHandle(HANDLE* appMainHandle);
```

#### Function

The primary task is set up. The primary task is used to receive messages from the bottom. This function must be called immediately after the main task is created when the machine is started, otherwise the underlying layer can not be released to the application layer.

#### Parameters

* appMainHandle:The pointer returned by the created primary task (handle)

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

Create a new task

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







