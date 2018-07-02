Gizwits
=====

Gizwits makes development more efficient and easy, see more infomation about gizwits from gizwits official website

example:[demo/gizwits](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/gizwits/src/demo_gizwits.c)



## enum

#### Gizwits_Action_t

action number

```c
typedef enum{
    GIZWITS_FIXED_LENGTH_ACTION_CONTROL			   =  0x01 ,
    GIZWITS_FIXED_LENGTH_ACTION_READ_STATUS		   =  0x02 ,
    GIZWITS_FIXED_LENGTH_ACTION_READ_STATUS_ACK	   =  0x03 ,
    GIZWITS_FIXED_LENGTH_ACTION_REPORT_STATUS	   =  0x04 ,
    GIZWITS_FIXED_LENGTH_ACTION_TRANS_RECV		   =  0x05 ,
    GIZWITS_FIXED_LENGTH_ACTION_TRANS_SEND		   =  0x06 ,
    GIZWITS_FIXED_LENGTH_ACTION_PUSH_OTA	       =  0xfe ,

    GIZWITS_VARIABLE_LENGTH_ACTION_CONTROL			 = 0x11 ,
    GIZWITS_VARIABLE_LENGTH_ACTION_READ_STATUS		 = 0x12 ,
    GIZWITS_VARIABLE_LENGTH_ACTION_READ_STATUS_ACK	 = 0x13 ,
    GIZWITS_VARIABLE_LENGTH_ACTION_REPORT_STATUS	 = 0x14 ,
    GIZWITS_VARIABLE_LENGTH_ACTION_TRANS_RECV		 = 0x15 ,
    GIZWITS_VARIABLE_LENGTH_ACTION_TRANS_SEND		 = 0x16 ,
    GIZWITS_VARIABLE_LENGTH_ACTION_PUSH_OTA	         = 0xfe ,

    GIZWITS_ACTION_MAX
}Gizwits_Action_t;
```


## Struct

### Gizwits_Config_t

Gizwits configuration, you must config `imei`,`pk`,`pk_secret`,`alive`，pk and
pk_secret can be found in your gizwits app in gizwits website

```c
typedef struct 
{
	char	   imei[32];
	char	   did[32];
	char	   passcode[16];
	char	   pk[48];
	char	   pk_secret[48];
	char	   hard_version[16];
	char	   soft_version[16];
    uint16_t   alive;
}Gizwits_Config_t; 
```

### Gizwits_t

Object of gizwits 

```c
typedef struct{
    Gizwits_Config_t* config;
    void*    cloud;
    char*    otaUrl;
}Gizwits_t;
```




## Function


### OnReceivedOnePacket_Callback_t

```c
typedef void (*OnReceivedOnePacket_Callback_t)(Gizwits_t* gizwits, Gizwits_Action_t action,uint8_t* data, int len);
```

##### function

数据接收回调函数

##### Parameters

* gizwits: Object of gizwits
* action: action of gizwits
* data: data received
* len: data length of received

##### Return

None

---

### GIZWITS_GetConfig

```c
 bool GIZWITS_GetConfig(Gizwits_Config_t* config, const char* path);
```

##### function

Get the configuratio of gizwts

##### Parameters

* config: configuration of gizwts
* path: config file path,e.g. `"/gizwits_config.conf"`

##### Return

* Is get config success

---

### GIZWITS_Connect

```c
int GIZWITS_Connect(Gizwits_t* gizwits, Gizwits_Config_t* config, const char* configPath);
```

##### function

Connect gizwits,if no did,it will register, or just log in

##### Parameters

* gizwits: Object of gizwits
* config: Configuration of gizwits
* configPath: Configuration file path of gizwits

##### Return

* Return 0 if succeed connect to gizwits, or return error code

---

### GIZWITS_Send

```c
int GIZWITS_Send(Gizwits_t* gizwits, Gizwits_Action_t action, uint8_t* data, int len);
```

##### function

Publish data to gizwits

##### Parameters

* gizwits: Object of gizwits
* action: Action
* data: Data need to send
* len: Length of data need to send

##### Return

* Return 0 if succeed send to gizwits, or return error code

---

### GIZWITS_DoReceive

```c
int GIZWITS_DoReceive(Gizwits_t* gizwits, OnReceivedOnePacket_Callback_t onOnePacket);
```

##### function

Deal with the data received from gizwits, call after socket received data

##### Parameters

* gizwits: Object of gizwits
* onOnePacket: data incomming callback function

##### Return

* Return the length of raw data received

---

### GIZWITS_Ping

```c
bool GIZWITS_Ping(Gizwits_t* gizwits);
```

##### function

Send heart beat packet to gizwits, you must call it within alive time in configuration, or the server will force to close the connection


##### Parameters

* gizwits: Object of gizwits

##### Return

* Is send heart beat packet success

---

### GIZWITS_GetSocket

```c
int GIZWITS_GetSocket(Gizwits_t* gizwits);
```

##### function

Get the file description of socket that connected to gizwits

##### Parameters

* gizwits: Object of gizwits

##### Return

* socket fd, > 0

---

### GIZWITS_Close

```c
bool GIZWITS_Close(Gizwits_t* gizwits);
```

##### function

Close connect with Gizwits

##### Parameters

* gizwits: Object of gizwits

##### Return

* Is succeed to close Gizwits

---


