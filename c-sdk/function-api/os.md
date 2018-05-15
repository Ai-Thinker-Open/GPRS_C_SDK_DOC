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

* pTaskEntry: task execution function, PTASK_FUNC_T type
* pParameter: needs to be passed to the parameters of the execution function
* pStackAddr: custom stack address, temporarily does not support custom, that is, the value can only be `NULL '.
* nStackSize: stack size
* nPriority: task priority, >=0, the priority of each task is different, the smaller the value, the larger the task priority.
* nCreationFlags: `OS_CREATE_DEFAULT `/`0`: by default, the task is started after the task is created; `OS_CREATE_SUSPENDED`: the task is not executed after the task is created, and the start function is required to be invoked manually to open the task
* nTimeSlice: reservation, value 0
* pTaskName: task name

#### Return

* A pointer to the task created (handle), if the creation of a task fails, it returns `NULL`.

---

### OS_StartTask

```c
void OS_StartTask(
    HANDLE pHTask,
    PVOID pParameter);
```

#### Function

Start the execution of the task

#### Parameters

* pHTask: task handle, return value of `OS_CreateTask`.
* pParameter: needs to pass to the parameter of the task function

#### Return

None

---

### OS_StopTask

```c
void OS_StopTask(
    HANDLE pHTask);
```

#### Function

Stop task execution

#### Parameters

* pHTask: task handle, return value of `OS_CreateTask`.

#### Return

None

---

### OS_DeleteTask

```c
bool OS_DeleteTask(
    HANDLE hTask);
```

#### Function

Delete task

#### Parameters

* hTask: task handle, return value of `OS_CreateTask`

#### Return

* delete whether the task is successful or not

---

### OS_SuspendTask

```c
bool OS_SuspendTask(
    HANDLE hTask);
```

#### Function

Hang up thread

#### Parameters

* hTask: task handle, return value of `OS_CreateTask`

#### Return

* whether to hang up or not

---

### OS_ResumeTask

```c
bool OS_ResumeTask(
    HANDLE hTask);
```

#### Function

Continue the task

#### Parameters

* hTask: task handle, return value of `OS_CreateTask`

#### Return

* whether or not it is successful

---

### OS_Sleep

```c
bool OS_Sleep(UINT32 nMillisecondes);
```

#### Function

Blocking millisecond delay

#### Parameters

* nMillisecondes: blocking delay time per unit millisecond

#### Return

* whether or not it is successful (always true)

---

### OS_SleepUs

```c
void OS_SleepUs(UINT32 us);
```

#### Function

Blocking subtlety delay

#### Parameters

* us: delay time, unit subtlety

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

Blocking wait event

#### Parameters

* hTask: task handle, return value of `OS_CreateTask`
* pEvent: event value, parameters from `OS_SendEvent`
* nTimeOut: is waiting for the timeout time. At present, it only supports blocking wait. The value must be `OS_WAIT_FOREVER`.

#### Return

* successful waiting for the event

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

Send an event to a task

#### Parameters

* hTask: task handle, return value of `OS_CreateTask`
* data sent by the pEvent: event (pointer)
* nTimeOut: timeout time, currently supporting blocking wait only, the value must be `OS_WAIT_FOREVER`.
* nOption: event option, `OS_EVENT_PRI_NORMAL`: general priority, `OS_EVENT_PRI_URGENT`: emergency priority.

#### Return

* whether the event was sent to success

---

### OS_ResetEventQueue

```c
bool OS_ResetEventQueue(
    HANDLE hTask);
```

#### Function

Reset the event queue

#### Parameters

Reset event queue * hTask: task handle, return value of `OS_CreateTask`.

#### Return

* whether to reset the success

---

### OS_IsEventAvailable

```c
bool OS_IsEventAvailable(
    HANDLE hTask);
```

#### Function

Judge whether or not a task has an event to be received

#### Parameters

* hTask: task handle, return value of `OS_CreateTask`

#### Return

* whether there is an event to be received

---

### OS_Malloc 

```c
PVOID OS_Malloc (UINT32 nSize);
```

#### Function

Dynamically allocated memory

#### Parameters

* nSize: dynamically allocates memory length, the unit is bytes

#### Return

* dynamically allocate the first address of the memory block. If the allocation fails, it will return to `NULL`.

---

### OS_Realloc

```c
PVOID OS_Realloc(VOID *ptr, UINT32 nSize);
```

#### Function

Redistribution of memory

#### Parameters

* ptr: dynamically allocated memory block first address
* nSize: new dynamically allocated memory block length

#### Return

* the first address of the memory block allocated successfully. If `NULL`, the allocation fails.

---

### OS_Free   

```c
bool  OS_Free   (PVOID pMemBlock);
```

#### Function

Release dynamically allocated memory

#### Parameters

* pMemBlock: dynamically allocated memory block first address

#### Return

* whether to release success or not

---

### OS_GetHeapUsageStatus

```c
bool OS_GetHeapUsageStatus(OS_Heap_Status_t* pOsHeapStatus);
```

#### Function

Get the use of the heap

#### Parameters

* pOsHeapStatus: reactor usage

#### Return

* whether to get heap status success

---

### OS_CreateSemaphore

```c
HANDLE OS_CreateSemaphore(
    UINT32 nInitCount // Specify the initial count of the semaphore
    );
