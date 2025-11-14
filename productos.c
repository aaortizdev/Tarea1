#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "productos.h"

Producto* cargar_inventario(const char* archivo, int* cantidad_productos) {
    FILE *f = fopen(archivo, "r");
    if (!f) {
        *cantidad_productos = 0;
        return NULL;
    }

    Producto* inventario = NULL;
    char linea[256];
    int count = 0;

    while (fgets(linea, sizeof(linea), f)) {
        // Realocación de memoria dinámica: Aumentamos el arreglo en 1
        inventario = (Producto*)realloc(inventario, (count + 1) * sizeof(Producto));
        
        char *token = strtok(linea, ",");
        strcpy(inventario[count].codigo, token);
        
        token = strtok(NULL, ",");
        strcpy(inventario[count].nombre, token);
        
        token = strtok(NULL, ",");
        inventario[count].cantidad = atoi(token);
        
        token = strtok(NULL, ",");
        inventario[count].costo = atof(token);
        
        token = strtok(NULL, "\n");
        inventario[count].precio = atof(token);

        count++;
    }
    
    fclose(f);
    *cantidad_productos = count;
    return inventario;
}

Producto* buscar_producto(Producto* inventario, int n, const char* codigo) {
    for (int i = 0; i < n; i++) {
        if (strcmp(inventario[i].codigo, codigo) == 0) {
            return &inventario[i];
        }
    }
    return NULL;
}

int obtener_siguiente_factura(const char* arch_ventas) {
    FILE *f = fopen(arch_ventas, "r");
    if (!f) return 1; // Si no existe, es la factura 1

    int last_id = 0;
    char linea[256];
    // Leer hasta el final para obtener el último ID
    while (fgets(linea, sizeof(linea), f)) {
        char *token = strtok(linea, ",");
        if (token) last_id = atoi(token);
    }
    fclose(f);
    return last_id + 1;
}

void registrar_venta(const char* arch_ventas, const char* arch_prod, Producto* inventario, int n, DetalleVenta* carrito, int items_carrito) {
    // 1. Actualizar archivo de productos (Inventario)
    FILE *fp = fopen(arch_prod, "w");
    for (int i = 0; i < n; i++) {
        fprintf(fp, "%s,%s,%d,%.2f,%.2f\n", 
            inventario[i].codigo, inventario[i].nombre, inventario[i].cantidad, 
            inventario[i].costo, inventario[i].precio);
    }
    fclose(fp);

    // 2. Registrar en ventas.txt
    // Obtener fecha
    time_t t = time(NULL);
    struct tm tm = *localtime(&t);
    char fecha[20];
    sprintf(fecha, "%d-%02d-%02d", tm.tm_year + 1900, tm.tm_mon + 1, tm.tm_mday);
    
    int num_factura = obtener_siguiente_factura(arch_ventas);
    
    FILE *fv = fopen(arch_ventas, "a");
    for (int i = 0; i < items_carrito; i++) {
        Producto *p = carrito[i].productoPtr;
        // Formato: Num_factura,Codigo,Nombre,cant_vendida,costo,precio,fecha
        fprintf(fv, "%d,%s,%s,%d,%.2f,%.2f,%s\n",
            num_factura, p->codigo, p->nombre, carrito[i].cantidadVenta,
            p->costo, p->precio, fecha);
    }
    fclose(fv);
    printf("\n[EXITO] Venta registrada correctamente. Factura #%d\n", num_factura);
}