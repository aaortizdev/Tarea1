#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "usuarios.h"

bool login(const char* archivo_vendedores, char* nombre_vendedor_out) {
    FILE *f = fopen(archivo_vendedores, "r");
    if (!f) {
        printf("Error: No se encuentra el archivo %s\n", archivo_vendedores);
        return false;
    }

    // Cargar vendedores en memoria (simplificado para el login)
    // En un caso real, podriamos usar memoria dinamica si son muchos.
    Vendedor temp;
    char inputUser[50], inputPass[50];
    int intentos = 0;
    char linea[256];

    while (intentos < 3) {
        printf("\n--- LOGIN (Intento %d/3) ---\n", intentos + 1);
        printf("Usuario: ");
        scanf("%s", inputUser);
        printf("Clave: ");
        scanf("%s", inputPass);

        rewind(f); // Volver al inicio del archivo para buscar
        int encontrado = 0;
        
        // Formato archivo: Usuario,clave,Nombre
        while (fgets(linea, sizeof(linea), f)) {
            // Parsear CSV
            char *token = strtok(linea, ",");
            if(token) strcpy(temp.usuario, token);
            
            token = strtok(NULL, ",");
            if(token) strcpy(temp.clave, token);
            
            token = strtok(NULL, "\n"); // El nombre suele ser lo ultimo
            if(token) strcpy(temp.nombre, token);

            if (strcmp(inputUser, temp.usuario) == 0 && strcmp(inputPass, temp.clave) == 0) {
                strcpy(nombre_vendedor_out, temp.nombre);
                encontrado = 1;
                break;
            }
        }

        if (encontrado) {
            fclose(f);
            return true;
        } else {
            printf("Credenciales incorrectas.\n");
            intentos++;
        }
    }

    fclose(f);
    printf("Ha excedido el numero maximo de intentos.\n");
    return false;
}
