package ve.usb.libGrafo

public class ArcoCosto(val x: Int, val y: Int, val costo: Double) : Arco(x, y) {

    /* Devuelve el costo de un arco
    precondicion: El metodo debe ser invocado por un ArcoCosto
    postcondicion: Se obtiene el valor costo del ArcoCosto
    tiempo de ejecucion: O(1)
    */
    fun costo() : Double {
        return this.costo;
    }

    /* Crea una representacion en string de un arcocosto
    precondicion: El metodo debe ser invocado por un ArcoCosto
    postcondicion: Se obtiene un string con la representacion de un ArcoCosto
    tiempo de ejecucion: O(1)
    */
    override fun toString() : String {
        var str = "("+inicio.toString()+","+fin.toString()+","+costo.toString()+")";
        return str
    }
} 
