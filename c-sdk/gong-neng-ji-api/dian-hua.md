CALL 电话语音电话
====

电话语音支持语音通话即DTMF功能

例程：[demo/call](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/call/src/demo_call.c)


## 枚举类型

### CALL_DTMF_Gain_t

DTMF 增益

```c
typedef enum
{
    CALL_DTMF_GAIN_0dB = 0,
    CALL_DTMF_GAIN_m3dB,
    CALL_DTMF_GAIN_m9dB,
    CALL_DTMF_GAIN_m15dB,

    CALL_DTMF_GAIN_MAX
} CALL_DTMF_Gain_t;
```

---

### Power_On_Cause_t

错误信息

```c
typedef enum{
    CALL_ERROR_NONE              = 0  ,
    CALL_ERROR_NO_DIAL_TONE           ,  //TERMINAL USER HAS POWERED OFF
    CALL_ERROR_BUSY                   ,  //TERMINAL USER RETURN UDUB
    CALL_ERROR_NO_ANSWER              ,  //TERMINAL USER DOESN'T ANSWER THE CALL
    CALL_ERROR_NO_CARRIER             ,  //remote hang up
    CALL_ERROR_NETWORK_TIME_OUT       ,
    CALL_ERROR_LINK_IS_BEINDG_BUILT   ,  //link is being built, can not hang up
    CALL_ERROR_UNKOWN                 ,
    
    CALL_ERROR_MAX
}CALL_Error_t;
```

---

## 结构体

### CALL_Status_t

电话状态信息

```c
typedef struct {
    uint8_t index;
    uint8_t direction;
    uint8_t status;
    uint8_t mode;
    bool    multiparty;
    char    number[22];
    uint8_t numberType;
}CALL_Status_t;
```

## 功能函数


### CALL_Dial

```c
bool CALL_Dial(const char* number);
```

##### 功能

拨打电话

##### 参数

* number：号码

##### 返回值

* 是否成功

---

### CALL_HangUp

```c
bool CALL_HangUp();
```

##### 功能

挂电话

##### 参数

无

##### 返回值

* 是否成功挂断电话

---

### CALL_Answer

```c
bool CALL_Answer();
```

##### 功能

接听电话

##### 参数

无

##### 返回值

是否成功接听电话

---

### CALL_DTMF

```c
bool CALL_DTMF(char dtmf, CALL_DTMF_Gain_t attenuation, uint8_t duration, uint8_t speakerGain, bool send);
```

##### 功能

拨DTMF，如果接收到对方哦DTMF，则会产生事件`API_EVENT_ID_CALL_DTMF`，param1是值，具体参考api_event.h

##### 参数

* dtmf:DTMF值，数值范围： '0'~'9', '#', '*', 'A'~'D'
* attenuation：衰减率
* speakerGain：喇叭回响增益
* send:是否发送出去，如果为false，只回响不实际发送出去

##### 返回值

* 是否成功拨DTMF

---

### CALL_Status

```c
bool CALL_Status(CALL_Status_t** callStatus, uint8_t* count);
```

##### 功能

查询电话状态信息，注意在调用后要调用OS_free对内存进行释放，比如：
```c
    CALL_Status_t* callStatus = NULL;
    uint8_t count;
    bool ret = CALL_Status(&callStatus,count);
    uint8_t i;
    if(ret)
    {
        for(i=0;i<count;++i)
        {
            Trace(1,"index:%d,direction:%d,status:%d,mode:%d,mpty:%d,number:%s,number type:%d",
                        callStatus[i].index,callStatus[i].direction,callStatus[i].status,callStatus[i].mode,
                        callStatus[i].multiparty,callStatus[i].number,callStatus[i].numberType);
        }
        OS_Free(callStatus);
    }
```

##### 参数

* callStatus: 指向存放状态信息数据块的指针
* count: 电话状态信息个数

##### 返回值

* 是否成功获取到电话状态信息，如果成功返回true，否则为false，

---