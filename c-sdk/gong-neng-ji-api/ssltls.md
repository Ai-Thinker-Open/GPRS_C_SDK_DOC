SSL/TLS
====

如果对SSL/TLS不是很熟悉，觉得各种证书很混乱，可以参照[这篇文章](https://www.jianshu.com/p/231b4196a6f5)生成证书


例程：[demo/ssl](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/ssl/src/demo_ssl.c)


## 枚举类型

### SSL_Version_t

SSL/TLS版本

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

错误信息

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

验证模式

```c
typedef enum{
    SSL_VERIFY_MODE_NONE     = 0,
    SSL_VERIFY_MODE_OPTIONAL = 1,
    SSL_VERIFY_MODE_REQUIRED = 2,
    SSL_VERIFY_MODE_MAX
}SSL_Verify_Mode_t;
```

---

## 结构体类型

### SSL_Config_t

SSL/TLS配置

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

## 功能函数


### SSL_Init

```c
SSL_Error_t SSL_Init(SSL_Config_t* sslConfig);
```

##### 功能

初始化SSL/TLS

##### 参数

* sslConfig:初始化配置参数

##### 返回值

* 返回错误信息

---

### SSL_Connect

```c
SSL_Error_t SSL_Connect(SSL_Config_t* sslConfig, const char* server, const char* port);
```

##### 功能

用SSL/TLS协议连接服务器

##### 参数

* sslConfig:SSL/TLS配置信息
* server:需要连接的SSL/TLS服务器
* port：服务器端口

##### 返回值

* 返回错误信息

---

### SSL_Write

```c
int SSL_Write(SSL_Config_t* sslConfig, uint8_t* data, int length, int timeoutMs);
```

##### 功能

SSL/TLS发送数据（阻塞）

##### 参数

* sslConfig:SSL/TLS配置
* data:发送给服务器的数据
* length:发送给服务器的数据的长度
* timeoutMs:发送超时时间（保留，暂不可用）

##### 返回值

* 成功发送的数据长度或错误代码

---

### SSL_Read

```c
int SSL_Read(SSL_Config_t* sslConfig, uint8_t* data, int length, int timeoutMs);
```

##### 功能

读取数据

##### 参数

* sslConfig:SSL/TLS配置
* data:接收到的数据
* length:接收到的数据的长度
* timeoutMs:接收超时时间

##### 返回值

* 成功接收的数据长度或者错误代码

---

### SSL_Close

```c
SSL_Error_t SSL_Close(SSL_Config_t* sslConfig);
```

##### 功能

关闭连接

##### 参数

* sslConfig:SSL/TLS配置

##### 返回值

* 关闭错误信息

---

### SSL_Destroy

```c
SSL_Error_t SSL_Destroy(SSL_Config_t* sslConfig);
```

##### 功能

释放SSL/TLS占用的空间

##### 参数

* sslConfig:SSL/TLS配置

##### 返回值

* 释放错误信息

---

