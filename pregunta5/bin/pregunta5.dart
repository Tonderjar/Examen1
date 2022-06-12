import 'package:pregunta5/pregunta5.dart' as pregunta5;
import 'dart:io';

/* 
* Programa que simula los programas interpretes y traductores en base a los diagramas de T,
* tomando las distintas acciones sobre definiciones y consultas de un usuario por linea de 
* comandos.
*/
void main(List<String> arguments) {
  var programas = <List<String>>[];     //Lista de programas con sus respectivos lenguajes
  var len_ejec = <String>[];            //Lista de lenguajes ejecutables
  var inter_act = <List<String>>[];     //Lista de interpretadores activos
  var inter_nact = <List<String>>[];    //Lista de interpretadores no activos
  var trad_act = <List<String>>[];      //Lista de traductores activos
  var trad_nact = <List<String>>[];     //Lista de traductores no activos
  var cond = true;                      //Condicion de parada del programa
  var accion;                           //Guarda la entrada escrita por el usuario
  var argumentos;                       //Divide la entrada del usuario en argumentos separados
  var nombre;                           //Guarda el nombre del programa definido
  var len1;                             //Guarda el nombre de un lenguaje
  var len2;                             //Guarda el nombre de un lenguaje
  var len3;                             //Guarda el nombre de un lenguaje
  var encontrado = false;               //Variable para determinar si se encontro el programa deseado
  var cambio = true;                    //Variable para indicar si al definir un interpretador o traductor se genero algun cambio

  len_ejec.add("LOCAL");

  while(cond == true){ // mientras el usuario no indique la salida
    accion = stdin.readLineSync();  //leo la entrada
    argumentos = accion.split(" ");   //divido la entrada para tener los argumentos separados
    if(argumentos[0] == "DEFINIR"){
      if(argumentos[1] == "PROGRAMA"){
        if(argumentos.length != 4){   //Si ingresa mas o menos argumentos de los necesarios para la opcion, lo indica al usuario
          print("Entrada incorrecta");
        } else {
          if(!pregunta5.existePrograma(programas, argumentos[2])){ // si no existe el programa, lo agrego
            programas.add(<String>[]);
            programas[programas.length-1].add(argumentos[2]);
            programas[programas.length-1].add(argumentos[3]);
            nombre = argumentos[2];
            len1 = argumentos[3];
            print("Se definio el programa '$nombre', ejecutable en '$len1'");
          } else {    //si existe el programa, aviso al usuario
            print("El programa ya existe.");
          }
          
        }
      } else if(argumentos[1] == "INTERPRETE"){
        if(argumentos.length != 4){  //Si ingresa mas o menos argumentos de los necesarios para la opcion, lo indica al usuario
          print("Entrada incorrecta");
        } else {
          if(!pregunta5.existeInterprete(inter_act, inter_nact, argumentos[2], argumentos[3])){ //Si no existe el interprete, lo agrego
            if(pregunta5.ejecutable(len_ejec, argumentos[2])){  //si el lenguaje base es ejecutable, agrego a interpretadores activos
              inter_act.add(<String>[]);
              inter_act[inter_act.length-1].add(argumentos[3]);
              inter_act[inter_act.length-1].add(argumentos[2]);
              len_ejec.add(argumentos[3]);  //agrego el lenguaje interpretado a los ejecutables
              len1 = argumentos[2];   //tomamos los nombres de los lenguajes del interprete
              len2 = argumentos[3];
              print("Se definio un interprete para '$len2', escrito en '$len1'");
              
              cambio = true;
              while(cambio){    //Como se agrego un lenguaje a ejecutables, revisamos las listas de no activos para actualizar
                cambio = false;
                for(var i = 0; i < inter_nact.length; i++){  //Iteramos sobre los interpretes inactivos
                  if(pregunta5.ejecutable(len_ejec, inter_nact[i][1])){ //Si el lenguaje base es ejecutable, agregamos a interpretes activos
                    inter_act.add(<String>[]);
                    inter_act[inter_act.length-1].add(inter_nact[i][0]);
                    inter_act[inter_act.length-1].add(inter_nact[i][1]);
                    len_ejec.add(inter_nact[i][0]);     //Agregamos el lenguaje interpretado a los ejecutables
                    inter_nact.removeAt(i);  //eliminamos el interpretador de los inactivos
                    cambio = true;    //Marcamos que si hubo un cambio
                  }
                }
                for(var i = 0; i < trad_nact.length; i++){    //iteramos sobre los traductores inactivos
                  if(pregunta5.ejecutable(len_ejec, trad_nact[i][0])){  //Si el lenguaje base es ejecutable, agregamos a traductores activos
                    trad_act.add(<String>[]);  
                    trad_act[trad_act.length-1].add(trad_nact[i][0]);
                    trad_act[trad_act.length-1].add(trad_nact[i][1]);
                    trad_act[trad_act.length-1].add(trad_nact[i][2]);
                    if(pregunta5.ejecutable(len_ejec, trad_nact[i][2])){  //Si el lenguaje destino es ejecutable, agregamos el lenguaje origen a ejecutables
                      len_ejec.add(trad_nact[i][1]);
                      cambio = true; //Marcamos que hubo un cambio
                    }
                    trad_nact.removeAt(i); //Eliminamos el traductor de los inactivos
                  }
                }
              }

            } else{ //si el lenguaje base no es ejecutable, lo agrego a los interpretadores no activos
              inter_nact.add(<String>[]);
              inter_nact[inter_nact.length-1].add(argumentos[3]);
              inter_nact[inter_nact.length-1].add(argumentos[2]);
              len1 = argumentos[2];  //tomamos los nombres de los lenguajes
              len2 = argumentos[3];
              print("Se definio un interprete para '$len2', escrito en '$len1'");
            }
          } else {    //Si el interprete ya existe, le aviso al usuario
            print("El interprete ya existe.");
          }
        }
      } else if(argumentos[1] == "TRADUCTOR"){
        if(argumentos.length != 5){ //Si ingresa mas o menos argumentos de los necesarios para la opcion, lo indica al usuario
          print("Entrada incorrecta");
        } else {
          if(!pregunta5.existeTraductor(trad_act, trad_nact, argumentos[2], argumentos[3], argumentos[4])){ //si el traductor no existe, lo agrego
            if(pregunta5.ejecutable(len_ejec, argumentos[2])){  //si el lenguaje base es ejecutable, lo agrego a traductores activos
              if(pregunta5.ejecutable(len_ejec, argumentos[4])){  //si el lenguage destino es ejecutable
                trad_act.add(<String>[]);
                trad_act[trad_act.length-1].add(argumentos[2]);
                trad_act[trad_act.length-1].add(argumentos[3]);
                trad_act[trad_act.length-1].add(argumentos[4]);
                len_ejec.add(argumentos[3]);  //agrego el lenguaje origen a los ejecutables
                len1 = argumentos[2];
                len2 = argumentos[3];
                len3 = argumentos[4];
                print("Se definio un traductor de'$len2' hacia '$len3', escrito en '$len1'");
                
                cambio = true;
                while(cambio){ //Como se agrego un lenguaje a ejecutables, revisamos las listas de no activos para actualizar
                  cambio = false;
                  for(var i = 0; i < inter_nact.length; i++){ //Iteramos sobre los interpretes inactivos
                    if(pregunta5.ejecutable(len_ejec, inter_nact[i][1])){ //Si el lenguaje base es ejecutable, agregamos a interpretes activos
                      inter_act.add(<String>[]);
                      inter_act[inter_act.length-1].add(inter_nact[i][0]);
                      inter_act[inter_act.length-1].add(inter_nact[i][1]);
                      len_ejec.add(inter_nact[i][0]);  //Agregamos el lenguaje interpretado a los ejecutables
                      inter_nact.removeAt(i);   //eliminamos el interpretador de los inactivos
                      cambio = true;   //Marcamos que si hubo un cambio
                    }
                  }
                  for(var i = 0; i < trad_nact.length; i++){  //iteramos sobre los traductores inactivos
                    if(pregunta5.ejecutable(len_ejec, trad_nact[i][0])){    //Si el lenguaje base es ejecutable, agregamos a traductores activos
                      trad_act.add(<String>[]);
                      trad_act[trad_act.length-1].add(trad_nact[i][0]);
                      trad_act[trad_act.length-1].add(trad_nact[i][1]);
                      trad_act[trad_act.length-1].add(trad_nact[i][2]);
                      if(pregunta5.ejecutable(len_ejec, trad_nact[i][2])){   //Si el lenguaje destino es ejecutable, agregamos el lenguaje origen a ejecutables
                        len_ejec.add(trad_nact[i][1]);
                        cambio = true;   //Marcamos que hubo un cambio
                      }
                      trad_nact.removeAt(i);   //Eliminamos el traductor de los inactivos
                    }
                  }
                }      

              } else {  //Si el lenguaje destino no es ejecutable
                trad_act.add(<String>[]);   //Agrego el traductor a los activos
                trad_act[trad_act.length-1].add(argumentos[2]);
                trad_act[trad_act.length-1].add(argumentos[3]);
                trad_act[trad_act.length-1].add(argumentos[4]);
                len1 = argumentos[2];  //tomo los nombres de los lenguajes del traductor
                len2 = argumentos[3];
                len3 = argumentos[4];
                print("Se definio un traductor de'$len2' hacia '$len3', escrito en '$len1'");
              }
            } else{  //Si el lenguaje base no es ejecutable
                trad_nact.add(<String>[]);   //Agrego el traductor a los no activos
                trad_nact[trad_nact.length-1].add(argumentos[2]);
                trad_nact[trad_nact.length-1].add(argumentos[3]);
                trad_nact[trad_nact.length-1].add(argumentos[4]);
                len1 = argumentos[2];   //tomo los nombres de los lenguajes del traductor
                len2 = argumentos[3];
                len3 = argumentos[4];
                print("Se definio un traductor de'$len2' hacia '$len3', escrito en '$len1'");
            }
          }
        }
      }
    } else if(argumentos[0] == "EJECUTABLE"){
      if(argumentos.length != 2){  //Si la entrada es incorrecta, aviso al usuario
        print("Entrada incorrecta.");
      } else {  
          for(var i = 0; i < programas.length; i++){  //Si la entrada es correcta, busco el programa
            if(programas[i][0] == argumentos[1]){   //Si encuentro el programa, verifico si es ejecutable
              nombre = argumentos[1];
              encontrado = true;
              if(pregunta5.ejecutable(len_ejec, programas[i][1])){   //Si el programa es ejecutable
                print("Si, es posible ejecutar el programa '$nombre'");
                break;
              } else {  //Si el programa no es ejecutable
                print("No es posible ejecutar el programa '$nombre'");
              }
            }
          }
          if(!encontrado){ //Si el programa no existe, aviso al usuario
            print("El programa no existe");
          }
      }
    } else if(argumentos[0] == "SALIR"){
      cond = false;  //Como el usuario desea salir, rompo el ciclo principal
    } else {
      print("No es un comando valido.");
    }
  }
}
