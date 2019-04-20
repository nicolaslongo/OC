# Organizacion de computadoras

## Tp1
Para compilar el tp copiar todo a NetBSD y usar el comando (desde ahí):
gcc -Wall -O0 -g unix2dos.c getch.S putch.S -o unix2dos

Para correrlo, por ejemplo:
echo "hola qui onda" | ./unix2dos -i - -o -

Una alternativa para continuar esto (incrementalmente, que es la posta porque sino debuggear con gdb se transforma en un parto) sería migrar a MIPS lo que consiste en el loop del while. Y después en ese loop se labura la transformación de los CR y LF respectivamente

## Tp0
hexdump -C prueba_linux.txt > dump_linux

gcc -Wall -O0 -o tp0 tp0.c

Para vista especial de caracteres con programa od: od -t c archivo.txt 


Od = CR = '\r'
0a = LF = '\n'

- https://stackoverflow.com/questions/50028810/file-read-using-fgetc-adds-ff-at-the-end



