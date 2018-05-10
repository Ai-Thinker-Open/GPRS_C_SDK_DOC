SPI
====

A9/A9G有两个SPI接口，使用的时候注意与哪些引脚复用了的，引脚情况查看pudding开发板引脚图


例程：[demo/spi](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/spi/src/demo_spi.c)


## 宏定义

### SPI_FREQ_MAX

SPI最大支持频率

```c
#define SPI_FREQ_MAX 13000000
```

---

## 枚举类型

#### SPI_ID_t

SPI编号，共两个SPI

```c
typedef enum
{
    SPI1      = 1 ,
    SPI2      = 2 ,
} SPI_ID_t;
```
---

### SPI_CS_t

SPI CS引脚，每个SPI都有两个CS引脚可供选择

```c
typedef enum
{
    SPI_CS_0  = 0 ,
    SPI_CS_1      ,
    SPI_CS_MAX
} SPI_CS_t;
```
---

### SPI_Mode_t

SPI模式，分为轮询、中断、DMA轮询、DMA中断四种模式

```c
typedef enum
{
    /// Direct polling: The application sends/receives the data directly to/from
    /// the hardware module. The number of bytes actually sent/received is
    /// returned.
    SPI_MODE_DIRECT_POLLING                   ,

	/// Direct IRQ: The application sends/receives the data directly to/from
    /// the hardware module. The number of bytes actually sent/received is
    /// returned. An Irq can be generated when the Tx/Rx FIFO reaches the
    /// pre-programmed level.
	SPI_MODE_DIRECT_IRQ                       ,

    /// DMA polling: The application sends/receives the data through a DMA to
    /// the hardware module. The function returns 0 when no DMA channel is
    /// available. No bytes are sent. The function returns the number of bytes
    /// to send when a DMA resource is available. They will all be sent. A
    /// function allows to check if the previous DMA transfer is finished. No
    /// new DMA transfer in the same direction will be allowed before the end
    /// of the previous transfer.
    SPI_MODE_DMA_POLLING                      ,

	/// DMA IRQ: The application sends/receives the data through a DMA to the
    /// hardware module. The function returns 0 when no DMA channel is
    /// available. No bytes are sent. The function returns the number of bytes
    /// to send when a DMA resource is available. They will all be sent. An
    /// IRQ is generated when the current transfer is finished. No new DMA
    /// transfer in the same direction will be allowed before the end of the
    /// previous transfer.
	SPI_MODE_DMA_IRQ                          ,

	SPI_MODE_MAX
} SPI_Mode_t;
```
---

### SPI_Line_t

SPI 支持3线和4线模式

```c
typedef enum{
	
	SPI_LINE_3  = 3    ,   ///  Half-Duplex Mode
	SPI_LINE_4  = 4    ,	///  Full-Duplex Mode
} SPI_Line_t;
```
---

### SPI_Data_Bits_t

SPI 数据位

```c
typedef enum{
	SPI_DATA_BITS_8 = 8 ,
	SPI_DATA_BITS_16 = 16,
} SPI_Data_Bits_t;
```
---


## 结构体类型

### SPI_Irq_Flags_t

SPI中断标志

```c
typedef struct
{
	/// Rx FIFO overflow
	bool rxOverflow;
	/// Tx send finish
	bool txFinish;
	/// Tx DMA send finish
	bool txDmaDone;
	/// Rx send finish
	bool rxFinish;
	/// Rx DMA send finish
	bool rxDmaDone;
} SPI_Irq_Flags_t;
```

---

### SPI_Config_t

SPI配置

```c
typedef struct
{
	/// Select the Chip Select
	SPI_CS_t cs;

	/// Emission transfer mode
	SPI_Mode_t txMode;

	/// Reception transfer mode
	SPI_Mode_t rxMode;

	/// SPI clock frequency
	/// up to 13Mbits/s (SPI_FREQ_MAX)
	uint32_t   freq;

	/// SPI transfer line mode
	SPI_Line_t line;

	/// SPI tx only
	/// false: tx only disable
	/// true:  tx only enable
	bool txOnly;

	/// SPI Clk Polarity
	/// 0 when SPI is free,clk line is in low level
	/// 1 when SPI is free,clk line is in high level
	uint8_t cpol;

	/// SPI Clk Phase
	/// 0 SPI sampling data at the first edge
	/// 1 SPI sampling data at the second edge
	uint8_t cpha;

	/// SPI Cs Active Polarity
	/// true: Cs Active Low
	/// false:  Cs Active High
	bool csActiveLow;

	/// SPI framesize
	SPI_Data_Bits_t dataBits;


	SPI_Irq_Handler_t irqHandler;

	SPI_Irq_Flags_t   irqMask;

} SPI_Config_t;
```

