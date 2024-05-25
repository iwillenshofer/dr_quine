; an assembly program that prints itself (quine).

section .data
    msg db "? an assembly program that prints itself (quine).**section .data*    msg db $#$, 0*%buffer db 0**section .text*%global _start**_start:*%? prints msg string then exits*%mov rdi, msg*%mov rsi, 0x1*%call ft_putstr*%mov rax, 60*%xor edi, edi*%syscall**ft_putchar:*%? Input: rdi = char to be printed*%mov rsi, buffer*%mov [rsi], rdi*%mov%rax, 0x1*%mov rdi, 0x1*%mov rdx, 0x1*%push rcx*%syscall*%pop rcx*%ret***ft_putstr:*%? Input: rdi = string to be printed*%?%% rsi = bool, wheter to replace special chars*%mov%%rcx, rdi*%jmp%%.comparison**.comparison:*%cmp%%byte [rcx], 0*%je%%.done*%push%rdi*%push%rsi*%call%check_special*%pop%%rsi*%pop%%rdi*%cmp%%rax, 0x1*%je%%.comparison*%push%rdi*%push%rsi*%movzx%rdi, byte [rcx]*%inc%%rcx*%call%ft_putchar*%pop%%rsi*%pop%%rdi*%jmp%%.comparison**.done:*%ret***check_special:*%cmp%%rsi, 0x1*%je%%.special*%jne%%.not_special**.not_special:*%mov rax, 0x0*%ret**.special:*%cmp byte [rcx], 0x2a*%je%.special_nl**%cmp byte [rcx], 0x23*%je%.special_str**%cmp byte [rcx], 0x24*%je%.special_quotes**%cmp byte [rcx], 0x25*%je%.special_tab**%cmp byte [rcx], 0x3f*%je .special_comment*%mov rax, 0x0*%ret**.special_nl:*%mov rdi, 0x0a*%call ft_putchar*%inc rcx*%mov rax, 0x1*%ret**.special_quotes:*%mov rdi, 0x22*%call ft_putchar*%inc rcx*%mov rax, 0x1*%ret**.special_tab:*%mov rdi, 0x09*%call ft_putchar*%inc rcx*%mov rax, 0x1*%ret**.special_comment:*%mov rdi, 0x3b*%call ft_putchar*%inc rcx*%mov rax, 0x1*%ret**.special_str:*%push rcx*%mov rsi, 0x0*%mov rdi, msg*%call ft_putstr*%pop rcx*%inc rcx*%mov rax, 0x1*%ret*", 0
	buffer db 0

section .text
	global _start

_start:
	; prints msg string then exits
	mov rdi, msg
	mov rsi, 0x1
	call ft_putstr
	mov rax, 60
	xor edi, edi
	syscall

ft_putchar:
	; Input: rdi = char to be printed
	mov rsi, buffer
	mov [rsi], rdi
	mov	rax, 0x1
	mov rdi, 0x1
	mov rdx, 0x1
	push rcx
	syscall
	pop rcx
	ret


ft_putstr:
	; Input: rdi = string to be printed
	;		 rsi = bool, wheter to replace special chars
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

	cmp byte [rcx], 0x25
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
