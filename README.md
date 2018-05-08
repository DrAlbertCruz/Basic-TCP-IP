# CMPS 3620 Computer Networks: Lab on Basic TCP/IP Communication

This lab will let us explore some of the practical/coding aspects of an application that
communicates over the network using the TCP/IP protocol. Many of the programs you 
use every day on the Internet use similar techniques to communicate.

TCP is a connection-oriented transport protocol used by hosts to communicate directly
to one another and IP is the network layer protocol used to route data from the sender 
to the receiver. In a previous lab, we looked into the relationship between the IP address 
and domain name. In this lab, we will be compiling a small client application and a small 
server application that will communicate via TCP/IP.

A server is a special host that waits for data from other hosts and then performs some 
action based on that data. A server is associated with a specific IP address and port number.
When you SSH to one of the department's servers for example, you are connecting to that 
server's IP address on the SSH port (port 22). On the dept. server, there is an SSH server process 
which waits for connection requests on port 22 and handles them.

A client is a host that is making requests of a server. The client initiates the connection by 
sending a connection request to the IP address and port number of the server. The server can then 
accept or reject the request. If the server accepts the request, the client can then send data to 
the server and the server can send data to the client. After the communication is complete, either 
the client or the server may close the connection. 

This lab will show you how to use the following C/C++ library functions to send and receive data 
over the Internet (or any TCP/IP network). 

The following connection primitives will be used:

* `socket()` - Create a byte stream (TCP descriptor) that will be used to send and receive data. 
This creates a file descriptor that is associated with that particular byte stream. Note that this
merely creates a socket/file descriptor. It does not associate the file descriptor with a network
address. That work is done with the function below.
*  `bind()` - Bind a given socket to a particular address (IP address and port number). Bind takes
a file descriptor created by the socket() function and an address structure. The address and 
port number can be set to "system assigns", in which case the next available port number is 
assigned to the socket and the address is set to 0.0.0.0, which means any IP address associated 
with that machine.
* `getsockname()` - Find out what address a socket is bound to. Useful if bind() asks the system 
to assign a port number.
* `listen()` - Wait for a connection to the bound address. Done by the server.
* `connect()` - Request a connection to a specific address. This is done on the client's side to 
initiate a connection-oriented channel with the server.
* `accept()` - Accept a connection request to the bound address. This establishes the connection-
oriented channel on the server's side.
* `send()` - Send data across the communication channel.
* `recv()` - Receive data from the communication channel.
* `close()` - Terminate the communication. This ends the connection-oriented channel. Any further 
communications must first use connect/accept to establish a new channel. 

These functions can be accessed by including the following header files: 

```c
#include <sys/types.h>
#include <sys/socket.h>
#include <unistd.h>
```

 You can get further information about each of these functions by looking at the man page for the 
 function, such as "man 2 bind". Make sure to specify "man 2" to select the manual pages associated 
 with the network libraries and not some other manual page. For example, "man accept" will give 
 you the man page for the printer command "accept", while "man 2 accept" will give you the man 
 page for the accept function. 
 
 ## Part 1 - Run the sample programs
 
 You will need to be logged onto the dept. server or some other POSIX system with a command line compiler 
 (e.g. Linux or Mac OS X). If you do not use the dept. server, your system will also need to support the make utility. 
 You can get a copy of the code for yourself by using `git`.
 
 ```console
git clone <use the link in this repository>
 ```
 
Once you have extracted the files, type "make tcp" to compile the two programs for this lab: vcrec and vcsend.

These programs do simple TCP sends and receives. The programs do the following: vcrec calls 
`socket()` to get a socket descriptor, `bind()` to bind the socket, `getsockname()` to get the port number, 
`listen()` to wait for a connection and `accept()` to accept a connection. vcsend calls `socket()` then 
calls `connect()` to try to connect to vcrec. Once connected they are connected to each other, 
they use `send()` and `recv()` to communicate. When the communication is complete, they use `close()` to end
the connection.

To run the programs, first start vcrec using the following command:

```console
./vcrec [optional_buffer_size] 
```

This is the server. It is idle and waiting for another program, such as vcsend, to establish a communication with it.
Note that it prints out the TCP port number it was able to bind for listening. You may want to copy these values for the next 
step. 

Either:
1. Open a new terminal. If you're using the department server, SSH to the server and get to the local 
directory with your source code in it.
1. Open a new shell. `screen` or `byobu` are helpful here.

In this new shell run vcsend and pass that port number to it:

```console
./vcsend <hostname> <portnumber> 
```

The "hostname" field is the hostname you are using for vcrec. Recall that it is 0.0.0.0. If you are running 
vcsend on the same host as vcrec, you can use the hostname "localhost", which is a special hostname to 
indicate that the server is on the same host as the client.

Play around with these programs sending various strings back and forth. To close a connection, type just a 
period by itself in vcsend. This will close both programs. 



Rerun vcrec using the option to set the buffer size (e.g. "./vcrec 5 &"). Use large and then small values for the buffer size. Notice what happens when you use small values for the buffer size.

