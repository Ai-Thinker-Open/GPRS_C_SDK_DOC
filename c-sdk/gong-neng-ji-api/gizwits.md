Gizwits 机智云
=====

机智云使用简单，很适合快速搭建应用，SDK中集成了机智云协议，使用几个简单的API即可快速接入

更多详细介绍可以前往机智云官网

例程：[demo/gizwits](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/gizwits/src/demo_gizwits.c)



## 枚举类型

#### Gizwits_Action_t

action 编号

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


## 结构体类型

### Gizwits_Config_t

Gizwits配置,必须配置`IMEI`、`pk`、`pk_secret`、`alive`，pk和pk secret可以在机智云控制面板中创建的应用中找到

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

机智云对象

```c
typedef struct{
    Gizwits_Config_t* config;
    void*    cloud;
    char*    otaUrl;
}Gizwits_t;
```




## 功能函数


### OnReceivedOnePacket_Callback_t

```c
typedef void (*OnReceivedOnePacket_Callback_t)(Gizwits_t* gizwits, Gizwits_Action_t action,uint8_t* data, int len);
```

##### 功能

数据接收回调函数

##### 参数

* gizwits: 机智云对象
* action: 动作
* data: 数据
* len: 数据长度

##### 返回值

* 无

---

### GIZWITS_GetConfig

```c
 bool GIZWITS_GetConfig(Gizwits_Config_t* config, const char* path);
```

##### 功能

获取机智云配置

##### 参数

* config: 机智云配置
* path: 配置文件存放路径，比如`"/gizwits_config.conf"`

##### 返回值

* 是否成功地从文件读取到配置

---

### GIZWITS_Connect

```c
int GIZWITS_Connect(Gizwits_t* gizwits, Gizwits_Config_t* config, const char* configPath);
```

##### 功能

连接机智云，如果配置对象中的did值为空，则会先注册机智云再登录，需要注意的是，每次重新注册，用户绑定的设备将会自动解绑，即如果设备重新注册，就算之前已经绑定了这个设备的用户也需要重新扫码绑定

##### 参数

* gizwits: 机智云对象
* config: 机智云配置
* configPath: 机智云配置文件路径，用于注册成功后保存did等信息

##### 返回值

* 是否成功连接到机智云，成功则返回0，否则返回错误代码

---

### GIZWITS_Send

```c
int GIZWITS_Send(Gizwits_t* gizwits, Gizwits_Action_t action, uint8_t* data, int len);
```

##### 功能

推送数据到机智云

##### 参数

* gizwits: 机智云对象
* action: 动作
* data: 需要发送的数据
* len: 需要发送的数据的长度

##### 返回值

* 是否成功发送数据到机智云，成功则返回0，否则返回错误代码

---

### GIZWITS_DoReceive

```c
int GIZWITS_DoReceive(Gizwits_t* gizwits, OnReceivedOnePacket_Callback_t onOnePacket);
```

##### 功能

处理来自机智云的消息，在socket接收到数据时调用

##### 参数

* gizwits: 机智云对象
* onOnePacket: 数据回调函数

##### 返回值

* 返回接收到的原始数据的长度，否则返回错误代码

---

### GIZWITS_Ping

```c
bool GIZWITS_Ping(Gizwits_t* gizwits);
```

##### 功能

发送心跳包到机智云，在连接到机智云的配置信息中配置了alive时长，在这段时间内必须调用这个函数给机智云发送心跳包，否则会被服务器判定为已经掉线并强制断开连接

##### 参数

* gizwits: 机智云对象

##### 返回值

* 发送心跳包是否成功

---

### GIZWITS_GetSocket

```c
int GIZWITS_GetSocket(Gizwits_t* gizwits);
```

##### 功能

获取连接到机智云的socket描述符

##### 参数

* gizwits: 机智云对象

##### 返回值

* socket描述符，大于零

---

### GIZWITS_Close

```c
bool GIZWITS_Close(Gizwits_t* gizwits);
```

##### 功能

关闭连接

##### 参数

* gizwits: 机智云对象

##### 返回值

* 关闭机智云连接是否正常

---


