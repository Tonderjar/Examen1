package lib

public class Nodo(val clave: Int,
                       val nivel: Int,
                       var proceso: String, 
                       var disponible: Boolean,
                       val capacidad: Int, 
                       var h_izq: Nodo?, 
                       var h_der: Nodo?,
                       val padre: Nodo?){

    var ocupado = 0
    var fragmentacion = 0
    var claveaux = -1
    var res1 = -1
    var res2 = -1

    fun clave() : Int {
        return this.clave
    }

    
    fun proc() : String {
        return this.proceso
    }

    
    fun disp() : Boolean {
        return disponible
    }

    fun niv() : Int {
        return nivel
    }

    fun cap() : Int {
        return capacidad
    }

    fun hizq() : Nodo? {
        return h_izq
    }

    fun hder() : Nodo? {
        return h_der
    }

    fun padre() : Nodo? {
        return padre
    }

    public fun buscarBloque(size: Int, actual: Nodo) : Int {
        claveaux = -1
        res1 = -1
        res2 = -1
        if(actual.disponible == true && actual.capacidad > size && actual.capacidad/2 < size){
            claveaux = actual.clave
            return claveaux
        }
        if(actual.h_izq != null){
            res1 = buscarBloque(size, actual.h_izq!!)
            if(res1 != -1){
                return res1
            }
        }
        if(actual.h_der != null){
            res2 = buscarBloque(size, actual.h_der!!)
            if(res2 != -1){
                return res2
            }
        }
        return -1
    }

    public fun buscarNodo(nombre: String, actual: Nodo) : Int {
        claveaux = -1
        res1 = -1
        res2 = -1
        if(actual.proceso == nombre){
            claveaux = actual.clave
            return claveaux
        }
        if(actual.h_izq != null){
            res1 = buscarNodo(nombre, actual.h_izq!!)
            if(res1 != -1){
                return res1
            }
        }
        if(actual.h_der != null){
            res2 = buscarNodo(nombre, actual.h_der!!)
            if(res2 != -1){
                return res2
            }
        }
        return -1
    }
} 
