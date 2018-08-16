time（RTC）
====

Basic RTC time and system timestamp, as well as network practice synchronization.


example:[demo/time](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/time/src/demo_time.c)


## 时间相关类型

### time_t

Use integers to represent time

```c
typedef int32_t         time_t;
```

---

### clock_t

Use integers to represent time

```c
typedef long         clock_t;
```

---

## Macro definition

### CLOCKS_PER_SEC

System clock convert to second

```c
#define CLOCKS_PER_SEC   (16384.0)
```

---

### CLOCKS_PER_MSEC

System clock convert to microsecond

```c
#define CLOCKS_PER_MSEC  (16.384)
```

---


## Struct

### tm

Time representation, including days and days

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

Time, seconds, and subtleties

```c
typedef struct timeval {
    time_t       tv_sec;        // seconds
    long         tv_usec;       //microsecond
}timeval_t;
```

---

### timezone_t

Time zone type

```c
typedef struct timezone {
    int tz_minuteswest;
    int tz_dsttime;
}timezone_t;
```

---

### RTC_Time_t

RTC time

```c
typedef struct{
    uint16_t year;
    uint8_t  month;
    uint8_t  day;
    uint8_t  hour;
    uint8_t  minute;
    uint8_t  second;
    int8_t   timeZone;        // timezone hour
    int8_t   timeZoneMinutes; // timezone minutes that less than 1 hours
                              // so `timezone = timeZone+timeZoneMinutes/60`
}RTC_Time_t;
```

---

## Function


### gettimeofday

```c
int gettimeofday(timeval_t *tv, timezone_t *tz);
```

#### Function

Get system time, seconds, and microseconds

#### Parameters

* TV: time information, seconds and microseconds
* TZ: unrealized, always NULL

#### Return

* The success returns 0, otherwise not 0

---

### TIME_SetIsAutoUpdateRtcTime

```c
void TIME_SetIsAutoUpdateRtcTime(bool isAutoUpdate);
```

#### Function

When you attach to the GPRS network, you will get the network time. If set to true, you will synchronize the network time to RTC local time.

Set to false does not synchronize

#### Parameters

* isAutoUpdate：Whether or not the network time is synchronized

#### Return

None

---

### TIME_IsAutoUpdateRtcTime

```c
bool TIME_IsAutoUpdateRtcTime();
```

#### Function

Query whether the current configuration will automatically synchronize from the network to the local time.

#### Parameters

None

#### Return

* Automatically synchronize network time to local, true: synchronization; false: asynchrony.

---

### TIME_SetRtcTime

```c
bool TIME_SetRtcTime(RTC_Time_t* time);
```

#### Function

Set local RTC time

#### Parameters

* time: time

#### Return

* Success or not

---

### TIME_GetRtcTIme

```c
bool TIME_GetRtcTIme(RTC_Time_t* time);
```

#### Function

Get local RTC time

#### Parameters

* time:time 

#### Return

* Get time success or not

---

### clock

```c
clock_t clock(void);
```

#### Function

Get the system clock, note that not time, need to change, for example, converted to seconds need to be divided by 16384.

#### Parameters

None

#### Return

* System clock

---

