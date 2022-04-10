//OPIS: ugnjezdeni for, 2 if-else, 2 while, 2 ternarna operatora i poziv funkcije
//RETURN: 10

int f1(int a){
	int b;
	int c;
	
	b = 3;
	c = 4;
	
	return 10 - (a - (c + (b - 2)));
}

int main(){
	int suma;
	int i;
	int p;
	int b;
	int g;
	
	suma = 0;
	b = 3;
	p = b + 3;
	i = 0;
	
	g = f1(5);
	
	suma = (p == b) ? b : 4;

	
	while(suma < b)
		suma = suma + 1;
	  
	while(suma < p)
		suma = suma + 1;
		
	
	for (i = 0; i < 5; i++) {
	    suma = suma + i;
	    for (p = 0; p < 5; p++)
	        suma = suma + i;
	}
	
	i = (p == b) ? b : 4;
		
		
	if(suma < 100)
		suma = suma + f1(1) + 1;
	else
		suma = suma + f1(1) + f1(1);
	  
	 
	if(suma > 100)
		suma = suma + f1(1) + 1;
	else
		suma = suma + f1(1) + f1(1);
	  
	
	return g;
	//return suma + i;
}