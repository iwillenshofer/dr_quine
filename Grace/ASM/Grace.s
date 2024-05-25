; an assembly program that replicates itself.

%define PERMISSIONS 0644o
%define FILE_FLAGS 577
%define EXIT 60

%macro FT 0
section .data
    msg db "? an assembly program that replicates itself.**%define PERMISSIONS 0644o*%define FILE_FLAGS 577*%define EXIT 60**%macro FT 0*section .data*    msg db $#$, 0*!err db $Could not write to file.$, 10, 0*!filename db $Grace_kid.s$, 0*!buffer db 0*!fd dd 2**section .text*!global _start**_start:*!call open_file*!mov rdi, msg*!mov rsi, 0x1*!call ft_putstr*!call close_file*!mov rax, EXIT*!xor edi, edi*!syscall***open_file:*!mov rax, 2*!mov rdi, filename*!mov rsi, FILE_FLAGS*!mov rdx, PERMISSIONS*!syscall*!cmp rax, 0*!jl .open_failed*!mov [fd], rax*!ret**.open_failed:*!mov dword [fd], 2*!mov rdi, err*!mov rsi, 0x1*!call ft_putstr*!mov rax, EXIT*!mov rdi, 1*!syscall**close_file:*!mov rax, 3*!mov rdi, [fd]*!syscall*!ret**ft_putchar:*!mov rsi, buffer*!mov [rsi], dil*!mov!rax, 0x1*!mov rdi, [fd]*!mov rdx, 0x1*!push rcx*!syscall*!pop rcx*!ret***ft_putstr:*!mov!!rcx, rdi*!jmp!!.comparison**.comparison:*!cmp!!byte [rcx], 0*!je!!.done*!push!rdi*!push!rsi*!call!check_special*!pop!!rsi*!pop!!rdi*!cmp!!rax, 0x1*!je!!.comparison*!push!rdi*!push!rsi*!movzx!rdi, byte [rcx]*!inc!!rcx*!call!ft_putchar*!pop!!rsi*!pop!!rdi*!jmp!!.comparison**.done:*!ret**check_special:*!cmp!!rsi, 0x1*!je!!.special*!jne!!.not_special**.not_special:*!mov rax, 0x0*!ret**.special:*!cmp byte [rcx], 0x2a*!je!.special_nl**!cmp byte [rcx], 0x23*!je!.special_str**!cmp byte [rcx], 0x24*!je!.special_quotes**!cmp byte [rcx], 0x21*!je!.special_tab**!cmp byte [rcx], 0x3f*!je .special_comment*!mov rax, 0x0*!ret**.special_nl:*!mov rdi, 0x0a*!call ft_putchar*!inc rcx*!mov rax, 0x1*!ret**.special_quotes:*!mov rdi, 0x22*!call ft_putchar*!inc rcx*!mov rax, 0x1*!ret**.special_tab:*!mov rdi, 0x09*!call ft_putchar*!inc rcx*!mov rax, 0x1*!ret**.special_comment:*!mov rdi, 0x3b*!call ft_putchar*!inc rcx*!mov rax, 0x1*!ret**.special_str:*!push rcx*!mov rsi, 0x0*!mov rdi, msg*!call ft_putstr*!pop rcx*!inc rcx*!mov rax, 0x1*!ret*%endmacro**FT*", 0
	err db "Could not write to file.", 10, 0
	filename db "Grace_kid.s", 0
	buffer db 0
	fd dd 2

section .text
	global _start

_start:
	call open_file
	mov rdi, msg
	mov rsi, 0x1
	call ft_putstr
	call close_file
	mov rax, EXIT
	xor edi, edi
	syscall


open_file:
	mov rax, 2
	mov rdi, filename
	mov rsi, FILE_FLAGS
	mov rdx, PERMISSIONS
	syscall
	cmp rax, 0
	jl .open_failed
	mov [fd], rax
	ret

.open_failed:
	mov dword [fd], 2
	mov rdi, err
	mov rsi, 0x1
	call ft_putstr
	mov rax, EXIT
	mov rdi, 1
	syscall

close_file:
	mov rax, 3
	mov rdi, [fd]
	syscall
	ret

ft_putchar:
	mov rsi, buffer
	mov [rsi], dil
	mov	rax, 0x1
	mov rdi, [fd]
	mov rdx, 0x1
	push rcx
	syscall
	pop rcx
	ret


ft_putstr:
	mov		rcx, rdi
	jmp		.comparison

.comparison:
	cmp		byte [rcx], 0
	je		.done
	push	rdi
	push	rsi
	call	check_special
	pop		rsi
	pop		rdi
	cmp		rax, 0x1
	je		.comparison
	push	rdi
	push	rsi
	movzx	rdi, byte [rcx]
	inc		rcx
	call	ft_putchar
	pop		rsi
	pop		rdi
	jmp		.comparison

.done:
	ret

check_special:
	cmp		rsi, 0x1
	je		.special
	jne		.not_special

.not_special:
	mov rax, 0x0
	ret

.special:
	cmp byte [rcx], 0x2a
	je	.special_nl

	cmp byte [rcx], 0x23
	je	.special_str

	cmp byte [rcx], 0x24
	je	.special_quotes

	cmp byte [rcx], 0x21
	je	.special_tab

	cmp byte [rcx], 0x3f
	je .special_comment
	mov rax, 0x0
	ret

.special_nl:
	mov rdi, 0x0a
	call ft_putchar
	inc rcx
	mov rax, 0x1
	ret

.special_quotes:
	mov rdi, 0x22
	call ft_putchar
	inc rcx
	mov rax, 0x1
	ret

.special_tab:
	mov rdi, 0x09
	call ft_putchar
	inc rcx
	mov rax, 0x1
	ret

.special_comment:
	mov rdi, 0x3b
	call ft_putchar
	inc rcx
	mov rax, 0x1
	ret

.special_str:
	push rcx
	mov rsi, 0x0
	mov rdi, msg
	call ft_putstr
	pop rcx
	inc rcx
	mov rax, 0x1
	ret
%endmacro

FT
