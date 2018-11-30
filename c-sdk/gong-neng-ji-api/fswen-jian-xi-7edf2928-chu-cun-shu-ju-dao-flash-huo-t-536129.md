File System
====

为了操作Flash更加简单，内置了文件系统和常用的API，
需要持久化数据或者配置信息，只需要将其保存为文件即可，
如果没有接触过文件系统， 可以简单地理解为，
当我们需要把数据储存到flash，每次储存我们自己擦除flash然后再写入，写到哪里怎么写这些策略需要我们自己安排，
而文件系统就是帮我们解决这个策略的问题，我们只需要调用api把数据发送给文件系统，文件系统自己会决定擦除哪个分区以及储存到哪个分区

需要注意的是文件系统是在Flash上的，不需要TF卡都可以使用，总大小有408k，当然可使用的空间小于408k，如果使用OTA还要给固件存放预留最大64k的空间。
当然也可以保存到外部TF卡，开机默认挂在TF卡到`/t`位置了，最大支持16G储存空间的TF卡


例程：[demo/fs](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/fs/src/demo_fs.c)


## 宏定义

### FS_TFLASH_ROOT

TF卡开机自动挂载的位置

```c
#define FS_TFLASH_ROOT "/t"
```

---

### FS_O_RDONLY

只读

```c
#define FS_O_RDONLY                0
```

---

#### FS_O_WRONLY

只写

```c
#define FS_O_WRONLY                1
```

---

### FS_O_RDWR

读写

```c
#define FS_O_RDWR                  2
```

---

### FS_O_ACCMODE

读写文件操作时，用于取出flag的低2位（判断文件权限）

```c
#define FS_O_ACCMODE               3
```

---

### FS_O_CREAT

如果文件存在，不产生影响，不存在则建立，返回成功
如果文件存在且有`FS_O_EXCL`，则返回失败

```c
#define FS_O_CREAT                 00100
```

---

### FS_O_EXCL

如果它和`FS_O_CREAT`同时设定，且文件已经存在，则创建文件操作会失败，返回-1

```c
#define FS_O_EXCL                  00200
```

---

### FS_O_TRUNC

如果文件存在，则以只写或只读打开，并删除文件之前的内容

```c
#define FS_O_TRUNC                 01000
```

---

### FS_O_APPEND

追加

```c
#define FS_O_APPEND                02000
```

---

### FS_ATTR_MARK

文件属性标记

```c
#define FS_ATTR_MARK       0x0
```

---

### FS_ATTR_RO

文件属性只读

```c
#define FS_ATTR_RO            0x00000001
```

---

### FS_ATTR_HIDDEN

文件属性隐藏

```c
#define FS_ATTR_HIDDEN    0x00000002
```

---

### FS_ATTR_SYSTEM

文件属性系统文件

```c
#define FS_ATTR_SYSTEM    0x00000004
```

---

### FS_ATTR_VOLUME

卷标

```c
#define FS_ATTR_VOLUME    0x00000008
```

---

### FS_ATTR_DIR

文件夹

```c
#define FS_ATTR_DIR           0x00000010
```

---

### FS_ATTR_ARCHIVE

压缩文件

```c
#define FS_ATTR_ARCHIVE   0x00000020
```

---

### FS_SEEK_SET

文件开头

```c
#define FS_SEEK_SET                 0
```

---

### FS_SEEK_CUR

当前位置

```c
#define FS_SEEK_CUR                 1
```

---

### FS_SEEK_END

末尾位置

```c
#define FS_SEEK_END                 2
```

---

### FS_DEVICE_NAME_T_FLASH

TF卡名称

```c
#define FS_DEVICE_NAME_T_FLASH  "TF"
```

---

### FS_DEVICE_NAME_FLASH

Flash名称

```c
#define FS_DEVICE_NAME_FLASH    "FLASH"
```

---

### ERR_FS

错误信息,错误信息详细信息请看[api_inc_fs.h](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/include/api_inc/api_inc_fs.h)

