GPRS related and base station information
====

After the module is powered up, it will automatically register the GSM network. After successful registration, you can call and send SMS.
To achieve the Internet function, we need to activate the GPRS network. The basic knowledge of GPRS has been explained in the basic knowledge part of this article.

We know that activating the GPRS network requires two steps: attachment and context activation.
Moreover, these two steps have priority in order to first attach and then activate context.

Network related events and parameters can be find in [api_event.h](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/include/api_inc/api_event.h)


examples:[demo/network](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/network/src/demo_network.c)


## Macro definition

### PDP_APN_MAX_LENGTH

APN max length

```c
#define PDP_APN_MAX_LENGTH         64
```

---

### PDP_USER_NAME_MAX_LENGTH

PDP username max length

```c
#define PDP_USER_NAME_MAX_LENGTH   64
```

---

### PDP_USER_PASSWD_MAX_LENGTH

PDP user password

```c
#define PDP_USER_PASSWD_MAX_LENGTH 64
```

---


## Struct

### Network_Status_t

Network status

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

PDP context parameters 

```c
typedef struct{
    char    apn[PDP_APN_MAX_LENGTH];                     // Access Point Name
    char    userName[PDP_USER_NAME_MAX_LENGTH];
    char    userPasswd[PDP_USER_PASSWD_MAX_LENGTH];
}Network_PDP_Context_t;
```

---

### Network_Location_t

Base stattion information

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

Network error information

```c
typedef enum{
    NETWORK_ERROR_NONE = 0      ,
    NETWORK_ERROR_MAX
} Network_Error_t;
```

---


## Function


### Network_Callback_Func_t

```c
typedef void (*Network_Callback_Func_t)(Network_Status_t status);
```

#### Function

Network callback, defined by user

#### Parameters

* status：Network status 

#### Return

None

---

### Network_SetStatusChangedCallback

```c
void Network_SetStatusChangedCallback(Network_Callback_Func_t callback);
```

#### Function

Setting up the callback function of the network, besides using the callback function, can also receive events from the bottom of the main task(recommend).

#### Parameters

* callback: Network status callback function

#### Return

None

---

### Network_StartAttach

```c
bool Network_StartAttach();
```

#### Function

Start attach network

#### Parameters

None

#### Return

* true: successful execution of attached network. After successful attachment, events will occur. False: failure of attachment may be attached or unable to be attached.

---

### Network_StartDetach

```c
bool Network_StartDetach();
```

#### Function

Detach network

#### Parameters

None

#### Return

* true：success，false：fail

---

### Network_StartActive

```c
bool Network_StartActive(Network_PDP_Context_t context);
```

#### Function

Start context activation

#### Parameters

* context：PDP context settings

#### Return

* If activation is successful, if it fails, check the signal and whether the network has been attached.

---

### Network_StartDeactive

```c
bool Network_StartDeactive(uint8_t contextID);
```

#### Function

Deactive context

#### Parameters

* contextID：Context ID, reserved, fixed to 1

#### Return

* return true execute success, or false, Whether activation is successful or not will produce an event.

---

### Network_GetIp

```c
bool Network_GetIp(char* ip, uint8_t size);
```

#### Function

Get GPRS ip address, Note that the IP address here is not the public network address, but the LAN address.

#### Parameters

* ip：ip address
* size：ip string length

#### Return

* Is succeed to get ip

---

### Network_GetCellInfoRequst

```c
bool Network_GetCellInfoRequst();
```

#### Function

Get base station information request, cell information will report by event `API_EVENT_ID_NETWORK_CELL_INFO`

#### Parameters

None

#### Return

* Is get base station information success

---

