Socket
====

Socket service requires GPRS network to be used normally.

example:[demo/socket](https://github.com/Ai-Thinker-Open/GPRS_C_SDK/blob/master/demo/socket/src/demo_socket.c)


## Enumerated type

#### TCP_UDP_t

TCP、UDP

```c
typedef enum{
    TCP = 0,
    UDP =1
}TCP_UDP_t;
```

---

### API_Socket_Error_t

Error code

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


## Function


### Socket_TcpipConnect

```c
int      Socket_TcpipConnect(TCP_UDP_t tcpOrUdp, const char* ip,uint16_t port);
```

#### Function

Connect server

#### Parameters

* tcpOrUdp: selects the TCP protocol or UDP
* IP: the IP address to be connected
* port: the server port to be connected

#### Return

* If successful, return the file descriptor FD. If it fails, return the error message `API_Socket_Error_t`

---

### Socket_TcpipWrite

```c
int      Socket_TcpipWrite(int socketFd, uint8_t* data, uint16_t length);
```

#### Function

Sending data to the server

#### Parameters

* the socket connection file descriptor established by socketFd:, and the return value after successful `Socket_TcpipConnect`.
* data: data to be sent
* length: the length of the data to be sent

#### Return

* the data length or error code that is successfully sent

---

### Socket_TcpipRead

```c
int      Socket_TcpipRead( int socketFd, uint8_t* data, uint16_t length);
```

#### Function

After the connection is established, information received from the server will generate events. After the event is triggered, the read function can be called to read the data.

#### Parameters

* the socket connection file descriptor established by socketFd:, and the return value after successful `Socket_TcpipConnect`.
* data: the location of the received data storage
* length: the length of the data to be sent

#### Return

* the length of the data read or the error code

---

### Socket_TcpipClose

```c
bool     Socket_TcpipClose(int socketFd);
```

#### Function

Close socket connection

#### Parameters

* socketFd:The socket connection file descriptor established, the return value after successful `Socket_TcpipConnect`.

#### Return

* Whether or not the socket connection is successfully closed

---
