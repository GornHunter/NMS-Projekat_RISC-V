//OPIS: obican for
//RETURN: 7

int fun(int a){
	//int b;
	//b = a + 3;
	return a + 1 + a;
}

int main(){
	int i;
	int j;
	int g;
	//int k;
	
	i = 4;
	j = 5;
	g = fun(i);
	
	g = g + i * 3 / 2;
	
	//if(i < j)
	//	i = 2;
	//else
	//	i = i + 2;
	
	//while(i == 4){
		//g = i / 2;
		//g = g + j;
		//i = i + 1;
		
	//	if(i > j){
	//		g = i / 2;
	//		g = g + j;
	//	}
	//	else
	//		g = i * 2;
		
	//	i = i + 1;
	//}
	
	//for(g = 0; g < 4; g++){
	//	i = i * 3 / 2;
	//}
	
	//g = (i < j) ? 6 : 7;
	
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