CALL
====

Call communication and DTMF support

example：[demo/call](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/call/src/demo_call.c)


## Enumerated type

### CALL_DTMF_Gain_t

DTMF gain

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

error info

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


## Function


### CALL_Dial

```c
bool CALL_Dial(const char* number);
```

#### Function

make a phone call

#### Parameters

* number：the number to make a call

#### Return

* make call succeed or not

---

### CALL_HangUp

```c
bool CALL_HangUp();
```

#### Function

Hang up call

#### Parameters

None

#### Return

* Hang up call succeed or not

---

### CALL_Answer

```c
bool CALL_Answer();
```

#### Function

Answer a phone call

#### Parameters

None

#### Return

* succeed answer a call or not

---

### CALL_DTMF

```c
bool CALL_DTMF(char dtmf, CALL_DTMF_Gain_t attenuation, uint8_t duration, uint8_t speakerGain, bool send);
```

#### Function

Make a DTMF tone, if received a DTMF tone , event `API_EVENT_ID_CALL_DTMF` will be be generated, parameters refer to `api_event.h`

#### Parameters

* dtmf:DTMF tone value： '0'~'9', '#', '*', 'A'~'D'
* attenuation：attenuation 
* speakerGain：speaker gain
* send: send DTMF tone and play in speaker if set to true, or just play in speaker and not send

#### Return

* Succeed to make a DTMF tone or not

---

### CALL_Status

```c
bool CALL_Status(CALL_Status_t** callStatus, uint8_t* count);
```

##### Function

query call infomation while make a call or received call, you must call `OS_Free()` to free memory later
e.g.
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

##### Parameters

* callStatus: The pointer to the call infomation, and value is NULL
* count: call infomation count

##### Return

* return true if got call infomation, or false

---

