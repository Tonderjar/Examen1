import 'package:matrix_mult/matrix_mult.dart' as matrix_mult;
import 'dart:io';
import 'package:path/path.dart' as p;

void main(List<String> arguments) {
  var linea_aux;
  var pointer;
  var suma = 0;
  var filePath = p.join(Directory.current.path, 'assets', 'matrices.txt');
  File file = File(filePath);
  var lines = file.readAsLinesSync();
  var filas = lines[0];
  var columnas = lines[1];
  pointer = int.parse(filas) + 2;
  var matriz1 = <List<int>>[];
  for(var i = 0; i < int.parse(filas); i++){
    matriz1.add(<int>[]); 
    linea_aux = lines[i+2].split(' ');
    for(var j = 0; j < int.parse(columnas); j++){
      matriz1[i].add(int.parse(linea_aux[j]));
    }
  }
  var filas2 = lines[pointer];
  var columnas2 = lines[pointer+1];
  var matriz2 = <List<int>>[];
  for(var i = 0; i < int.parse(filas2); i++){
    matriz2.add(<int>[]); 
    linea_aux = lines[i+4+int.parse(filas)].split(' ');
    for(var j = 0; j < int.parse(columnas2); j++){
      matriz2[i].add(int.parse(linea_aux[j]));
    }
  }
  var matriz_sol = <List<int>>[];
  for(var i = 0; i < int.parse(filas); i++){
    matriz_sol.add(<int>[]);
    for(var j = 0; j < int.parse(columnas2); j++){
      suma = 0;
      for(var k = 0; k < int.parse(columnas); k++){
        suma = suma + (matriz1[i][k]*matriz2[k][j]);
      }
      matriz_sol[i].add(suma);
    }
  }
  print("La matriz solucion es: $matriz_sol");
  print("Cada entrada en la lista principal representa una fila.");
}
