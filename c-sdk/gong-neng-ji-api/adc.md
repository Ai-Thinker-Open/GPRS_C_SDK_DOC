ADC（模数转换）
======

A9/A9G模组有两个10位ADC接口，可以测量0~1.8V电压

例示程序参考 [`demo/adc`](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/adc/src/demo_adc.c)

---


## 枚举类型

### ADC_Channel_t

ADC通道，总共两个通道，ADC0和ADC1

```c
typedef enum
{
    ADC_CHANNEL_0 = 0 ,
    ADC_CHANNEL_1     ,
    ADC_CHANNEL_MAX
}ADC_Channel_t;
```
---

### ADC_Sample_Period_t

ADC采样周期

```c
typedef enum
{
    ADC_SAMPLE_PERIOD_122US = 0        ,
    ADC_SAMPLE_PERIOD_1MS              ,
    ADC_SAMPLE_PERIOD_10MS             ,
    ADC_SAMPLE_PERIOD_100MS            ,
    ADC_SAMPLE_PERIOD_250MS            ,
    ADC_SAMPLE_PERIOD_500MS            ,
    ADC_SAMPLE_PERIOD_1S               ,
    ADC_SAMPLE_PERIOD_2S               ,
    ADC_SAMPLE_PERIOD_MAX              
} ADC_Sample_Period_t;//Acquisition Time Period
```

---

## 结构体类型

### ADC_Config_t

ADC配置信息，包含了通道值和采样周期

```c
typedef struct
{
    ADC_Channel_t        channel;
    ADC_Sample_Period_t  samplePeriod;
}ADC_Config_t;
```


## 功能函数

### ADC_Init

```c
void ADC_Init(ADC_Config_t adcConfig);
```

##### 功能

初始化ADC

##### 参数

* adcConfig：ADC配置信息

##### 返回值

无

---

### ADC_Read

```c
bool ADC_Read(ADC_Channel_t channel, uint16_t* value, uint16_t* mV);
```

##### 功能

读取ADC值，包括数值（0~1023）和电压值(0~1.8v)

##### 参数

* channel:ADC通道选择
* value:读取到的值，传入指针
* mV:读取到的电压值，传入指针

##### 返回值

* bool：是否读取成功

---

### ADC_Close

```c
void ADC_Close(ADC_Channel_t channel);
```

##### 功能

关闭ADC定期采样，当所有通道关闭后会释放ADC硬件资源

##### 参数

* channel:ADC通道选择

##### 返回值

无

---








