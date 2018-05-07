ADC（模数转换）
======

A9/A9G模组有两个10位ADC接口，可以测量0~1.8V电压

例示程序参考 [`demo/adc`](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/adc/src/demo_adc.c)

---


## 一：枚举类型

#### ADC_Channel_t

ADC通道，总共两个通道，ADC0和ADC1

```
typedef enum
{
    ADC_CHANNEL_0 = 0 ,
    ADC_CHANNEL_1     ,
    ADC_CHANNEL_MAX
}ADC_Channel_t;
```
-----

#### ADC_Sample_Period_t

ADC采样周期

```
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

## 二：结构体类型

## 三：功能函数







