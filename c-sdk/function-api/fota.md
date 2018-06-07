FOTA
====

refer to demo: [demo/fota](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/fota/src/demo_fota.c)

## Demo usage

The demo is to receive upgrade firmware from the server to upgrade firmware or to receive firmware upgrade from the serial port upgrade.

It should be noted that upgrading is based on differential upgrade. Every upgrade must be upgraded on the basis of the last firmware.

1. `./build.bat clean` to clean project
2. edit code：
Use serial or http server through comment or uncomment code
```c
    // FOTA_UartTest();
    FOTASERVER_Test();
```
If use http server, edit server address
e.g.:
```
#define SOFT_VERSION          "V3.0"
#define FOTA_HTTP_SERVER      "http://test.ai-thinker.com/csdk/fota/%stonew.pack"
```
so the `V3.0tonew.pack` is the new upgrade pack name

3. `./build.bat demo fota` compile old version firmware, `fota_*_debug.lod` and `fota_*_debug_ota.lod` can be find in `hex/fota` folder, back up `fota_*_debug_ota.lod` as `old.lod`,and back up `hex/fota` folder

4. edit new version code,e.g.:
```
#define SOFT_VERSION          "V3.0"
```
to 
```
#define SOFT_VERSION          "V3.1"
```

5. Compile new version, `./build.bat demo fota`, and we get the same new firmware `new.lod`

6. Generate a upgrade package: `./build.bat fota old.lod new.lod V3.0tonew.pack`, the fourth parameter is the name of upgrade package, must the same as the upgrade link in the code(`FOTA_HTTP_SERVER`)

7. Download the old version firmware(`fota_*_debug.lod`) to hardware, and wait auto upgrade from http server; If use serial should send upgrade file to serial. 
It will auto reboot after upgrade success. 
Then we can see the versioin upgrade to V3.1 from V3.0




