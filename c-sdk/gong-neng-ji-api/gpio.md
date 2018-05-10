GPIO (General Purpose Input Output)通用输入输出接口
===


要保证引脚功能可以正常使用，在配置IO之前必须将对应IO口的电源打开，使用
```c
bool PM_PowerEnable(Power_Type_t powerType, bool isOn)
```c
函数来打开对应的IO口电源,不同IO口对应的电源如下：
```c
typedef enum{
    POWER_TYPE_VPAD = 0,            // GPIO0  ~ GPIO7  and GPIO25 ~ GPIO36    2.8V   //always on
    POWER_TYPE_MMC,                 // GPIO8  ~ GPIO13                        1.9V
    POWER_TYPE_LCD,                 // GPIO14 ~ GPIO18                        1.9V
    POWER_TYPE_CAM,                 // GPIO19 ~ GPIO24                        1.9V
    POWER_TYPE_MAX
}Power_Type_t;
```

> 比如：
* 需要使用GPIO5，则需要调用`PM_PowerEnable(POWER_TYPE_VPAD,true);`
* 需要调用I2C2,因为I2C2是复用IO19和20，所以调用`PM_PowerEnable(POWER_TYPE_CAM,true);`

模组引脚除了通用IO功能外，部分引脚还有复用功能，具体见[开发板中的引脚图](../../ying-jian/kai-fa-ban-pudding.md/#引脚图)



例示代码请参考[CSDK demo/gpio](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/gpio/src/demo_gpio.c)

---


## 枚举类型

### GPIO_PIN

引脚

```c
typedef enum{
    GPIO_PIN0 = 0, //IO 可中断
    GPIO_PIN1,     //IO 可中断
    GPIO_PIN2,     //IO 可中断
    GPIO_PIN3,     //IO 可中断
    GPIO_PIN4,     //IO 可中断
    GPIO_PIN5,     //IO 可中断
    GPIO_PIN6,     //IO 可中断
    GPIO_PIN7,     //IO 可中断
    GPIO_PIN8,
    GPIO_PIN9,
    GPIO_PIN10,
    GPIO_PIN11,
    GPIO_PIN12,
    GPIO_PIN13,
    GPIO_PIN14,
    GPIO_PIN15,
    GPIO_PIN16,
    GPIO_PIN17,
    GPIO_PIN18,
    GPIO_PIN19,
    GPIO_PIN20,
    GPIO_PIN21,
    GPIO_PIN22,
    GPIO_PIN23,
    GPIO_PIN24,
    GPIO_PIN25,
    GPIO_PIN26,
    GPIO_PIN27,
    GPIO_PIN28,
    GPIO_PIN29,
    GPIO_PIN30,
    GPIO_PIN31,
    GPIO_PIN32,
    GPIO_PIN33,
    GPIO_PIN34,
    GPIO_PIN_MAX
}GPIO_PIN;
```

---

### GPIO_MODE

IO模式

```c
typedef enum{
    GPIO_MODE_OUTPUT = 0,   // 输出模式
    GPIO_MODE_INPUT,        // 输入模式
    GPIO_MODE_INPUT_INT,    // 中断模式
    GPIO_MODE_MAX
}GPIO_MODE;
```

---

### GPIO_LEVEL

高低电平

```c
typedef enum{
    GPIO_LEVEL_LOW  = 0,  //低电平
    GPIO_LEVEL_HIGH = 1   //高电平
}GPIO_LEVEL;
```

---

### GPIO_INT_TYPE

中断类型

```c
typedef enum {
    GPIO_INT_TYPE_HIGH_LEVEL = 0,      //高电平中断
    GPIO_INT_TYPE_LOW_LEVEL,           //低电平中断
    GPIO_INT_TYPE_RISING_EDGE,         //上升沿中断
    GPIO_INT_TYPE_FALLING_EDGE,        //下降沿中断
    GPIO_INT_TYPE_RISING_FALLING_EDGE, //上升沿和下降沿中断
    GPIO_INT_TYPE_MAX
}GPIO_INT_TYPE;
```

---


## 结构体类型

### GPIO_INT_callback_param_t

中断回调函数参数类型

```c
typedef struct{
    GPIO_PIN pin;
}GPIO_INT_callback_param_t;
```

---

### PCallbackINT

中断回调函数类型

```c
typedef void (*PCallbackINT)(GPIO_INT_callback_param_t* param);
```

---

### GPIO_INT_config_t

中断配置选项

```c
typedef struct{
    uint16_t        debounce; //去抖时间（ms）
    GPIO_INT_TYPE   type    ;
    PCallbackINT    callback;
}GPIO_INT_config_t;
```

---

### GPIO_config_t

GPIO配置选项

```c
typedef struct{
    GPIO_PIN          pin         ;  //引脚
    GPIO_MODE         mode        ;  //模式
    GPIO_LEVEL        defaultLevel;  //默认电平
    GPIO_INT_config_t intConfig   ;  //中断配置（中断模式需要配置）
}GPIO_config_t;
```

---


## 功能函数接口


### GPIO_Init

```c
bool GPIO_Init(GPIO_config_t config);
```

##### 功能

初始化IO

##### 参数

* config：初始化配置

##### 返回值

* bool：配置成功/失败

----

### GPIO_GetConfig

```c
void GPIO_GetConfig(GPIO_PIN pin,GPIO_config_t* config);
```

##### 功能

获取GPIO配置

##### 参数

* config：GPIO配置变量地址

##### 返回值

---


### GPIO_SetLevel

```c
bool GPIO_SetLevel(GPIO_config_t gpioConf, GPIO_LEVEL  level);
```

##### 功能

设置GPIO电平

##### 参数

* gpioConf：GPIO初始化配置变量
* level:电平高低

##### 返回值

* bool：是否设置成功

---



### GPIO_Set

```c
bool GPIO_Set(GPIO_PIN pin, GPIO_LEVEL  level);
```

##### 功能

设置GPIO电平，与`GPIO_SetLevel`功能一样，只是参数不一样

##### 参数

* pin:GPIO口
* level:电平高低

##### 返回值

* bool：是否设置成功

---


### GPIO_GetLevel

```c
bool GPIO_GetLevel(GPIO_config_t gpioConf, GPIO_LEVEL* level);
```

##### 功能

获取GPIO电平

##### 参数

* gpioConf:GPIO初始化配置变量
* level:电平高低结果返回值，变量指针

##### 返回值

* bool：是否获取成功

---


### GPIO_Get

```c
bool GPIO_Get(GPIO_PIN pin, GPIO_LEVEL* level);
```

##### 功能

获取GPIO电平，功能与`GPIO_GetLevel`一样，只是参数不同

##### 参数

* pin:GPIO口
* level:电平高低结果返回值，变量指针

##### 返回值

* bool：是否获取成功

---



### GPIO_Close

```c
bool GPIO_Close(GPIO_PIN pin);
```

##### 功能

关闭GPIO口，复位GPIO到默认状态

##### 参数

* pin:GPIO口

##### 返回值

* bool：是否成功

---


