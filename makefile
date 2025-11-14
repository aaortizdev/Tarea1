CC = gcc
CFLAGS = -Wall -g
# Definimos las carpetas de destino
ODIR = obj
SDIR = asm

# Lista de objetos con su ruta (ej: obj/main.o)
_OBJ = main.o usuarios.o productos.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))

# Objetivo principal: Generar el ejecutable
sistema_ventas: $(OBJ)
	$(CC) -o sistema_ventas $(OBJ)

# Regla para compilar .c a .o (guardando en carpeta obj)
$(ODIR)/%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Regla para generar ensamblador .s (guardando en carpeta asm)
$(SDIR)/%.s: %.c
	$(CC) -S $< -o $@

# Generar todos los .s originales (ejecutar: make assembly)
assembly: $(SDIR)/main.s $(SDIR)/usuarios.s $(SDIR)/productos.s

# Objetivo especial solicitado: Objdump desde la carpeta obj
dump_main: $(ODIR)/main.o
	objdump -d -S $(ODIR)/main.o > $(SDIR)/main.dump.s
	@echo "Archivo generado en asm/main.dump.s"

# Limpiar todo (ahora borra dentro de las carpetas)
clean:
	del /Q sistema_ventas.exe $(ODIR)\*.o $(SDIR)\*.s 2>NUL
	