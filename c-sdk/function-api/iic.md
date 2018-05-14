I2C
====

A9/A9G has three I2C interfaces. When using it, pay attention to which pins are multiplexed and pin view the pin diagram of pudding development board.
And open power first
Only support the master mode

example:[demo/i2c](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/i2c/src/demo_i2c.c)


## Macro definition

### I2C_DEFAULT_TIME_OUT

default timeout time

```c
#define I2C_DEFAULT_TIME_OUT 10 //10ms
```

## Enumerated type

#### I2C_ID_t

I2C ID

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

I2C frequency

```c
typedef enum
{
I2C_FREQ_100K,
I2C_FREQ_400K,
I2C_FREQ_MAX
} I2C_FREQ_t;
```

### I2C_Error_t

I2C error information

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

The I2C flag bit, the function of the Function with `Raw`

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


## Struct

### I2C_Config_t

I2C configuration

```c
typedef struct{
I2C_FREQ_t freq;
} I2C_Config_t;
```




## Function


### I2C_Init

```c
bool I2C_Init(I2C_ID_t i2c, I2C_Config_t config);
```

#### Function

Initialize I2C

#### Parameters

* i2c：I2C ID
* config：I2C initialize configuration

#### Return

* Is success to config I2C

---

### I2C_Transmit

```c
I2C_Error_t I2C_Transmit(I2C_ID_t i2c, uint16_t slaveAddr, uint8_t* pData, uint16_t length, uint32_t timeOut);
```

#### Function

Send data with I2C

#### Parameters

* i2c：I2C ID
* slaveAddr:slave address
* pData:需要发送的数据
* length：length
* timeOut:time out , unit: ms

#### Return

* 是否成功发送数据

---

### I2C_Receive

```c
I2C_Error_t I2C_Receive(I2C_ID_t i2c, uint16_t slaveAddr, uint8_t* pData, uint16_t length, uint32_t timeOut);
```

#### Function

通过I2C接收数据

#### Parameters

* i2c：I2C ID
* slaveAddr:slave address
* pData:The location of the received data storage
* length：length
* timeOut:time out , unit: ms

#### Return

* Whether or not to receive data successfully

---

### I2C_WriteMem

```c
I2C_Error_t I2C_WriteMem(I2C_ID_t i2c, uint16_t slaveAddr, uint32_t memAddr, uint8_t memSize, uint8_t* pData, uint16_t length, uint32_t timeOut);
```

#### Function

Write slave's register

#### Parameters

* i2c：I2C ID
* slaveAddr:slave address
* memAddr：slave register address
* memSize：slave register address length,unit:byte, max 4
* pData: data to write
* length：length of data to write
* timeOut:time out , unit: ms

#### Return

* Whether the data is written successfully

---

### I2C_ReadMem

```c
I2C_Error_t I2C_ReadMem(I2C_ID_t i2c, uint16_t slaveAddr, uint32_t memAddr, uint8_t memSize, uint8_t* pData, uint16_t length, uint32_t timeOut);
```

#### Function

Read register of slave

#### Parameters

* i2c：I2C ID
* slaveAddr:slave address
* memAddr：slave register address
* memSize： slave register address length,unit:byte, max 4
* pData: data read
* length：length of read data read
* timeOut:time out , unit: ms

#### Return

* Whether the data is read successfully

---

### I2C_WriteRawByte

```c
I2C_Error_t I2C_WriteRawByte(I2C_ID_t i2c, uint8_t sendByte, I2C_CMD_Mask_t cmdMask, uint32_t timeOut);
```

#### Function

Write byte raw

#### Parameters

* i2c：I2C ID
* sendByte: data to send, one byte
* cmdMask：command value from `I2C_CMD_Mask_t`
* timeOut:time out , unit: ms

#### Return

* Whether the data is written successfully

---

### I2C_ReadRawByte

```c
uint8_t I2C_ReadRawByte(I2C_ID_t i2c, I2C_CMD_Mask_t cmdMask, uint32_t timeOut);
```

#### Function

Read one byte raw

#### Parameters

* i2c：I2C ID
* cmdMask： command value from `I2C_CMD_Mask_t`
* timeOut:time out , unit: ms

#### Return

* the value read

---

### I2C_Close

```c
bool I2C_Close(I2C_ID_t i2c);
```

#### Function

Close I2C

#### Parameters

* i2c：I2C ID

#### Return

* Close success or not

---
