Power Manager 
====

It contains some basic power related operations, peripheral power settings, shutdown, restart, low power consumption, etc.

Release of power button will cause an event: `API_EVENT_ID_KEY_DOWN`, `API_EVENT_ID_KEY_UP`

example:[demo/pm](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/pm/src/demo_pm.c)


## Enumerated type

### Power_Type_t

Peripherals power supply

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

Cause of opening

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


## Function


### PM_PowerEnable

```c
bool PM_PowerEnable(Power_Type_t powerType, bool isOn);
```

#### Function

It is important to enable peripheral power. When you use peripherals, you must turn on the power supply before you can use it.

#### Parameters

* powerType: peripherals power supply
* isOn: switch

#### Return

* Whether or not it has been successfully set up

---

### PM_SleepMode

```c
void PM_SleepMode(bool isSleepMode);
```

#### Function

Low power mode, low power mode will reduce the main frequency to 32kHz, the program will still run, and can be called back to restore this function.

At the same time, it can turn off peripherals and their power to reduce power consumption.

#### Parameters

* isSleepMode：Whether or not to enter a low power mode, true enters

#### Return

None

---

### PM_Voltage

```c
uint16_t PM_Voltage(uint8_t* percent);
```

#### Function

Check the battery voltage

#### Parameters

* percent:Percentage of battery power

#### Return

* Voltage value, unit: milli V

---

### PM_ShutDown

```c
void PM_ShutDown();
```

#### Function

Turn off the machine

#### Parameters

None

#### Return

None

---

### PM_Restart

```c
void PM_Restart();
```

#### Function

Reboot system

#### Parameters

None

#### Return

None

---

