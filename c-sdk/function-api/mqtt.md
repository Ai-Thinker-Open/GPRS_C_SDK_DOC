MQTT
====

MQTT is a protocol based on subscription publishing model. It is widely used in real time chat (IM) and Internet of things.

example:
[demo/mqtt](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/mqtt/src/demo_mqtt.c)
[demo/mqtt_ssl](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/mqtt_ssl/src/demo_mqtt.c)


**Pay Attention**:
The Function related to MQTT only can be called in thread(task), can't call in interrup callback function, or errors occurs, refer to the demo code.

## Enumerated type

### MQTT_Error_t

MQTT error code

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

MQTT SSL version

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

Verify mode

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

MQTT connection status

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

MQTT flags

```c
typedef enum{
    MQTT_FLAG_NONE      = 0   ,
    MQTT_FLAG_DATA_LAST = 1 ,
    MQTT_FLAG_MAX
}MQTT_Flags_t;
```

---



## Struct

### MQTT_Client_t

MQTT object

```c
typedef struct{
    void* mqttClient;
}MQTT_Client_t;
```

---

### MQTT_Connect_Info_t

MQTT connection configuration

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


## Function


### MQTT_Connection_Callback_t

```c
typedef void (*MQTT_Connection_Callback_t)(MQTT_Client_t* client, void* arg, MQTT_Connection_Status_t status);
```

#### Function

Connection callback

#### Parameters

* client：MQTT client object
* arg：parameter from connect function
* status:MQTT

#### Return

None

---

### MQTT_Request_Callback_t

```c
typedef void (*MQTT_Request_Callback_t)(void* arg, MQTT_Error_t err);
```

#### Function

MQTT request callback

#### Parameters

* arg：param from request function
* err：error code

#### Return

None

---

### MQTT_InPub_Callback_t

```c
typedef void (*MQTT_InPub_Callback_t)(void* arg, const char* topic, uint32_t payloadLen);
```

#### Function

MQTT data header callback when received publish request

#### Parameters

* arg：the param from callback function setting function
* topic：topic of message
* payloadLen：payload length of message 

#### Return

None

---

### MQTT_InPub_Data_Callback_t

```c
typedef void (*MQTT_InPub_Data_Callback_t)(void* arg, const uint8_t* data, uint16_t len, MQTT_Flags_t flags);
```

#### Function

MQTT message body, receive before `MQTT_InPub_Callback_t`

#### Parameters

* arg：the param from callback function setting function
* data：payload data
* len：payload data length
* flags：flag, `MQTT_FLAG_DATA_LAST` means this message is the last slice data

#### Return

None

---

### MQTT_ClientNew

```c
MQTT_Client_t* MQTT_ClientNew();
```

#### Function

Create a MQTT client object

#### Parameters

None

#### Return

* MQTT client object

---

### MQTT_Connect

```c
MQTT_Error_t   MQTT_Connect(MQTT_Client_t* client, const char* domainOrIp,uint16_t port, 
                            MQTT_Connection_Callback_t callback, void* arg, const MQTT_Connect_Info_t* connectInfo);
```

#### Function

Connect the MQTT server(broker)

#### Parameters

* client:MQTT client object
* domainOrIp: server address
* port: server port
* callback: connect the successful callback function
* Arg: parameters that need to be passed to the successful callback function
* connectInfo: connection configuration

#### Return

* MQTT Conenction error

---

### MQTT_Disconnect

```c
MQTT_Error_t   MQTT_Disconnect(MQTT_Client_t* client);
```

#### Function

Disconnect the connection to the MQTT server (broker)

#### Parameters

* client：MQTT client object

#### Return

* MQTT connection error

---

### MQTT_SetInPubCallback

```c
void           MQTT_SetInPubCallback(MQTT_Client_t* client, MQTT_InPub_Callback_t inpubCallback, MQTT_InPub_Data_Callback_t dataInpubCallback, void* arg);
```

#### Function

Setting the callback function when MQTT receives the subscription message

#### Parameters

* client:MQTT client object
* inpubCallback: callback function when the subscription message is received.
* dataInpubCallback: message volume callback function when the subscription message is received.
* Arg: parameters that need to be passed to the successful callback function

#### Return

None

---

### MQTT_Subscribe

```c
MQTT_Error_t   MQTT_Subscribe(MQTT_Client_t* client, const char* topic, uint8_t qos, MQTT_Request_Callback_t callback, void* arg);
```

#### Function

Subscribe to a subscription subject request to the MQTT server (broker)

#### Parameters

* client:MQTT client object
* topic: topic
* QoS: quality of service
* callback: subscribe to the topic callback function
* Arg: parameters that need to be passed to the callback function

#### Return

* MQTT connection error information

---

### MQTT_Unsubscribe

```c
MQTT_Error_t   MQTT_Unsubscribe(MQTT_Client_t* client, const char* topic, MQTT_Request_Callback_t callback, void* arg);
```

#### Function

Cancel the subscription topic from the MQTT server (broker)

#### Parameters

* client:MQTT client object
* topic: topic
* callback: subscribe to the topic callback function
* Arg: parameters that need to be passed to the callback function

#### Return

* MQTT connection error information

---

### MQTT_Publish

```c
MQTT_Error_t   MQTT_Publish(MQTT_Client_t* client, const char* topic, const void* payload, uint16_t payloadLen, uint8_t dup, uint8_t qos, uint8_t retain,
                                  MQTT_Request_Callback_t callback, void* arg);
```

#### Function

Publish messages to the MQTT server (broker)

#### Parameters

* client:MQTT client object
* topic: topic
* port: server port
* payload: message body
* payloadLen: message body length
* DUP: indicating the number of sending repeats
* QoS: quality of service
* retain: needs the server to keep the message persisted
* callback: publish request callback function
* Arg: parameters that need to be passed to the callback function

#### Return

* MQTT connection error information

---

### MQTT_IsConnected

```c
uint8_t MQTT_IsConnected(MQTT_Client_t* client);
```

#### Function

Whether the query has been connected to the MQTT server (broker)

#### Parameters

* client：MQTT client object

#### Return

* return 0 If not connected, or return other value

---
