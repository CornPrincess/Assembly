## 实验3 编程、编译、连接、跟踪

1. 将下面的程序保存为t1.asm文件，将其生成可执行文件t1.exe。

   ```assembly
   assume cs:codesg
   
   codesg segment
   mov ax, 2000H
   mov ss, ax
   mov sp, 0
   add sp, 10
   pop ax
   pop bx
   push ax
   push bx
   pop ax
   pop bx
   
   mov ax, 4c00h
   int 21h
   codesg ends
   
   end
   ```

   结果：

   ```
   edit t1.asm
   masm.exe t1.asm;
   link.exe t1.obj;
   ```

2. 用Debug跟踪t1.exe的执行过程，写出每一步执行后，相关寄存器中的内容和栈顶的内容。

   |   汇编指令    |   相关寄存器的内容    | 栈顶的内容 |
   | :-----------: | :-------------------: | :--------: |
   | mov ax, 2000H |      AX = 2000H       |     -      |
   |  mov ss, ax   |      SS = 2000H       |   _____    |
   |   mov sp, 0   |      SP = 0000H       |   2000H    |
   |  add sp, 10   |      SP = 000AH       |   0000H    |
   |    pop ax     | AX = 0000H SP = 000CH |   0000H    |
   |    pop bx     | BX = 0000H SP = 000EH |   0000H    |
   |    push ax    |      SP = 000CH       |   0000H    |
   |    push bx    |      SP = 000AH       |   0000H    |
   |    pop ax     | AX = 0000H SP = 000CH |   0000H    |
   |    pop bx     | BX = 0000H SP = 000EH |   0000H    |
   | mov ax, 4c00h |      AX = 4C00H       |   0000H    |
   |    int 21h    |         _____         |   _____    |

   结果不唯一

   

3. PSP的头两个字节是CD 20，用Debug加载t1.exe，查看PSP的内容。

   ```
   -d 075A:0
   ```

   ![image-20220114112134354](/Users/zhoutianbin/Library/Application Support/typora-user-images/image-20220114112134354.png)

   DS = CS - 0010H

