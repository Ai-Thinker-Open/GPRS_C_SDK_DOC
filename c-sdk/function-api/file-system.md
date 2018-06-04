File System
====

SDK does not currently provide flash related operations, but provides a more convenient and simple file system to use.
You need to persist data or configuration information, just save it as a file.
You can save data to flash internal or save it to the external TF card.


example:[demo/fs](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/fs/src/demo_fs.c)


## Macro definition

### FS_TFLASH_ROOT

The location of the TF Card auto mount on system start

```c
#define FS_TFLASH_ROOT "/t"
```

---

### FS_O_RDONLY

Read only

```c
#define FS_O_RDONLY                0
```

---

#### FS_O_WRONLY

Write only

```c
#define FS_O_WRONLY                1
```

---

### FS_O_RDWR

Read and Write

```c
#define FS_O_RDWR                  2
```

---

### FS_O_ACCMODE

When reading and writing file operations, get the low 2 bits flag (read the file permissions).

```c
#define FS_O_ACCMODE               3
```

---

### FS_O_CREAT

If a file exists, it will not affect, if it does not exist, it will be established and return to success.

If a file exists and has `FS_O_EXCL`, it returns fail.

```c
#define FS_O_CREAT                 00100
```

---

### FS_O_EXCL

If it is set at the same time as `FS_O_CREAT`, and the file already exists, then the creation of the file operation will fail and return -1.

```c
#define FS_O_EXCL                  00200
```

---

### FS_O_TRUNC

If the file is present, it will be opened with only write or read only, and delete the contents before the file.

```c
#define FS_O_TRUNC                 01000
```

---

### FS_O_APPEND

Append data

```c
#define FS_O_APPEND                02000
```

---

### FS_ATTR_MARK

File attribute flags

```c
#define FS_ATTR_MARK       0x0
```

---

### FS_ATTR_RO

File attribute read only

```c
#define FS_ATTR_RO            0x00000001
```

---

### FS_ATTR_HIDDEN

File attribute hidden

```c
#define FS_ATTR_HIDDEN    0x00000002
```

---

### FS_ATTR_SYSTEM

File attribute system file

```c
#define FS_ATTR_SYSTEM    0x00000004
```

---

### FS_ATTR_VOLUME

File attribute volume

```c
#define FS_ATTR_VOLUME    0x00000008
```

---

### FS_ATTR_DIR

File attribute folder

```c
#define FS_ATTR_DIR           0x00000010
```

---

### FS_ATTR_ARCHIVE

File attribute archive

```c
#define FS_ATTR_ARCHIVE   0x00000020
```

---

### FS_SEEK_SET

File position start

```c
#define FS_SEEK_SET                 0
```

---

### FS_SEEK_CUR

file current position

```c
#define FS_SEEK_CUR                 1
```

---

### FS_SEEK_END

file position end

```c
#define FS_SEEK_END                 2
```

---

### FS_DEVICE_NAME_T_FLASH

TF card name

```c
#define FS_DEVICE_NAME_T_FLASH  "TF"
```

---

### FS_DEVICE_NAME_FLASH

Flash name

```c
#define FS_DEVICE_NAME_FLASH    "FLASH"
```

---

### ERR_FS

error code see:[api_inc_fs.h](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/include/api_inc/api_inc_fs.h)

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


## Struct

### API_FS_INFO

File system size info

```c
typedef struct
{
    UINT64 totalSize;    // Total size
    UINT64 usedSize;     // Has used  size
} API_FS_INFO;
```

---


## Function


### API_FS_Open

```c
int32_t  API_FS_Open(
    PCSTR    fileName,
    uint32_t operationFlag,
    uint32_t mode
);
```

#### Function

Open file

#### Parameters

