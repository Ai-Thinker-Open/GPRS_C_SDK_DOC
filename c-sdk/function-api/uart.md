UART (Serial port)
=====

The module has three UART, serial port 1, serial port 2 and download and debug serial HST serial port.

example:[`demo/uart`](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/uart/src/demo_uart.c)

---

## Enumerated type

### UART_Port_t

Port id

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

Baud rate

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

Data bits

```c
typedef enum{
    UART_DATA_BITS_7                        = 7,
    UART_DATA_BITS_8                        = 8,
    UART_DATA_BITS_MAX
}UART_Data_Bits_t;
```

---

### UART_Stop_Bits_t

Stop bits

```c
typedef enum{
    UART_STOP_BITS_1                         = 1,
    UART_STOP_BITS_2                           ,
    UART_STOP_BITS_MAX
}UART_Stop_Bits_t;
```

---

### UART_Parity_t

Parity

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

Error code

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

## Struct

### UART_Callback_Param_t

Callback function parameter

```c
typedef struct{
UART_Port_t port;
uint32_t length;
char *buf;//the receive buf
}UART_Callback_Param_t;
```

---

### UART_Config_t

Serial initialization parameters

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


## Function

### UART_Callback_t

```c
typedef void (*UART_Callback_t)(UART_Callback_Param_t param);
```

#### Function

Serial callback function, defined by the user


#### Parameters

* param：callback parameters

#### Return

None

---

### UART_Error_Callback_t

```c
typedef void (*UART_Error_Callback_t)(UART_Error_t error);
```

#### Function

Serial error callback function, defined by the user


#### Parameters

* error：error info

#### Return

None

---

### UART_Init

```c
bool     UART_Init(UART_Port_t uartN, UART_Config_t config);
```

#### Function

Initialize UART

#### Parameters

* uartN: uart id
* config: uart configuration

#### Return

* bool:Initialize success or not

---


### UART_Write

```c
uint32_t UART_Write(UART_Port_t uartN, uint8_t* dataToWrite, uint32_t length);
```

#### Function

Send data to UART

#### Parameters

* uartN: UART id
* dataToWrite: data to write
* length: data length

#### Return

* Successfully written to the length of the serial port

---


### UART_Read

```c
uint32_t UART_Read(UART_Port_t uartN, uint8_t* dataToRead, uint32_t length, uint32_t timeOutMs);
```

#### Function

Reading data from the serial port

#### Parameters

* uartN: serial number
* the location of the data stored by the dataToWrite: read
* the length of the data to be read by length:
* timeOutMs: timeout time, the unit is milliseconds

#### Return

* Data length read successfully from serial port

---


### UART_Close

```c
bool     UART_Close(UART_Port_t uartN);
```

#### Function

Close UART

#### Parameters

* uartN: id

#### Return

* Close success or not

---
















