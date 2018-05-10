GPRS相关及基站信息获取
====

模组上电后会自动注册GSM网络，注册成功后便可以通话、发送短信，
要实现上网功能则还需要激活GPRS网络，GPRS的基本知识在本文基础知识部分已经阐述了，这里边不再进行说明。

我们知道激活GPRS网络需要进行附着和上下文激活两个步骤，
而且这两个步骤有先后顺序，先进行附着再进行上下文激活。
网络相关的事件及参数可以在[api_event.h](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/include/api_inc/api_event.h)中找到


例程：[demo/network](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/network/src/demo_network.c)


## 宏定义

### PDP_APN_MAX_LENGTH

APN最长长度

```c
#define PDP_APN_MAX_LENGTH         64
```

---

### PDP_USER_NAME_MAX_LENGTH

PDP用户名最长长度

```c
#define PDP_USER_NAME_MAX_LENGTH   64
```

---

### PDP_USER_PASSWD_MAX_LENGTH

PDP用户密码最长长度

```c
#define PDP_USER_PASSWD_MAX_LENGTH 64
```

---


## 结构体类型

### Network_Status_t

网络状态

```c
typedef enum{
    NETWORK_STATUS_OFFLINE = 0      ,
    NETWORK_STATUS_REGISTERING      ,
    NETWORK_STATUS_REGISTERED       ,
    NETWORK_STATUS_DETACHED         ,
    NETWORK_STATUS_ATTACHING        ,
    NETWORK_STATUS_ATTACHED         ,
    NETWORK_STATUS_DEACTIVED        ,
    NETWORK_STATUS_ACTIVATING       ,
    NETWORK_STATUS_ACTIVATED        ,
    NETWORK_STATUS_ATTACH_FAILED    ,
    NETWORK_STATUS_ACTIVATE_FAILED  ,
    NETWORK_STATUS_MAX
}Network_Status_t;
```

---

### Network_PDP_Context_t

PDP上下文参数设置

```c
typedef struct{
    char    apn[PDP_APN_MAX_LENGTH];                     // Access Point Name
    char    userName[PDP_USER_NAME_MAX_LENGTH];
    char    userPasswd[PDP_USER_PASSWD_MAX_LENGTH];
}Network_PDP_Context_t;
```

---

### Network_Location_t

基站信息

```c
typedef struct 
{
    uint8_t  sMcc[3];      //移动国家号码，中国为460
    uint8_t  sMnc[3];      //移动网号，中国移动00，中国联通01
    uint16_t sLac;         //位置区号码
    uint16_t sCellID;      //小区识别码
    uint8_t  iBsic;        //基站识别码
    int8_t   iRxLev;       //接收报告信号强度
    uint8_t  iRxLevSub;    //接收报告信号强度小数部分
    uint16_t nArfcn;       //基站频点
} Network_Location_t;
```

---

### Network_Error_t

网络错误信息

```c
typedef enum{
    NETWORK_ERROR_NONE = 0      ,
    NETWORK_ERROR_MAX
} Network_Error_t;
```

---


## 功能函数


### Network_Callback_Func_t

```c
typedef void (*Network_Callback_Func_t)(Network_Status_t status);
```

##### 功能

网络回调函数，由用户定义

##### 参数

* status：网络状态

##### 返回值

无

---

### Network_SetStatusChangedCallback

```c
void Network_SetStatusChangedCallback(Network_Callback_Func_t callback);
```

##### 功能

设置网络回调函数,除了使用回调函数，也可以在主任务接收来自底层的事件（建议）

##### 参数

* callback:网路状态回调函数

##### 返回值

无

---

### Network_StartAttach

```c
bool Network_StartAttach();
```

##### 功能

开始附着网络

##### 参数

无

##### 返回值

* true：成功执行附着网络，附着成功后会产生事件，false：附着失败，可能是已经附着或者无法附着

---

### Network_StartDetach

```c
bool Network_StartDetach();
```

##### 功能

去附着网络

##### 参数

无

##### 返回值

* true：执行去附着成功，false：执行去附着失败

---

### Network_StartActive

```c
bool Network_StartActive(Network_PDP_Context_t context);
```

##### 功能

开始上下文激活

##### 参数

* context：上下文设置，根据不同的运营商和网络设置

##### 返回值

* 执行激活是否成功，如果失败，请检查信号以及是否已经附着了网络

---

### Network_StartDeactive

```c
bool Network_StartDeactive(uint8_t contextID);
```

##### 功能

上下文去激活

##### 参数

* contextID：上下文ID，这里作保留，目前传入值始终为1

##### 返回值

* 去激活是否成功执行，具体是否成功会产生事件

---

### Network_GetIp

```c
bool Network_GetIp(char* ip, uint8_t size);
```

##### 功能

获得GPRS ip地址，注意这里的ip地址不是公网地址，而是局域网地址

##### 参数

* ip：获取到的ip地址点分十进制表示
* size：字符串长度

##### 返回值

* 是否成功获取ip地址

---

### Network_GetCellInfoRequst

```c
bool Network_GetCellInfoRequst();
```

##### 功能

发起获取附近基站信息请求，信息会以事件（`API_EVENT_ID_NETWORK_CELL_INFO`）产生

##### 参数

无

##### 返回值

* 发起获取基站信息请求是否成功

---

