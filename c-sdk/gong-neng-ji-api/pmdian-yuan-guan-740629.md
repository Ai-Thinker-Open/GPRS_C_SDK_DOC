Power Manager 电源管理
====

包含了一些基本的电源相关的操作，外设电源设置、关机、重启、低功耗等

电源按键按下释放会产生事件：`API_EVENT_ID_KEY_DOWN`，`API_EVENT_ID_KEY_UP`

例程：[demo/pm](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/pm/src/demo_pm.c)


## 枚举类型

### Power_Type_t

外设电源

```c
typedef enum{
    POWER_TYPE_VPAD = 0,            // GPIO0  ~ GPIO7  and GPIO25 ~ GPIO36    2.8V   //always on
    POWER_TYPE_MMC,                 // GPIO8  ~ GPIO13                        1.9V
    POWER_TYPE_LCD,                 // GPIO14 ~ GPIO18                        1.9V
    POWER_TYPE_CAM,                 // GPIO19 ~ GPIO24                        1.9V
    POWER_TYPE_MAX
}Power_Type_t;
```

---

### Power_On_Cause_t

开机原因

```c
typedef enum{
    POWER_ON_CAUSE_KEY = 0  ,
    POWER_ON_CAUSE_CHARGE   ,
    POWER_ON_CAUSE_ALARM    ,
    POWER_ON_CAUSE_EXCEPTION,
    POWER_ON_CAUSE_RESET    ,
    POWER_ON_CAUSE_MAX
}Power_On_Cause_t;
```

---


## 功能函数


### PM_PowerEnable

```c
bool PM_PowerEnable(Power_Type_t powerType, bool isOn);
```

##### 功能

使能外设电源，重要，在使用外设时一定要先打开电源，否则无法使用

##### 参数

* powerType：外设电源
* isOn：开关

##### 返回值

* 是否成功设置

---

### PM_SleepMode

```c
void PM_SleepMode(bool isSleepMode);
```

##### 功能

低功耗模式，低功耗模式会降低主频到32kHz，程序依然会运行，可以再调用这个函数恢复。
同时可以关闭外设及其电源来降低功耗

##### 参数

* isSleepMode：是否进入低功耗模式，true进入

##### 返回值

无

---

### PM_Voltage

```c
uint16_t PM_Voltage(uint8_t* percent);
```

##### 功能

查看电池电压

##### 参数

* percent:电池电量百分比

##### 返回值

* 电压值，单位：毫伏

---

### PM_ShutDown

```c
void PM_ShutDown();
```

##### 功能

关机

##### 参数

无

##### 返回值

无

---

### PM_Restart

```c
void PM_Restart();
```

##### 功能

系统重启

##### 参数

无

##### 返回值

无

---