```c
#define ERR_FS_IS_DIRECTORY                                -4200001
#define ERR_FS_NOT_DIRECTORY                               -4200002
#define ERR_FS_NO_DIR_ENTRY                                -4200003
#define ERR_FS_OPERATION_NOT_GRANTED                       -4200005
#define ERR_FS_DIR_NOT_EMPTY                               -4200006
#define ERR_FS_FDS_MAX                                     -4200007
#define ERR_FS_PROCESS_FILE_MAX                            -4200008
#define ERR_FS_FILE_EXIST                                  -4200009
#define ERR_FS_NO_BASENAME                                 -4200011
#define ERR_FS_BAD_FD                                      -4200012
#define ERR_FS_NO_MORE_FILES                               -4200013
#define ERR_FS_HAS_MOUNTED                                 -4200014
#define ERR_FS_MOUNTED_FS_MAX                              -4200015
#define ERR_FS_UNKNOWN_FILESYSTEM                          -4200016
#define ERR_FS_INVALID_DIR_ENTRY                           -4200018
#define ERR_FS_INVALID_PARAMETER                           -4200019
#define ERR_FS_NOT_SUPPORT                                 -4200020
#define ERR_FS_UNMOUNT_FAILED                              -4200021
#define ERR_FS_NO_MORE_MEMORY                              -4200025
#define ERR_FS_DEVICE_NOT_REGISTER                         -4200027
#define ERR_FS_DISK_FULL                                   -4200030
#define ERR_FS_NOT_FORMAT                                  -4200032
#define ERR_FS_HAS_FORMATED                                -4200033
#define ERR_FS_NOT_FIND_SB                                 -4200035
#define ERR_FS_DEVICE_BUSY                                 -4200037
#define ERR_FS_OPEN_DEV_FAILED                             -4200038
#define ERR_FS_ROOT_FULL                                   -4200039
#define ERR_FS_ACCESS_REG_FAILED                           -4200040
#define ERR_FS_PATHNAME_PARSE_FAILED                       -4200041
#define ERR_FS_READ_DIR_FAILED                             -4200048
#define ERR_FS_MOUNT_READ_ROOT_INODE_FAILED                -4200050
#define ERR_FS_INVALID_DEV_NUMBER                          -4200051
#define ERR_FS_RENAME_DIFF_PATH                            -4200052
#define ERR_FS_FORMAT_MOUNTING_DEVICE                      -4200053
#define ERR_FS_DATA_DESTROY                                -4200056
#define ERR_FS_READ_SECTOR_FAILED                          -4200057
#define ERR_FS_WRITE_SECTOR_FAILED                         -4200058
#define ERR_FS_READ_FILE_EXCEED                            -4200059
#define ERR_FS_WRITE_FILE_EXCEED                           -4200060
#define ERR_FS_FILE_TOO_MORE                               -4200061
#define ERR_FS_FILE_NOT_EXIST                              -4200062
#define ERR_FS_DEVICE_DIFF                                 -4200063
#define ERR_FS_GET_DEV_INFO_FAILED                         -4200064
#define ERR_FS_NO_MORE_SB_ITEM                             -4200065
#define ERR_FS_NOT_MOUNT                                   -4200066
#define ERR_FS_NAME_BUFFER_TOO_SHORT                       -4200068
#define ERR_FS_NOT_REGULAR                                 -42000100
#define ERR_FS_VOLLAB_IS_NULL                              -42000101
```
---


## 结构体类型

### API_FS_INFO

文件系统空间信息，包括总空间和已经使用的空间信息

```c
typedef struct
{
    UINT64 totalSize;    // Total size
    UINT64 usedSize;     // Has used  size
} API_FS_INFO;
```

---


## 功能函数


### API_FS_Open

```c
int32_t  API_FS_Open(
    PCSTR    fileName,
    uint32_t operationFlag,
    uint32_t mode
);
```

##### 功能

打开文件

##### 参数

* fileName：文件名，注意文件名只接受unicode编码,
先调用`LocalLanguage2UnicodeBigEndian`将字符格式转换为unicode编码
* operationFlag：操作标记，比如只读、只写等(`FS_O_...`)，可以多个操作进行或运算传入
* mode：模式,文件或文件夹属性，`FS_ATTR_...`，可以多个操作进行或运算传入

##### 返回值

* 如果成功返回大于等于零的文件描述符，负责返回错误代码

---

### API_FS_Close

```c
int32_t  API_FS_Close(
    int32_t fd
);
```

##### 功能

关闭文件

##### 参数

* fd：文件描述符，`API_FS_Open`的返回值

##### 返回值

* 成功返回0，否则返回错误代码

---

### API_FS_Read

```c
int32_t  API_FS_Read(
    int32_t  fd,
    uint8_t* pBuffer,
    uint32_t length
);
```

##### 功能

读取数据

##### 参数

* fd：文件描述符，`API_FS_Open`的返回值
* pBuffer:读取到的数据存放的位置
* length:读取数据的长度

##### 返回值

* 成功读取到的数据字节，错误则返回错误代码（负数）

---

### API_FS_Write

```c
int32_t  API_FS_Write(
    int32_t  fd,
    uint8_t* pBuffer,
    uint32_t length
);
```

##### 功能

写入文件

##### 参数

* fd：文件描述符，`API_FS_Open`的返回值
* pBuffer:读取到的数据存放的位置
* length:读取数据的长度

##### 返回值

* 成功写入的数据字节，错误则返回错误代码（负数）

---

### API_FS_Flush

