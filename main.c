#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include "usuarios.h"
#include "productos.h"

int main() {
    char nombre_vendedor[100];
    
    // 1. Login
    if (!login("vendedores.txt", nombre_vendedor)) {
        return 1;
    }
    
    printf("\nBienvenido, %s!\n", nombre_vendedor);

    // 2. Cargar Inventario
    int n_productos = 0;
    Producto* inventario = cargar_inventario("producto.txt", &n_productos);
    if (!inventario) {
        printf("Error cargando inventario.\n");
        return 1;
    }

    // Carrito de compras (Memoria Dinamica)
    DetalleVenta* carrito = NULL;
    int items_carrito = 0;
    char continuar = 's';



    // 3. Bucle de Ventas
    while (continuar == 's' || continuar == 'S') {
        char codigo[20];
        int cantidad;

        printf("\n--- NUEVA LINEA DE VENTA ---\n");
        printf("Ingrese Codigo del producto: ");
        scanf("%s", codigo);

        Producto* p = buscar_producto(inventario, n_productos, codigo);
        
        if (p) {
            // === NUEVA VALIDACIÓN: CALCULAR STOCK REAL ===
            int cantidad_ya_en_carrito = 0;
            
            // Recorremos el carrito para ver si ya agregamos este producto antes
            for(int i = 0; i < items_carrito; i++) {
                // Comparamos punteros o códigos para saber si es el mismo producto
                if(carrito[i].productoPtr == p) {
                    cantidad_ya_en_carrito += carrito[i].cantidadVenta;
                }
            }

            // El disponible real es lo que hay en bodega MENOS lo que ya tiene el cliente en la mano
            int disponible_real = p->cantidad - cantidad_ya_en_carrito;

            printf("Producto: %s\n", p->nombre);
            printf("Precio: %.2f\n", p->precio);
            printf("Stock Bodega: %d | En su carrito: %d | -> DISPONIBLE: %d\n", 
                   p->cantidad, cantidad_ya_en_carrito, disponible_real);

            // Si ya no queda nada disponible, avisamos y saltamos
            if (disponible_real <= 0) {
                printf("¡ALERTA! Ya ha reservado todo el stock disponible de este producto.\n");
            } else {
                printf("Ingrese cantidad a vender (Max %d): ", disponible_real);
                scanf("%d", &cantidad);

                // Validamos:
                // 1. Que sea positivo (cantidad > 0)
                // 2. Que no supere lo que queda disponible (cantidad <= disponible_real)
                if (cantidad > 0 && cantidad <= disponible_real) {
                    
                    // Buscar si el producto YA existe en el carrito para sumar la cantidad
                    // en lugar de crear una línea nueva (Opcional, pero recomendado)
                    int encontrado_en_carrito = 0;
                    for(int i=0; i < items_carrito; i++) {
                        if(carrito[i].productoPtr == p) {
                            carrito[i].cantidadVenta += cantidad;
                            encontrado_en_carrito = 1;
                            break;
                        }
                    }

                    // Si no estaba en el carrito, creamos nueva línea
                    if (!encontrado_en_carrito) {
                        carrito = (DetalleVenta*)realloc(carrito, (items_carrito + 1) * sizeof(DetalleVenta));
                        carrito[items_carrito].productoPtr = p;
                        carrito[items_carrito].cantidadVenta = cantidad;
                        items_carrito++;
                    }
                    
                    printf(">> Agregado exitosamente. (Total en carrito de este prod: %d)\n", 
                           cantidad_ya_en_carrito + cantidad);
                } else {
                    printf(">> ERROR: Cantidad invalida. Debe ser entre 1 y %d.\n", disponible_real);
                }
            }
        } else {
            printf(">> Error: Producto no encontrado.\n");
        }

        printf("\n¿Desea registrar otro producto? (s/n): ");
        scanf(" %c", &continuar);
    }



    // 4. Mostrar Resumen y Confirmar
    if (items_carrito > 0) {
        int next_fact = obtener_siguiente_factura("ventas.txt");
        float gran_total = 0;

        printf("\n========================================\n");
        printf("PRE-FACTURA #%d\n", next_fact);
        printf("========================================\n");
        printf("%-20s %-10s %-10s %-10s\n", "Producto", "Cant", "P.Unit", "Total");
        
        for(int i=0; i<items_carrito; i++) {
            Producto* p = carrito[i].productoPtr;
            float total_linea = p->precio * carrito[i].cantidadVenta;
            gran_total += total_linea;
            printf("%-20s %-10d %-10.2f %-10.2f\n", p->nombre, carrito[i].cantidadVenta, p->precio, total_linea);
        }
        printf("----------------------------------------\n");
        printf("TOTAL A PAGAR: %.2f\n", gran_total);
        
        printf("\n¿Confirmar venta y actualizar inventario? (s/n): ");
        char confirmar;
        scanf(" %c", &confirmar);

        if (confirmar == 's' || confirmar == 'S') {
            // Reducir stock en memoria
            for(int i=0; i<items_carrito; i++) {
                carrito[i].productoPtr->cantidad -= carrito[i].cantidadVenta;
            }
            // Guardar en disco
            registrar_venta("ventas.txt", "producto.txt", inventario, n_productos, carrito, items_carrito);
        } else {
            printf("Venta cancelada.\n");
        }
    }

    // 5. Limpieza de memoria
    free(inventario);
    free(carrito);

    return 0;
}

