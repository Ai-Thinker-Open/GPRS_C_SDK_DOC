ICCID(Integrate circuit card identity 集成电路卡识别码)
===

ICCD是SIM卡的唯一标识,长度为20的字符串。

例程：[demo/iccid](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/iccid/src/demo_iccid.c)

## 函数

### SIM_GetICCID

```c
bool SIM_GetICCID(uint8_t* iccid);
```

##### 功能

获取SIM卡ICCID值

##### 参数

* iccid：获取到的iccid值存放位置，数组长度>=20

##### 返回值

* 是否成功获取ICCID值，如果失败请检查卡是否插好

