Socket
====

网络通信，需要GPRS网络已经能正常使用的前提下使用

例程：[demo/socket](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/socket/src/demo_socket.c)


## 枚举类型

#### TCP_UDP_t

TCP、UDP选择

```c
typedef enum{
    TCP = 0,
    UDP =1
}TCP_UDP_t;
```

---

### API_Socket_Error_t

错误信息

```c
typedef enum{
    /** No error, everything OK. */
    API_SOCKET_ERROR_NONE = 0,
    /** Out of memory error.     */
    API_SOCKET_ERROR_MEM        = -1,
    /** Buffer error.            */
    API_SOCKET_ERROR_BUF        = -2,
    /** Timeout.                 */
    API_SOCKET_ERROR_TIMEOUT    = -3,
    /** Routing problem.         */
    API_SOCKET_ERROR_RTE        = -4,
    /** Operation in progress    */
    API_SOCKET_ERROR_INPROGRESS = -5,
    /** Illegal value.           */
    API_SOCKET_ERROR_VAL        = -6,
    /** Operation would block.   */
    API_SOCKET_ERROR_WOULDBLOCK = -7,
    /** Address in use.          */
    API_SOCKET_ERROR_USE        = -8,
    /** Already connecting.      */
    API_SOCKET_ERROR_ALREADY    = -9,
    /** Conn already established.*/
    API_SOCKET_ERROR_ISCONN     = -10,
    /** Not connected.           */
    API_SOCKET_ERROR_CONN       = -11,
    /** Low-level netif error    */
    API_SOCKET_ERROR_IF         = -12,

    /** Connection aborted.      */
    API_SOCKET_ERROR_ABRT       = -13,
    /** Connection reset.        */
    API_SOCKET_ERROR_RST        = -14,
    /** Connection closed.       */
    API_SOCKET_ERROR_CLSD       = -15,
    /** Illegal argument.        */
    API_SOCKET_ERROR_ARG        = -16
}API_Socket_Error_t;
```


## 功能函数


### Socket_TcpipConnect

```c
int      Socket_TcpipConnect(TCP_UDP_t tcpOrUdp, const char* ip,uint16_t port);
```

##### 功能

连接服务器

##### 参数

* tcpOrUdp:选择TCP协议还是UDP
* ip：要连接的ip地址
* port：要连接的服务器端口

##### 返回值

* 若成功，返回文件描述符fd，若失败，返回错误信息`API_Socket_Error_t`

---

### Socket_TcpipWrite

```c
int      Socket_TcpipWrite(int socketFd, uint8_t* data, uint16_t length);
```

##### 功能

向服务器发送数据

##### 参数

* socketFd:建立的socket连接文件描述符，`Socket_TcpipConnect`成功后的返回值
* data：需要发送的数据
* length：需要发送的数据的长度

##### 返回值

* 成功发送的数据长度或者错误代码

---

### Socket_TcpipRead

```c
int      Socket_TcpipRead( int socketFd, uint8_t* data, uint16_t length);
```

##### 功能

连接建立后，收到来自服务器的信息会产生事件，在事件触发后调用read函数即可读取数据

##### 参数

* socketFd:建立的socket连接文件描述符，`Socket_TcpipConnect`成功后的返回值
* data：接收到的数据存放的位置
* length：需要发送的数据的长度

##### 返回值

* 读取到的数据的长度或者错误代码

---

### Socket_TcpipClose

```c
bool     Socket_TcpipClose(int socketFd);
```

##### 功能

关闭socket连接

##### 参数

* socketFd:建立的socket连接文件描述符，`Socket_TcpipConnect`成功后的返回值

##### 返回值

* 是否成功关闭socket连接

---
