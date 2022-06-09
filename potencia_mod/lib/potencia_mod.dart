int calculate(int a, int b, int c) {
  if(b == 0){
        return 1;
    }
    if(b > 0){
        return ((a%c)*(calculate(a,b-1,c))%c);
    }
    return 0;
}
