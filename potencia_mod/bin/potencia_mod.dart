import 'package:potencia_mod/potencia_mod.dart' as potencia_mod;
import 'dart:io';

void main(List<String> arguments) {
  print("Introduzca el valor de a:");
    var a = stdin.readLineSync();
    print("Introduzca el valor de b:");
    var b = stdin.readLineSync();
    print("Introduzca el valor de c:");
    var c = stdin.readLineSync();
    var aint = int.tryParse(a ?? "");
    var bint = int.tryParse(b ?? "");
    var cint = int.tryParse(c ?? "");
    if(aint == null || bint == null || cint == null){
    print("Debe introducir correctamente los valores");
    } else {
	    var resultado = potencia_mod.calculate(aint,bint,cint);
	    print("El resultado es: $resultado");
    }
}
