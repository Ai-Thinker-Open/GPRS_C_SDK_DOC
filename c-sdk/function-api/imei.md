IMEI
===

IMEI is a string of 15 bytes in length. Each module corresponds to the only IMEI number. When the factory is produced, it is printed on the module shell and exists in the form of two-dimensional code. It can be scanned by the mobile phone to get the two-dimensional code and can be obtained by the API function.

example:[demo/imei](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/imei/src/demo_imei.c)

## Function

### INFO_GetIMEI

```c
bool INFO_GetIMEI(uint8_t* pImei);
```

#### Function

Get IMEI of module

#### Parameters

* pImei:IMEI read, length >=15 bytes

#### Return

* Get IMEI success or not

