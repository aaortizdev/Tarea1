#ifndef COMMON_H
#define COMMON_H

typedef struct {
    char usuario[50];
    char clave[50];
    char nombre[100];
} Vendedor;

typedef struct {
    float costo;
    float precio;
    int cantidad;
    char codigo[20];
    char nombre[50];
} Producto;

// Estructura para el "carrito" de compras temporal
typedef struct {
    Producto* productoPtr; // Puntero al producto en el inventario
    int cantidadVenta;
} DetalleVenta;

#endif
