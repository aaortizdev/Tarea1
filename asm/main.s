	.file	"main.c"
	.def	___main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
LC0:
	.ascii "vendedores.txt\0"
LC1:
	.ascii "\12Bienvenido, %s!\12\0"
LC2:
	.ascii "producto.txt\0"
LC3:
	.ascii "Error cargando inventario.\0"
LC4:
	.ascii "\12--- NUEVA LINEA DE VENTA ---\0"
LC5:
	.ascii "Ingrese Codigo del producto: \0"
LC6:
	.ascii "%s\0"
LC7:
	.ascii "Producto: %s\12\0"
LC8:
	.ascii "Precio: %.2f\12\0"
	.align 4
LC9:
	.ascii "Stock Bodega: %d | En su carrito: %d | -> DISPONIBLE: %d\12\0"
	.align 4
LC10:
	.ascii "\302\241ALERTA! Ya ha reservado todo el stock disponible de este producto.\0"
	.align 4
LC11:
	.ascii "Ingrese cantidad a vender (Max %d): \0"
LC12:
	.ascii "%d\0"
	.align 4
LC13:
	.ascii ">> Agregado exitosamente. (Total en carrito de este prod: %d)\12\0"
	.align 4
LC14:
	.ascii ">> ERROR: Cantidad invalida. Debe ser entre 1 y %d.\12\0"
	.align 4
LC15:
	.ascii ">> Error: Producto no encontrado.\0"
	.align 4
LC16:
	.ascii "\12\302\277Desea registrar otro producto? (s/n): \0"
LC17:
	.ascii " %c\0"
LC18:
	.ascii "ventas.txt\0"
	.align 4
LC20:
	.ascii "\12========================================\0"
LC21:
	.ascii "PRE-FACTURA #%d\12\0"
	.align 4
LC22:
	.ascii "========================================\0"
LC23:
	.ascii "Total\0"
LC24:
	.ascii "P.Unit\0"
LC25:
	.ascii "Cant\0"
LC26:
	.ascii "Producto\0"
LC27:
	.ascii "%-20s %-10s %-10s %-10s\12\0"
LC28:
	.ascii "%-20s %-10d %-10.2f %-10.2f\12\0"
	.align 4
LC29:
	.ascii "----------------------------------------\0"
LC30:
	.ascii "TOTAL A PAGAR: %.2f\12\0"
	.align 4
LC31:
	.ascii "\12\302\277Confirmar venta y actualizar inventario? (s/n): \0"
LC32:
	.ascii "Venta cancelada.\0"
	.text
	.globl	_main
	.def	_main;	.scl	2;	.type	32;	.endef
