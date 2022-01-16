assume cs:codesg, ss:stack

stack segment
dw 8 dup (0)
stack ends

data segment
    db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
    db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
    db '1993', '1994', '1995'

    dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
    dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000

    dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
    dw 11542, 14430, 15257, 17800
data ends

table segment
    db 21 dup ('year summ ne ?? ')
table ends

codesg segment
    start: mov ax,data
           mov ds,ax ; 读取数据位置
           mov ax,table
           mov es,ax ; 写入数据位置
           mov ax,stack
           mov ss,ax
           mov sp,16

           mov bx,0 ; table 起始偏移地址
           mov si,0 ; 指向 data 中每一个字节的指针
           mov cx,21
           year0: push cx
               mov cx,4
               mov di,0 
           year1: mov al,ds:[si] ; 复制year
               mov es:[bx+di],al
               inc si
               inc di
            loop year1
            add bx,16
            pop cx
            loop year0

            mov cx,21
            mov bx,0
            income: mov ax,ds:[si] ; data中的指针，经过上面的循环，现在指向第一个收入
                mov es:[bx+5],ax
                add si,2 ; 因为是dd，所以需要复制两次
                mov ax,ds:[si]
                mov es:[bx+7],ax
                add si,2
                add bx,16
            loop income

            mov cx,21
            mov bx,0
            staff: mov ax,ds:[si]
                   mov [bx+10],ax
                   add si,2
                   add bx,16
            loop staff

            mov cx,21
            mov bx,0
            average: mov ax,[bx+5]
                     mov bx,[bx+7]
                     div word ptr [bx+10]
                     mov [bx+13], ax
                     add bx,16
            loop average

            mov ax,4c00h
            int 21h
codesg ends

end start