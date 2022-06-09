import 'package:potencia_mod/potencia_mod.dart' as potencia_mod;
import 'dart:io';

/* 
* Programa para calcular la potencia modulada dados 3 valores a, b y c
* ((a^b) mod c)
*/

void main(List<String> arguments) {
  /*
  * Pedimos los valores a, b y c por linea de comandos
  * para realizar el calculo.
  */
  print("Introduzca el valor de a:");
    var a = stdin.readLineSync();
    print("Introduzca el valor de b:");
    var b = stdin.readLineSync();
    print("Introduzca el valor de c:");
    var c = stdin.readLineSync();
    /*
    * Necesitamos variables nuevas porque no se puede convertir
    * la entrada directamente a entero desde string por la seguridad
    * del lenguaje contra elementos nullable.
    */
    var aint = int.tryParse(a ?? ""); 
    var bint = int.tryParse(b ?? "");
    var cint = int.tryParse(c ?? "");
    
    if(aint == null || bint == null || cint == null){   //Nos aseguramos que lso valores no sean null
    print("Debe introducir correctamente los valores");
    } else {
	    var resultado = potencia_mod.calculate(aint,bint,cint); //Llamada a la funcion que calculara la potencia modulada
	    print("El resultado es: $resultado");
    }
}
