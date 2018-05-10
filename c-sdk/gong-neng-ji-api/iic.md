I2C
====

A9/A9G有三个I2C接口，使用的时候注意与哪些引脚复用了的，引脚情况查看pudding开发板引脚图
只支持主模式

例程：[demo/i2c](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/i2c/src/demo_i2c.c)


## 宏定义

### I2C_DEFAULT_TIME_OUT

默认超时时间

```c
#define I2C_DEFAULT_TIME_OUT 10 //10ms
```

## 枚举类型

#### I2C_ID_t

I2C编号

```c
typedef enum
{
I2C1 = 1 ,
I2C2 = 2 ,
I2C3 = 3 ,
I2C_ID_MAX
} I2C_ID_t;
```

### I2C_FREQ_t

I2C支持的频率

```c
typedef enum
{
I2C_FREQ_100K,
I2C_FREQ_400K,
I2C_FREQ_MAX
} I2C_FREQ_t;
```

### I2C_Error_t

I2C错误信息

```c
typedef enum{
I2C_ERROR_NONE = 0 ,
/// A resource reset is required
I2C_ERROR_RESOURCE_RESET,
/// An attempt to access a busy resource failed
I2C_ERROR_RESOURCE_BUSY,
/// Timeout while trying to access the resource
I2C_ERROR_RESOURCE_TIMEOUT,
/// An attempt to access a resource that is not enabled
I2C_ERROR_RESOURCE_NOT_ENABLED,
/// Invalid parameter
I2C_ERROR_BAD_PARAMETER,
/// Communication failure
I2C_ERROR_COMMUNICATION_FAILED = 14,

I2C_ERROR_MAX
} I2C_Error_t;
```

### I2C_CMD_Mask_t

I2C标志位，功能函数中带`Raw`的函数使用

```c
typedef enum{
I2C_CMD_MASK_MASTER_NACK = (1<<0) ,
I2C_CMD_MASK_MASTER_READ = (1<<4) ,
I2C_CMD_MASK_MASTER_STOP = (1<<8) ,
I2C_CMD_MASK_MASTER_WRITE = (1<<12) ,
I2C_CMD_MASK_MASTER_START = (1<<16) ,
I2C_CMD_MASK_MAX
} I2C_CMD_Mask_t;
```


## 结构体类型

### I2C_Config_t

I2C配置

```c
typedef struct{
I2C_FREQ_t freq;
} I2C_Config_t;
```




## 功能函数


### I2C_Init

```c
bool I2C_Init(I2C_ID_t i2c, I2C_Config_t config);
```

##### 功能

初始化I2C

##### 参数

* i2c：I2C编号
* config：I2C初始化配置

##### 返回值

* 是否成功设置I2C

---

### I2C_Transmit

```c
I2C_Error_t I2C_Transmit(I2C_ID_t i2c, uint16_t slaveAddr, uint8_t* pData, uint16_t length, uint32_t timeOut);
```

##### 功能

通过I2C发送数据

##### 参数

* i2c：I2C编号
* slaveAddr:从机地址
* pData:需要发送的数据
* length：长度
* timeOut:超时时间，单位毫秒

##### 返回值

* 是否成功发送数据

---

### I2C_Receive

```c
I2C_Error_t I2C_Receive(I2C_ID_t i2c, uint16_t slaveAddr, uint8_t* pData, uint16_t length, uint32_t timeOut);
```

##### 功能

通过I2C接收数据

##### 参数

* i2c：I2C编号
* slaveAddr:从机地址
* pData:接收到的数据存放位置
* length：长度
* timeOut:超时时间，单位毫秒

##### 返回值

* 是否成功接收数据

---

### I2C_WriteMem

```c
I2C_Error_t I2C_WriteMem(I2C_ID_t i2c, uint16_t slaveAddr, uint32_t memAddr, uint8_t memSize, uint8_t* pData, uint16_t length, uint32_t timeOut);
```

##### 功能

通过I2C写从器件寄存器

##### 参数

* i2c：I2C编号
* slaveAddr:从机地址
* memAddr：从机寄存器地址
* memSize：从机寄存器地址长度，单位字节，即memAddr的字节数，最大为4
* pData:要写的数据的数据
* length：写数据长度
* timeOut:超时时间，单位毫秒

##### 返回值

* 是否成功写入数据

---

### I2C_ReadMem

```c
I2C_Error_t I2C_ReadMem(I2C_ID_t i2c, uint16_t slaveAddr, uint32_t memAddr, uint8_t memSize, uint8_t* pData, uint16_t length, uint32_t timeOut);
```

##### 功能

通过I2C读从器件寄存器

##### 参数

* i2c：I2C编号
* slaveAddr:从机地址
* memAddr：从机寄存器地址
* memSize：从机寄存器地址长度，单位字节，即memAddr的字节数，最大为4
* pData:读取的数据存放的位置
* length：读取数据长度，单位字节
* timeOut:超时时间，单位毫秒

##### 返回值

* 是否成功读取从机寄存器数据

---

### I2C_WriteRawByte

```c
I2C_Error_t I2C_WriteRawByte(I2C_ID_t i2c, uint8_t sendByte, I2C_CMD_Mask_t cmdMask, uint32_t timeOut);
```

##### 功能

通过I2C写单个字节数据

##### 参数

* i2c：I2C编号
* sendByte:需要发送的数据，一个字节
* cmdMask：附加的命令，`I2C_CMD_Mask_t`中的值
* timeOut:超时时间，单位毫秒

##### 返回值

* 是否成功写入数据

---

### I2C_ReadRawByte

```c
uint8_t I2C_ReadRawByte(I2C_ID_t i2c, I2C_CMD_Mask_t cmdMask, uint32_t timeOut);
```

##### 功能

通过I2C读单个字节数据

##### 参数

* i2c：I2C编号
* cmdMask：附加的命令，`I2C_CMD_Mask_t`中的值
* timeOut:超时时间，单位毫秒

##### 返回值

* 读取到的值

---

### I2C_Close

```c
bool I2C_Close(I2C_ID_t i2c);
```

##### 功能

关闭I2C

##### 参数

* i2c：I2C编号

##### 返回值

* 是否成功关闭I2C

---
