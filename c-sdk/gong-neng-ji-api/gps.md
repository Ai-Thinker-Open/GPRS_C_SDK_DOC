GPS
===

获取卫星定位信息，A9G模组内GPS芯片和GPRS芯片的串口2相连，故GPS启动后产生的信息会在串口2收到

例程：[demo/gps](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/gps/src/demo_gps.c)


## GPS_Open

```
bool GPS_Open(UART_Callback_t gpsReceivedCallback);
```

##### 功能

开启GPS

##### 参数

* gpsReceivedCallback：串口回调函数，如果设置为`NULL`，则收到串口2收到GPS数据后不会产生回调，而是将GPS的数据以事件的方式发送给主任务；若不为`NULL`，则不会产生事件，设置的串口回调函数会被调用，不要在处理函数中消耗太多时间。建议使用事件的方式，参考GPS例程

##### 返回值

* 是否成功打开GPS

#### 
bool GPS_Close();