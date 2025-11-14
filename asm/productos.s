	.file	"productos.c"
	.section .rdata,"dr"
LC0:
	.ascii "r\0"
LC1:
	.ascii ",\0"
LC2:
	.ascii "\12\0"
	.text
	.globl	_cargar_inventario
	.def	_cargar_inventario;	.scl	2;	.type	32;	.endef
_cargar_inventario:
LFB18:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$308, %esp
	.cfi_offset 3, -12
	movl	$LC0, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	jne	L2
	movl	12(%ebp), %eax
	movl	$0, (%eax)
	movl	$0, %eax
	jmp	L6
L2:
	movl	$0, -12(%ebp)
	movl	$0, -16(%ebp)
	jmp	L4
L5:
	movl	-16(%ebp), %eax
	addl	$1, %eax
	imull	$84, %eax, %eax
	movl	%eax, 4(%esp)
	movl	-12(%ebp), %eax
	movl	%eax, (%esp)
	call	_realloc
	movl	%eax, -12(%ebp)
	movl	$LC1, 4(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	_strtok
	movl	%eax, -24(%ebp)
	movl	-16(%ebp), %eax
	imull	$84, %eax, %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_strcpy
	movl	$LC1, 4(%esp)
	movl	$0, (%esp)
	call	_strtok
	movl	%eax, -24(%ebp)
	movl	-16(%ebp), %eax
	imull	$84, %eax, %edx
	movl	-12(%ebp), %eax
	addl	%edx, %eax
	leal	20(%eax), %edx
	movl	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_strcpy
	movl	$LC1, 4(%esp)
	movl	$0, (%esp)
	call	_strtok
	movl	%eax, -24(%ebp)
	movl	-16(%ebp), %eax
	imull	$84, %eax, %edx
	movl	-12(%ebp), %eax
	leal	(%edx,%eax), %ebx
	movl	-24(%ebp), %eax
	movl	%eax, (%esp)
	call	_atoi
	movl	%eax, 72(%ebx)
	movl	$LC1, 4(%esp)
	movl	$0, (%esp)
	call	_strtok
	movl	%eax, -24(%ebp)
	movl	-16(%ebp), %eax
	imull	$84, %eax, %edx
	movl	-12(%ebp), %eax
	leal	(%edx,%eax), %ebx
	movl	-24(%ebp), %eax
	movl	%eax, (%esp)
	call	_atof
	fstps	-284(%ebp)
	flds	-284(%ebp)
	fstps	76(%ebx)
	movl	$LC2, 4(%esp)
	movl	$0, (%esp)
	call	_strtok
	movl	%eax, -24(%ebp)
	movl	-16(%ebp), %eax
	imull	$84, %eax, %edx
	movl	-12(%ebp), %eax
	leal	(%edx,%eax), %ebx
	movl	-24(%ebp), %eax
	movl	%eax, (%esp)
	call	_atof
	fstps	-284(%ebp)
	flds	-284(%ebp)
	fstps	80(%ebx)
	addl	$1, -16(%ebp)
L4:
	movl	-20(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$256, 4(%esp)
	leal	-280(%ebp), %eax
	movl	%eax, (%esp)
	call	_fgets
	testl	%eax, %eax
	jne	L5
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	12(%ebp), %eax
	movl	-16(%ebp), %edx
	movl	%edx, (%eax)
	movl	-12(%ebp), %eax
L6:
	addl	$308, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE18:
	.globl	_buscar_producto
	.def	_buscar_producto;	.scl	2;	.type	32;	.endef
_buscar_producto:
LFB19:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$40, %esp
	movl	$0, -12(%ebp)
	jmp	L8
L11:
	movl	-12(%ebp), %eax
	imull	$84, %eax, %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	movl	%eax, %edx
	movl	16(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	%edx, (%esp)
	call	_strcmp
	testl	%eax, %eax
	jne	L9
	movl	-12(%ebp), %eax
	imull	$84, %eax, %edx
	movl	8(%ebp), %eax
	addl	%edx, %eax
	jmp	L10
L9:
	addl	$1, -12(%ebp)
L8:
	movl	-12(%ebp), %eax
	cmpl	12(%ebp), %eax
	jl	L11
	movl	$0, %eax
L10:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE19:
	.globl	_obtener_siguiente_factura
	.def	_obtener_siguiente_factura;	.scl	2;	.type	32;	.endef
_obtener_siguiente_factura:
LFB20:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	subl	$296, %esp
	movl	$LC0, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, -16(%ebp)
	cmpl	$0, -16(%ebp)
	jne	L13
	movl	$1, %eax
	jmp	L17
L13:
	movl	$0, -12(%ebp)
	jmp	L15
L16:
	movl	$LC1, 4(%esp)
	leal	-276(%ebp), %eax
	movl	%eax, (%esp)
	call	_strtok
	movl	%eax, -20(%ebp)
	cmpl	$0, -20(%ebp)
	je	L15
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_atoi
	movl	%eax, -12(%ebp)
L15:
	movl	-16(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$256, 4(%esp)
	leal	-276(%ebp), %eax
	movl	%eax, (%esp)
	call	_fgets
	testl	%eax, %eax
	jne	L16
	movl	-16(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	-12(%ebp), %eax
	addl	$1, %eax
L17:
	leave
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE20:
	.section .rdata,"dr"
LC4:
	.ascii "w\0"
LC5:
	.ascii "%s,%s,%d,%.2f,%.2f\12\0"
LC6:
	.ascii "%d-%02d-%02d\0"
LC7:
	.ascii "a\0"
LC8:
	.ascii "%d,%s,%s,%d,%.2f,%.2f,%s\12\0"
	.align 4
LC9:
	.ascii "\12[EXITO] Venta registrada correctamente. Factura #%d\12\0"
	.text
	.globl	_registrar_venta
	.def	_registrar_venta;	.scl	2;	.type	32;	.endef
_registrar_venta:
LFB21:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	subl	$148, %esp
	.cfi_offset 3, -12
	movl	$LC4, 4(%esp)
	movl	12(%ebp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, -20(%ebp)
	movl	$0, -12(%ebp)
	jmp	L19
L20:
	movl	-12(%ebp), %eax
	imull	$84, %eax, %edx
	movl	16(%ebp), %eax
	addl	%edx, %eax
	flds	80(%eax)
	movl	-12(%ebp), %eax
	imull	$84, %eax, %edx
	movl	16(%ebp), %eax
	addl	%edx, %eax
	flds	76(%eax)
	fxch	%st(1)
	movl	-12(%ebp), %eax
	imull	$84, %eax, %edx
	movl	16(%ebp), %eax
	addl	%edx, %eax
	movl	72(%eax), %eax
	movl	-12(%ebp), %edx
	imull	$84, %edx, %ecx
	movl	16(%ebp), %edx
	addl	%ecx, %edx
	addl	$20, %edx
	movl	-12(%ebp), %ecx
	imull	$84, %ecx, %ebx
	movl	16(%ebp), %ecx
	addl	%ebx, %ecx
	fstpl	28(%esp)
	fstpl	20(%esp)
	movl	%eax, 16(%esp)
	movl	%edx, 12(%esp)
	movl	%ecx, 8(%esp)
	movl	$LC5, 4(%esp)
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_fprintf
	addl	$1, -12(%ebp)
L19:
	movl	-12(%ebp), %eax
	cmpl	20(%ebp), %eax
	jl	L20
	movl	-20(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	$0, (%esp)
	call	_time
	movl	%eax, -36(%ebp)
	leal	-36(%ebp), %eax
	movl	%eax, (%esp)
	call	_localtime
	movl	(%eax), %edx
	movl	%edx, -72(%ebp)
	movl	4(%eax), %edx
	movl	%edx, -68(%ebp)
	movl	8(%eax), %edx
	movl	%edx, -64(%ebp)
	movl	12(%eax), %edx
	movl	%edx, -60(%ebp)
	movl	16(%eax), %edx
	movl	%edx, -56(%ebp)
	movl	20(%eax), %edx
	movl	%edx, -52(%ebp)
	movl	24(%eax), %edx
	movl	%edx, -48(%ebp)
	movl	28(%eax), %edx
	movl	%edx, -44(%ebp)
	movl	32(%eax), %eax
	movl	%eax, -40(%ebp)
	movl	-60(%ebp), %eax
	movl	-56(%ebp), %edx
	leal	1(%edx), %ecx
	movl	-52(%ebp), %edx
	addl	$1900, %edx
	movl	%eax, 16(%esp)
	movl	%ecx, 12(%esp)
	movl	%edx, 8(%esp)
	movl	$LC6, 4(%esp)
	leal	-92(%ebp), %eax
	movl	%eax, (%esp)
	call	_sprintf
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_obtener_siguiente_factura
	movl	%eax, -24(%ebp)
	movl	$LC7, 4(%esp)
	movl	8(%ebp), %eax
	movl	%eax, (%esp)
	call	_fopen
	movl	%eax, -28(%ebp)
	movl	$0, -16(%ebp)
	jmp	L21
L22:
	movl	-16(%ebp), %eax
	leal	0(,%eax,8), %edx
	movl	24(%ebp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, -32(%ebp)
	movl	-32(%ebp), %eax
	flds	80(%eax)
	movl	-32(%ebp), %eax
	flds	76(%eax)
	fxch	%st(1)
	movl	-16(%ebp), %eax
	leal	0(,%eax,8), %edx
	movl	24(%ebp), %eax
	addl	%edx, %eax
	movl	4(%eax), %edx
	movl	-32(%ebp), %eax
	leal	20(%eax), %ebx
	movl	-32(%ebp), %eax
	leal	-92(%ebp), %ecx
	movl	%ecx, 40(%esp)
	fstpl	32(%esp)
	fstpl	24(%esp)
	movl	%edx, 20(%esp)
	movl	%ebx, 16(%esp)
	movl	%eax, 12(%esp)
	movl	-24(%ebp), %eax
	movl	%eax, 8(%esp)
	movl	$LC8, 4(%esp)
	movl	-28(%ebp), %eax
	movl	%eax, (%esp)
	call	_fprintf
	addl	$1, -16(%ebp)
L21:
	movl	-16(%ebp), %eax
	cmpl	28(%ebp), %eax
	jl	L22
	movl	-28(%ebp), %eax
	movl	%eax, (%esp)
	call	_fclose
	movl	-24(%ebp), %eax
	movl	%eax, 4(%esp)
	movl	$LC9, (%esp)
	call	_printf
	nop
	addl	$148, %esp
	popl	%ebx
	.cfi_restore 3
	popl	%ebp
	.cfi_restore 5
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE21:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_fopen;	.scl	2;	.type	32;	.endef
	.def	_realloc;	.scl	2;	.type	32;	.endef
	.def	_strtok;	.scl	2;	.type	32;	.endef
	.def	_strcpy;	.scl	2;	.type	32;	.endef
	.def	_atoi;	.scl	2;	.type	32;	.endef
	.def	_atof;	.scl	2;	.type	32;	.endef
	.def	_fgets;	.scl	2;	.type	32;	.endef
	.def	_fclose;	.scl	2;	.type	32;	.endef
	.def	_strcmp;	.scl	2;	.type	32;	.endef
	.def	_fprintf;	.scl	2;	.type	32;	.endef
	.def	_time;	.scl	2;	.type	32;	.endef
	.def	_localtime;	.scl	2;	.type	32;	.endef
	.def	_sprintf;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
