#define I2C_DEFAULT_TIME_OUT 10  //10ms

typedef enum
{
    I2C1 = 1 ,
    I2C2 = 2 ,
    I2C3 = 3 ,
    I2C_ID_MAX
} I2C_ID_t;

typedef enum
{
    I2C_FREQ_100K,
    I2C_FREQ_400K,
    I2C_FREQ_MAX
} I2C_FREQ_t;

typedef struct{
    I2C_FREQ_t freq;
} I2C_Config_t;

typedef enum{
    I2C_ERROR_NONE = 0     ,
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
    I2C_ERROR_COMMUNICATION_FAILED  = 14,

    I2C_ERROR_MAX
} I2C_Error_t;

typedef enum{
    I2C_CMD_MASK_MASTER_NACK   =     (1<<0)  ,
    I2C_CMD_MASK_MASTER_READ   =     (1<<4)  ,
    I2C_CMD_MASK_MASTER_STOP   =     (1<<8)  ,
    I2C_CMD_MASK_MASTER_WRITE  =     (1<<12) ,
    I2C_CMD_MASK_MASTER_START  =     (1<<16) ,
    I2C_CMD_MASK_MAX
} I2C_CMD_Mask_t;
 

/// \brief  bool I2C_Init(I2C_ID_t i2c,I2C_Speed_t Bpsx);
/// \param  I2C_Bus_ID_t i2c, ID of the I2C bus
/// \param  I2C_Bps_t Bpsx, the speed of I2C
/// \return BOOL  
///         TRUE: init success
///			FALSE: init failed
/// \note   when I2C1 is used, the i2c1 pin must be pulled up
bool I2C_Init(I2C_ID_t i2c, I2C_Config_t config);


I2C_Error_t I2C_Transmit(I2C_ID_t i2c, uint16_t slaveAddr, uint8_t* pData, uint16_t length, uint32_t timeOut);

I2C_Error_t I2C_Receive(I2C_ID_t i2c, uint16_t slaveAddr, uint8_t* pData, uint16_t length, uint32_t timeOut);

I2C_Error_t I2C_WriteMem(I2C_ID_t i2c, uint16_t slaveAddr, uint32_t memAddr, uint8_t memSize, uint8_t* pData, uint16_t length, uint32_t timeOut);

I2C_Error_t I2C_ReadMem(I2C_ID_t i2c, uint16_t slaveAddr, uint32_t memAddr, uint8_t memSize, uint8_t* pData, uint16_t length, uint32_t timeOut);

/// \brief  I2C_Error_t I2C_Read_Raw_Byte(I2C_Bus_ID_t i2c, uint32_t CmdMask)
/// \param  I2C_Bus_ID_t i2c, ID of the I2C bus
/// \param  uint8_t SendByte, one byte what you want to send
/// \param  uint32_t CmdMask, this is the command associated with this byte.  It must
///         be sent at the same time so the two actions (write to the data fifo and
///         issue the command) are done together, can be I2C_MASTER_ACK|I2C_MASTER_RD|
///         I2C_MASTER_STO|I2C_MASTER_WR|I2C_MASTER_STA
/// \return I2C_Error_t
/// \note   This function sends a single byte on the I2C interface
///         It is not designed for use in the real I2C protocol, but allows access
///         for non-standard usages such as SCCB for the Omnivision Camera control
I2C_Error_t I2C_WriteRawByte(I2C_ID_t i2c, uint8_t SendByte, I2C_CMD_Mask_t CmdMask, uint32_t timeOut);

/// \brief  I2C_Error_t I2C_Read_Raw_Byte(I2C_Bus_ID_t i2c, uint32_t CmdMask)
/// \param  I2C_Bus_ID_t i2c, ID of the I2C bus
/// \param  uint32_t CmdMask, can be I2C_MASTER_ACK|I2C_MASTER_RD|I2C_MASTER_STO|I2C_MASTER_WR|I2C_MASTER_STA
/// \return I2C_Error_t
/// \note   This function completes the 2 phase read cycle as defined in the SCCB
///         spec.  The actual commands for the I2C module must be:  Stop, Read, and
///         NACK. (The SCCB requires a NACK at the end of the read byte)
uint8_t I2C_ReadRawByte(I2C_ID_t i2c, I2C_CMD_Mask_t CmdMask, uint32_t timeOut);


/// \brief  bool I2C_Close(I2C_Bus_ID_t i2c)
/// \param  I2C_Bus_ID_t i2c, ID of the I2C bus
/// \return BOOL
///         TRUE: close success
///			FALSE: close failed
bool I2C_Close(I2C_ID_t i2c);