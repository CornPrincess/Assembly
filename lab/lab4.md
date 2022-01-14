## 实验4 [bx]和loop的使用

1. 编程，向内存0:200～0:23F依此传送数据0～63（3FH）。

2. 编程，向内存0:200～0:23F依此传送数据0～63（3FH），程序中只能使用9条指令，9条指令中包括“mov ax, 4c00h”和“int 21h”。

   ```assembly
   assume cs:code
   code segment
       mov ax,0020h
       mov ds,ax
       mov cx,64
       mov bx,0
       s: mov [bx],bl
       inc bx
       loop s
       mov ax,4c00h
       int 21h
   code ends
   end
   ```

3. 下面的程序的功能是将“mov ax, 4c00h”之前的指令复制到内存的0:200处，补全程序，上机调试，跟踪运行结果。

   ```assembly
   assume cs:code
   code segment
   mov ax, _____
   mov ds, ax
   mov ax, 0020h
   mov es, ax
   mov bx, 0
   mov cx, _____
   s:      mov al, [bx]
   mov es:[bx], al
   inc bx
   loop s
   mov ax, 4c00h
   int 21h
   code ends
   end
   ```

   结果：

   ![image-20220114154038617](/Users/zhoutianbin/Library/Application Support/typora-user-images/image-20220114154038617.png)

   ```
   code
   18H
   ```

   提示：
   复制的是什么？从哪里到哪里？
   复制的是代码段中mov ax, 4c00h之前的代码，以数据的形式，从内存中代码段的位置复制到内存中0:200处开始的一段连续的空间。
   复制的是什么？有多少个字节？你如何直到要复制的字节的数量？
   复制的是代码段中的数据，有18H 个字节。可以用offset计算得出，也可以在Debug中用T命令观察得出。