---

## 功能函数


### SPI_Irq_Handler_t

```c
typedef void (*SPI_Irq_Handler_t)(SPI_Irq_Flags_t flags);
```

##### 功能

SPI 中断回调函数

##### 参数

* flags:中断状态标志

##### 返回值

无

---

### SPI_Init

```c
bool SPI_Init(SPI_ID_t spiN, SPI_Config_t spiConfig);
```

##### 功能

初始化SPI

##### 参数

* spiN:SPI编号
* spiConfig：SPI配置

##### 返回值

* 是否成功初始化

---

### SPI_Close

```c
bool SPI_Close(SPI_ID_t spiN);
```

##### 功能

关闭SPI

##### 参数

* spiN:SPI编号

##### 返回值

* 是否成功关闭SPI

---

### SPI_Write

```c
uint32_t SPI_Write(SPI_ID_t spiN, const uint8_t *data, uint32_t length);
```

##### 功能

向SPI写数据

##### 参数

* spiN:SPI编号
* data：需要发送的数据
* length：需要发送的数据的长度

##### 返回值

* 成功发送的数据长度，如果在DMA模式下返回值为0，则表示DMA通道不可用

---

### SPI_Read

```c
uint32_t SPI_Read(SPI_ID_t spiN, uint8_t *data, uint32_t length);
```

##### 功能

从SPI读取数据

##### 参数

* spiN:SPI编号
* data：读取的数据存放的位置
* length：需要读取的数据的长度

##### 返回值

* 读取到的数据长度，单位字节

---

### SPI_IsTxDone

```c
bool SPI_IsTxDone(SPI_ID_t spiN);
```

##### 功能

检查最后一次传输是否已经完成，如果传输的数据很重要，在关闭SPI前这个函数最好被调用。
在直接传输和DMA传输的过程中不应该被调用

##### 参数

* spiN:SPI编号

##### 返回值

* 如果发送FIFO空，返回true；否则返回false

---

### SPI_IsTxDmaDone

```c
bool SPI_IsTxDmaDone(SPI_ID_t spiN);
```

##### 功能

查询SPI DMA发送是否完成，在DMA模式发送新的数据时要保证之前的数据已经发送完成，可以用这个函数来轮询。
需要注意的是DMA发送完成了但是发送FIFO可能不为空，及时这样也可以进行下一次DMA新的数据发送，关闭SPI之前必须要用`SPI_IsTxDone`检查SPI FIFO是否为空

##### 参数

* spiN:SPI编号

##### 返回值

* DMA传输是否完成

---

### SPI_IsRxDmaDone

```c
bool SPI_IsRxDmaDone(SPI_ID_t spiN);
```

##### 功能

检查DMA接收数据是否完成

##### 参数

* spiN:SPI编号

##### 返回值

* 是否成功接收数据完毕

---

### SPI_ClearTxDmaDone

```c
void SPI_ClearTxDmaDone(SPI_ID_t spiN);
```

##### 功能

清除SPI DMA发送完成标志

##### 参数

* spiN:SPI编号

##### 返回值

无

---

### SPI_FlushFIFOs

```c
void SPI_FlushFIFOs(SPI_ID_t spiN);
```

##### 功能

刷新两个SPI的缓冲区（FIFO）

##### 参数

* spiN:SPI编号

##### 返回值

无

---

### SPI_SetIrqHandler

```c
void SPI_SetIrqHandler(SPI_ID_t spiN, SPI_Irq_Handler_t handler);
```

##### 功能

设置中断回调函数

##### 参数

* spiN:SPI编号
* handler：中断回调函数

##### 返回值

无

---

### SPI_SetIrqMask

```c
void SPI_SetIrqMask(SPI_ID_t spiN, SPI_Irq_Flags_t irqMask);
```

##### 功能

设置中断标志位，即使能哪些中断标志位

##### 参数

* spiN:SPI编号
* irqMask：中断标志

##### 返回值

无

---
