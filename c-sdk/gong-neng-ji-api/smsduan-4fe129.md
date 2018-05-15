SMS 短信功能
====

常用短信功能


例程：[demo/sms](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/sms/src/demo_sms.c)


## 宏定义

### SMS_PHONE_NUMBER_MAX_LEN

电话号码最长长度

```c
#define  SMS_PHONE_NUMBER_MAX_LEN  21
```

### SMS_BODY_MAX_LEN

短信消息体最长长度（字节）

```c
#define  SMS_BODY_MAX_LEN  176
```


## 枚举类型

### SMS_Format_t

短信格式，目前仅支持文本格式

```c
typedef enum{
    // SMS_FORMAT_PDU  = 0, // not support now
    SMS_FORMAT_TEXT = 1, // default
    SMS_FORMAT_MAX
} SMS_Format_t;
```

---

### SMS_Error_t

错误信息

```c
typedef enum{
    SMS_ERROR_DECODE_ERROR = 0,
    SMS_ERROR_MAX
} SMS_Error_t;
```

---

### SMS_Encode_Type_t

编码格式，包括ascii和unicode

```c
typedef enum{
    SMS_ENCODE_TYPE_ASCII  = 0,
    SMS_ENCODE_TYPE_UNICODE   ,
    SMS_ENCODE_TYPE_MAX
} SMS_Encode_Type_t;
```

---

### SMS_Number_Type_t

号码地区类型

```c
typedef enum{
    SMS_NUMBER_TYPE_UNKNOWN         = 129 ,
    SMS_NUMBER_TYPE_INTERNATIONAL   = 145 ,
    SMS_NUMBER_TYPE_NATIONAL        = 161
} SMS_Number_Type_t; //SMS_Server_Center_Addr_Type_t;
```

---

### SMS_Status_t

短信状态

```c
typedef enum{
    SMS_STATUS_UNREAD                    = 0x01 ,
    SMS_STATUS_READ                      = 0x02 ,
    SMS_STATUS_UNSENT                    = 0x04 ,
    SMS_STATUS_SENT_NOT_SR_REQ           = 0x08 ,
    SMS_STATUS_SENT_SR_REQ_NOT_RECV      = 0x10 ,
    SMS_STATUS_SENT_SR_REQ_NOT_STORE     = 0x20 ,
    SMS_STATUS_SENT_SR_REQ_RECV_STORE    = 0x40 ,
    SMS_STATUS_ALL                       = 0x80 ,
    SMS_STATUS_MAX
} SMS_Status_t;
```

---

### SMS_Storage_t

短信储存位置

```c
typedef enum{
    SMS_STORAGE_FLASH    = 1,
    SMS_STORAGE_SIM_CARD = 2,
    SMS_STORAGE_MAX
} SMS_Storage_t;
```

---

## 结构体类型

### SMS_Parameter_t

短信参数

```c
typedef struct
{
    uint8_t fo;  // default: 17
    uint8_t vp;  // default: 167
    uint8_t pid; // default: 0
    uint8_t dcs; // default: 0:English 7bit, 4:English 8 bit, 8:Unicode 2 Bytes(UCS2)
} SMS_Parameter_t;
```

---

### SMS_Server_Center_Info_t

短信中心信息

```c
typedef struct{
    char*          addr;
    SMS_Number_Type_t addrType;
} SMS_Server_Center_Info_t;
```

---

### SMS_Message_Info_t

短消息

```c
typedef struct{
    //header
    uint8_t           index;
    SMS_Status_t      status;
    SMS_Number_Type_t phoneNumberType;
    char              phoneNumber[SMS_PHONE_NUMBER_MAX_LEN];
    RTC_Time_t        time;
    
    //body
    uint16_t          dataLen;
    uint8_t*          data;
} SMS_Message_Info_t;
```

---

### SMS_Storage_Info_t

短消息储存信息

```c
typedef struct{
    uint16_t used;
    uint16_t total;
    uint16_t unReadRecords;
    uint16_t readRecords;
    uint16_t sentRecords;
    uint16_t unsentRecords;
    uint16_t unknownRecords;
    uint16_t storageId;
} SMS_Storage_Info_t;
```

---


## 功能函数


### SMS_SetFormat

```c
bool SMS_SetFormat(SMS_Format_t format, SIM_ID_t simID);
```

##### 功能

设置短信格式

##### 参数

* format:格式，目前仅支持字符格式
* simID：卡ID，仅支持`SIM0`

