; an assembly program that replicates itself.

%define PERMISSIONS 0644o
%define FILE_FLAGS 577
%define EXIT 60

; ------------------------------------------------
; -                  Heading                     -
; ------------------------------------------------

section .data align=16

    msg db "? an assembly program that replicates itself.**%define PERMISSIONS 0644o*%define FILE_FLAGS 577*%define EXIT 60**? ------------------------------------------------*? -                  Heading                     -*? ------------------------------------------------**section .data align=16**    msg db $#$, 0*!*!? -- error messages -- *!err db $Could not write to file.$, 10, 0*!err_fork db $Could not fork.$, 10, 0*!err_execve db $Could not execve.$, 10, 0**!? -- variables --*!filename db $./Sully_X.s$, 0*!output db $./Sully_X$, 0*!object db $./Sully_X.o$, 0*!buffer db 0*!fd dd 2*!i dd +*!X dd 0**!? -- arguments for execve --*!? 1. nasm*!nasm_path db $/usr/bin/nasm$, 0*!nasm_arg1 db $-felf64$, 0*!nasm_arg2 db $-DINNERCOMP$, 0*!nasm_arg3 db $-o$, 0*!nasm_array dq nasm_path, nasm_arg1, nasm_arg2, nasm_arg3, object, filename, 0**!? 2. ld*!ld_path db $/usr/bin/ld$, 0*!ld_arg1 db $-o$, 0*!ld_array dq ld_path, ld_arg1, output, object, 0**!? 3. program*!output_array dq output, 0**!? 4. env*!env dq 0**? ------------------------------------------------*? -                    Main                      -*? ------------------------------------------------**section .text*!global _start**_start: !!!!!? start of the program*!mov rdi, 0x0*!cmp dword [i], 0x0!!!? checks if i equals 0*!je!exit*!call set_filename*!call open_file*!mov rdi, msg*!mov rsi, 0x1*!call ft_putstr*!call close_file*!mov r12, 0x0!!!? sets a counter for the fork*!call fork*!mov rdi, 0x0!!!? sets exit code to 0*!call exit**exit:*!mov rax, EXIT*!syscall**set_filename:!!!!? change the filename to the proper one*!mov eax, [i]*!mov [X], eax*!%ifdef INNERCOMP*!sub dword [X], 0x1!!!!? the program is compiling itself, so decrease X*!%endif*!add dword [X], 0x30!!!!? adds '0' to X*!mov rdi, filename*!add rdi, 8!!!!!!? selects 6th byte of filename*!mov al, byte [X]*!mov [rdi], al!!!!!? change it.*!mov rdi, output!!!!!? do the same for the output*!add rdi, 8*!mov al, byte [X]*!mov [rdi], al*!mov rdi, object!!!!!? do the same for the object*!add rdi, 8*!mov al, byte [X]*!mov [rdi], al*!ret**? ------------------------------------------------*? -          File Opening for Writing            -*? ------------------------------------------------**open_file:*!mov rax, 2!!!!? write syscall*!mov rdi, filename*!mov rsi, FILE_FLAGS*!mov rdx, PERMISSIONS*!syscall*!cmp rax, 0*!jl .open_failed*!mov [fd], rax*!ret**.open_failed:*!mov dword [fd], 2!!? sets fd to stderr*!mov rdi, err!!!? set error message*!mov rsi, 0x1!!!? arg for ft_putstr*!call ft_putstr*!mov rdi, 0x1!!!? exit code*!call exit**close_file:*!mov rax, 3!!!!? close syscall*!mov rdi, [fd]*!syscall*!ret***? ------------------------------------------------*? -                   Printing                   -*? ------------------------------------------------**ft_putchar:!!!!!? puts a single char into fd*!mov rsi, buffer*!mov [rsi], dil!!!? moves single byte from buffer*!mov!rax, 0x1!!!? write syscall*!mov rdi, [fd]!!!? sets the fd*!mov rdx, 0x1!!!? one byte per time*!push rcx*!syscall*!pop rcx*!ret***ft_putstr:*!mov!!rcx, rdi!!? moves the msg pointer to rcx*!jmp!!.comparison!!? enters putstr loop**.comparison:*!cmp!!byte [rcx], 0*!je!!.done*!push!rdi*!push!rsi*!call!check_special*!pop!!rsi*!pop!!rdi*!cmp!!rax, 0x1*!je!!.comparison*!push!rdi*!push!rsi*!movzx!rdi, byte [rcx]*!inc!!rcx*!call!ft_putchar*!pop!!rsi*!pop!!rdi*!jmp!!.comparison**.done:*!ret**check_special:!!!!? special character checker*!cmp!!rsi, 0x1!!? will check only if second argument is true*!je!!.special*!jne!!.not_special**.not_special:*!mov rax, 0x0*!ret**.special:!!!!!? replaces character if special*!cmp byte [rcx], 0x2a*!je!.special_nl**!cmp byte [rcx], 0x23*!je!.special_str**!cmp byte [rcx], 0x24*!je!.special_quotes**!cmp byte [rcx], 0x21*!je!.special_tab**!cmp byte [rcx], 0x2b*!je!.special_X**!cmp byte [rcx], 0x3f*!je .special_comment*!mov rax, 0x0*!ret**.special_nl:*!mov rdi, 0x0a*!call ft_putchar*!inc rcx*!mov rax, 0x1*!ret**.special_X:*!mov rdi, [X]*!call ft_putchar*!inc rcx*!mov rax, 0x1*!ret**.special_quotes:*!mov rdi, 0x22*!call ft_putchar*!inc rcx*!mov rax, 0x1*!ret**.special_tab:*!mov rdi, 0x09*!call ft_putchar*!inc rcx*!mov rax, 0x1*!ret**.special_comment:*!mov rdi, 0x3b*!call ft_putchar*!inc rcx*!mov rax, 0x1*!ret**.special_str:*!push rcx*!mov rsi, 0x0*!mov rdi, msg*!call ft_putstr*!pop rcx*!inc rcx*!mov rax, 0x1*!ret**? ------------------------------------------------*? -                   Forking                   -*? ------------------------------------------------**fork:*!mov rax, 57*!syscall*!cmp rax, 0x0*!je!.child*!inc r12!!!? r12 is keeping a count of which fork this is.*!jg!.parent*!jl!.failed_fork*!ret**.parent:*!call .wait*!cmp r12, 3*!jl fork!!!!!? creates a new fork if r12 < 3*!mov rdi, 0x0!!!? exit code*!call exit***? the action of the child will be determined by r12*.child: !!!!!*!cmp r12, 1*!jl .compile*!je .link*!jg .execute**.wait:*    mov rax, 61             ? syscall number for wait*    mov rdi, -1              ? wait for any child process*!mov rsi, 0*!mov rdx, 0*    syscall*    ret**.failed_fork:*!mov dword [fd], 2!!? sets fd to stderr*!mov rdi, err_fork!!!? set error message*!mov rsi, 0x1!!!? arg for ft_putstr*!call ft_putstr*!mov rdi, 0x1!!!? exit code*!call exit**? ------------------------------------------------*? -   Child processes: Compiling and Executing   -*? ------------------------------------------------**.compile:*!mov rdi, nasm_path*!mov rsi, nasm_array*!mov rdx, env*!mov rax, 59!!!!?execve system call*!syscall*!jmp .failed_execve**.link:*!mov rdi, ld_path*!mov rsi, ld_array*!mov rdx, env*!mov rax, 59!!!!?execve system call*!syscall*!jmp .failed_execve**.execute:*!mov rdi, output*!mov rsi, output_array*!mov rdx, env*!mov rax, 59!!!!?execve system call*!syscall*!jmp .failed_execve**.failed_execve:*!mov dword [fd], 2!!? sets fd to stderr*!mov rdi, err_execve!!? set error message*!mov rsi, 0x1!!!? arg for ft_putstr*!call ft_putstr*!mov rdi, 0x1!!!? exit code*!call exit*", 0
	
	; -- error messages -- 
	err db "Could not write to file.", 10, 0
	err_fork db "Could not fork.", 10, 0
	err_execve db "Could not execve.", 10, 0

	; -- variables --
	filename db "./Sully_X.s", 0
	output db "./Sully_X", 0
	object db "./Sully_X.o", 0
	buffer db 0
	fd dd 2
	i dd 5
	X dd 0

	; -- arguments for execve --
	; 1. nasm
	nasm_path db "/usr/bin/nasm", 0
	nasm_arg1 db "-felf64", 0
	nasm_arg2 db "-DINNERCOMP", 0
	nasm_arg3 db "-o", 0
	nasm_array dq nasm_path, nasm_arg1, nasm_arg2, nasm_arg3, object, filename, 0

	; 2. ld
	ld_path db "/usr/bin/ld", 0
	ld_arg1 db "-o", 0
	ld_array dq ld_path, ld_arg1, output, object, 0

	; 3. program
	output_array dq output, 0

	; 4. env
	env dq 0

