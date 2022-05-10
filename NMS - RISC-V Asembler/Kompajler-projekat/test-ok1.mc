//OPIS: obican for
//RETURN: 128

//int fun(int a){
//	int b;
//	int c;
	
//	b = 3;
//	a = a * 2 / 3; //3
//	b = b + ((a * 3) / 3) + (a + 4) * 2; // 26
//	return b;
//}

//int fun1(int a){
//	int b;
//	b = 3;
//	return a * 6 / b; //52
//}

int fun2(int a, int b){
	return a + b; //16
}

int main(){
	int i;
	//int j;
	int g;
	int k;
	int h;
	
	//i = 4;
	//j = 5;
	//i = fun(j); //26
	//g = fun1(i) + i; //78
	
	
	//g = g + i * 3 / 2; //156
	
	//if(i < j)
	//	i = 2;
	//else{
	//	if(g != 0)
	//		g = g + 2; //158
	//	else{
	//		g = 4;
	//	}
	//}
	
	//while(i < 28){
	//	while(j > 3){
	//		g = i / 2; //13
	//		g = g + j; //18
	//		j = j - 1;
	//	}
	//	g = g * 3; //153
	//	i = i + 1;
	//}
	
	
	//for(k = 0; k < 4; k++){
	//	for(h = 0; h < 3; h++){
	//		g = g - 3; //117
	//	}
	//}
	
	
	//g = (i > j) ? g : 4; //117
	
	//g = g + fun2(); //128
	
	k = 3;
	h = 2;
	//g = fun2(2, h);
	
	g = fun2(k,3);
	
	return g;
}