time（RTC）
====

基本的RTC时间以及系统时间戳，以及网络时间同步等


例程：[demo/time](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/time/src/demo_time.c)


## 时间相关类型

### time_t

用整数来表示时间

```c
typedef int32_t         time_t;
```

---

### clock_t

用整数来表示时间

```c
typedef long         clock_t;
```

---

## 宏定义

### CLOCKS_PER_SEC

系统clock转秒

```c
#define CLOCKS_PER_SEC   (16384.0)
```

---

### CLOCKS_PER_MSEC

系统clock转ms

```c
#define CLOCKS_PER_MSEC  (16.384)
```

---


## 结构体类型

### tm

时间表示，包括年月日时分秒

```c
typedef struct tm{
    int tm_sec;         /* 秒，范围从 0 到 59        */
    int tm_min;         /* 分，范围从 0 到 59        */
    int tm_hour;        /* 小时，范围从 0 到 23        */
    int tm_mday;        /* 一月中的第几天，范围从 1 到 31    */
    int tm_mon;         /* 月，范围从 0 到 11        */
    int tm_year;        /* 自 1900 年起的年数        */
    int tm_wday;        /* 一周中的第几天，范围从 0 到 6    */
    int tm_yday;        /* 一年中的第几天，范围从 0 到 365    */
    int tm_isdst;       /* 夏令时                */
 }tm;
```

---

### timeval_t

时间，秒和微秒表示

```c
typedef struct timeval {
    time_t    tv_sec;        // seconds
    long         tv_usec;       //microsecond
}timeval_t;
```

---

### timezone_t

时区类型

```c
typedef struct timezone {
    int tz_minuteswest;
    int tz_dsttime;
}timezone_t;
```

---

### RTC_Time_t

RTC时间

```c
typedef struct{
    uint16_t year;
    uint8_t  month;
    uint8_t  day;
    uint8_t  hour;
    uint8_t  minute;
    uint8_t  second;
    int8_t   timeZone;        // 时区小时数
    int8_t   timeZoneMinutes; // 时区不足小时的分钟数
                              // 所以 `时区 = timeZone+timeZoneMinutes/60`
}RTC_Time_t;
```

---

## 功能函数


### gettimeofday

```c
int gettimeofday(timeval_t *tv, timezone_t *tz);
```

##### 功能

获取系统时间，秒和微秒

##### 参数

* tv：时间信息，秒和微妙(实际上系统无法到微妙级,值是毫秒*1000得到)
* tz：未实现，始终为NULL

##### 返回值

* 获取成功返回0，否则非0

---

### TIME_SetIsAutoUpdateRtcTime

```c
void TIME_SetIsAutoUpdateRtcTime(bool isAutoUpdate);
```

##### 功能

附着到GPRS网络时，会获取到网络时间，如果设置为true，则将这个网络时间同步到RTC本地时间，
设置为false则不会同步

##### 参数

* isAutoUpdate：是否同步网络时间

##### 返回值

无

---

### TIME_IsAutoUpdateRtcTime

```c
bool TIME_IsAutoUpdateRtcTime();
```

##### 功能

查询当前配置，是否会自动从网路同步时间到本地时间

##### 参数

无

##### 返回值

* 是否自动同步网络时间到本地，true：同步； false：不同步

---

### TIME_SetRtcTime

```c
bool TIME_SetRtcTime(RTC_Time_t* time);
```

##### 功能

设置本地RTC时间

##### 参数

* time:时间

##### 返回值

* 是否设备成功

---

### TIME_GetRtcTIme

```c
bool TIME_GetRtcTIme(RTC_Time_t* time);
```

##### 功能

获取本地RTC时间

##### 参数

* time：时间

##### 返回值

* 是否成功获取到时间

---

### clock

```c
clock_t clock(void);
```

##### 功能

获取系统时钟，注意不是时间，需要转换，比如转换成秒需要除以16384，运算时注意是整数运算还是浮点运算

##### 参数

无

##### 返回值

* 系统时钟

---

