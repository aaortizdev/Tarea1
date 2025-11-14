	.file	"usuarios.c"
	.section .rdata,"dr"
LC0:
	.ascii "r\0"
	.align 4
LC1:
	.ascii "Error: No se encuentra el archivo %s\12\0"
	.align 4
LC2:
	.ascii "\12--- LOGIN (Intento %d/3) ---\12\0"
LC3:
	.ascii "Usuario: \0"
LC4:
	.ascii "%s\0"
LC5:
	.ascii "Clave: \0"
LC6:
	.ascii ",\0"
LC7:
	.ascii "\12\0"
LC8:
	.ascii "Credenciales incorrectas.\0"
	.align 4
LC9:
	.ascii "Ha excedido el numero maximo de intentos.\0"
	.text
	.globl	_login
	.def	_login;	.scl	2;	.type	32;	.endef
_login:
LFB17:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$600, %esp
	movl	$LC0, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	jne	L2
	movl	8(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC1, (%esp)
	call	_printf
	movl	$0, %eax
	jmp	L13
L2:
	movl	$0, -12(%ebp)
	jmp	L4
L12:
	movl	-12(%ebp), %eax
	addl	$1, %eax
	movl	%eax, 4(%esp)
	movl	$LC2, (%esp)
	call	_printf
	movl	$LC3, (%esp)
	call	_printf
	leal	-274(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC4, (%esp)
	call	_scanf
	movl	$LC5, (%esp)
	call	_printf
	leal	-324(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC4, (%esp)
	call	_scanf
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_rewind
	movl	$0, -16(%ebp)
	jmp	L5
L10:
	movl	$LC6, 4(%esp)
	leal	-580(%ebp), %eax
	movl	%eax, (%esp)
	call	_strtok
	movl	%eax, -24(%ebp)
	cmpl	$0, -24(%ebp)
	je	L6
	movl	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-224(%ebp), %eax
	movl	%eax, (%esp)
	call	_strcpy
L6:
	movl	$LC6, 4(%esp)
	movl	$0, (%esp)
	call	_strtok
	movl	%eax, -24(%ebp)
	cmpl	$0, -24(%ebp)
	je	L7
	movl	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-224(%ebp), %eax
	addl	$50, %eax
	movl	%eax, (%esp)
	call	_strcpy
L7:
	movl	$LC7, 4(%esp)
	movl	$0, (%esp)
	call	_strtok
	movl	%eax, -24(%ebp)
	cmpl	$0, -24(%ebp)
	je	L8
	movl	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-224(%ebp), %eax
	addl	$100, %eax
	movl	%eax, (%esp)
	call	_strcpy
L8:
	leal	-224(%ebp), %eax
	movl	%eax, 4(%esp)
	leal	-274(%ebp), %eax
	movl	%eax, (%esp)
	call	_strcmp
	testl	%eax, %eax
	jne	L5
	leal	-224(%ebp), %eax
	addl	$50, %eax
	movl	%eax, 4(%esp)
	leal	-324(%ebp), %eax
	movl	%eax, (%esp)
	call	_strcmp
	testl	%eax, %eax
	jne	L5
	leal	-224(%ebp), %eax
	addl	$100, %eax
	movl	%eax, 4(%esp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	_strcpy
	movl	$1, -16(%ebp)
	jmp	L9
L5:
	movl	-20(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$256, 4(%esp)
	leal	-580(%ebp), %eax
	movl	%eax, (%esp)
	call	_fgets
	testl	%eax, %eax
	jne	L10
L9:
	cmpl	$0, -16(%ebp)
	je	L11
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$1, %eax
	jmp	L13
L11:
	movl	$LC8, (%esp)
	call	_puts
	addl	$1, -12(%ebp)
L4:
	cmpl	$2, -12(%ebp)
	jle	L12
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$LC9, (%esp)
	call	_puts
	movl	$0, %eax
L13:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE17:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_fopen;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_scanf;	.scl	2;	.type	32;	.endef
	.def	_rewind;	.scl	2;	.type	32;	.endef
	.def	_strtok;	.scl	2;	.type	32;	.endef
	.def	_strcpy;	.scl	2;	.type	32;	.endef
	.def	_strcmp;	.scl	2;	.type	32;	.endef
	.def	_fgets;	.scl	2;	.type	32;	.endef
	.def	_fclose;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
