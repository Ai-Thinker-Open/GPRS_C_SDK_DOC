ADC
======

A9/A9G have two 10 bits ADC interface, 0~1.8V voltage can be measured

example: [`demo/adc`](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/adc/src/demo_adc.c)

---


## Enumerated type

### ADC_Channel_t

ADC channel,ADC0 and ADC1

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

ADC sample rate

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

## Struct

### ADC_Config_t

ADC config info, include channel and sample rate

```c
typedef struct
{
    ADC_Channel_t        channel;
    ADC_Sample_Period_t  samplePeriod;
}ADC_Config_t;
```


## Function

### ADC_Init

```c
void ADC_Init(ADC_Config_t adcConfig);
```

#### Function

初始化ADC

#### Parameters

* adcConfig：ADC config infomation

#### Return

None

---

### ADC_Read

```c
bool ADC_Read(ADC_Channel_t channel, uint16_t* value, uint16_t* mV);
```

#### Function

Read ADC value, value in 0~1023, voltage in 0~1.8v

#### Parameters

* channel:ADC channel
* value: the value read
* mV: the voltage value read

#### Return

* bool：read success or not

---

### ADC_Close

```c
void ADC_Close(ADC_Channel_t channel);
```

#### Function

关闭ADC定期采样，当所有通道关闭后会释放ADC硬件资源
Close ADC, release ADC resources when all channel are closed

#### Parameters

* channel:ADC channel

#### Return

None

---