```c
uint32_t API_FS_Flush(
    int32_t fd
);
```

##### 功能

刷新缓冲区

##### 参数

* fd：文件描述符，`API_FS_Open`的返回值

##### 返回值

* 返回0或错误代码

---

### API_FS_Create

```c
int32_t API_FS_Create(
    PCSTR fileName,
    uint32_t mode
);
```

##### 功能

创建文件

##### 参数

* fileName:文件名，unicode编码
* mode：文件属性`FS_ATTR_...`，可以多个属性或运算传入

##### 返回值

* 成功返回0，否则返回错误代码

---

### API_FS_Delete

```c
int32_t  API_FS_Delete(
    PCSTR fileName
);
```

##### 功能

删除文件

##### 参数

* fileName:文件名，unicode编码

##### 返回值

* 成功返回0，否则返回错误代码

---

### API_FS_Seek

```c
int64_t API_FS_Seek(
    int32_t  fd,
    int64_t  offset,
    uint8_t  origin
);
```

##### 功能

设置文件指针位置

##### 参数

* fd：文件描述符，`API_FS_Open`的返回值
* offset：偏移，相对于origin的偏移字节数
* origin：偏移的起始地址,具体位置或者特殊值：`FS_SEEK_...`

##### 返回值

* 成功返回0，否则返回错误代码

---

### API_FS_IsEndOfFile

```c
int32_t API_FS_IsEndOfFile(
    int32_t fd
);
```

##### 功能

判断文件指针是否在文件末尾

##### 参数

* fd：文件描述符，`API_FS_Open`的返回值

##### 返回值

* 是在末尾则返回1，没在末尾返回0，否则返回错误代码

---

### API_FS_Rename

```c
int32_t API_FS_Rename(
    PCSTR oldName,
    PCSTR newName
);
```

##### 功能

重命名文件

##### 参数

* oldName:旧文件名，unicode编码
* newName:新文件名，unicode编码

##### 返回值

* 成功返回0，否则返回错误代码

---

### API_FS_GetFileName

```c
int32_t  API_FS_GetFileName(
    int32_t  fd,
    int32_t  nameBufferLen,
    uint8_t* fileName
);
```

##### 功能

根据文件描述符获取文件名

##### 参数

* fd：文件描述符，`API_FS_Open`的返回值
* nameBufferLen：读取到的名字存放数组的长度
* fileName：读取到的文件名

##### 返回值

* 成功返回0，否则返回错误代码

---

### API_FS_GetFileSize

```c
int64_t  API_FS_GetFileSize(
    int32_t fd
);
```

##### 功能

获取文件大小

##### 参数

* fd：文件描述符，`API_FS_Open`的返回值

##### 返回值

* 文件大小，或者错误代码

---

### API_FS_GetDirSize

```c
int64_t  API_FS_GetDirSize(
    PCSTR     fileName,
    uint64_t* size
);
```

##### 功能

获取文件夹大小

##### 参数

* fileName：文件名，unicode编码
* size：获取到的文件夹大小

##### 返回值

* 成功返回0，否则返回错误代码

---

### API_FS_GetCurDir

```c
int32_t  API_FS_GetCurDir(
    uint32_t size,
    PSTR     pCurDir
);
```

##### 功能

获取当前文件夹名称

##### 参数

* size：得到的文件夹名称存放数组长度
* pCurDir：得到的文件夹名称存放数组

##### 返回值

* 成功返回0，否则返回错误代码

---

### API_FS_ChangeDir

```c
int32_t  API_FS_ChangeDir(
    PCSTR pDirName
);
```

##### 功能

切换当前文件夹

##### 参数

* pDirName：文件夹名，unicode编码

##### 返回值

* 成功返回0，否则返回错误代码

---

### API_FS_Mkdir

```c
int32_t API_FS_Mkdir(
    PCSTR fileName,
    uint32_t mode
);
```

##### 功能

创建文件夹

##### 参数

* fileName：文件名，unicode编码
* mode：文件夹属性，`FS_ATTR_...`

##### 返回值

* 成功返回0，否则返回错误代码

---

### API_FS_Rmdir

```c
int32_t API_FS_Rmdir(
    PCSTR dirName
);
```

##### 功能

删除文件夹

##### 参数

* dirName：文件夹名，unicode编码

##### 返回值

* 成功返回0，否则返回错误代码

---

### API_FS_GetFSInfo

```c
int32_t API_FS_GetFSInfo(
    PCSTR         pDevName,
    API_FS_INFO* pFsInfo
);
```

##### 功能

获取储存空间大小信息

##### 参数

* pDevName:设备名：`FS_DEVICE_NAME_...`
* pFsInfo:返回的储存空间信息

##### 返回值

* 成功返回0，否则返回错误代码

---

