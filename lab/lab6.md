## 实验6 实践课程中的程序

1. 将课程中所有讲解过的程序上机调试，用Debug跟踪其执行过程，并在过程中进一步理解所讲内容。

2. 编程，完成问题7.9中的程序。
   程序如下：

   ```assembly
   assume cs:codesg, ss:stacksg, ds:datasg
   stacksg segment
   dw 0, 0, 0, 0, 0, 0, 0, 0
   stacksg ends
   
   datasg segment
   db '1. display      '
   db '2. brows        '
   db '3. replace      '
   db '4. modify       '
   datasg ends
   
   codesg segment
   start:  mov ax, datasg
   mov ds, ax
   mov ax, stacksg
   mov ss, ax
   mov sp, 16
   mov bx, 0
   mov cx, 4
   s:      push cx
   mov cx, 4
   mov si, 0
   s0:     mov al, [bx + si + 3]
   and al, 11011111b
   mov [bx + si + 3], al
   inc si
   loop s0
   add bx, 16
   pop cx
   loop s
   mov ax, 4c00h
   int 21h
   codesg ends
   end start
   ```