##### 返回值

* 是否成功

---

### SMS_SetParameter

```c
bool SMS_SetParameter(SMS_Parameter_t* smsParameter,SIM_ID_t simID);
```

##### 功能

设置短信参数

##### 参数

* smsParameter:短信参数
* simID:卡ID，仅支持`SIM0`

##### 返回值

* 是否成功

---

### SMS_SendMessage

```c
bool SMS_SendMessage(const char* phoneNumber, const uint8_t* message,  uint8_t length, SIM_ID_t simID);
```

##### 功能

发送短信

##### 参数

* phoneNumber：电话号码
* message：短信内容，注意必须是unicode编码，可以用`SMS_LocalLanguage2Unicode`转换
* length：短信长度（字节）
* simID:固定为`SIM0`

##### 返回值

* 是否成功发送

---

### SMS_SetServerCenterInfo

```c
bool SMS_SetServerCenterInfo(SMS_Server_Center_Info_t* serverCenterInfo);
```

##### 功能

设置短信中心信息

##### 参数

* serverCenterInfo：短信中心信息

##### 返回值

* 是否成功设置短信中心信息

---

### SMS_GetServerCenterInfo

```c
bool SMS_GetServerCenterInfo(SMS_Server_Center_Info_t* serverCenterInfo);
```

##### 功能

获取短信中心信息

##### 参数

* serverCenterInfo：短信中心信息

##### 返回值

* 是否成功获取短信中心信息

---

### SMS_ListMessageRequst

```c
bool SMS_ListMessageRequst(SMS_Status_t smsStatus,SMS_Storage_t storage);
```

##### 功能

请求列出保存的短信，短信信息会以事件的方式产生`API_EVENT_ID_SMS_LIST_MESSAGE`，具体参数看[api_event.h](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/include/api_inc/api_event.h)

##### 参数

* smsStatus：选择列出哪些类型的短信，比如只列出未读消息`SMS_STATUS_UNREAD`

##### 返回值

* 是否成功请求读取短信

---

### SMS_DeleteMessage

```c
bool SMS_DeleteMessage(uint8_t index,SMS_Status_t status,SMS_Storage_t storage);
```

##### 功能

删除保存的短信

##### 参数

* index：保存的短信的下标
* storage：选择储存位置，flash还是SIM卡

##### 返回值

* 是否成功删除短信

---

### SMS_GetStorageInfo

```c
bool SMS_GetStorageInfo(SMS_Storage_Info_t* storageInfo, SMS_Storage_t storage);
```

##### 功能

获取短信储存信息

##### 参数

* storageInfo：储存信息
* storage：选择要查询的储存位置

##### 返回值

* 是否成功查询

---

### SMS_SetNewMessageStorage

```c
bool SMS_SetNewMessageStorage(SMS_Storage_t storage);
```

##### 功能

选择新收到的消息储存的位置

##### 参数

* storage：新消息储存的位置

##### 返回值

* 是否成功设置新消息储存位置

---

### SMS_GetCharset

```c
const char* SMS_GetCharset(Charset_t charset);
```

##### 功能

获取特定字符集的ascii名称

##### 参数

* charset：字符集

##### 返回值

* 对应字符集的ascii名称

---

### SMS_Unicode2LocalLanguage

```c
bool SMS_Unicode2LocalLanguage(uint8_t* unicodeIn, uint16_t unicodeLenIn, Charset_t localLanguage, uint8_t** localOut, uint32_t* localLenOut);
```

##### 功能

unicode转本地语言

##### 参数

* unicodeIn：unicode编码的消息
* unicodeLenIn：unicode编码的消息长度
* localLanguage：要转换成的本地语言
* localOut:转换好的本地语言
* localLenOut：转换好的本地语言长度

##### 返回值

* 是否成功转换

---

### SMS_LocalLanguage2Unicode

```c
bool SMS_LocalLanguage2Unicode(uint8_t* localIn, uint16_t localLenIn, Charset_t localLanguage, uint8_t** unicodeOut, uint32_t* unicodeLenOut);
```

##### 功能

本地语言转unicode编码

##### 参数

* localIn：本地语言消息体
* localLenIn：本地语言消息体长度
* localLanguage：本地编码格式
* unicodeOut：转换好的unicode编码消息体
* unicodeLenOut：转换好的unicode编码消息体长度


##### 返回值

* 是否成功转换

---






