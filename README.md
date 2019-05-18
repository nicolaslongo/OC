# Organizacion de computadoras

## Tp1

### Correciones
 - Es demasiado dedicar una función a comparar un byte con CR o LR (isCR, isLF)
 - [x] documentar al menos los prototipos de las funciones, para hacer más fácil su
   interpretación (ej: getch)
 - [x] documentar los stack frames
 - [x] por qué getch tiene 3 argumentos? sólo necesita 1 por ser stdin y leer 1
   byte. Los almacena en la ABA del caller, pero luego no los usa (??), hardcodea
   los argumentos del syscall, excepto por el buffer. Lo mismo con putch.
 - [ ] No pasa el script de pruebas del enunciado. Aquí se ve una secuencia de bytes
   que entran a unix2dos (archivo in), luego su salida alimenta a dos2unix, y la
   salida final (out) no es igual a la entrada.
   ```
   diff <(hexdump -C in|grep 240) <(hexdump -C out|grep 240)
     1c1
     < 00000240  8c b3 fa 75 4f 18 d8 ee  cf 0d 0a b3 03 98 28 4c  |...uO.........(L|
     ---
     > 00000240  8c b3 fa 75 4f 18 d8 ee  cf 0d 0d 0a b3 03 98 28  |...uO..........(|
     ```
     
### Instrucciones     

Para compilar el tp copiar todo a NetBSD y usar el comando (desde ahí):
gcc -Wall -O0 -g unix2dos.c getch.S putch.S -o unix2dos

Para correrlo SIN GDB, por ejemplo:
echo "hola qui onda" | ./unix2dos -i - -o -

Para correrlo con GDB es necesario hacerlo con un archivo txt:
gdb ./unix2dos
(poner los breakpoints correspondientes)
run < input.txt

Para hacer saltos de linea usando echo:  echo -e "linea1\nlinea2"

Una alternativa para continuar esto (incrementalmente, que es la posta porque sino debuggear con gdb se transforma en un parto) sería migrar a MIPS lo que consiste en el loop del while. Y después en ese loop se labura la transformación de los CR y LF respectivamente

## Tp0
hexdump -C prueba_linux.txt > dump_linux

gcc -Wall -O0 -o tp0 tp0.c

Para vista especial de caracteres con programa od: od -t c archivo.txt


Od = CR = '\r'
0a = LF = '\n'

- https://stackoverflow.com/questions/50028810/file-read-using-fgetc-adds-ff-at-the-end
