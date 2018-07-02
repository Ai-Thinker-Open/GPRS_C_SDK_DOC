LBS Get location(longitude & latitude) from base station infomation
====


In some scenarios, it is necessary to use the latitude and longitude to determine the location of the module, but it does not require a very precise location. This time you can use the base station location to achieve this function without GPS.


The principle of base station location is to get the base station information through the GSM module, and then send the base station information to the location server through GPRS. The server can return to the module after calculating the rough latitude and longitude according to the base station information.

So if you need to use LBS, you can build your own server (recommended), and the GPRS module gets longitude and latitude information through long base station information.

You can also use API in SDK, but just support China now.


[demo/lbs](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/lbs/src/demo_lbs.c)


## Function

### LBS_GetLocation

```c
bool LBS_GetLocation(Network_Location_t* bsInfo, uint8_t bsNumber,int timeoutS, float* longitude, float* latitude);
```

##### 功能

Get location(longitude & latitude) from base station infomation, please ensure network activate complete already


##### 参数

* bsInfo: Base station infomation , Get by `Network_GetCellInfoRequst`
* bsNumber: The number of base station
* timeoutS: socket timeout time,unit:s
* longitude: longitude,unit:dgree
* latitude: latitude, unit:dgree

##### 返回值

* Is get location success





