[Ai-Thinker GPRS C SDK](https://github.com/Ai-Thinker-Open/GPRS-C-SDK) Documentation
======

[![Build Status](https://travis-ci.org/Ai-Thinker-Open/GPRS_C_SDK_DOC.svg?branch=en)](https://travis-ci.org/Ai-Thinker-Open/GPRS_C_SDK_DOC)

Ai-Thinker GPRS C SDK documentation


Code of CSDK: [GPRS_C_SDK](https://github.com/Ai-Thinker-Open/GPRS-C-SDK)

Source code of documention: [GPRS_C_SDK_DOC](https://github.com/Ai-Thinker-Open/GPRS_C_SDK_DOC)

[Click Me To Read Online](https://ai-thinker-open.github.io/GPRS_C_SDK_DOC/en) ( [中文](https://ai-thinker-open.github.io/GPRS_C_SDK_DOC/zh) )




## About Module

Ai-Thinker GPRS module models are mainly **A9**, **A9G**.
A9 mainly has GSM/GPRS (2G) related functions; A9G also integrates a GPS chip to facilitate the positioning related applications. For more functions, refer to hardware introduction section.

Module can be bought at taobao or other ways : [taobao link](https://anxinke.taobao.com/category-1303500786.htm?spm=2013.1.w5002-16491372996.5.3c354c53OwDR7Y&search=y&catName=GPRS%C4%A3%D7%E9%C7%F8)

## Development

The development of modules mainly provides two kinds of interfaces:

（A） **AT Command**: a module connect with  MCU with UART
   * It's a easy way to operate GSM/GPRS module, and requires MCU to send command to the module through a serial port(UART), and you just need to find the command you need in AT Command Documentation
   * AT firmware is the default firmware， you can set up immediately, more refer to [Ai-Thinker Wiki](http://wiki.ai-thinker.com/gprs)
   * This document does not contains any infomation of AT Command

（B）**SDK On Chip Development**，No external MCU is needed, burn the firmware directly to GPRS module

* The advantage of this method is that it doesn't need extra MCU, programming directly on modules, saving hardware resources, and save mony for projects

* This documentation introduces in detail how to use SDK to develop and provide related API docs.

* The AT application source code is not included in this SDK

