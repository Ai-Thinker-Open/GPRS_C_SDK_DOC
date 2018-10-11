MQTT
====

MQTT是一种基于订阅发布模型的协议，在实时聊天（IM）、物联网等领域中有广泛应用

例程：
[demo/mqtt](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/mqtt/src/demo_mqtt.c)
[demo/mqtt_ssl](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/mqtt_ssl/src/demo_mqtt.c)

**注意**：
MQTT相关的连接、断开连接、（取消）订阅发布等函数**只能在线程中调用**，不能在中断回调函数中调用，否则无法使用,参见例程的用法

## 枚举类型

### MQTT_Error_t

MQTT错误信息

```c
typedef enum{
    MQTT_ERROR_NONE       =  0,  //no error
    /** Out of memory error.     */
    MQTT_ERROR_MEM        = -1,
    /** Buffer error.            */
    MQTT_ERROR_BUF        = -2,
    /** Timeout.                 */
    MQTT_ERROR_TIMEOUT    = -3,
    /** Routing problem.         */
    MQTT_ERROR_RTE        = -4,
    /** Operation in progress    */
    MQTT_ERROR_INPROGRESS = -5,
    /** Illegal value.           */
    MQTT_ERROR_VAL        = -6,
    /** Operation would block.   */
    MQTT_ERROR_WOULDBLOCK = -7,
    /** Address in use.          */
    MQTT_ERROR_USE        = -8,
    /** Already connecting.      */
    MQTT_ERROR_ALREADY    = -9,
    /** Conn already established.*/
    MQTT_ERROR_ISCONN     = -10,
    /** Not connected.           */
    MQTT_ERROR_CONN       = -11,
    /** Low-level netif error    */
    MQTT_ERROR_IF         = -12,

    /** Connection aborted.      */
    MQTT_ERROR_ABRT       = -13,
    /** Connection reset.        */
    MQTT_ERROR_RST        = -14,
    /** Connection closed.       */
    MQTT_ERROR_CLSD       = -15,
    /** Illegal argument.        */
    MQTT_ERROR_ARG        = -16,
    MQTT_ERROR_PARAM      = -17,
    MQTT_ERROR_DNS        = -18
}MQTT_Error_t;
```

---

### MQTT_SSL_Version_t

MQTT SSL支持的版本

```c
typedef enum{
    MQTT_SSL_VERSION_SSLv3 = 0,
    MQTT_SSL_VERSION_TLSv1    ,
    MQTT_SSL_VERSION_TLSv1_1  ,
    MQTT_SSL_VERSION_TLSv1_2  ,
    MQTT_SSL_VERSION_MAX
}MQTT_SSL_Version_t;
```

---

### MQTT_SSL_Verify_Mode_t

验证模式

```c
typedef enum{
    MQTT_SSL_VERIFY_MODE_NONE     = 0,
    MQTT_SSL_VERIFY_MODE_OPTIONAL = 1,
    MQTT_SSL_VERIFY_MODE_REQUIRED = 2,
    MQTT_SSL_VERIFY_MODE_MAX
}MQTT_SSL_Verify_Mode_t;
```

---

### MQTT_Connection_Status_t

MQTT连接状态

```c
typedef enum
{
    /** Accepted */
    MQTT_CONNECTION_ACCEPTED                 = 0,
    /** Refused protocol version */
    MQTT_CONNECTION_REFUSED_PROTOCOL_VERSION = 1,
    /** Refused identifier */
    MQTT_CONNECTION_REFUSED_IDENTIFIER       = 2,
    /** Refused server */
    MQTT_CONNECTION_REFUSED_SERVER           = 3,
    /** Refused user credentials */
    MQTT_CONNECTION_REFUSED_USERNAME_PASS    = 4,
    /** Refused not authorized */
    MQTT_CONNECTION_REFUSED_NOT_AUTHORIZED   = 5,
    /** Disconnected */
    MQTT_CONNECTION_DISCONNECTED             = 256,
    /** Timeout */
    MQTT_CONNECTION_TIMEOUT                  = 257,
    MQTT_CONNECTION_DNS_FAIL                 = 258,
    MQTT_CONNECTION_STATUS_MAX
}MQTT_Connection_Status_t;
```

---

### MQTT_Flags_t

MQTT标志位

```c
typedef enum{
    MQTT_FLAG_NONE      = 0   ,
    MQTT_FLAG_DATA_LAST = 1 ,
    MQTT_FLAG_MAX
}MQTT_Flags_t;
```

---



## 结构体类型

### MQTT_Client_t

MQTT对象

```c
typedef struct{
    void* mqttClient;
}MQTT_Client_t;
```

---

### MQTT_Connect_Info_t

MQTT连接配置信息

```c
typedef struct{
    /** Client identifier, must be set by caller  */
    const char *client_id;
    /** User name, set to NULL if not used */
    const char* client_user;
    /** Password, set to NULL if not used */
    const char* client_pass;
    /** keep alive time in seconds, 0 to disable keep alive functionality*/
    uint16_t    keep_alive;
    /** will topic, set to NULL if will is not to be used,
         will_msg, will_qos and will retain are then ignored */
    const char* will_topic;
    /** will_msg, see will_topic */
    const char* will_msg;
    /** will_qos, see will_topic */
    uint8_t     will_qos;
    /** will_retain, see will_topic */
    uint8_t     will_retain;
    uint8_t     clean_session;
    /** SSL/TLS configuration for secure connections */
    bool                   use_ssl;
    MQTT_SSL_Verify_Mode_t ssl_verify_mode;
    const char*            ca_cert;
    const char*            ca_crl;
    const char*            client_cert;
    const char*            client_key;
    const char*            client_key_passwd;
    const char*            broker_hostname;
    MQTT_SSL_Version_t     ssl_min_version;
    MQTT_SSL_Version_t     ssl_max_version;
    const char*            entropy_custom;    //自定义混淆字符
}MQTT_Connect_Info_t;
```

