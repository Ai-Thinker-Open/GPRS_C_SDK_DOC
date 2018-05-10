串口
=====

模组共有三个UART，串口1、串口2以及下载调试串口HST串口

例程:[`demo/uart`](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/uart/src/demo_uart.c)

---

## 枚举类型

### UART_Port_t

串口编号

```c
typedef enum{
    UART1   = 1,
    UART2   = 2,
    UART_GPS = 2,
    UART_PORT_MAX
}UART_Port_t;
```

---

### UART_Baud_Rate_t

波特率

```c
typedef enum{
    UART_BAUD_RATE_1200                     = 1200,
    UART_BAUD_RATE_2400                     = 2400,
    UART_BAUD_RATE_4800                     = 4800,
    UART_BAUD_RATE_9600                     = 9600,
    UART_BAUD_RATE_14400                    = 14400,
    UART_BAUD_RATE_19200                    = 19200,
    UART_BAUD_RATE_28800                    = 28800,
    UART_BAUD_RATE_33600                    = 33600,
    UART_BAUD_RATE_38400                    = 38400,
    UART_BAUD_RATE_57600                    = 57600,
    UART_BAUD_RATE_115200                   = 115200,
    UART_BAUD_RATE_230400                   = 230400,
    UART_BAUD_RATE_460800                   = 460800,
    UART_BAUD_RATE_921600                   = 921600,
    UART_BAUD_RATE_1300000                  = 1300000,
    UART_BAUD_RATE_1625000                  = 1625000,
    UART_BAUD_RATE_2166700                  = 2166700,
    UART_BAUD_RATE_3250000                  = 3250000,
    UART_BAUD_RATE_MAX                      = 3250001
}UART_Baud_Rate_t;
```

---

### UART_Data_Bits_t

数据位

```c
typedef enum{
    UART_DATA_BITS_7                        = 7,
    UART_DATA_BITS_8                        = 8,
    UART_DATA_BITS_MAX
}UART_Data_Bits_t;
```

---

### UART_Stop_Bits_t

停止位

```c
typedef enum{
    UART_STOP_BITS_1                         = 1,
    UART_STOP_BITS_2                           ,
    UART_STOP_BITS_MAX
}UART_Stop_Bits_t;
```

---

### UART_Parity_t

校验位

```c
typedef enum{
UART_PARITY_NONE = 0,
UART_PARITY_ODD ,
UART_PARITY_EVEN ,
UART_PARITY_SPACE ,
UART_PARITY_MARK ,
UART_PARITY_MAX
}UART_Parity_t;
```

---

### UART_Error_t

串口错误

```c
typedef enum{
    UART_ERROR_RX_LINE_ERROR,
    UART_ERROR_RX_OVER_FLOW_ERROR,
    UART_ERROR_RX_PARITY_ERROR,
    UART_ERROR_RX_BREAK_INT_ERROR,
    UART_ERROR_RX_FRAMING_ERROR,
    UART_ERROR_TX_OVER_FLOW_ERROR,
    UART_ERROR_MAX
}UART_Error_t;
```

---

## 结构体类型

### UART_Callback_Param_t

回调函数参数

```c
typedef struct{
UART_Port_t port;
uint32_t length;
char *buf;//the receive buf
}UART_Callback_Param_t;
```

---

### UART_Config_t

串口初始化参数

```c
typedef struct{
    UART_Baud_Rate_t      baudRate;
    UART_Data_Bits_t      dataBits;
    UART_Stop_Bits_t      stopBits;
    UART_Parity_t         parity;
    UART_Callback_t       rxCallback;
    UART_Error_Callback_t errorCallback;
    bool                  useEvent;
}UART_Config_t;
```

---


## 功能函数

### UART_Callback_t

```c
typedef void (*UART_Callback_t)(UART_Callback_Param_t param);
```

##### 功能

串口回调函数，由用户定义 


##### 参数

* param：回调参数

##### 返回值

无

---

### UART_Error_Callback_t

```c
typedef void (*UART_Error_Callback_t)(UART_Error_t error);
```

##### 功能

串口错误回调函数，由用户定义


##### 参数

* error：错误信息

##### 返回值

无

---

### UART_Init

```c
bool     UART_Init(UART_Port_t uartN, UART_Config_t config);
```

##### 功能

串口初始化

##### 参数

* uartN:串口号
* config:串口配置

##### 返回值

* bool:是否初始化成功

---


### UART_Write

```c
uint32_t UART_Write(UART_Port_t uartN, uint8_t* dataToWrite, uint32_t length);
```

##### 功能

向串口写（发送）数据

##### 参数

* uartN:串口号
* dataToWrite:需要写的数据
* length:数据长度

##### 返回值

* 成功写到串口的长度

---


### UART_Read

```c
uint32_t UART_Read(UART_Port_t uartN, uint8_t* dataToRead, uint32_t length, uint32_t timeOutMs);
```

##### 功能

从串口读取数据

##### 参数

* uartN:串口号
* dataToWrite:读取的数据存放的位置
* length:需要读取的数据长度
* timeOutMs:超时时间，单位是毫秒

##### 返回值

* 从串口成功读取到的数据长度

---


### UART_Close

```c
bool     UART_Close(UART_Port_t uartN);
```

##### 功能

关闭串口

##### 参数

* uartN:串口

##### 返回值

* 是否关闭成功

---
















