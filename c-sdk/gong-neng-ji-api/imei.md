IMEI
===

IMEI是一串长度为15个字节的字符串，每个模组对应唯一IMEI号，生产出厂的时候确定，并且印在模组壳子上，以二维码形式存在，可以用手机扫描得到二维码得到，也可以通过API函数得到

例程：[demo/imei](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/imei/src/demo_imei.c)

## 函数

### INFO_GetIMEI

```c
bool INFO_GetIMEI(uint8_t* pImei);
```

##### 功能

获取模组IMEI号

##### 参数

* pImei:获取到的IMEI号存放位置，注意，数组长度>=15字节

##### 返回值

* 是否获取IMEI号成功