```

#### Function

Create a semaphore

#### Parameters

* nInitCount: semaphore initialization value, 0 indicates that the resource is occupied, n indicates that there are n resource values, each wait will wait for the value of the resource and reduce one, and the release operation will add the value of the resource to one

#### 返回值

* semaphore handle, if failed, return to `NULL`

---

### OS_DeleteSemaphore

```c
bool OS_DeleteSemaphore(
    HANDLE hSem);
```

#### Function

Deleting the semaphore

#### Parameters

* hSem: semaphore handle, return value of `OS_CreateSemaphore`.

#### Return

* whether the signal is deleted or not

---

### OS_WaitForSemaphore

```c
bool OS_WaitForSemaphore(
    HANDLE hSem,    // Specify the handle to a counting semaphore
    UINT32 nTimeOut // the time-out value
    );
```

#### Function

Wait for the semaphore to know that the resource value is greater than 0 and reduce the resource value.

#### Parameters

* hSem: semaphore handle, return value of `OS_CreateSemaphore`.

* nTimeOut: timeout value, temporarily reserved, or `OS_WAIT_FOREVER`

#### Return

* whether the amount of signal (resource value) is successfully obtained

---

### OS_ReleaseSemaphore

```c
bool OS_ReleaseSemaphore(
    HANDLE hSem //Specify the counting semaphore
    );
```

#### Function

Release the semaphore, that is, the value of the resource plus one

#### Parameters

* hSem: semaphore handle, return value of `OS_CreateSemaphore`.

#### Return

* whether to release the signal (resource value) success

---

### OS_CreateMutex

```c
HANDLE OS_CreateMutex(void);
```

#### Function

Create a mutual exclusion

#### Parameters

None

#### Return

* mutex handle, if failed, return to `NULL`

---

### OS_DeleteMutex

```c
void OS_DeleteMutex(HANDLE mutex);
```

#### Function

Deleting mutual exclusion

#### Parameters

* mutex: mutual exclusion handle, return value of `OS_CreateMutex`.

#### Return

None

---

### OS_LockMutex

```c
void OS_LockMutex(HANDLE mutex);
```

#### Function

Lock mutual exclusion, that is, occupying resources

#### Parameters

* mutex: mutual exclusion handle, return value of `OS_CreateMutex`.

#### Return

None

---

### OS_UnlockMutex

```c
void OS_UnlockMutex(HANDLE mutex);
```

#### Function

Release mutual exclusion, that is, release resources

#### Parameters

* mutex: mutual exclusion handle, return value of `OS_CreateMutex`.

#### Return
None

---

### OS_CALLBACK_FUNC_T

```c
typedef void (*OS_CALLBACK_FUNC_T)(void* param);
```

#### Function

Callback function, defined by the user

#### Parameters

* param: User incoming parameters

#### Return

None

---

### OS_StartCallbackTimer

```c
bool OS_StartCallbackTimer(HANDLE hTask, UINT32 ms, OS_CALLBACK_FUNC_T callback, void* param);
```

#### Function

Start the software timer and set the callback function when the time is set.

#### Parameters

* hTask: task handle, which must include `OS_WaitEvent` function call (for example, the main task), otherwise the callback will not be triggered.
* ms: timing time
* callback: callback function
* param: passes the parameters of the callback function

#### Return

* to create a timer success

---

### OS_StopCallbackTimer

```c
bool OS_StopCallbackTimer(HANDLE hTask, OS_CALLBACK_FUNC_T callback, void *param);
```

#### Function

Stop the software timer

#### Parameters

* hTask: task handle, which must include `OS_WaitEvent` function call (for example, the main task), otherwise the callback will not be triggered.

* callback: callback function

* param: passes the parameters of the callback function

#### Return

* cessation of the success of the timer

---

### OS_QueryCallbackTimer

```c
uint32_t OS_QueryCallbackTimer(HANDLE hTask, OS_CALLBACK_FUNC_T callback, void *param);
```

#### Function

How much time is left to end the query software timer

#### Parameters

* hTask: task handle, which must include `OS_WaitEvent` function call (for example, the main task), otherwise the callback will not be triggered.

* callback: callback function

* param: passes the parameters of the callback function

#### Return

* the timer is out of the rest of the time

---







