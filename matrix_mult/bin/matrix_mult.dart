import 'package:matrix_mult/matrix_mult.dart' as matrix_mult;
import 'dart:io';
import 'package:path/path.dart' as p;

/*
* Programa para calcular el producto de 2 matrices, recibiendo la informacion de 
* un archivo de texto.
* El archivo de texto tiene el numero de filas y columnas de la matriz 1 en las primeras 2 lineas
* respectivamente, luego tiene las filas de la matriz en cada linea y los datos de cada fila
* estan separados por espacios. Luego de las filas de la matriz 1 esta el numero de filas y columnas
* de la matriz 2 en las siguientes 2 lineas del archivo (respectivamente) y por ultimo los datos de 
* la matriz 2 con la misma estructura que la matriz 1.
*/

void main(List<String> arguments) {
  var linea_aux;  // variable auxiliar para almacenar los elementos de cada fila como string
  var pointer;    // variable para almacenar el comienzo de la informacion de la segunda matriz en el archivo txt
  var suma = 0;   // variable para almacenar el producto de una fila por una columna para la matriz final
  var filePath = p.join(Directory.current.path, 'assets', 'matrices.txt'); 
  File file = File(filePath); 
  var lines = file.readAsLinesSync(); // almacenamos cada linea del txt como string en lines
  var filas = lines[0];               // numero de filas de la matriz 1
  var columnas = lines[1];            // numero de columnas de la matriz 1
  pointer = int.parse(filas) + 2;     // calculamos la linea de inicio para la matriz 2 en el txt
  var matriz1 = <List<int>>[];        // inicializamos la matriz 1
  for(var i = 0; i < int.parse(filas); i++){     
    matriz1.add(<int>[]);                             // iniciamos cada casilla de la lista principal como una lista 
    linea_aux = lines[i+2].split(' ');                // separamos los valores de cada linea del txt en las casillas de linea_aux
    for(var j = 0; j < int.parse(columnas); j++){     // ingresamos los datos de la matriz 1
      matriz1[i].add(int.parse(linea_aux[j]));
    }
  }
  var filas2 = lines[pointer];        // almacenamos el numero de filas de la matriz 2
  var columnas2 = lines[pointer+1];   // almacenamos el numero de columnas de la matriz 2
  var matriz2 = <List<int>>[];        // inicializamos la matriz 2
  for(var i = 0; i < int.parse(filas2); i++){            
    matriz2.add(<int>[]);                               // iniciamos cada casilla de la lista principal como una lista 
    linea_aux = lines[i+4+int.parse(filas)].split(' '); // separamos los valores de cada linea del txt en las casillas de linea_aux
    for(var j = 0; j < int.parse(columnas2); j++){      // ingresamos los datos de la matriz 2
      matriz2[i].add(int.parse(linea_aux[j]));
    }
  }
  var matriz_sol = <List<int>>[];   // inicializamos la matriz final
  for(var i = 0; i < int.parse(filas); i++){  
    matriz_sol.add(<int>[]);                  // inicializamos cada lista dentro de la matriz
    for(var j = 0; j < int.parse(columnas2); j++){   // loop para calcular el producto de las matrices
      suma = 0;                                      // restablecemos el valor de suma para no acumular
      for(var k = 0; k < int.parse(columnas); k++){  //hacemos el calculo del producto
        suma = suma + (matriz1[i][k]*matriz2[k][j]);    
      }
      matriz_sol[i].add(suma);    // ingresamos los datos a la matriz final
    }
  }
  print("La matriz solucion es: $matriz_sol");
  print("Cada entrada en la lista principal representa una fila.");
}