---


## 功能函数


### MQTT_Connection_Callback_t

```c
typedef void (*MQTT_Connection_Callback_t)(MQTT_Client_t* client, void* arg, MQTT_Connection_Status_t status);
```

##### 功能

连接回调函数

##### 参数

* client：MQTT客户端对象
* arg：connect函数传的参数
* status:MQTT连接状态

##### 返回值

无

---

### MQTT_Request_Callback_t

```c
typedef void (*MQTT_Request_Callback_t)(void* arg, MQTT_Error_t err);
```

##### 功能

MQTT请求回调函数

##### 参数

* arg：发起请求时传的参数
* err：错误信息

##### 返回值

无

---

### MQTT_InPub_Callback_t

```c
typedef void (*MQTT_InPub_Callback_t)(void* arg, const char* topic, uint32_t payloadLen);
```

##### 功能

MQTT收到消息头回调函数，没有消息体，消息体在`MQTT_InPub_Data_Callback_t`中传入

##### 参数

* arg：设置回调函数时传的参数
* topic：收到消息的主题
* payloadLen：消息体长度

##### 返回值

无

---

### MQTT_InPub_Data_Callback_t

```c
typedef void (*MQTT_InPub_Data_Callback_t)(void* arg, const uint8_t* data, uint16_t len, MQTT_Flags_t flags);
```

##### 功能

MQTT收到消息的消息体,`MQTT_InPub_Callback_t`后产生

##### 参数

* arg：设置回调函数时传入的参数
* data：消息体数据
* len：消息体数据长度
* flags：标记，因为长数据可能被分段传输，`MQTT_FLAG_DATA_LAST`表示是消息的最后一段

##### 返回值

无

---

### MQTT_ClientNew

```c
MQTT_Client_t* MQTT_ClientNew();
```

##### 功能

创建MQTT客户端对象

##### 参数

无

##### 返回值

* MQTT客户端对象

---

### MQTT_Connect

```c
MQTT_Error_t   MQTT_Connect(MQTT_Client_t* client, const char* domainOrIp,uint16_t port, 
                            MQTT_Connection_Callback_t callback, void* arg, const MQTT_Connect_Info_t* connectInfo);
```

##### 功能

连接MQTT服务器(broker)

##### 参数

* client：MQTT客户端对象
* domainOrIp：服务器地址
* port：服务器端口
* callback：连接成功回调函数
* arg：需要传递给成功回调函数的参数
* connectInfo:连接配置

##### 返回值

* MQTT连接错误信息

---

### MQTT_Disconnect

```c
MQTT_Error_t   MQTT_Disconnect(MQTT_Client_t* client);
```

##### 功能

断开与MQTT服务器(broker)的连接

##### 参数

* client：MQTT客户端对象

##### 返回值

* MQTT连接错误信息

---

### MQTT_SetInPubCallback

```c
void           MQTT_SetInPubCallback(MQTT_Client_t* client, MQTT_InPub_Callback_t inpubCallback, MQTT_InPub_Data_Callback_t dataInpubCallback, void* arg);
```

##### 功能

设置MQTT接收到订阅的消息时的回调函数

##### 参数

* client：MQTT客户端对象
* inpubCallback：接收到订阅消息时的回调函数
* dataInpubCallback：接收到订阅消息时的消息体回调函数
* arg：需要传递给成功回调函数的参数

##### 返回值

无

---

### MQTT_Subscribe

```c
MQTT_Error_t   MQTT_Subscribe(MQTT_Client_t* client, const char* topic, uint8_t qos, MQTT_Request_Callback_t callback, void* arg);
```

##### 功能

向MQTT服务器(broker)发起订阅主题请求

##### 参数

* client：MQTT客户端对象
* topic：主题
* qos：服务质量
* callback：订阅主题回调函数
* arg：需要传递给回调函数的参数

##### 返回值

* MQTT连接错误信息

---

### MQTT_Unsubscribe

```c
MQTT_Error_t   MQTT_Unsubscribe(MQTT_Client_t* client, const char* topic, MQTT_Request_Callback_t callback, void* arg);
```

##### 功能

从MQTT服务器(broker)取消订阅主题

##### 参数

* client：MQTT客户端对象
* topic：主题
* callback：订阅主题回调函数
* arg：需要传递给回调函数的参数

##### 返回值

* MQTT连接错误信息

---

### MQTT_Publish

```c
MQTT_Error_t   MQTT_Publish(MQTT_Client_t* client, const char* topic, const void* payload, uint16_t payloadLen, uint8_t dup, uint8_t qos, uint8_t retain,
                                  MQTT_Request_Callback_t callback, void* arg);
```

##### 功能

向MQTT服务器(broker)发布消息

##### 参数

* client：MQTT客户端对象
* topic：主题
* port：服务器端口
* payload：消息体
* payloadLen：消息体长度
* dup：标示发送重复数
* qos：服务质量
* retain:需要服务器持久保存消息
* callback：发布请求回调函数
* arg：需要传递给回调函数的参数

##### 返回值

* MQTT连接错误信息

---

### MQTT_IsConnected

```c
uint8_t MQTT_IsConnected(MQTT_Client_t* client);
```

##### 功能

查询是否已经连接MQTT服务器(broker)

##### 参数

* client：MQTT客户端对象

##### 返回值

* 如果已经连接，返回非0值，否则返回0

---
