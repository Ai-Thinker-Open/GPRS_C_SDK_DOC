DNS
====

Get ip from domain name

example：[demo/dns](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/dns/src/demo_dns.c)


## Enumerated type

### DNS_Status_t

DNS status

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

DNS callback funtion

#### Parameters

* status:DNS status
* param：parameter

#### Return

None

---

### DNS_GetHostByName

```c
DNS_Status_t     DNS_GetHostByName(const char* domain, char* ip);
```

#### Function

Resolve domain names to IP addresses, because domain name resolution sometimes takes a long time. In order not to block programs, the return value may be `DNS_STATUS_WAIT`, that is, domain name resolution has not yet been completed, and events will happen after completion.

#### Parameters

* domain： domain name
* ip：ip address output, ensure array have enough length, e.g:`127.0.0.1`

#### Return

* DNS_STATUS_OK：success, DNS_STATUS_ERROR: error, DNS_STATUS_WAIT：wait for resolve

---

### DNS_GetHostByNameEX

```c
DNS_Status_t     DNS_GetHostByNameEX(const char *hostname, char* ip, DNS_CALLBACK_FUNC_T func, void* param);
```

#### Function

Resolve the domain name to the IP address, and call the callback function after success.

#### Parameters

* hostname：domain name
* ip：ip address output, ensure array have enough length, e.g:`127.0.0.1`
* fuc: callback function
* param:the parameter to callback function

#### Return

* DNS_STATUS_OK: success, DNS_STATUS_ERROR: error, DNS_STATUS_WAIT:wait for result

---

### DNS_GetHostByName2

```c
int32_t          DNS_GetHostByName2(const char* domain, char* ip);
```

#### Function

Parsing domain name to IP address with block way, easy to use, but poor performance.

#### Parameters

* hostname：domain name
* ip：ip address output, ensure array have enough length, e.g:`127.0.0.1`

#### Return

* 0: success, other:error code

---
