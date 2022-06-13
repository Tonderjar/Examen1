import lib.*

/* 
*Programa que simula el comportamento de un manejador de memoria
*utilizando el algoritmo Buddy System, utilizando un arbol binario,
*donde los nodos representan las posibles particiones necesarias en algun
*punto del manejo de la memoria
*/
fun main() {
    
    var nodos = mutableListOf<Nodo>() //Lista de nodos
    var cond = true                   //Variable para continuar pidiendo la entrada si esta es invalida
    var input : String                //Variable donde almacenaremos la entrada
    var bloques = 0                   //Numero de bloques
    var potencia = 0                  //Potencia de 2 que representa el numero de bloques
    var nivel = 0                     //Nivel actual del arbol binario
    var aux : Int                     //Entero auxiliar
    var cont = 0                      //Contador que indica los id de los nodos creados
    var encontrado : Int
    var nodoaux : Nodo

    while(cond){   //Pido los bloques de memoria iniciales hasta que la entrada sea correcta
        println("Introduzca el numero de bloques de memoria:")
        input = readln()
        if(input.toInt()%2 != 0){  //Si la entrada no tiene division exacta entre 2, no es potencia de 2
            println("El numero debe ser potencia de 2.")
        } else {
            cond = false
            bloques = input.toInt()  //almaceno la cantidad de bloques de memoria
        }
    }

    aux = bloques
    while(aux/2 != 1){  //calculo la potencia de 2 que representa la entrada
        aux = aux/2
        potencia = potencia + 1
    }

    var root = Nodo(cont, 0, "", true, bloques.toInt(), null, null, null)  //creo el nodo inicial del arbol
    nodos.add(root) //agrego el nodo a la lista de nodos

    for(j in 0..potencia){  //Creo el arbol binario de posibles particiones de la memoria
        for(i in 0..nodos.size-1){    //para cada nodo, si su nivel es igual al actual, creo sus hijos
            if(nodos[i].nivel == nivel){    
                cont = cont + 1  //aumento el contador para la creacion del proximo nodo
                nodos[i].h_izq = Nodo(cont, nodos[i].nivel+1, "", true, nodos[i].capacidad/2, null, null, nodos[i]) //creo hijo izquierdo
                nodos.add(nodos[i].h_izq!!)  //agrego el nodo izquierdo a la lista de nodos
                cont = cont + 1  //aumento el contador para la creacion del proximo nodo
                nodos[i].h_der = Nodo(cont, nodos[i].nivel+1, "", true, nodos[i].capacidad/2, null, null, nodos[i]) //creo hijo derecho
                nodos.add(nodos[i].h_der!!)  //agrego el nodo derecho a la lista de nodos
            }
        }
        nivel = nivel + 1  //Aumento el nivel para crear la siguiente "fila" de nodos en el arbol
    }
    //Ya se ha creado el arbol con todas las posibles particiones posibles.
    cond = true
    while(cond){
        println("Introduzca su siguiente accion:")
        var input2 = readln().split(" ")  //Guardamos los argumentos de la accion del usuario
        if(input2[0] == "RESERVAR"){
            encontrado = nodos[0].buscarBloque(input2[2].toInt(), nodos[0])  //Guardamos el key del bloque en donde se alocara el proceso, -1 si no se puede alocar
            if(encontrado != -1){ //Si se encontro un bloque disponible valido
                nodos[encontrado].disponible = false    //Como se utilizo el bloque, se marca como nno disponible
                nodos[encontrado].ocupado = input2[2].toInt()  //Marco el espacio ocupado de la particion utilizada
                nodos[encontrado].fragmentacion = nodos[encontrado].capacidad - input2[2].toInt()  //Calculo y marco la fragmentacion interna
                nodos[encontrado].proceso = input2[1]   //Marco el nombre del proceso que ocupa la particion
                println("El proceso se aloco en la particion $encontrado")  //Verificacion de funcionamiento
                if(nodos[encontrado].nivel > 0){     //Si el nodo no es el root del arbol
                    nodoaux = nodos[encontrado]     //Guardo el valor del nodo base
                    for(i in 0..nodos[encontrado].nivel-1){ //Marcaremos todas las particiones mas grandes padres de la actual como no disponibles
                        nodos[encontrado].padre!!.disponible = false    //Marco la particion padre como no disponible
                        nodos[encontrado] = nodos[encontrado].padre!!   //No movemos al padre del nodo actual
                    }
                    nodos[encontrado] = nodoaux //Devolvemos el valor original al nodo
                }
            }
        } else if(input2[0] == "LIBERAR"){
            encontrado = nodos[0].buscarNodo(input2[1], nodos[0])   //Guardamos el key del la particion donde se aloca el proceso
            if(encontrado != -1){   //Si el proceso si estaba alocado, liberamos
                nodos[encontrado].proceso = ""  //Marcamos el proceso de la particion como vacio
                nodos[encontrado].ocupado = 0   //Marcamos que la particion no tiene memoria ocupada
                nodos[encontrado].fragmentacion = 0 //Marcamos que no hay fragmentacion interna
                nodos[encontrado].disponible = true //Marcamos la particion como disponible
                println("El proceso ha sido removido de la particion $encontrado")  //Verificacion de funcionamiento
                if(nodos[encontrado].nivel > 0){    //Si el nodo es distinto al root del arbol
                    nodoaux = nodos[encontrado]     //Guardamos el valor del nodo base
                    for(i in 0..nodos[encontrado].nivel-1){     //Actualizamos la disponibilidad de las particiones padres
                        if(nodos[encontrado].padre!!.h_izq!!.disponible == true && nodos[encontrado].padre!!.h_der!!.disponible == true){ //Si los hijos del padre del nodo base estan disponibles, el nodo padre se marca disponible
                            nodos[encontrado].padre!!.disponible = true     //Se marca el padre como disponible
                            nodos[encontrado] = nodos[encontrado].padre!!   //Nos movemos al nodo padre para volver a verificar con sus padres
                        } 
                    }
                    nodos[encontrado] = nodoaux     //Devolvemos el valor inicial al nodo base
                }
            } 
        } else if(input2[0] == "SALIR"){    //Salimos del programa
            cond = false    //Condicion de salida
        } else {
            println("Entrada invalida")
        }
    }

}
