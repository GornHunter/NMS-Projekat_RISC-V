//OPIS: obican for
//RETURN: 128

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

int main(){
	int i;
	int j;
	int g;
	int k;
	int h;
	
	i = 4;
	j = 5;
	i = fun(j); //26
	g = fun1(i) + i; //78
	
	//g = i * 3;
	
	g = g + i * 3 / 2; //156
	
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
	
	//	if(i > j){
	//		g = i / 2;
	//		g = g + j;
	//	}
	//	else
	//		g = i * 2;
		
	//	i = i + 1;
	//}
	
	for(k = 0; k < 4; k++){
		for(h = 0; h < 3; h++){
			g = g - 3; //117
		}
	}
	
	
	g = (i > j) ? g : 4; //117
	
	g = g + fun2(); //128
	
	//if(i < 6)
	//	i = g + 3;
	//else
	//	g = 12;
		
	//if(i > 6)
	//	i = i + 3;
	//else
	//	g = 12;
	
	//g = 10;
	//i = j + ((j * 5) / 2) - (j * 5) + i;
	//i = j / 3 / 2 * 4;
	//i = j * j + 5 / 3;
	//k = 6;
	//i = j + (((j + 1) + k) + 2);
	//g = i + j;
	//g = g * j;
	
	
	return g;
}