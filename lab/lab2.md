# 实验2 用机器指令和汇编指令编程

1. 使用Debug，将下面的程序段写入内存，逐条执行，根据指令执行后的实验运行情况填空。

   ```
   mov ax, ffff
   mov ds, ax
   
   mov ax, 2200
   mov ss, ax
   
   mov sp, 1000
   
   mov ax,[0]  ;ax = _____
   add ax,[2]  ;ax = _____
   mov bx,[4]  ;bx = _____
   add bx,[6]  ;bx = _____
   
   push ax     ;sp = _____ 修改的内存单元的地址是_____内容为_____
   push bx     ;sp = _____ 修改的内存单元的地址是_____内容为_____
   pop ax      ;sp = _____ ax = _____
   pop bx      ;sp = _____ bx = _____
   
   push [4]    ;sp = _____ 修改的内存单元的地址是_____内容为_____
   push [6]    ;sp = _____ 修改的内存单元的地址是_____内容为_____
   ```

   结果（不唯一）:

   ```
   C0EA
   C0FC
   30F0
   6021
   00FE 220FE C0FC
   00FC 220FC 6021
   00FE 6021
   0100 C0FC
   00FE 220FE 30F0
   00FC 220FC 2F31
   ```

2. 仔细观察图3.19中的实验过程，然后分析：为什么2000:0～2000:f中的内容会发生改变？
   在使用T命令进行单步追踪的时候，产生了中断，为了保护现场，CPU将PSW、CS和IP依此入栈，导致了内存相关位置内容的改变。

