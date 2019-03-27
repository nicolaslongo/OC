/* Se explica el razonamiento a tratar para los parámetros:
en argv[0] está el path del programa
en argv[1] se espera que esté si el archivo de entrada es de windows o linux
en argv[2] se espera que esté el archivo de entrada
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NAME 100

const char CR = '\r';
const char LF = '\n';

int mostrarMensajeErrorParametrosInvalidos()
{
  fprintf(stderr, "Los parámetros ingresados no son válidos.\n");
  return -1;
}

void windowsToLinux(FILE* input_file, FILE* output_file)
{
	printf("ESTO ES: '%02hhx'\n", (unsigned char) 0x0A);
  	char c, d;

	while((c = fgetc(input_file)) != -1)
	{
    	printf(" Valor: '%02hhx' \n", (unsigned char) c);
		if ( c == CR )
		{
      	//printf("Tengo un CR\n");
      		if((d = fgetc(input_file)) == -1)
      		{
      		//printf("Entre al break \n");
        		fputc(CR, output_file);
        		break;
      		}
      		else
      		{
        		printf(" Valor: '%02hhx' \n", (unsigned char) d);
        		if( d == LF )
        		{
        			//printf("Modifico el CRLF\n");
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
    		//printf("No tengo CR \n");
      		fputc(c, output_file);
    	}

	}
}


int main(int argc, char** argv)
{
  char *input_name = NULL;
  char *output_name = NULL;

  if (argc != 3)
  {
    return mostrarMensajeErrorParametrosInvalidos();
  }

  input_name = argv[1];
  output_name = argv[2];

  FILE* input_file;
  if( (input_file = fopen(input_name, "rt")) == NULL)
  {
      fprintf(stderr,"No se pudo abrir el archivo de entrada\n");
      return -1;
  }

  //Te dejo esta gadorcha
  // armar un output_name piola
  // char output_name[MAX_NAME] = "";
  // strcat(output_name, input_name);
  // strcat(output_name, "_v2");

  FILE* output_file = fopen(output_name, "wb");

  windowsToLinux(input_file, output_file);

  fclose(input_file);
  fclose(output_file);
  return 0;
}
