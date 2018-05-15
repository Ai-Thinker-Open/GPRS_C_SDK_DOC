SSL/TLS
====

If you are not familiar with SSL/TLS and feel that all kinds of certificates are very confusing, you can refer to this [article](https://www.jianshu.com/p/231b4196a6f5) to generate certificate


example:[demo/ssl](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/ssl/src/demo_ssl.c)


## Enumerated type

### SSL_Version_t

SSL/TLS version

```c
typedef enum{
    SSL_VERSION_SSLv3 = 0,
    SSL_VERSION_TLSv1    ,
    SSL_VERSION_TLSv1_1  ,
    SSL_VERSION_TLSv1_2  ,
    SSL_VERSION_MAX
}SSL_Version_t;
```

---

### SSL_Error_t

error message

```c
typedef enum{
    SSL_ERROR_NONE       =  0x00 ,
    SSL_ERROR_PARAM      = -0x01 ,
    SSL_ERROR_PARSE      = -0x02 ,
    SSL_ERROR_MALLOC_FAIL= -3    ,
    SSL_ERROR_CONNECTION = -4    ,
    SSL_ERROR_TIMEOUT    = -5    ,
    SSL_ERROR_FAIL       = -6    ,
    SSL_ERROR_INTERNAL           ,
    SSL_ERROR_MAX
} SSL_Error_t;
```

---

### SSL_Verify_Mode_t

Validation mode

```c
typedef enum{
    SSL_VERIFY_MODE_NONE     = 0,
    SSL_VERIFY_MODE_OPTIONAL = 1,
    SSL_VERIFY_MODE_REQUIRED = 2,
    SSL_VERIFY_MODE_MAX
}SSL_Verify_Mode_t;
```

---

## Struct

### SSL_Config_t

SSL/TLS configuration

```c
typedef struct{
    const char*       caCert;
    const char*       caCrl;
    const char*       clientCert;
    const char*       clientKey;
    const char*       clientKeyPasswd;
    const char*       hostName;
    SSL_Version_t     minVersion;
    SSL_Version_t     maxVersion;
    SSL_Verify_Mode_t verifyMode;
    const char*       entropyCustom;     //自定义混淆字符
    //////////////////////////////////
    void* obj;//do not edit it
    //////////////////////////////////
} SSL_Config_t;
```

---

## Function


### SSL_Init

```c
SSL_Error_t SSL_Init(SSL_Config_t* sslConfig);
```

#### Function

Init SSL/TLS

#### Parameters

* sslConfig:Initialization configuration parameters

#### Return

* Return error information

---

### SSL_Connect

```c
SSL_Error_t SSL_Connect(SSL_Config_t* sslConfig, const char* server, const char* port);
```

#### Function

Connect the server with the SSL/TLS protocol

#### Parameters

* sslConfig:SSL/TLS configuration information
* server: SSL/TLS server that needs to be connected
* port: server port

#### Return

* Return error information

---

### SSL_Write

```c
int SSL_Write(SSL_Config_t* sslConfig, uint8_t* data, int length, int timeoutMs);
```

#### Function

SSL/TLS Sending data (blocking)

#### Parameters

* sslConfig:SSL/TLS configuration
* data: data sent to the server
* the length of the data sent to the server by length:
* timeoutMs: sends timeout time (reserved, temporarily unavailable)

#### Return

* Data length or error code that is successfully sent

---

### SSL_Read

```c
int SSL_Read(SSL_Config_t* sslConfig, uint8_t* data, int length, int timeoutMs);
```

#### Function

Read the data

#### Parameters

* sslConfig:SSL/TLS configuration
* data: received data
* the length of the data received by length:
* timeoutMs: receives timeout time

#### Return

* The data length or error code that is successfully received

---

### SSL_Close

```c
SSL_Error_t SSL_Close(SSL_Config_t* sslConfig);
```

#### Function

Close connection

#### Parameters

* sslConfig:SSL/TLS configuration

#### Return

* error message

---

### SSL_Destroy

```c
SSL_Error_t SSL_Destroy(SSL_Config_t* sslConfig);
```

#### Function

Release the space occupied by SSL/TLS

#### Parameters

* sslConfig:SSL/TLS configuration

#### Return

* error code of release

---

