#ifndef USUARIOS_H
#define USUARIOS_H
#include "common.h"
#include <stdbool.h>

// Retorna true si el login es exitoso
bool login(const char* archivo_vendedores, char* nombre_vendedor_out);

#endif