SPI
====

A9/A9G has two SPI interfaces. When using it, pay attention to which pins are multiplexed and pin view the pin diagram of pudding development board.

Open power first


example:[demo/spi](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/spi/src/demo_spi.c)


## Macro definition

### SPI_FREQ_MAX

SPI maximum support frequency

```c
#define SPI_FREQ_MAX 13000000
```

---

## Enumerated type

#### SPI_ID_t

SPI number, two SPI

```c
typedef enum
{
    SPI1      = 1 ,
    SPI2      = 2 ,
} SPI_ID_t;
```
---

### SPI_CS_t

SPI CS pin, each SPI has two CS pins to choose from.

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

SPI mode is divided into four modes: polling, interruption, DMA polling and DMA interruption.

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

SPI supports 3 line and 4 line mode

```c
typedef enum{
	
	SPI_LINE_3  = 3    ,   ///  Half-Duplex Mode
	SPI_LINE_4  = 4    ,	///  Full-Duplex Mode
} SPI_Line_t;
```
---

### SPI_Data_Bits_t

SPI data bits

```c
typedef enum{
	SPI_DATA_BITS_8 = 8 ,
	SPI_DATA_BITS_16 = 16,
} SPI_Data_Bits_t;
```
---


## Struct

### SPI_Irq_Flags_t

SPI interrupt flag

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

SPI configuration

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

## Function


### SPI_Irq_Handler_t

```c
typedef void (*SPI_Irq_Handler_t)(SPI_Irq_Flags_t flags);
```

#### Function

SPI interrupt callback function

#### Parameters

* flags: interrupt status flag

#### Return

None

---

### SPI_Init

```c
bool SPI_Init(SPI_ID_t spiN, SPI_Config_t spiConfig);
```

#### Function

Initialization of SPI

#### Parameters

* spiN:SPI number
* spiConfig:SPI configuration

#### Return

* whether or not it is successfully initialized

---

### SPI_Close

```c
bool SPI_Close(SPI_ID_t spiN);
```

#### Function

Shut down SPI

#### Parameters

* spiN:SPI number

#### Return

* whether SPI has been successfully closed

---

### SPI_Write

```c
uint32_t SPI_Write(SPI_ID_t spiN, const uint8_t *data, uint32_t length);
```

#### Function

Write data to SPI

#### Parameters

* spiN:SPI number
* data: data to be sent
* length: the length of the data to be sent

#### Return

* the length of the data sent successfully, if the return value in DMA mode is 0, it means that the DMA channel is not available.

---

### SPI_Read

```c
uint32_t SPI_Read(SPI_ID_t spiN, uint8_t *data, uint32_t length);
```

#### Function

Reading data from SPI

#### Parameters

* spiN:SPI number
* data: the location of the stored data read
* length: the length of the data to be read

#### Return

* read the length of the data, unit bytes

---

### SPI_IsTxDone

```c
bool SPI_IsTxDone(SPI_ID_t spiN);
```

#### Function

Check whether the last transmission has been completed. If the transmitted data is very important, this function is best invoked before closing the SPI.

It should not be invoked in direct transmission and DMA transmission.

#### Parameters

* spiN:SPI number

#### Return

* If FIFO is sent empty, return to true; otherwise, return false.

---

### SPI_IsTxDmaDone

```c
bool SPI_IsTxDmaDone(SPI_ID_t spiN);
```

#### Function

If you want to know whether the SPI DMA is complete or not, when you send new data in DMA mode, you need to ensure that the previous data has been sent to completion. You can use this function to poll.

It is important to note that the DMA transmission is completed but the sending FIFO may not be empty, so that the next DMA new data can be sent in time, and before the SPI is closed, it is necessary to check whether the SPI FIFO is empty with `SPI_IsTxDone`.

#### Parameters

* spiN:SPI number

#### Return

* DMA transmission is completed

---

### SPI_IsRxDmaDone

```c
bool SPI_IsRxDmaDone(SPI_ID_t spiN);
```

#### Function

Check whether the DMA received data is completed

#### Parameters

* spiN:SPI number

#### Return

* whether the data has been successfully received

---

### SPI_ClearTxDmaDone

```c
void SPI_ClearTxDmaDone(SPI_ID_t spiN);
```

#### Function

Clear the SPI DMA to send the completion flag

#### Parameters

* spiN:SPI number

#### Return

None

---

### SPI_FlushFIFOs

```c
void SPI_FlushFIFOs(SPI_ID_t spiN);
```

#### Function

Refresh the buffer of two SPI (FIFO)

#### Parameters

* spiN:SPI number

#### Return

None

---

### SPI_SetIrqHandler

```c
void SPI_SetIrqHandler(SPI_ID_t spiN, SPI_Irq_Handler_t handler);
```

#### Function

Setting the interrupt callback function

#### Parameters

* spiN:SPI number
* handler: interrupt callback function

#### Return

None

---

### SPI_SetIrqMask

```c
void SPI_SetIrqMask(SPI_ID_t spiN, SPI_Irq_Flags_t irqMask);
```

#### Function

Set interrupt flag bits, even which interrupt flag bits can be.

#### Parameters

* spiN:SPI number
* irqMask: interrupt sign

#### Return

None

---
