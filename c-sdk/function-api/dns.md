DNS
====

域名解析服务，需要GPRS网络已经能正常使用的前提下使用

例程：[demo/dns](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/dns/src/demo_dns.c)


## Enumerated type

### DNS_Status_t

DNS状态

```c
typedef enum{
    DNS_STATUS_ERROR = -1,
    DNS_STATUS_OK    =  0,
    DNS_STATUS_WAIT  =  1,
    DNS_STATUS_MAX
}DNS_Status_t;
```

---


## Function


### DNS_CALLBACK_FUNC_T

```c
typedef VOID (*DNS_CALLBACK_FUNC_T)(DNS_Status_t status, void* param);
```

#### Function

DNS解析回调函数

#### Parameters

* status:DNS状态
* param：调用解析时传的参数

#### Return

None

---

### DNS_GetHostByName

```c
DNS_Status_t     DNS_GetHostByName(const char* domain, char* ip);
```

#### Function

解析域名到IP地址，因为域名解析有时候时间很长，为了不阻塞程序，所以返回值有可能是`DNS_STATUS_WAIT`，
及域名解析还未完成，完成后会产生事件

#### Parameters

* domain：域名
* ip：解析到的ip地址存放的位置，请保证输出长度足够IP地址的点分十进制表示的长度

#### Return

* DNS_STATUS_OK：成功，DNS_STATUS_ERROR：错误，DNS_STATUS_WAIT：仍在解析，解析完成后会产生事件

---

### DNS_GetHostByNameEX

```c
DNS_Status_t     DNS_GetHostByNameEX(const char *hostname, char* ip, DNS_CALLBACK_FUNC_T func, void* param);
```

#### Function

解析域名到IP地址，成功后调用回调函数

#### Parameters

* hostname：域名
* ip：解析到的ip，请保证输出长度足够IP地址的点分十进制表示的长度，若返回`DNS_STATUS_OK`则有效，其它无效
* fuc:回调函数
* param:需要传给回调函数的参数

#### Return

* DNS_STATUS_OK：成功，DNS_STATUS_ERROR：错误，DNS_STATUS_WAIT：仍在解析，解析完成后会产生回调

---

### DNS_GetHostByName2

```c
int32_t          DNS_GetHostByName2(const char* domain, char* ip);
```

#### Function

**阻塞**式解析域名到IP地址，使用简单，但是性能不佳

#### Parameters

* hostname：域名
* ip：解析到的ip，请保证输出长度足够IP地址的点分十进制表示的长度

#### Return

* 0：成功 其它：错误代码

---
