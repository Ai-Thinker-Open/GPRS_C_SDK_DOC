SMS
====

Short message function


example:[demo/sms](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/sms/src/demo_sms.c)


## Macro definition

### SMS_PHONE_NUMBER_MAX_LEN

The longest length of the telephone number

```c
#define  SMS_PHONE_NUMBER_MAX_LEN  21
```

### SMS_BODY_MAX_LEN

The longest length of message message body (bytes)

```c
#define  SMS_BODY_MAX_LEN  176
```


## Enumerated type

### SMS_Format_t

SMS format, currently only supporting text format

```c
typedef enum{
    // SMS_FORMAT_PDU  = 0, // not support now
    SMS_FORMAT_TEXT = 1, // default
    SMS_FORMAT_MAX
} SMS_Format_t;
```

---

### SMS_Error_t

error message

```c
typedef enum{
    SMS_ERROR_DECODE_ERROR = 0,
    SMS_ERROR_MAX
} SMS_Error_t;
```

---

### SMS_Encode_Type_t

Encoding format, including ASCII and Unicode

```c
typedef enum{
    SMS_ENCODE_TYPE_ASCII  = 0,
    SMS_ENCODE_TYPE_UNICODE   ,
    SMS_ENCODE_TYPE_MAX
} SMS_Encode_Type_t;
```

---

### SMS_Number_Type_t

Number area type

```c
typedef enum{
    SMS_NUMBER_TYPE_UNKNOWN         = 129 ,
    SMS_NUMBER_TYPE_INTERNATIONAL   = 145 ,
    SMS_NUMBER_TYPE_NATIONAL        = 161
} SMS_Number_Type_t; //SMS_Server_Center_Addr_Type_t;
```

---

### SMS_Status_t

SMS status

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

SMS storage location

```c
typedef enum{
    SMS_STORAGE_FLASH    = 1,
    SMS_STORAGE_SIM_CARD = 2,
    SMS_STORAGE_MAX
} SMS_Storage_t;
```

---

## Struct

### SMS_Parameter_t

Short message parameter

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

SMS center information

```c
typedef struct{
    char*          addr;
    SMS_Number_Type_t addrType;
} SMS_Server_Center_Info_t;
```

---

### SMS_Message_Info_t

Short message

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

Short message storage information

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


## Function


### SMS_SetFormat

```c
bool SMS_SetFormat(SMS_Format_t format, SIM_ID_t simID);
```

#### Function

Setting short message format

#### Parameters

* format: format, currently only support character format

* simID: card ID, only `SIM0`

#### Return

* whether or not it is successful

---

### SMS_SetParameter

```c
bool SMS_SetParameter(SMS_Parameter_t* smsParameter,SIM_ID_t simID);
```

#### Function

Setting short message parameters

#### Parameters

* smsParameter: short message parameters
* simID: card ID, only `SIM0`

#### Return

* whether or not it is successful

---

### SMS_SendMessage

```c
bool SMS_SendMessage(const char* phoneNumber, const uint8_t* message,  uint8_t length, SIM_ID_t simID);
```

#### Function

Send text messages

#### Parameters

* phoneNumber: telephone number
* message: note content, attention must be Unicode encoding, `SMS_LocalLanguage2Unicode` conversion can be used.
* length: short message length (bytes)
* simID: is fixed to `SIM0`

#### Return

* whether or not it is successfully sent

---

### SMS_SetServerCenterInfo

```c
bool SMS_SetServerCenterInfo(SMS_Server_Center_Info_t* serverCenterInfo);
```

#### Function

Setting up SMS center information

#### Parameters

* serverCenterInfo：SMS center information

#### Return

* whether SMS center information is successfully set up

---

### SMS_GetServerCenterInfo

```c
bool SMS_GetServerCenterInfo(SMS_Server_Center_Info_t* serverCenterInfo);
```

#### Function

Getting SMS center information

#### Parameters

* serverCenterInfo：SMS center information

#### Return

* whether or not a message center information is successfully obtained

---

### SMS_ListMessageRequst

```c
bool SMS_ListMessageRequst(SMS_Status_t smsStatus,SMS_Storage_t storage);
```

#### Function

Request to list saved SMS, SMS message will produce `API_EVENT_ID_SMS_LIST_MESSAGE` by event. See [api_event.h](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/include/api_inc/api_event.h)

#### Parameters

* smsStatus：Choose which types of SMS to list, such as listing only unread messages `SMS_STATUS_UNREAD`

#### Return

* whether or not a message is successfully requested to read short messages

---

### SMS_DeleteMessage

```c
bool SMS_DeleteMessage(uint8_t index,SMS_Status_t status,SMS_Storage_t storage);
```

#### Function

Delete saved SMS

#### Parameters

* index: the subscript of the saved SMS
* storage: select the storage location, flash or SIM card

#### Return

* whether or not to delete messages successfully

---

### SMS_GetStorageInfo

```c
bool SMS_GetStorageInfo(SMS_Storage_Info_t* storageInfo, SMS_Storage_t storage);
```

#### Function

Get message storage information

#### Parameters

* storageInfo: storage information
* storage: select the location of the storage to query

#### Return

* whether or not the query is successful

---

### SMS_SetNewMessageStorage

```c
bool SMS_SetNewMessageStorage(SMS_Storage_t storage);
```

#### Function

Select the location of the newly received message store

#### Parameters

* storage：The location of the new message storage

#### Return

* Whether the new message storage location is set up successfully

---

### SMS_GetCharset

```c
const char* SMS_GetCharset(Charset_t charset);
```

#### Function

Getting the ASCII name of a specific character set

#### Parameters

* charset：character set

#### Return

* The ASCII name of the corresponding character set

---

### SMS_Unicode2LocalLanguage

```c
bool SMS_Unicode2LocalLanguage(uint8_t* unicodeIn, uint16_t unicodeLenIn, Charset_t localLanguage, uint8_t** localOut, uint32_t* localLenOut);
```

#### Function

Unicode to local language

#### Parameters

* unicodeIn:unicode encoded messages
* unicodeLenIn:unicode encoded message length
* localLanguage: the local language to be converted into
* localOut: converts a good local language
* localLenOut: the converted local language length

#### Return

* Whether or not the conversion is successful

---

### SMS_LocalLanguage2Unicode

```c
bool SMS_LocalLanguage2Unicode(uint8_t* localIn, uint16_t localLenIn, Charset_t localLanguage, uint8_t** unicodeOut, uint32_t* unicodeLenOut);
```

#### Function

Local language conversion to unicode coding

#### Parameters

* localIn: local language message body
* localLenIn: the length of the local language message body
* localLanguage: local coding format
* unicodeOut: a converted Unicode encoded message body
* unicodeLenOut: the length of the converted Unicode encoding message body.


#### Return

* Whether or not the conversion is successful

---






