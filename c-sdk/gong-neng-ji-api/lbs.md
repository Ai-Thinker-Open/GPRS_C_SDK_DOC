LBS 基站定位获取经纬度
====


在某些场景中，需要使用到经纬度来判断模块所在的位置，但是又不需要十分精确的位置，这个时候可以不使用GPS，使用基站定位即可实现这个功能


基站定位的原理主要是通过GSM模块获取到周围的基站信息，然后将这些基站信息通过GPRS发送到位置服务器，服务器可以根据基站信息计算出大致的经纬度后返回给模块

所以如果需要使用LBS，可以自己搭建服务器（推荐），GPRS模块通过长传基站信息来获得经纬度信息；
也可以使用SDK中的api，暂时只支持国内位置查询

[demo/lbs](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/lbs/src/demo_lbs.c)


## 功能函数

### LBS_GetLocation

```c
bool LBS_GetLocation(Network_Location_t* bsInfo, uint8_t bsNumber,int timeoutS, float* longitude, float* latitude);
```

##### 功能

通过基站信息获得经纬度，使用前保证网络已经激活可用


##### 参数

* bsInfo: 基站信息，通过`Network_GetCellInfoRequst`获得
* bsNumber: 基站数量
* timeoutS: 网络超时时间
* longitude: 纬度返回值
* latitude: 经度返回值

##### 返回值

* 是否成功获取到经纬度





