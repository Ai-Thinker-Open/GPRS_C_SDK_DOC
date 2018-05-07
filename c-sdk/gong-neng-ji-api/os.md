操作系统(OS)
===

一个轻量级的操作系统，包含了基本的任务操作、消息机制等等

例程：[`demo/os`](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/os/src/demo_os.c)

---

## 一：宏定义

#### OS_WAIT_FOREVER 

阻塞等待（永远等待）

```
#define OS_WAIT_FOREVER 0xFFFFFFFF
```

---

#### OS_NO_WAIT 

不等待

```
#define OS_NO_WAIT 0x0
```

---

#### OS_EVENT_PRI_NORMAL 

事件优先级普通

```
#define OS_EVENT_PRI_NORMAL 0
```

---

#### OS_EVENT_PRI_URGENT 

事件优先级紧急

```
#define OS_EVENT_PRI_URGENT 1
```

---

## 二：结构体

#### OS_Heap_Status_t

堆状态，包括总大小和已经使用了的大小

```
typedef struct{
    uint32_t usedSize;
    uint32_t totalSize;
}OS_Heap_Status_t;
```

---

## 三：功能函数

#### PTASK_FUNC_T

```
typedef void (*PTASK_FUNC_T)(PVOID pParameter);
```

##### 功能

创建的任务主函数，由用户定义

##### 参数

* pParameter:调用这个函数的时候传入的参数

##### 返回值

无

---


#### OS_SetUserMainHandle

```
void OS_SetUserMainHandle(HANDLE* appMainHandle);
```

##### 功能

设置主任务，主任务用来接收来自底层的消息，这个函数必须在开机的时候创建主任务后立即调用，否则可能导致底层无法向应用层发布消息

##### 参数

* appMainHandle:创建的主任务返回的指针（句柄）

##### 返回值

无

---

#### OS_CreateTask

```
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

##### 功能

创建一个新的任务

##### 参数

* pTaskEntry:任务执行函数，PTASK_FUNC_T 类型
* pParameter:需要传递给执行函数的参数
* pStackAddr:自定义栈的地址，可以为`NULL `
* 

##### 返回值

* 创建的任务的指针（句柄），如果创建任务失败，则返回`NULL`

---

void OS_StartTask(
    HANDLE pHTask,
    PVOID pParameter);

void OS_StopTask(
    HANDLE pHTask);

bool OS_DeleteTask(
    HANDLE hTask);

UINT32 OS_SuspendTask(
    HANDLE hTask);

bool OS_ResumeTask(
    HANDLE hTask);

bool OS_Sleep(UINT32 nMillisecondes);
void OS_SleepUs(UINT32 us);


#define OS_TIME_OUT_WAIT_FOREVER 0xFFFFFFFF
#define OS_TIME_OUT_NO_WAIT      0x0

bool OS_WaitEvent(
    HANDLE   hTask,
    PVOID*   pEvent,
    UINT32   nTimeOut);

bool OS_SendEvent(
    HANDLE hTask,
    PVOID  pEvent,
    UINT32 nTimeOut,
    UINT16 nOption);

bool OS_ResetEventQueue(
    HANDLE hTask);

bool OS_IsEventAvailable(
    HANDLE hTask);

PVOID OS_Malloc (UINT32 nSize);
PVOID OS_Realloc(VOID *ptr, UINT32 nSize);
bool  OS_Free   (PVOID pMemBlock);

bool OS_GetHeapUsageStatus(OS_Heap_Status_t* pOsHeapStatus);

HANDLE OS_CreateSemaphore(
    UINT32 nInitCount // Specify the initial count of the semaphore
    );

bool OS_DeleteSemaphore(
    HANDLE hSem);

bool OS_WaitForSemaphore(
    HANDLE hSem,    // Specify the handle to a counting semaphore
    UINT32 nTimeOut // the time-out value
    );

bool OS_ReleaseSemaphore(
    HANDLE hSem //Specify the counting semaphore
    );



HANDLE OS_CreateMutex(void);

void OS_DeleteMutex(HANDLE mutex);

void OS_LockMutex(HANDLE mutex);

void OS_UnlockMutex(HANDLE mutex);


/********************************************************************/
//////////////////////////////timer///////////////////////////////////

typedef void (*OS_CALLBACK_FUNC_T)(void* param);
/**
  *
  * @param hTask Task handle that must have OS_WaitEvent(hTask.....)
  *
  */
bool OS_StartCallbackTimer(HANDLE hTask, UINT32 ms, OS_CALLBACK_FUNC_T callback, void* param);

bool OS_StopCallbackTimer(HANDLE hTask, OS_CALLBACK_FUNC_T callback, void *param);

uint32_t OS_QueryCallbackTimer(HANDLE hTask, OS_CALLBACK_FUNC_T callback, void *param);