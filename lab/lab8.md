## 实验8 分析一个奇怪的程序

分析下面的程序，在运行前思考，这个程序可以正确返回吗？
运行后再思考：为什么是这种结果？
通过这个程序加深对相关内容的理解。

```assembly
assume cs:codesg
codesg segment
mov ax, 4c00h
int 21h
start: mov ax, 0
    s: nop
	 		 nop
	 		 mov di, offset s
			 mov si, offset s2
			 mov ax, cs:[si]
			 mov cs:[di], ax
	 s0: jmp short s
	 s1: mov ax, 0
			 int 21h
			 mov ax, 0
	 s2: jmp short s1
			 nop
codesg ends
end start
```


分析：
这个程序可以正确返回，程序的入口为mov ax, 0，注意到指令jmp short s1占2字节，于是指令mov di, offset s将s的偏移地址传送到寄存器DI，mov si, offset s2将s2的偏移地址传送到SI，然后再通过通用寄存器ax做中转将s2处的指令复制到s处，最后再跳转至s处执行复制过来的指令。
注意jmp short s1是相对跳转，其直接修改IP寄存器，从s2到s1共有8个字节的偏移，实际上 jmp short s1等价于(ip)=(ip)-8，通过Debug可知第一个nop指令的偏移地址为8，所以再执行了复制过的指令后，IP将指向0，程序按照顺序执行mov ax, 4c00h和int 21h，正确返回。

