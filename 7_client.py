#客户控制端：利用socket模块实现数据的发送和接收


import socket

s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.connect(('127.0.0.1',9999))
print(s.recv(1024).decode('utf-8'))

while True:
    com = input(str('~####>'))
    s.send(com.encode('utf-8'))
    if com == 'exit':
        break
    data = s.recv(4096)
    print(data.decode('utf-8'))
