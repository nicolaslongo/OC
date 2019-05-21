#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NAME 100

const char CR = '\r';
const char LF = '\n';

void while_cota();

int mostrarMensajeErrorParametrosInvalidos()
{
  fprintf(stderr, "Los parámetros ingresados no son válidos.\n");
  return -1;
}

void windowsToLinux(FILE* input_file, FILE* output_file)
{
	// int c, d;

  /*
	while((c = fgetc(input_file)) != -1)
	{
		if ( c == CR )
		{
    		if((d = fgetc(input_file)) == -1)
    		{
      		fputc(CR, output_file);
      		break;
    		}
    		else
    		{
      		if( d == LF )
      		{
        			fputc(LF, output_file);
      		}
	        else
	        {
	          	fputc(CR, output_file);
	          	fputc(d, output_file);
	        }
    		}
  	}
  	else
  	{
    		fputc(c, output_file);
  	}

	}*/
  
  while_cota();

}


int main(int argc, char** argv)
{
  // Inicializo los valores por defecto. No se ingresaron archivos y estos son stdin y stdout
  int seIngresoArchivoDeEntrada = 0;
  int seIngresoArchivoDeSalida = 0;
  char *input_fileName = NULL;
  char *output_fileName = NULL;

  /* No puedo recibir más de 5 parámetros. Este es el máximo esperado. Por otro lado, puedo
   recibir 1 parámetro (el nombre del programa), 3 parámetros (se especifica archivo de
   entrada o de salida) y 5 parámetros (se especifican ambos). Además argc siempre es mayor
   o igual a 1          */

  if (argc > 5 || argc == 4 || argc == 2) {
    return mostrarMensajeErrorParametrosInvalidos();
  }

  // Caso de recepción de al menos un archivo por parametro
  if (argc >= 3) {
    if (strcmp(argv[1], "-i") == 0) {
      if (strcmp(argv[2], "-") != 0)
      {
        input_fileName = argv[2];
        seIngresoArchivoDeEntrada = 1;
      }
    }
    else if (strcmp(argv[1], "-o") == 0) {
      if (strcmp(argv[2], "-") != 0)
      {
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
          if (strcmp(argv[4], "-") != 0)
          {
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
          if (strcmp(argv[4], "-") != 0)
          {
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
  if (input_fileName != NULL)
  {
    if( (input_file = fopen(input_fileName, "rt")) == NULL)
    {
        fprintf(stderr,"No se pudo abrir el archivo de entrada\n");
        return -1;
    }
  }
  else
    input_file = stdin;

  FILE* output_file;
  if(output_fileName != NULL)
  {
    if( (output_file = fopen(output_fileName, "wt")) == NULL)
    {
        fprintf(stderr,"No se pudo abrir el archivo de salida\n");
        return -1;
    }
  }
  else
    output_file = stdout;

  windowsToLinux(input_file, output_file);

  fclose(input_file);
  fclose(output_file);
  return 0;
}