_main:
LFB18:
	.cfi_startproc
	pushl	%ebp
	.cfi_def_cfa_offset 8
	.cfi_offset 5, -8
	movl	%esp, %ebp
	.cfi_def_cfa_register 5
	pushl	%ebx
	andl	$-16, %esp
	subl	$256, %esp
	.cfi_offset 3, -12
	call	___main
	leal	96(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC0, (%esp)
	call	_login
	xorl	$1, %eax
	testb	%al, %al
	je	L2
	movl	$1, %eax
	jmp	L28
L2:
	leal	96(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC1, (%esp)
	call	_printf
	movl	$0, 92(%esp)
	leal	92(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC2, (%esp)
	call	_cargar_inventario
	movl	%eax, 216(%esp)
	cmpl	$0, 216(%esp)
	jne	L4
	movl	$LC3, (%esp)
	call	_puts
	movl	$1, %eax
	jmp	L28
L4:
	movl	$0, 252(%esp)
	movl	$0, 248(%esp)
	movb	$115, 91(%esp)
	jmp	L5
L19:
	movl	$LC4, (%esp)
	call	_puts
	movl	$LC5, (%esp)
	call	_printf
	leal	71(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC6, (%esp)
	call	_scanf
	movl	92(%esp), %eax
	leal	71(%esp), %edx
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	216(%esp), %eax
	movl	%eax, (%esp)
	call	_buscar_producto
	movl	%eax, 212(%esp)
	cmpl	$0, 212(%esp)
	je	L6
	movl	$0, 244(%esp)
	movl	$0, 240(%esp)
	jmp	L7
L9:
	movl	240(%esp), %eax
	leal	0(,%eax,8), %edx
	movl	252(%esp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	cmpl	212(%esp), %eax
	jne	L8
	movl	240(%esp), %eax
	leal	0(,%eax,8), %edx
	movl	252(%esp), %eax
	addl	%edx, %eax
	movl	4(%eax), %eax
	addl	%eax, 244(%esp)
L8:
	addl	$1, 240(%esp)
L7:
	movl	240(%esp), %eax
	cmpl	248(%esp), %eax
	jl	L9
	movl	212(%esp), %eax
	movl	72(%eax), %eax
	subl	244(%esp), %eax
	movl	%eax, 208(%esp)
	movl	212(%esp), %eax
	addl	$20, %eax
	movl	%eax, 4(%esp)
	movl	$LC7, (%esp)
	call	_printf
	movl	212(%esp), %eax
	flds	80(%eax)
	fstpl	4(%esp)
	movl	$LC8, (%esp)
	call	_printf
	movl	212(%esp), %eax
	movl	72(%eax), %eax
	movl	208(%esp), %edx
	movl	%edx, 12(%esp)
	movl	244(%esp), %edx
	movl	%edx, 8(%esp)
	movl	%eax, 4(%esp)
	movl	$LC9, (%esp)
	call	_printf
	cmpl	$0, 208(%esp)
	jg	L10
	movl	$LC10, (%esp)
	call	_puts
	jmp	L18
L10:
	movl	208(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC11, (%esp)
	call	_printf
	leal	64(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC12, (%esp)
	call	_scanf
	movl	64(%esp), %eax
	testl	%eax, %eax
	jle	L12
	movl	64(%esp), %eax
	cmpl	208(%esp), %eax
	jg	L12
	movl	$0, 236(%esp)
	movl	$0, 232(%esp)
	jmp	L13
L16:
	movl	232(%esp), %eax
	leal	0(,%eax,8), %edx
	movl	252(%esp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	cmpl	212(%esp), %eax
	jne	L14
	movl	232(%esp), %eax
	leal	0(,%eax,8), %edx
	movl	252(%esp), %eax
	addl	%edx, %eax
	movl	232(%esp), %edx
	leal	0(,%edx,8), %ecx
	movl	252(%esp), %edx
	addl	%ecx, %edx
	movl	4(%edx), %ecx
	movl	64(%esp), %edx
	addl	%ecx, %edx
	movl	%edx, 4(%eax)
	movl	$1, 236(%esp)
	jmp	L15
L14:
	addl	$1, 232(%esp)
L13:
	movl	232(%esp), %eax
	cmpl	248(%esp), %eax
	jl	L16
L15:
	cmpl	$0, 236(%esp)
	jne	L17
	movl	248(%esp), %eax
	addl	$1, %eax
	sall	$3, %eax
	movl	%eax, 4(%esp)
	movl	252(%esp), %eax
	movl	%eax, (%esp)
	call	_realloc
	movl	%eax, 252(%esp)
	movl	248(%esp), %eax
	leal	0(,%eax,8), %edx
	movl	252(%esp), %eax
	addl	%eax, %edx
	movl	212(%esp), %eax
	movl	%eax, (%edx)
	movl	248(%esp), %eax
	leal	0(,%eax,8), %edx
	movl	252(%esp), %eax
	addl	%eax, %edx
	movl	64(%esp), %eax
	movl	%eax, 4(%edx)
	addl	$1, 248(%esp)
L17:
	movl	64(%esp), %edx
	movl	244(%esp), %eax
	addl	%edx, %eax
	movl	%eax, 4(%esp)
	movl	$LC13, (%esp)
	call	_printf
	jmp	L18
L12:
	movl	208(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC14, (%esp)
	call	_printf
	jmp	L18
L6:
	movl	$LC15, (%esp)
	call	_puts
L18:
	movl	$LC16, (%esp)
	call	_printf
	leal	91(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC17, (%esp)
	call	_scanf
L5:
	movzbl	91(%esp), %eax
	cmpb	$115, %al
	je	L19
	movzbl	91(%esp), %eax
	cmpb	$83, %al
	je	L19
	cmpl	$0, 248(%esp)
	jle	L20
	movl	$LC18, (%esp)
	call	_obtener_siguiente_factura
	movl	%eax, 204(%esp)
	fldz
	fstps	228(%esp)
	movl	$LC20, (%esp)
	call	_puts
	movl	204(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC21, (%esp)
	call	_printf
	movl	$LC22, (%esp)
	call	_puts
	movl	$LC23, 16(%esp)
	movl	$LC24, 12(%esp)
	movl	$LC25, 8(%esp)
	movl	$LC26, 4(%esp)
	movl	$LC27, (%esp)
	call	_printf
	movl	$0, 224(%esp)
	jmp	L21
L22:
	movl	224(%esp), %eax
	leal	0(,%eax,8), %edx
	movl	252(%esp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	%eax, 200(%esp)
	movl	200(%esp), %eax
	flds	80(%eax)
	movl	224(%esp), %eax
	leal	0(,%eax,8), %edx
	movl	252(%esp), %eax
	addl	%edx, %eax
	movl	4(%eax), %eax
	movl	%eax, 44(%esp)
	fildl	44(%esp)
	fmulp	%st, %st(1)
	fstps	196(%esp)
	flds	228(%esp)
	fadds	196(%esp)
	fstps	228(%esp)
	flds	196(%esp)
	movl	200(%esp), %eax
	flds	80(%eax)
	fxch	%st(1)
	movl	224(%esp), %eax
	leal	0(,%eax,8), %edx
	movl	252(%esp), %eax
	addl	%edx, %eax
	movl	4(%eax), %eax
	movl	200(%esp), %edx
	addl	$20, %edx
	fstpl	20(%esp)
	fstpl	12(%esp)
	movl	%eax, 8(%esp)
	movl	%edx, 4(%esp)
	movl	$LC28, (%esp)
	call	_printf
	addl	$1, 224(%esp)
L21:
	movl	224(%esp), %eax
	cmpl	248(%esp), %eax
	jl	L22
	movl	$LC29, (%esp)
	call	_puts
	flds	228(%esp)
	fstpl	4(%esp)
	movl	$LC30, (%esp)
	call	_printf
	movl	$LC31, (%esp)
	call	_printf
	leal	63(%esp), %eax
	movl	%eax, 4(%esp)
	movl	$LC17, (%esp)
	call	_scanf
	movzbl	63(%esp), %eax
	cmpb	$115, %al
	je	L23
	movzbl	63(%esp), %eax
	cmpb	$83, %al
	jne	L24
L23:
	movl	$0, 220(%esp)
	jmp	L25
L26:
	movl	220(%esp), %eax
	leal	0(,%eax,8), %edx
	movl	252(%esp), %eax
	addl	%edx, %eax
	movl	(%eax), %eax
	movl	220(%esp), %edx
	leal	0(,%edx,8), %ecx
	movl	252(%esp), %edx
	addl	%ecx, %edx
	movl	(%edx), %edx
	movl	72(%edx), %ecx
	movl	220(%esp), %edx
	leal	0(,%edx,8), %ebx
	movl	252(%esp), %edx
	addl	%ebx, %edx
	movl	4(%edx), %edx
	subl	%edx, %ecx
	movl	%ecx, %edx
	movl	%edx, 72(%eax)
	addl	$1, 220(%esp)
L25:
	movl	220(%esp), %eax
	cmpl	248(%esp), %eax
	jl	L26
	movl	92(%esp), %eax
	movl	248(%esp), %edx
	movl	%edx, 20(%esp)
	movl	252(%esp), %edx
	movl	%edx, 16(%esp)
	movl	%eax, 12(%esp)
	movl	216(%esp), %eax
	movl	%eax, 8(%esp)
	movl	$LC2, 4(%esp)
	movl	$LC18, (%esp)
	call	_registrar_venta
	jmp	L20
L24:
	movl	$LC32, (%esp)
	call	_puts
L20:
	movl	216(%esp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	252(%esp), %eax
	movl	%eax, (%esp)
	call	_free
	movl	$0, %eax
L28:
	movl	-4(%ebp), %ebx
	leave
	.cfi_restore 5
	.cfi_restore 3
	.cfi_def_cfa 4, 4
	ret
	.cfi_endproc
LFE18:
	.ident	"GCC: (MinGW.org GCC-6.3.0-1) 6.3.0"
	.def	_login;	.scl	2;	.type	32;	.endef
	.def	_printf;	.scl	2;	.type	32;	.endef
	.def	_cargar_inventario;	.scl	2;	.type	32;	.endef
	.def	_puts;	.scl	2;	.type	32;	.endef
	.def	_scanf;	.scl	2;	.type	32;	.endef
	.def	_buscar_producto;	.scl	2;	.type	32;	.endef
	.def	_realloc;	.scl	2;	.type	32;	.endef
	.def	_obtener_siguiente_factura;	.scl	2;	.type	32;	.endef
	.def	_registrar_venta;	.scl	2;	.type	32;	.endef
	.def	_free;	.scl	2;	.type	32;	.endef
