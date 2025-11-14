#ifndef COMMON_H
#define COMMON_H

typedef struct {
    char usuario[50];
    char clave[50];
    char nombre[100];
} Vendedor;

typedef struct {
    char codigo[20];
    char nombre[50];
    int cantidad;
    float costo;
    float precio;
} Producto;

// Estructura para el "carrito" de compras temporal
typedef struct {
    Producto* productoPtr; // Puntero al producto en el inventario
    int cantidadVenta;
} DetalleVenta;

#endif