* fileName：File name, note that the name of the file is only encoded by Unicode,
First call `LocalLanguage2UnicodeBigEndian` to convert the character format to unicode encoding.
* operationFlag：Operation marks, such as read-only, write only, and so on (`FS_O_...), can be carried out or calculated by multiple operations.
* mode：Mode, file or folder attribute, `FS_ATTR_..., can be performed or calculated by multiple operations.

#### Return

* if success, return file descriptor id(>=0),or return error code

---

### API_FS_Close

```c
int32_t  API_FS_Close(
    int32_t fd
);
```

#### Function

Close file

#### Parameters

* fd：The file descriptor, the return value of the `API_FS_Open`

#### Return

* return 0 if success, or return error code

---

### API_FS_Read

```c
int32_t  API_FS_Read(
    int32_t  fd,
    uint8_t* pBuffer,
    uint32_t length
);
```

#### Function

read data

#### Parameters

* fd：The file descriptor, the return value of the `API_FS_Open`
* pBuffer:The location of the read data storage
* length: Length of read data

#### Return

* data length of read success, or error code

---

### API_FS_Write

```c
int32_t  API_FS_Write(
    int32_t  fd,
    uint8_t* pBuffer,
    uint32_t length
);
```

#### Function

Write file

#### Parameters

* fd：The file descriptor, the return value of the `API_FS_Open`
* pBuffer: Data to write
* length: Data length

#### Return

* Write length, or return error code

---

### API_FS_Flush

```c
uint32_t API_FS_Flush(
    int32_t fd
);
```

#### Function

Flush cache

#### Parameters

* fd：The file descriptor, the return value of the `API_FS_Open`

#### Return

* 0 or error code

---

### API_FS_Create

```c
int32_t API_FS_Create(
    PCSTR fileName,
    uint32_t mode
);
```

#### Function

Create file

#### Parameters

* fileName:file anme with unicode encoding
* mode：file attribute `FS_ATTR_...`

#### Return

* return 0 or error code

---

### API_FS_Delete

```c
int32_t  API_FS_Delete(
    PCSTR fileName
);
```

#### Function

Delete file

#### Parameters

* fileName:file name with unicode encoding

#### Return

* success reutrn 0 or return error code

---

### API_FS_Seek

```c
int64_t API_FS_Seek(
    int32_t  fd,
    int64_t  offset,
    uint8_t  origin
);
```

#### Function

Set file pointer position

#### Parameters

* fd：The file descriptor, the return value of the `API_FS_Open`
* offset：Offset, the number of offset bytes relative to origin
* origin：The starting address, the specific location or the special value of the offset: `FS_SEEK_...

#### Return

* 0 or error code

---

### API_FS_IsEndOfFile

```c
int32_t API_FS_IsEndOfFile(
    int32_t fd
);
```

#### Function

Determine whether the file pointer is at the end of the file

#### Parameters

* fd：The file descriptor, the return value of the `API_FS_Open`

#### Return

* return 1 if is the end of file , return 0 if not, or error code

---

### API_FS_Rename

```c
int32_t API_FS_Rename(
    PCSTR oldName,
    PCSTR newName
);
```

#### Function

Rename file name

#### Parameters

* oldName: old name with unicode encoding
* newName: new name with unicode encoding

#### Return

* return 0 or error code

---

### API_FS_GetFileName

```c
int32_t  API_FS_GetFileName(
    int32_t  fd,
    int32_t  nameBufferLen,
    uint8_t* fileName
);
```

#### Function

Obtaining the file name based on the file descriptor

#### Parameters

* fd：The file descriptor, the return value of the `API_FS_Open`
* nameBufferLen：buffer length
* fileName：the name read

#### Return

* return 0 if success, or return error code

---

### API_FS_GetFileSize

```c
int64_t  API_FS_GetFileSize(
    int32_t fd
);
```

#### Function

Get file size

#### Parameters

* fd：The file descriptor, the return value of the `API_FS_Open`

#### Return

* file size or error code

---

### API_FS_GetDirSize

```c
int64_t  API_FS_GetDirSize(
    PCSTR     fileName,
    uint64_t* size
);
```

#### Function

Get folder size

#### Parameters

* fileName：file name with unicode encoding
* size：folder size

#### Return

* return 0 if success, or return error code

---

### API_FS_GetCurDir

```c
int32_t  API_FS_GetCurDir(
    uint32_t size,
    PSTR     pCurDir
);
```

#### Function

Get current folder name 

#### Parameters

* size：size of name buffer
* pCurDir：name buffer

#### Return

* return 0 if success, or return error code

---

### API_FS_ChangeDir

```c
int32_t  API_FS_ChangeDir(
    PCSTR pDirName
);
```

#### Function

Change current directory 

#### Parameters

* pDirName：folder name with unicode encofing

#### Return

* return 0 if success, or return error code

---

### API_FS_Mkdir

```c
int32_t API_FS_Mkdir(
    PCSTR fileName,
    uint32_t mode
);
```

#### Function

Creat folder

#### Parameters

* fileName：file name with unicode encoding
* mode：folder attribute `FS_ATTR_...`

#### Return

* return 0 if success, or return error code

---

### API_FS_Rmdir

```c
int32_t API_FS_Rmdir(
    PCSTR dirName
);
```

#### Function

Delete folder

#### Parameters

* dirName：folder name with unicode encofing

#### Return

* return 0 if success, or return error code

---

### API_FS_GetFSInfo

```c
int32_t API_FS_GetFSInfo(
    PCSTR         pDevName,
    API_FS_INFO* pFsInfo
);
```

#### Function

Get file system size infomation

#### Parameters

* pDevName: device name `FS_DEVICE_NAME_...`
* pFsInfo: size infomation

#### Return

* return 0 if success, or return error code

---

