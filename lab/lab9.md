## 实验9 根据材料编程

编程：在屏幕中间分别显示绿色、绿底红色、白底蓝色的字符串’welcome to masm!’。
编程所需的只是通过阅读、分析下面的材料获得。

```assembly
assume ds:data, cs:code

data segment
db 'welcome to masm!'
data ends

code segment
start:  mov ax, data
mov ds, ax
mov ax, 0B800H
mov es, ax

mov bx, 1664
mov si, 0
mov cx, 16
char1:  mov al, [si]
mov ah, 10000010B
mov es:[bx], ax
add bx, 2
inc si
loop char1

mov bx, 1824
mov si, 0
mov cx, 16
char2:  mov al, [si]
mov ah, 10100100B
mov es:[bx], ax
add bx, 2
inc si
loop char2

mov bx, 1984
mov si, 0
mov cx, 16
char3:  mov al, [si]
mov ah, 11110001B
mov es:[bx], ax
add bx, 2
inc si
loop char3

mov ax, 4C00H
int 21H
code ends
end start
```

