FOTA
====

参考例程 [demo/fota](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/fota/src/demo_fota.c)

## 升级流程简介

考虑到流量使用以及flash空间占用，升级使用了查分升级的方式，类似Android中的App增量更新，每次升级必须在上一次的基础上进行升级，因此每次生成固件后需要保留旧固件方便以后升级使用
每次的升级包最大64kB，
如果使用到了FOTA功能，堆需要预留最大64kB的空间，以及文件系统也需要预留64kB

* 应用程序通过串口或者网络获取升级包并保存到flash中的文件系统中

* 获取升级包完毕后会自动重启进入升级序列

> 这时会通过HST口打印事件，事件的数值及其含义如下：
```
#define FOTA_EVENT_START_CHECK        0xf07a0000
#define FOTA_EVENT_VERSION_ERROR      0xf07a0001
#define FOTA_EVENT_STATUS_EMPTY       0xf07a0002
#define FOTA_EVENT_STATUS_DOWNLOADING 0xf07a0003
#define FOTA_EVENT_STATUS_DOWNLOADED  0xf07a0004
#define FOTA_EVENT_STATUS_UPGRADING   0xf07a0005
#define FOTA_EVENT_STATUS_UPGRADED    0xf07a0006
#define FOTA_EVENT_AREA_INVALID       0xf07a0007
#define FOTA_EVENT_UPGRADE_START      0xf07a0008
#define FOTA_EVENT_UPGRADE_PROGRESS   0xf07a0009
#define FOTA_EVENT_UPGRADE_FAILED     0xf07a000a
#define FOTA_EVENT_UPGRADE_DONE       0xf07a000b
```
> 升级过程也会汇报进度，事件共4个字节，前两个是总进度，后两个字节则是当前进度即值为(total << 16) | current
> 升级过程会备份一些数据到FOTA备份分区，以便升级过程中断电造成升级失败，分区详情见Flash分区文档

* 如果在升级过程中出现了错误，比如断电，下次上电会继续升级过程直到升级完成,因此断电不会造成固件损坏


## 例程使用

例程做的事情就是开机后从服务器获得升级包进行固件升级或者接收来自串口的升级包进行固件升级，
需要注意的是升级使用的是差分升级，每一次升级必须要在上一次的固件基础上进行升级

1. 进入工程主目录，`./build.bat clean`清理工程
2. 修改例程代码：
使用串口升级或者通过http服务器升级，通过注释代码选择
```c
    // FOTA_UartTest();
    FOTASERVER_Test();
```
如果是服务器升级，需要修改服务器固件地址，即升级包的地址，
比如：
```
#define SOFT_VERSION          "V3.0"
#define FOTA_HTTP_SERVER      "http://test.ai-thinker.com/csdk/fota/%stonew.pack"
```
后面我们生成的升级包就需要将名字改成`V3.0tonew.pack`

1. `./build.bat demo fota` 编译生成老版本固件，在`hex/fota`文件夹下可以看到`fota_*_debug.lod`和`fota_*_debug_ota.lod`,备份`hex/fota/fota_*_debug_ota.lod`为`hex/fota/old.lod`,同时备份好旧固件或者直接备份`hex/fota`文件夹
> 新版不再生成`*_ota.lod`这个文件，使用完整的lod文件即可

4. 修改代码，及新的代码比如这里修改
```
#define SOFT_VERSION          "V3.0"
```
为
```
#define SOFT_VERSION          "V3.1"
```

5. 编译新版本固件,`./build.bat demo fota`,同理得到`hex/fota/new.lod`

6. 生成升级包, `./build.bat fota hex/fota/old.lod hex/fota/new.lod V3.0tonew.pack`，这里第四个参数就是之前链接里的名字，如果串口升级名字无所谓。并将这个升级包拷贝到http服务器代码中对应的升级地址。
#### **注意这里各个固件的路径**

7. 下载老版本固件(`fota_*_debug.lod`)到硬件运行，如果是串口升级则用串口发送升级文件`*.pack`，等待升级完毕后重启；如果是http服务器升级，例程上电后会自动联网获取升级包进行升级，升级完毕后自动重启。

升级完成后可以看到打印的消息中，版本从3.0升级到了3.1