; ------------------------------------------------
; -                    Main                      -
; ------------------------------------------------

section .text
	global _start

_start: 					; start of the program
	mov rdi, 0x0
	cmp dword [i], 0x0			; checks if i equals 0
	je	exit
	call set_filename
	call open_file
	mov rdi, msg
	mov rsi, 0x1
	call ft_putstr
	call close_file
	mov r12, 0x0			; sets a counter for the fork
	call fork
	mov rdi, 0x0			; sets exit code to 0
	call exit

exit:
	mov rax, EXIT
	syscall

set_filename:				; change the filename to the proper one
	mov eax, [i]
	mov [X], eax
	%ifdef INNERCOMP
	sub dword [X], 0x1				; the program is compiling itself, so decrease X
	%endif
	add dword [X], 0x30				; adds '0' to X
	mov rdi, filename
	add rdi, 8						; selects 6th byte of filename
	mov al, byte [X]
	mov [rdi], al					; change it.
	mov rdi, output					; do the same for the output
	add rdi, 8
	mov al, byte [X]
	mov [rdi], al
	mov rdi, object					; do the same for the object
	add rdi, 8
	mov al, byte [X]
	mov [rdi], al
	ret

; ------------------------------------------------
; -          File Opening for Writing            -
; ------------------------------------------------

