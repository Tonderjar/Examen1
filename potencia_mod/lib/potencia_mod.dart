/* 
* Funcion que calcula la potenciacion modulada dados tres 
* valores a, b y c.
* @param a: entero, representa la base de la potencia
* @param b: entero, representa el exponente de la potencia
* @param c: entero, represenda el indice del modulo (mod c)
* La funcion retorna el valor de la potencia modulada ((a^b) mod c)
*/

int calculate(int a, int b, int c) {
  if(b == 0){       //Si b es 0, la potencia es 1 y el mod final es 1.
        return 1;
    }
    //Si b > 0, tenemos que buscar recursivamente los resultados hasta que el exponente sea 0
    if(b > 0){      
        return ((a%c)*(calculate(a,b-1,c))%c);
    }
    return 0;
}
