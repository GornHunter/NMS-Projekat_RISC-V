//OPIS: obican for
//RETURN: 128

int f(int p){
	int a;
	a = 2;
	
	return p + a;
}

int fun(int a){
	int b;
	int c;
	
	b = 3;
	a = a * 2 / 3; //3
	b = b + ((a * 3) / 3) + (a + 4) * 2; // 26
	return b;
}

int fun1(int a){
	int b;
	b = 3;
	return a * 6 / b; //52
}


int fun2(){
	return 11;
}

int fun3(int a, int b){
	return a + b;
}

int fun4(int a, int b, int c){  //2, 4, 9
	a = a * 3 / 2; //3
	b = b + a; //7
	
	return c + b * 2; //32
}


int main(){
	int i;
	int j;
	int g;
	int k;
	int h;
	
	
	i = 4;
	j = 5;
	
	//i = f(i + j);
	
	if(i < j)
		i = 1;
	else
		i = 2;
	
	//i = fun(j); //26
	//g = fun1(i) + i; //78
	
	
	//g = g + i * 3 / 2; //156
	
	if(i < j)
		i = 2;
	else{
		if(g != 0)
			g = g + 2; //158
		else{
			g = 4;
		}
	}
	
	while(i < 28){
		while(j > 3){
			g = i / 2; //13
			g = g + j; //18
			j = j - 1;
		}
		g = g * 3; //153
		i = i + 1;
	}
	
	
	for(k = 0; k < 4; k++){
		for(h = 0; h < 3; h++){
			g = g - 3; //117
		}
	}
	
	
	g = (i > j) ? g : 4; //117
	
	g = g + fun2(); //128
	
	g = g + fun3(3,5); //136
	
	g = g + fun4(2,4,9); //168
	
	
	return g;
}