FOTA
====

参考例程 [demo/fota](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/fota/src/demo_fota.c)

## 例程使用

例程做的事情就是开机后从服务器获得升级包进行固件升级或者接收来自串口的升级包进行固件升级，
需要注意的是升级使用的是查分升级，每一次升级必须要在上一次的固件基础上进行升级

1. `./build.bat clean`清理工程
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

3. `./build.bat demo fota` 编译生成老版本固件，在`hex/fota`文件夹下可以看到`fota_*_debug.lod`和`fota_*_debug_ota.lod`,备份`fota_*_debug_ota.lod`为`old.lod`

4. 修改代码，及新的代码比如这里修改
```
#define SOFT_VERSION          "V3.0"
```
为
```
#define SOFT_VERSION          "V3.1"
```

5. 编译新版本固件,`./build.bat demo fota`,同理得到`new.lod`

6. 生成升级包, `./build.bat fota old.lod new.lod V3.0tonew.pack`，这里第四个参数就是之前链接里的名字，如果串口升级名字无所谓。并将这个升级包拷贝到http服务器代码中对应的升级地址

7. 下载老版本固件(`fota_*_debug.lod`)到硬件运行，如果是串口升级则用串口发送升级文件`*.pack`，等待升级完毕后重启；如果是http服务器升级，例程上电后会自动联网获取升级包进行升级，升级完毕后自动重启。

升级完成后可以看到打印的消息中，版本从3.0升级到了3.1




