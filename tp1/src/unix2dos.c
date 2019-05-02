#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NAME 100

const char CR = '\r';
const char LF = '\n';

int getch(int fd, int8_t* c, int size);

int putch(int fd, int8_t* d, int size);

int isLF(int8_t* caracter); // devuelve 1 si lo es. 0 si no lo es

//void my_while(int8_t* caracter);
void my_while();

int mostrarMensajeErrorParametrosInvalidos() {
    fprintf(stderr, "Los parámetros ingresados no son válidos.\n");
    return -1;
}

void linuxToWindows(FILE* input_file, FILE* output_file)
{
    //int8_t* c;

    // int32_t res = -2;
    // int fd_input = fileno(input_file);
    // int fd_output = fileno(output_file);
    // fprintf(stdout, "Primero voy a usar el while del .c: \n");
    // res = getch(fd_input, c, 1);
    // while(res != -1) { //-1 da cuando es EOF
    // 	if( isLF(c) == 1 ) {
    // 		fprintf(stdout, "\nEs LF, che\n");
    //         // acá se haría un putch delo correspondiente para reemplazar esto
    //         // y un continue
    // 	}
    //     else {
    //         putch(fd_output, c, 1);
    //     }
    //     res = getch(fd_input, c, 1);
    // }

    fprintf(stdout, "\n Ahora voy a usar el while del .S: \n");
    my_while();

}


int main(int argc, char** argv)
{
    // Inicializo los valores por defecto. No se ingresaron archivos y estos son stdin y stdout
    int seIngresoArchivoDeEntrada = 0;
    int seIngresoArchivoDeSalida = 0;
    char *input_fileName = NULL;
    char *output_fileName = NULL;

    // Caso de recepción de al menos un archivo por parametro
    if (argc >= 3) {
        if (strcmp(argv[1], "-i") == 0) {
            if (strcmp(argv[2], "-") != 0)  {
                input_fileName = argv[2];
                seIngresoArchivoDeEntrada = 1;
            }
        }
        else if (strcmp(argv[1], "-o") == 0) {
            if (strcmp(argv[2], "-") != 0) {
                output_fileName = argv[2];
                seIngresoArchivoDeSalida = 1;
            }
        }
        else {
        // Parámetro invalido
            return mostrarMensajeErrorParametrosInvalidos();
        }
        // Caso de recepción de dos archivos por parámetro
        if (argc > 4) {
            if (seIngresoArchivoDeEntrada) {
                if (strcmp(argv[3], "-o") == 0) {
                    if (strcmp(argv[4], "-") != 0) {
                        output_fileName = argv[4];
                        seIngresoArchivoDeSalida = 1;
                    }
                }
                else {
                    // Si ya se ingreso el parametro "-i" el único válido que queda es "-o"
                    return mostrarMensajeErrorParametrosInvalidos();
                }
            }
            else if (seIngresoArchivoDeSalida) {
                if (strcmp(argv[3], "-i") == 0) {
                    if (strcmp(argv[4], "-") != 0) {
                        input_fileName = argv[4];
                        seIngresoArchivoDeEntrada = 1;
                    }
                }
                else {
                    // Si ya se ingreso el parametro "-o" el único válido que queda es "-i"
                    return mostrarMensajeErrorParametrosInvalidos();
                }
            }
        }
    }

    FILE* input_file;
    if (input_fileName != NULL) {
        if( (input_file = fopen(input_fileName, "rt")) == NULL) {
            fprintf(stderr,"No se pudo abrir el archivo de entrada\n");
            return -1;
        }
    }
    else
        input_file = stdin;

    FILE* output_file;
    if(output_fileName != NULL) {
        if( (output_file = fopen(output_fileName, "wt")) == NULL) {
            fprintf(stderr,"No se pudo abrir el archivo de salida\n");
            return -1;
        }
    }
    else
        output_file = stdout;

    linuxToWindows(input_file, output_file);
    fclose(input_file);
    fclose(output_file);
    return 0;
}
