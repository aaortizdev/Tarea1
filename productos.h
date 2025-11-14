#ifndef PRODUCTOS_H
#define PRODUCTOS_H
#include "common.h"

// Carga productos desde archivo a memoria dinámica
Producto* cargar_inventario(const char* archivo, int* cantidad_productos);

// Busca un producto por código en el arreglo
Producto* buscar_producto(Producto* inventario, int n, const char* codigo);

// Guarda una venta en el archivo y actualiza el archivo de inventario
void registrar_venta(const char* arch_ventas, const char* arch_prod, Producto* inventario, int n, DetalleVenta* carrito, int items_carrito);

// Obtiene el siguiente numero de factura
int obtener_siguiente_factura(const char* arch_ventas);

#endif

