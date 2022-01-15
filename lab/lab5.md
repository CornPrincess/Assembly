## 实验5 编写、调试具有多个段的程序

1. 将下面的程序编译连接，用Debug加载、跟踪，然后回答问题。

   ```assembly
   assume cs:code, ds:data, ss:stack
   
   data segment
   dw 0123h, 0456h, 0789h, 0abch, 0defh, 0fedh, 0cbah, 0987h
   data ends
   
   stack segment
   dw 0, 0, 0, 0, 0, 0, 0, 0
   stack ends
   
   code segment
   start:  mov ax, stack
   mov ss, ax
   mov sp, 16
   
   mov ax, data
   mov ds, ax
   
   push ds:[0]
   push ds:[2]
   pop ds:[2]
   pop ds:[0]
   
   mov ax, 4c00h
   int 21h
   code ends
   
   end start
   ```

   ①CPU执行程序，程序返回前，data段中的数据为多少？

   data段中的数据不变。

   ②CPU执行程序，程序返回前，CS = _____、SS = _____、DS = _____。

   076C、076B、076A

   ③设程序加载后，code段的段地址为X，则data段的段地址为_____，stack段的段地址为_____。
   X-2、X-1

2. 将下面的程序编译连接，用Debug加载、跟踪，然后回答问题。

   ```
   assume cs:code, ds:data, ss:stack
   
   data segment
   dw 0123h, 0456h
   data ends
   
   stack segment
   dw 0, 0
   stack ends
   
   code segment
   start:  mov ax, stack
   mov ss, ax
   mov sp, 16
   
   mov ax, data
   mov ds, ax
   
   push ds:[0]
   push ds:[2]
   pop ds:[2]
   pop ds:[0]
   
   mov ax, 4c00h
   int 21h
   code ends
   
   end start
   ```

   (1)CPU执行程序，程序返回前，data段中的数据为多少？

   data段中的数据不变。

   (2)CPU执行程序，程序返回前，CS = _____、SS = _____、DS = _____。

   CS = 076C、SS =076B 、DS = 076A

   (3)设程序加载后，code段的段地址为X，则data段的段地址为_____，stack段的段地址为_____。

   data段地址为X-2，stack段段段地址为X-1

   (4)对于如下定义的段：

   ```
   name segment
   ...
   name ends
   ```

   如果段中的数据占N个字节，则程序加载后，该段实际占有的空间为_____。
   **((N-1)/16 + 1)*16 其中除法为整除，即实际占用内存为16字节的整数倍，这样可以使每个段的偏移地址为0。**

3. 将下面的程序编译连接，用Debug加载、跟踪，然后回答问题。

   ```
   assume cs:code, ds:data, ss:stack
   
   code segment
   start:  mov ax, stack
   mov ss, ax
   mov sp, 16
   
   mov ax, data
   mov ds, ax
   
   push ds:[0]
   push ds:[2]
   pop ds:[2]
   pop ds:[0]
   
   mov ax, 4c00h
   int 21h
   code ends
   
   data segment
   dw 0123h, 0456h
   data ends
   
   stack segment
   dw 0, 0
   stack ends
   
   end start
   ```

   (1)CPU执行程序，程序返回前，data段中的数据为多少？

   data段中的数据不变。

   (2)CPU执行程序，程序返回前，CS = _____、SS = _____、DS = _____。

   076A、076E、076D

   (3)设程序加载后，code段的段地址为X，则data段的段地址为_____，stack段的段地址为_____。
   X+3、X+4

4. 如果将1. 2. 3.题中的最后一条伪指令“end start”改为“end”（也就是说，不指明程序的入口），则哪个程序仍然可以正确执行？请说明原因。
   答案：
   只有程序3可以正确运行，在不指明程序入口的情况下，程序默认按照顺序从头开始执行，而3个程序中只有程序3的code段位于最开始的部分，所以只有程序3可以正确运行。

5. 程序如下，编写code段中的代码，将a段和b段中的数据依此相加，将结果存到c段中。

   ```
   assume cs:code
   a segment
   db 1, 2, 3, 4, 5, 6, 7, 8
   a ends
   
   b segment
   db 1, 2, 3, 4, 5, 6, 7, 8
   b ends
   
   c segment
   db 0, 0, 0, 0, 0, 0, 0, 0
   c ends
   
   code segment
   start:
   ?
   code ends
   end start
   ```

   答案：

   ```assembly
   start:  mov ax, a
   mov ds, ax
   mov ax, b
   mov es, ax
   mov ax, c
   mov ss, ax
   mov bx, 0
   mov cx, 8
   s:      mov al, [bx]
   add al, es:[bx]
   mov ss:[bx], al
   inc bx
   loop s
   mov ax, 4c00h
   int 21h
   ```

6. 程序如下，编写code段中的代码，用push指令将a段中的前8个字型数据，逆序存储到b段中。

   ```
   assume cs:code
   
   a segment
   dw 1, 2, 3, 4, 5, 6, 7, 8, 9, 0ah, 0bh, 0ch, 0dh, 0eh, 0fh, 0ffh
   a ends
   
   b segment
   dw 0, 0, 0, 0, 0, 0, 0, 0
   b ends
   
   code segment
   start:  
   ?
   code ends
   
   end start
   ```

   答案：

   ```
   start:  mov ax, b
   mov ss, ax
   mov sp, 16
   mov ax, a
   mov ds, ax
   mov bx, 0
   mov cx, 8
   s:      push [bx]
   add bx, 2
   loop s
   mov ax, 4c00h
   int 21h
   ```

参考

1.https://www.cnblogs.com/tsembrace/p/3267160.html

