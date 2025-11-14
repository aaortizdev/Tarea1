
obj/main.o:     file format pe-i386


Disassembly of section .text:

00000000 <_main>:
#include <string.h>
#include <ctype.h>
#include "usuarios.h"
#include "productos.h"

int main() {
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	81 ec 00 01 00 00    	sub    $0x100,%esp
   d:	e8 00 00 00 00       	call   12 <_main+0x12>
    char nombre_vendedor[100];
    
    // 1. Login
    if (!login("vendedores.txt", nombre_vendedor)) {
  12:	8d 44 24 60          	lea    0x60(%esp),%eax
  16:	89 44 24 04          	mov    %eax,0x4(%esp)
  1a:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  21:	e8 00 00 00 00       	call   26 <_main+0x26>
  26:	83 f0 01             	xor    $0x1,%eax
  29:	84 c0                	test   %al,%al
  2b:	74 0a                	je     37 <_main+0x37>
        return 1;
  2d:	b8 01 00 00 00       	mov    $0x1,%eax
  32:	e9 6b 06 00 00       	jmp    6a2 <_main+0x6a2>
    }
    
    printf("\nBienvenido, %s!\n", nombre_vendedor);
  37:	8d 44 24 60          	lea    0x60(%esp),%eax
  3b:	89 44 24 04          	mov    %eax,0x4(%esp)
  3f:	c7 04 24 0f 00 00 00 	movl   $0xf,(%esp)
  46:	e8 00 00 00 00       	call   4b <_main+0x4b>

    // 2. Cargar Inventario
    int n_productos = 0;
  4b:	c7 44 24 5c 00 00 00 	movl   $0x0,0x5c(%esp)
  52:	00 
    Producto* inventario = cargar_inventario("producto.txt", &n_productos);
  53:	8d 44 24 5c          	lea    0x5c(%esp),%eax
  57:	89 44 24 04          	mov    %eax,0x4(%esp)
  5b:	c7 04 24 21 00 00 00 	movl   $0x21,(%esp)
  62:	e8 00 00 00 00       	call   67 <_main+0x67>
  67:	89 84 24 d8 00 00 00 	mov    %eax,0xd8(%esp)
    if (!inventario) {
  6e:	83 bc 24 d8 00 00 00 	cmpl   $0x0,0xd8(%esp)
  75:	00 
  76:	75 16                	jne    8e <_main+0x8e>
        printf("Error cargando inventario.\n");
  78:	c7 04 24 2e 00 00 00 	movl   $0x2e,(%esp)
  7f:	e8 00 00 00 00       	call   84 <_main+0x84>
        return 1;
  84:	b8 01 00 00 00       	mov    $0x1,%eax
  89:	e9 14 06 00 00       	jmp    6a2 <_main+0x6a2>
    }

    // Carrito de compras (Memoria Dinamica)
    DetalleVenta* carrito = NULL;
  8e:	c7 84 24 fc 00 00 00 	movl   $0x0,0xfc(%esp)
  95:	00 00 00 00 
    int items_carrito = 0;
  99:	c7 84 24 f8 00 00 00 	movl   $0x0,0xf8(%esp)
  a0:	00 00 00 00 
    char continuar = 's';
  a4:	c6 44 24 5b 73       	movb   $0x73,0x5b(%esp)



    // 3. Bucle de Ventas
    while (continuar == 's' || continuar == 'S') {
  a9:	e9 2a 03 00 00       	jmp    3d8 <_main+0x3d8>
        char codigo[20];
        int cantidad;

        printf("\n--- NUEVA LINEA DE VENTA ---\n");
  ae:	c7 04 24 49 00 00 00 	movl   $0x49,(%esp)
  b5:	e8 00 00 00 00       	call   ba <_main+0xba>
        printf("Ingrese Codigo del producto: ");
  ba:	c7 04 24 67 00 00 00 	movl   $0x67,(%esp)
  c1:	e8 00 00 00 00       	call   c6 <_main+0xc6>
        scanf("%s", codigo);
  c6:	8d 44 24 47          	lea    0x47(%esp),%eax
  ca:	89 44 24 04          	mov    %eax,0x4(%esp)
  ce:	c7 04 24 85 00 00 00 	movl   $0x85,(%esp)
  d5:	e8 00 00 00 00       	call   da <_main+0xda>

        Producto* p = buscar_producto(inventario, n_productos, codigo);
  da:	8b 44 24 5c          	mov    0x5c(%esp),%eax
  de:	8d 54 24 47          	lea    0x47(%esp),%edx
  e2:	89 54 24 08          	mov    %edx,0x8(%esp)
  e6:	89 44 24 04          	mov    %eax,0x4(%esp)
  ea:	8b 84 24 d8 00 00 00 	mov    0xd8(%esp),%eax
  f1:	89 04 24             	mov    %eax,(%esp)
  f4:	e8 00 00 00 00       	call   f9 <_main+0xf9>
  f9:	89 84 24 d4 00 00 00 	mov    %eax,0xd4(%esp)
        
        if (p) {
 100:	83 bc 24 d4 00 00 00 	cmpl   $0x0,0xd4(%esp)
 107:	00 
 108:	0f 84 9e 02 00 00    	je     3ac <_main+0x3ac>
            // === NUEVA VALIDACIÓN: CALCULAR STOCK REAL ===
            int cantidad_ya_en_carrito = 0;
 10e:	c7 84 24 f4 00 00 00 	movl   $0x0,0xf4(%esp)
 115:	00 00 00 00 
            
            // Recorremos el carrito para ver si ya agregamos este producto antes
            for(int i = 0; i < items_carrito; i++) {
 119:	c7 84 24 f0 00 00 00 	movl   $0x0,0xf0(%esp)
 120:	00 00 00 00 
 124:	eb 4b                	jmp    171 <_main+0x171>
                // Comparamos punteros o códigos para saber si es el mismo producto
                if(carrito[i].productoPtr == p) {
 126:	8b 84 24 f0 00 00 00 	mov    0xf0(%esp),%eax
 12d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 134:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 13b:	01 d0                	add    %edx,%eax
 13d:	8b 00                	mov    (%eax),%eax
 13f:	3b 84 24 d4 00 00 00 	cmp    0xd4(%esp),%eax
 146:	75 21                	jne    169 <_main+0x169>
                    cantidad_ya_en_carrito += carrito[i].cantidadVenta;
 148:	8b 84 24 f0 00 00 00 	mov    0xf0(%esp),%eax
 14f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 156:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 15d:	01 d0                	add    %edx,%eax
 15f:	8b 40 04             	mov    0x4(%eax),%eax
 162:	01 84 24 f4 00 00 00 	add    %eax,0xf4(%esp)
            for(int i = 0; i < items_carrito; i++) {
 169:	83 84 24 f0 00 00 00 	addl   $0x1,0xf0(%esp)
 170:	01 
 171:	8b 84 24 f0 00 00 00 	mov    0xf0(%esp),%eax
 178:	3b 84 24 f8 00 00 00 	cmp    0xf8(%esp),%eax
 17f:	7c a5                	jl     126 <_main+0x126>
                }
            }

            // El disponible real es lo que hay en bodega MENOS lo que ya tiene el cliente en la mano
            int disponible_real = p->cantidad - cantidad_ya_en_carrito;
 181:	8b 84 24 d4 00 00 00 	mov    0xd4(%esp),%eax
 188:	8b 40 08             	mov    0x8(%eax),%eax
 18b:	2b 84 24 f4 00 00 00 	sub    0xf4(%esp),%eax
 192:	89 84 24 d0 00 00 00 	mov    %eax,0xd0(%esp)

            printf("Producto: %s\n", p->nombre);
 199:	8b 84 24 d4 00 00 00 	mov    0xd4(%esp),%eax
 1a0:	83 c0 20             	add    $0x20,%eax
 1a3:	89 44 24 04          	mov    %eax,0x4(%esp)
 1a7:	c7 04 24 88 00 00 00 	movl   $0x88,(%esp)
 1ae:	e8 00 00 00 00       	call   1b3 <_main+0x1b3>
            printf("Precio: %.2f\n", p->precio);
 1b3:	8b 84 24 d4 00 00 00 	mov    0xd4(%esp),%eax
 1ba:	d9 40 04             	flds   0x4(%eax)
 1bd:	dd 5c 24 04          	fstpl  0x4(%esp)
 1c1:	c7 04 24 96 00 00 00 	movl   $0x96,(%esp)
 1c8:	e8 00 00 00 00       	call   1cd <_main+0x1cd>
            printf("Stock Bodega: %d | En su carrito: %d | -> DISPONIBLE: %d\n", 
 1cd:	8b 84 24 d4 00 00 00 	mov    0xd4(%esp),%eax
 1d4:	8b 40 08             	mov    0x8(%eax),%eax
 1d7:	8b 94 24 d0 00 00 00 	mov    0xd0(%esp),%edx
 1de:	89 54 24 0c          	mov    %edx,0xc(%esp)
 1e2:	8b 94 24 f4 00 00 00 	mov    0xf4(%esp),%edx
 1e9:	89 54 24 08          	mov    %edx,0x8(%esp)
 1ed:	89 44 24 04          	mov    %eax,0x4(%esp)
 1f1:	c7 04 24 a4 00 00 00 	movl   $0xa4,(%esp)
 1f8:	e8 00 00 00 00       	call   1fd <_main+0x1fd>
                   p->cantidad, cantidad_ya_en_carrito, disponible_real);

            // Si ya no queda nada disponible, avisamos y saltamos
            if (disponible_real <= 0) {
 1fd:	83 bc 24 d0 00 00 00 	cmpl   $0x0,0xd0(%esp)
 204:	00 
 205:	7f 11                	jg     218 <_main+0x218>
                printf("¡ALERTA! Ya ha reservado todo el stock disponible de este producto.\n");
 207:	c7 04 24 e0 00 00 00 	movl   $0xe0,(%esp)
 20e:	e8 00 00 00 00       	call   213 <_main+0x213>
 213:	e9 a0 01 00 00       	jmp    3b8 <_main+0x3b8>
            } else {
                printf("Ingrese cantidad a vender (Max %d): ", disponible_real);
 218:	8b 84 24 d0 00 00 00 	mov    0xd0(%esp),%eax
 21f:	89 44 24 04          	mov    %eax,0x4(%esp)
 223:	c7 04 24 28 01 00 00 	movl   $0x128,(%esp)
 22a:	e8 00 00 00 00       	call   22f <_main+0x22f>
                scanf("%d", &cantidad);
 22f:	8d 44 24 40          	lea    0x40(%esp),%eax
 233:	89 44 24 04          	mov    %eax,0x4(%esp)
 237:	c7 04 24 4d 01 00 00 	movl   $0x14d,(%esp)
 23e:	e8 00 00 00 00       	call   243 <_main+0x243>

                // Validamos:
                // 1. Que sea positivo (cantidad > 0)
                // 2. Que no supere lo que queda disponible (cantidad <= disponible_real)
                if (cantidad > 0 && cantidad <= disponible_real) {
 243:	8b 44 24 40          	mov    0x40(%esp),%eax
 247:	85 c0                	test   %eax,%eax
 249:	0f 8e 44 01 00 00    	jle    393 <_main+0x393>
 24f:	8b 44 24 40          	mov    0x40(%esp),%eax
 253:	3b 84 24 d0 00 00 00 	cmp    0xd0(%esp),%eax
 25a:	0f 8f 33 01 00 00    	jg     393 <_main+0x393>
                    
                    // Buscar si el producto YA existe en el carrito para sumar la cantidad
                    // en lugar de crear una línea nueva (Opcional, pero recomendado)
                    int encontrado_en_carrito = 0;
 260:	c7 84 24 ec 00 00 00 	movl   $0x0,0xec(%esp)
 267:	00 00 00 00 
                    for(int i=0; i < items_carrito; i++) {
 26b:	c7 84 24 e8 00 00 00 	movl   $0x0,0xe8(%esp)
 272:	00 00 00 00 
 276:	eb 71                	jmp    2e9 <_main+0x2e9>
                        if(carrito[i].productoPtr == p) {
 278:	8b 84 24 e8 00 00 00 	mov    0xe8(%esp),%eax
 27f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 286:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 28d:	01 d0                	add    %edx,%eax
 28f:	8b 00                	mov    (%eax),%eax
 291:	3b 84 24 d4 00 00 00 	cmp    0xd4(%esp),%eax
 298:	75 47                	jne    2e1 <_main+0x2e1>
                            carrito[i].cantidadVenta += cantidad;
 29a:	8b 84 24 e8 00 00 00 	mov    0xe8(%esp),%eax
 2a1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 2a8:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 2af:	01 d0                	add    %edx,%eax
 2b1:	8b 94 24 e8 00 00 00 	mov    0xe8(%esp),%edx
 2b8:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 2bf:	8b 94 24 fc 00 00 00 	mov    0xfc(%esp),%edx
 2c6:	01 ca                	add    %ecx,%edx
 2c8:	8b 4a 04             	mov    0x4(%edx),%ecx
 2cb:	8b 54 24 40          	mov    0x40(%esp),%edx
 2cf:	01 ca                	add    %ecx,%edx
 2d1:	89 50 04             	mov    %edx,0x4(%eax)
                            encontrado_en_carrito = 1;
 2d4:	c7 84 24 ec 00 00 00 	movl   $0x1,0xec(%esp)
 2db:	01 00 00 00 
                            break;
 2df:	eb 1c                	jmp    2fd <_main+0x2fd>
                    for(int i=0; i < items_carrito; i++) {
 2e1:	83 84 24 e8 00 00 00 	addl   $0x1,0xe8(%esp)
 2e8:	01 
 2e9:	8b 84 24 e8 00 00 00 	mov    0xe8(%esp),%eax
 2f0:	3b 84 24 f8 00 00 00 	cmp    0xf8(%esp),%eax
 2f7:	0f 8c 7b ff ff ff    	jl     278 <_main+0x278>
                        }
                    }

                    // Si no estaba en el carrito, creamos nueva línea
                    if (!encontrado_en_carrito) {
 2fd:	83 bc 24 ec 00 00 00 	cmpl   $0x0,0xec(%esp)
 304:	00 
 305:	75 6d                	jne    374 <_main+0x374>
                        carrito = (DetalleVenta*)realloc(carrito, (items_carrito + 1) * sizeof(DetalleVenta));
 307:	8b 84 24 f8 00 00 00 	mov    0xf8(%esp),%eax
 30e:	83 c0 01             	add    $0x1,%eax
 311:	c1 e0 03             	shl    $0x3,%eax
 314:	89 44 24 04          	mov    %eax,0x4(%esp)
 318:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 31f:	89 04 24             	mov    %eax,(%esp)
 322:	e8 00 00 00 00       	call   327 <_main+0x327>
 327:	89 84 24 fc 00 00 00 	mov    %eax,0xfc(%esp)
                        carrito[items_carrito].productoPtr = p;
 32e:	8b 84 24 f8 00 00 00 	mov    0xf8(%esp),%eax
 335:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 33c:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 343:	01 c2                	add    %eax,%edx
 345:	8b 84 24 d4 00 00 00 	mov    0xd4(%esp),%eax
 34c:	89 02                	mov    %eax,(%edx)
                        carrito[items_carrito].cantidadVenta = cantidad;
 34e:	8b 84 24 f8 00 00 00 	mov    0xf8(%esp),%eax
 355:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 35c:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 363:	01 c2                	add    %eax,%edx
 365:	8b 44 24 40          	mov    0x40(%esp),%eax
 369:	89 42 04             	mov    %eax,0x4(%edx)
                        items_carrito++;
 36c:	83 84 24 f8 00 00 00 	addl   $0x1,0xf8(%esp)
 373:	01 
                    }
                    
                    printf(">> Agregado exitosamente. (Total en carrito de este prod: %d)\n", 
 374:	8b 54 24 40          	mov    0x40(%esp),%edx
 378:	8b 84 24 f4 00 00 00 	mov    0xf4(%esp),%eax
 37f:	01 d0                	add    %edx,%eax
 381:	89 44 24 04          	mov    %eax,0x4(%esp)
 385:	c7 04 24 50 01 00 00 	movl   $0x150,(%esp)
 38c:	e8 00 00 00 00       	call   391 <_main+0x391>
                if (cantidad > 0 && cantidad <= disponible_real) {
 391:	eb 25                	jmp    3b8 <_main+0x3b8>
                           cantidad_ya_en_carrito + cantidad);
                } else {
                    printf(">> ERROR: Cantidad invalida. Debe ser entre 1 y %d.\n", disponible_real);
 393:	8b 84 24 d0 00 00 00 	mov    0xd0(%esp),%eax
 39a:	89 44 24 04          	mov    %eax,0x4(%esp)
 39e:	c7 04 24 90 01 00 00 	movl   $0x190,(%esp)
 3a5:	e8 00 00 00 00       	call   3aa <_main+0x3aa>
 3aa:	eb 0c                	jmp    3b8 <_main+0x3b8>
                }
            }
        } else {
            printf(">> Error: Producto no encontrado.\n");
 3ac:	c7 04 24 c8 01 00 00 	movl   $0x1c8,(%esp)
 3b3:	e8 00 00 00 00       	call   3b8 <_main+0x3b8>
        }

        printf("\n¿Desea registrar otro producto? (s/n): ");
 3b8:	c7 04 24 ec 01 00 00 	movl   $0x1ec,(%esp)
 3bf:	e8 00 00 00 00       	call   3c4 <_main+0x3c4>
        scanf(" %c", &continuar);
 3c4:	8d 44 24 5b          	lea    0x5b(%esp),%eax
 3c8:	89 44 24 04          	mov    %eax,0x4(%esp)
 3cc:	c7 04 24 16 02 00 00 	movl   $0x216,(%esp)
 3d3:	e8 00 00 00 00       	call   3d8 <_main+0x3d8>
    while (continuar == 's' || continuar == 'S') {
 3d8:	0f b6 44 24 5b       	movzbl 0x5b(%esp),%eax
 3dd:	3c 73                	cmp    $0x73,%al
 3df:	0f 84 c9 fc ff ff    	je     ae <_main+0xae>
 3e5:	0f b6 44 24 5b       	movzbl 0x5b(%esp),%eax
 3ea:	3c 53                	cmp    $0x53,%al
 3ec:	0f 84 bc fc ff ff    	je     ae <_main+0xae>
    }



    // 4. Mostrar Resumen y Confirmar
    if (items_carrito > 0) {
 3f2:	83 bc 24 f8 00 00 00 	cmpl   $0x0,0xf8(%esp)
 3f9:	00 
 3fa:	0f 8e 7f 02 00 00    	jle    67f <_main+0x67f>
        int next_fact = obtener_siguiente_factura("ventas.txt");
 400:	c7 04 24 1a 02 00 00 	movl   $0x21a,(%esp)
 407:	e8 00 00 00 00       	call   40c <_main+0x40c>
 40c:	89 84 24 cc 00 00 00 	mov    %eax,0xcc(%esp)
        float gran_total = 0;
 413:	d9 ee                	fldz   
 415:	d9 9c 24 e4 00 00 00 	fstps  0xe4(%esp)

        printf("\n========================================\n");
 41c:	c7 04 24 28 02 00 00 	movl   $0x228,(%esp)
 423:	e8 00 00 00 00       	call   428 <_main+0x428>
        printf("PRE-FACTURA #%d\n", next_fact);
 428:	8b 84 24 cc 00 00 00 	mov    0xcc(%esp),%eax
 42f:	89 44 24 04          	mov    %eax,0x4(%esp)
 433:	c7 04 24 52 02 00 00 	movl   $0x252,(%esp)
 43a:	e8 00 00 00 00       	call   43f <_main+0x43f>
        printf("========================================\n");
 43f:	c7 04 24 64 02 00 00 	movl   $0x264,(%esp)
 446:	e8 00 00 00 00       	call   44b <_main+0x44b>
        printf("%-20s %-10s %-10s %-10s\n", "Producto", "Cant", "P.Unit", "Total");
 44b:	c7 44 24 10 8d 02 00 	movl   $0x28d,0x10(%esp)
 452:	00 
 453:	c7 44 24 0c 93 02 00 	movl   $0x293,0xc(%esp)
 45a:	00 
 45b:	c7 44 24 08 9a 02 00 	movl   $0x29a,0x8(%esp)
 462:	00 
 463:	c7 44 24 04 9f 02 00 	movl   $0x29f,0x4(%esp)
 46a:	00 
 46b:	c7 04 24 a8 02 00 00 	movl   $0x2a8,(%esp)
 472:	e8 00 00 00 00       	call   477 <_main+0x477>
        
        for(int i=0; i<items_carrito; i++) {
 477:	c7 84 24 e0 00 00 00 	movl   $0x0,0xe0(%esp)
 47e:	00 00 00 00 
 482:	e9 c5 00 00 00       	jmp    54c <_main+0x54c>
            Producto* p = carrito[i].productoPtr;
 487:	8b 84 24 e0 00 00 00 	mov    0xe0(%esp),%eax
 48e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 495:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 49c:	01 d0                	add    %edx,%eax
 49e:	8b 00                	mov    (%eax),%eax
 4a0:	89 84 24 c8 00 00 00 	mov    %eax,0xc8(%esp)
            float total_linea = p->precio * carrito[i].cantidadVenta;
 4a7:	8b 84 24 c8 00 00 00 	mov    0xc8(%esp),%eax
 4ae:	d9 40 04             	flds   0x4(%eax)
 4b1:	8b 84 24 e0 00 00 00 	mov    0xe0(%esp),%eax
 4b8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 4bf:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 4c6:	01 d0                	add    %edx,%eax
 4c8:	8b 40 04             	mov    0x4(%eax),%eax
 4cb:	89 44 24 2c          	mov    %eax,0x2c(%esp)
 4cf:	db 44 24 2c          	fildl  0x2c(%esp)
 4d3:	de c9                	fmulp  %st,%st(1)
 4d5:	d9 9c 24 c4 00 00 00 	fstps  0xc4(%esp)
            gran_total += total_linea;
 4dc:	d9 84 24 e4 00 00 00 	flds   0xe4(%esp)
 4e3:	d8 84 24 c4 00 00 00 	fadds  0xc4(%esp)
 4ea:	d9 9c 24 e4 00 00 00 	fstps  0xe4(%esp)
            printf("%-20s %-10d %-10.2f %-10.2f\n", p->nombre, carrito[i].cantidadVenta, p->precio, total_linea);
 4f1:	d9 84 24 c4 00 00 00 	flds   0xc4(%esp)
 4f8:	8b 84 24 c8 00 00 00 	mov    0xc8(%esp),%eax
 4ff:	d9 40 04             	flds   0x4(%eax)
 502:	d9 c9                	fxch   %st(1)
 504:	8b 84 24 e0 00 00 00 	mov    0xe0(%esp),%eax
 50b:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 512:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 519:	01 d0                	add    %edx,%eax
 51b:	8b 40 04             	mov    0x4(%eax),%eax
 51e:	8b 94 24 c8 00 00 00 	mov    0xc8(%esp),%edx
 525:	83 c2 20             	add    $0x20,%edx
 528:	dd 5c 24 14          	fstpl  0x14(%esp)
 52c:	dd 5c 24 0c          	fstpl  0xc(%esp)
 530:	89 44 24 08          	mov    %eax,0x8(%esp)
 534:	89 54 24 04          	mov    %edx,0x4(%esp)
 538:	c7 04 24 c1 02 00 00 	movl   $0x2c1,(%esp)
 53f:	e8 00 00 00 00       	call   544 <_main+0x544>
        for(int i=0; i<items_carrito; i++) {
 544:	83 84 24 e0 00 00 00 	addl   $0x1,0xe0(%esp)
 54b:	01 
 54c:	8b 84 24 e0 00 00 00 	mov    0xe0(%esp),%eax
 553:	3b 84 24 f8 00 00 00 	cmp    0xf8(%esp),%eax
 55a:	0f 8c 27 ff ff ff    	jl     487 <_main+0x487>
        }
        printf("----------------------------------------\n");
 560:	c7 04 24 e0 02 00 00 	movl   $0x2e0,(%esp)
 567:	e8 00 00 00 00       	call   56c <_main+0x56c>
        printf("TOTAL A PAGAR: %.2f\n", gran_total);
 56c:	d9 84 24 e4 00 00 00 	flds   0xe4(%esp)
 573:	dd 5c 24 04          	fstpl  0x4(%esp)
 577:	c7 04 24 09 03 00 00 	movl   $0x309,(%esp)
 57e:	e8 00 00 00 00       	call   583 <_main+0x583>
        
        printf("\n¿Confirmar venta y actualizar inventario? (s/n): ");
 583:	c7 04 24 20 03 00 00 	movl   $0x320,(%esp)
 58a:	e8 00 00 00 00       	call   58f <_main+0x58f>
        char confirmar;
        scanf(" %c", &confirmar);
 58f:	8d 44 24 3f          	lea    0x3f(%esp),%eax
 593:	89 44 24 04          	mov    %eax,0x4(%esp)
 597:	c7 04 24 16 02 00 00 	movl   $0x216,(%esp)
 59e:	e8 00 00 00 00       	call   5a3 <_main+0x5a3>

        if (confirmar == 's' || confirmar == 'S') {
 5a3:	0f b6 44 24 3f       	movzbl 0x3f(%esp),%eax
 5a8:	3c 73                	cmp    $0x73,%al
 5aa:	74 0d                	je     5b9 <_main+0x5b9>
 5ac:	0f b6 44 24 3f       	movzbl 0x3f(%esp),%eax
 5b1:	3c 53                	cmp    $0x53,%al
 5b3:	0f 85 ba 00 00 00    	jne    673 <_main+0x673>
            // Reducir stock en memoria
            for(int i=0; i<items_carrito; i++) {
 5b9:	c7 84 24 dc 00 00 00 	movl   $0x0,0xdc(%esp)
 5c0:	00 00 00 00 
 5c4:	eb 5e                	jmp    624 <_main+0x624>
                carrito[i].productoPtr->cantidad -= carrito[i].cantidadVenta;
 5c6:	8b 84 24 dc 00 00 00 	mov    0xdc(%esp),%eax
 5cd:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 5d4:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 5db:	01 d0                	add    %edx,%eax
 5dd:	8b 00                	mov    (%eax),%eax
 5df:	8b 94 24 dc 00 00 00 	mov    0xdc(%esp),%edx
 5e6:	8d 0c d5 00 00 00 00 	lea    0x0(,%edx,8),%ecx
 5ed:	8b 94 24 fc 00 00 00 	mov    0xfc(%esp),%edx
 5f4:	01 ca                	add    %ecx,%edx
 5f6:	8b 12                	mov    (%edx),%edx
 5f8:	8b 4a 08             	mov    0x8(%edx),%ecx
 5fb:	8b 94 24 dc 00 00 00 	mov    0xdc(%esp),%edx
 602:	8d 1c d5 00 00 00 00 	lea    0x0(,%edx,8),%ebx
 609:	8b 94 24 fc 00 00 00 	mov    0xfc(%esp),%edx
 610:	01 da                	add    %ebx,%edx
 612:	8b 52 04             	mov    0x4(%edx),%edx
 615:	29 d1                	sub    %edx,%ecx
 617:	89 ca                	mov    %ecx,%edx
 619:	89 50 08             	mov    %edx,0x8(%eax)
            for(int i=0; i<items_carrito; i++) {
 61c:	83 84 24 dc 00 00 00 	addl   $0x1,0xdc(%esp)
 623:	01 
 624:	8b 84 24 dc 00 00 00 	mov    0xdc(%esp),%eax
 62b:	3b 84 24 f8 00 00 00 	cmp    0xf8(%esp),%eax
 632:	7c 92                	jl     5c6 <_main+0x5c6>
            }
            // Guardar en disco
            registrar_venta("ventas.txt", "producto.txt", inventario, n_productos, carrito, items_carrito);
 634:	8b 44 24 5c          	mov    0x5c(%esp),%eax
 638:	8b 94 24 f8 00 00 00 	mov    0xf8(%esp),%edx
 63f:	89 54 24 14          	mov    %edx,0x14(%esp)
 643:	8b 94 24 fc 00 00 00 	mov    0xfc(%esp),%edx
 64a:	89 54 24 10          	mov    %edx,0x10(%esp)
 64e:	89 44 24 0c          	mov    %eax,0xc(%esp)
 652:	8b 84 24 d8 00 00 00 	mov    0xd8(%esp),%eax
 659:	89 44 24 08          	mov    %eax,0x8(%esp)
 65d:	c7 44 24 04 21 00 00 	movl   $0x21,0x4(%esp)
 664:	00 
 665:	c7 04 24 1a 02 00 00 	movl   $0x21a,(%esp)
 66c:	e8 00 00 00 00       	call   671 <_main+0x671>
 671:	eb 0c                	jmp    67f <_main+0x67f>
        } else {
            printf("Venta cancelada.\n");
 673:	c7 04 24 54 03 00 00 	movl   $0x354,(%esp)
 67a:	e8 00 00 00 00       	call   67f <_main+0x67f>
        }
    }

    // 5. Limpieza de memoria
    free(inventario);
 67f:	8b 84 24 d8 00 00 00 	mov    0xd8(%esp),%eax
 686:	89 04 24             	mov    %eax,(%esp)
 689:	e8 00 00 00 00       	call   68e <_main+0x68e>
    free(carrito);
 68e:	8b 84 24 fc 00 00 00 	mov    0xfc(%esp),%eax
 695:	89 04 24             	mov    %eax,(%esp)
 698:	e8 00 00 00 00       	call   69d <_main+0x69d>

    return 0;
 69d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 6a2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 6a5:	c9                   	leave  
 6a6:	c3                   	ret    
 6a7:	90                   	nop
