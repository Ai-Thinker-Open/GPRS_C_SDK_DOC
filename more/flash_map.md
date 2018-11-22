Flash 分区布局
=======

内置了4M Flash，其中留给用户程序的空间位1M，详情如下表：

| 地址               | 空间大小    | 功能               |
| ---               | -------    | ----              |
| 0x000000~0x099999 |  64 (kB)   | Bootloader        |
| 0x100000~0x239999 |  1.25 (MB) | platform          |
| 0x240000~0x339999 |  1M (MB)   | APP               |
| 0x340000~0x379999 |  256 (kB)  | reserved          |
| 0x380000~0x389999 |  64 (kB)   | FOTA backup       | 
| 0x390000~0x3F5999 |  408 (kB)  | SPIFFS            |
| 0x3F6000~0x3F9999 |  16 (kB)   | FatFS(deprecated) |
| 0x3FA000~0x3FB999 |  8 (kB)    | Calib1            |
| 0x3FC000~0x3FD999 |  8 (kB)    | Calib2            |
| 0x3FE000~0x3FE9999|  8 (kB)    | Factory CFG       |


* 用户程序在APP分区中

* 文件系统在SPIFFS分区中

* 旧的FatFS因为读写均衡原因弃用了，但是考虑到历史原因，该分区仍保存，尽量不要再使用这个文件系统

* 系统配置分区以及校准分区为出厂时写入，请不要随意修改和擦除

* FOTA backup 分区是用来在FOTA升级时保证升级正常进行的备份分区，请勿另作他用

* reserved分区目前没有使用，在APP分区使用完之前不建议使用这个分区，可能在将来会使用

* platform是系统底层代码存放区域，请勿修改

* bootloader为启动引导分区，请勿修改