open_file:
	mov rax, 2				; write syscall
	mov rdi, filename
	mov rsi, FILE_FLAGS
	mov rdx, PERMISSIONS
	syscall
	cmp rax, 0
	jl .open_failed
	mov [fd], rax
	ret

.open_failed:
	mov dword [fd], 2		; sets fd to stderr
	mov rdi, err			; set error message
	mov rsi, 0x1			; arg for ft_putstr
	call ft_putstr
	mov rdi, 0x1			; exit code
	call exit

close_file:
	mov rax, 3				; close syscall
	mov rdi, [fd]
	syscall
	ret


; ------------------------------------------------
; -                   Printing                   -
; ------------------------------------------------

ft_putchar:					; puts a single char into fd
	mov rsi, buffer
	mov [rsi], dil			; moves single byte from buffer
	mov	rax, 0x1			; write syscall
	mov rdi, [fd]			; sets the fd
	mov rdx, 0x1			; one byte per time
	push rcx
	syscall
	pop rcx
	ret


ft_putstr:
	mov		rcx, rdi		; moves the msg pointer to rcx
	jmp		.comparison		; enters putstr loop

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

check_special:				; special character checker
	cmp		rsi, 0x1		; will check only if second argument is true
	je		.special
	jne		.not_special

.not_special:
	mov rax, 0x0
	ret

.special:					; replaces character if special
	cmp byte [rcx], 0x2a
	je	.special_nl

	cmp byte [rcx], 0x23
	je	.special_str

	cmp byte [rcx], 0x24
	je	.special_quotes

	cmp byte [rcx], 0x21
	je	.special_tab

	cmp byte [rcx], 0x2b
	je	.special_X

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

.special_X:
	mov rdi, [X]
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

; ------------------------------------------------
; -                   Forking                   -
; ------------------------------------------------

fork:
	mov rax, 57
	syscall
	cmp rax, 0x0
	je	.child
	inc r12			; r12 is keeping a count of which fork this is.
	jg	.parent
	jl	.failed_fork
	ret

.parent:
	call .wait
	cmp r12, 3
	jl fork					; creates a new fork if r12 < 3
	mov rdi, 0x0			; exit code
	call exit


; the action of the child will be determined by r12
.child: 					
	cmp r12, 1
	jl .compile
	je .link
	jg .execute

.wait:
    mov rax, 61             ; syscall number for wait
    mov rdi, -1              ; wait for any child process
	mov rsi, 0
	mov rdx, 0
    syscall
    ret

.failed_fork:
	mov dword [fd], 2		; sets fd to stderr
	mov rdi, err_fork			; set error message
	mov rsi, 0x1			; arg for ft_putstr
	call ft_putstr
	mov rdi, 0x1			; exit code
	call exit

; ------------------------------------------------
; -   Child processes: Compiling and Executing   -
; ------------------------------------------------

.compile:
	mov rdi, nasm_path
	mov rsi, nasm_array
	mov rdx, env
	mov rax, 59				;execve system call
	syscall
	jmp .failed_execve

.link:
	mov rdi, ld_path
	mov rsi, ld_array
	mov rdx, env
	mov rax, 59				;execve system call
	syscall
	jmp .failed_execve

.execute:
	mov rdi, output
	mov rsi, output_array
	mov rdx, env
	mov rax, 59				;execve system call
	syscall
	jmp .failed_execve

.failed_execve:
	mov dword [fd], 2		; sets fd to stderr
	mov rdi, err_execve		; set error message
	mov rsi, 0x1			; arg for ft_putstr
	call ft_putstr
	mov rdi, 0x1			; exit code
	call exit
