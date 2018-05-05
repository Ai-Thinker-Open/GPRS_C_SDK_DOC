GPIO (General Purpose Input Output)通用输入输出接口
===

## 一：枚举类型

#### 1. GPIO_PIN：引脚

```
typedef enum{
    GPIO_PIN0 = 0,       //IO interruptible
    GPIO_PIN1,           //IO interruptible
    GPIO_PIN2,           //IO interruptible
    GPIO_PIN3,           //IO interruptible
    GPIO_PIN4,           //IO interruptible
    GPIO_PIN5,           //IO interruptible
    GPIO_PIN6,           //IO interruptible
    GPIO_PIN7,           //IO interruptible
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

#### 2. GPIO_MODE：IO模式

```
typedef enum{
    GPIO_MODE_OUTPUT = 0,   // 输出模式
    GPIO_MODE_INPUT,        // 输入模式
    GPIO_MODE_INPUT_INT,    // 中断模式
    GPIO_MODE_MAX
}GPIO_MODE;
```

#### 3. GPIO_LEVEL：高低电平

```
typedef enum{
    GPIO_LEVEL_LOW  = 0,  //低电平
    GPIO_LEVEL_HIGH = 1   //高电平
}GPIO_LEVEL;
```

#### 4. GPIO_INT_TYPE：中断类型

```
typedef enum {
    GPIO_INT_TYPE_HIGH_LEVEL = 0,      //高电平中断
    GPIO_INT_TYPE_LOW_LEVEL,           //低电平中断
    GPIO_INT_TYPE_RISING_EDGE,         //上升沿中断
    GPIO_INT_TYPE_FALLING_EDGE,        //下降沿中断
    GPIO_INT_TYPE_RISING_FALLING_EDGE, //上升沿和下降沿中断
    GPIO_INT_TYPE_MAX
}GPIO_INT_TYPE;
```



## 二：结构体类型

## 三：功能函数接口





typedef struct{
    GPIO_PIN pin;
}GPIO_INT_callback_param_t;

typedef void (*PCallbackINT)(GPIO_INT_callback_param_t* param);

typedef struct{
    uint16_t        debounce; //ms
    GPIO_INT_TYPE   type    ;
    PCallbackINT    callback;
}GPIO_INT_config_t;

typedef struct{
    GPIO_PIN          pin         ;
    GPIO_MODE         mode        ;
    GPIO_LEVEL        defaultLevel;
    GPIO_INT_config_t intConfig   ;
}GPIO_config_t;

#endif
