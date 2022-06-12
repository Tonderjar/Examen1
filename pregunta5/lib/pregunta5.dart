/*
* Fucion que determina si un programa ya esta en la lista de programas
* @param programas: Lista de programas definidos
* @param prog: programa a buscar en la lista
* @return true si existe, false si no existe
*/
bool existePrograma(List<List<String>> programas, String prog){
  for(var i = 0; i < programas.length; i++){
    if(programas[i][0] == prog){
      return true;
    }
  }
  return false;
}

/*
* Funcion que determina si un interprete ya existe
* @param act: Lista de interpretes activos
* @param nact: Lista de interpretes no activos
* @param base: Lenguaje base
* @param origen: lenguaje interpretado
* @return true si existe, false si no existe
*/
bool existeInterprete(List<List<String>> act, List<List<String>> nact, String base, String origen){
  for(var i = 0; i < act.length; i++){
    if(act[i][0] == origen && act[i][1] == base){
      return true;
    }
  }
  for(var i = 0; i < nact.length; i++){
    if(nact[i][0] == origen && nact[i][1] == base){
      return true;
    }
  }
  return false;
}

/*
* Funcion que determina si un traductor ya existe
* @param act: Lista de traductores activos
* @param nact: Lista de traductores no activos
* @param base: Lenguaje base
* @param origen: lenguaje origen
* @param destino: lenguaje destino
* @return true si existe, false si no existe
*/
bool existeTraductor(List<List<String>> act, List<List<String>> nact, String base, String origen, String destino){
  for(var i = 0; i < act.length; i++){
    if(act[i][0] == base && act[i][1] == origen && act[i][2] == destino){
      return true;
    }
  }
  for(var i = 0; i < nact.length; i++){
    if(nact[i][0] == base && nact[i][1] == origen && nact[i][2] == destino){
      return true;
    }
  }
  return false;
}

/*
* Funcion que determina si un lenguaje es ejecutable
* @param ejecutables: Lista de lenguajes ejecutables
* @param leng: Lenguaje a consultar
* @return true si es ejecutable, false si no es ejecutable
*/
bool ejecutable(List<String> ejecutables, String leng){
  for(var i = 0; i < ejecutables.length; i++){
    if(ejecutables[i] == leng){
      return true;
    }
  }
  return false;

}