[Ai-Thinker GPRS C SDK](https://github.com/Ai-Thinker-Open/GPRS-C-SDK) 文档
======

[![Build Status](https://travis-ci.org/Ai-Thinker-Open/GPRS_C_SDK_DOC.svg?branch=master)](https://travis-ci.org/Ai-Thinker-Open/GPRS_C_SDK_DOC)

Ai-Thinker SoC development GPRS C SDK documention

安信可GPRS模组片上(SoC)开发C语言版SDK文档



CSDK代码：[GPRS_C_SDK](https://github.com/Ai-Thinker-Open/GPRS-C-SDK)

文档源码：[GPRS_C_SDK_DOC](https://github.com/Ai-Thinker-Open/GPRS_C_SDK_DOC)

[点我在线阅读文档](https://ai-thinker-open.github.io/GPRS_C_SDK_DOC/zh) ( [Read English](https://ai-thinker-open.github.io/GPRS_C_SDK_DOC/en) )




## 关于模组

安信可GPRS模组型号主要有**A9**，**A9G**。
A9主要有GSM/GPRS（2G)相关功能；A9G除了GSM/GPRS还集成了定位芯片，方便定位相关的应用，更多功能介绍请看硬件介绍章节

模组样品都可以在淘宝购买到：[淘宝链接](https://anxinke.taobao.com/category-1303500786.htm?spm=2013.1.w5002-16491372996.5.3c354c53OwDR7Y&search=y&catName=GPRS%C4%A3%D7%E9%C7%F8)

## 开发

模组的开发主要提供两种接口：

（一） **AT接口**

即需要外接MCU使用串口来操作模组

   * 这种方式操作较简单，是需要让模块实施什么动作通过串口向模块发送一个命令即可，这个命令就是一串字符串，具体哪个命令是什么字符串，查AT文档即可，适合刚入门的开发者
   * 模组出厂默认烧录的就是AT固件，拿到模组就可以操作，资料参见这里：[安信可wiki](http://wiki.ai-thinker.com/gprs)
   * 本文档不涉及任何AT操作

（二）**SDK片上开发**(SoC开发/SDK二次开发)

不需要外接MCU，直接写GPRS模组的固件，对GPRS模组进行编程.
A9/A9G GPRS模块使用RDA8955作为主芯片,主频能达到312MHz,除了跑协议栈之外,还有很多空余的资源可以使用,非常适合拿来进行二次开发,可以满足大多数应用需要,但是不建议跑实时性要求非常高的控制类应用

   * 这种方式的优点是不用再外接MCU，直接对模组编程，节约了硬件资源，适合对硬件成本要求高的场景
   * 本文就是使用这种方式，详细介绍如何使用SDK进行开发，并提供相关API说明
   * 本SDK中不包含AT应用及接口,所有操作均通过SDK接口调用