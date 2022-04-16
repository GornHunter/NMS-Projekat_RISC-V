#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "codegen.h"
#include "symtab.h"


extern FILE *output;
int free_reg_num = 0;
char invalid_value[] = "???";

// REGISTERS

int take_reg(void) {
  if(free_reg_num > LAST_WORKING_REG) {
    err("Compiler error! No free registers!");
    exit(EXIT_FAILURE);
  }
  return free_reg_num++;
}

void free_reg(void) {
   if(free_reg_num < 1) {
      err("Compiler error! No more registers to free!");
      exit(EXIT_FAILURE);
   }
   else
      set_type(--free_reg_num, NO_TYPE);
}

// Ako je u pitanju indeks registra, oslobodi registar
void free_if_reg(int reg_index) {
  if(reg_index >= 0 && reg_index <= LAST_WORKING_REG)
    free_reg();
}

// SYMBOL
//nastavlja se
/*void gen_sym_name(int index) {
  if(index > -1) {
    if(get_kind(index) == VAR) // -n*4(%14)
      code("-%d(%%14)", get_atr1(index) * 4);
    else 
      if(get_kind(index) == PAR) // m*4(%14)
        code("%d(%%14)", 4 + get_atr1(index) *4);
      else
        if(get_kind(index) == LIT){
          code("%s", get_name(index));
		  
		  //code("$%s", get_name(index));
		}
        else //function, reg
          code("%s", get_name(index));
  }
}*/

void gen_sym_name(int index) {
  if(index > -1) {
    if(get_kind(index) == VAR) // -n*4(%14)
      code("%s", get_name(get_atr1(index) - 1));
    else 
      if(get_kind(index) == PAR){ // m*4(%14)
		code("a0");
	  
	  
        //code("%d(%%14)", 4 + get_atr1(index) *4);
	  }
      else
        if(get_kind(index) == LIT){
          code("%s", get_name(index));
		  
		  //code("$%s", get_name(index));
		}
        else //function, reg
          code("%s", get_name(index));
  }
}

// OTHER

void gen_cmp(int op1_index, int op2_index) {
  if(get_type(op1_index) == INT)
    code("\n\t\tCMPS \t");
  else
    code("\n\t\tCMPU \t");
  gen_sym_name(op1_index);
  code(",");
  gen_sym_name(op2_index);
  free_if_reg(op2_index);
  free_if_reg(op1_index);
}

void gen_mov(int input_index, int output_index) {
  code("\n\t\tMOV \t");
  gen_sym_name(input_index);
  code(", ");
  gen_sym_name(output_index);

  //ako se smešta u registar, treba preneti tip 
  if(output_index >= 0 && output_index <= LAST_WORKING_REG)
    set_type(output_index, get_type(input_index));
  free_if_reg(input_index);
}

void gen_mov_risc(int output_index, int input_index) {
  if(get_kind(output_index) == REG && get_kind(input_index) == VAR){
	code("\n\t\tmv\t\t");
	gen_sym_name(output_index);
	code(", %s", get_name(get_atr1(input_index) - 1));
	//gen_sym_name(input_index);
  }
  else if(get_kind(output_index) == VAR && get_kind(input_index) == REG){
	code("\n\t\tmv\t\t%s", get_name(get_atr1(output_index) - 1));
	//gen_sym_name(output_index);
	//code(", %s", get_name(get_atr1(input_index) - 1));
	code(", ");
	gen_sym_name(input_index);
  }
  else if(get_kind(output_index) == VAR && get_kind(input_index) == VAR){
	code("\n\t\tmv\t\t%s, %s", get_name(get_atr1(output_index) - 1), get_name(get_atr1(input_index) - 1));
  }
  else if(get_kind(output_index) == VAR && get_kind(input_index) == PAR){
	code("\n\t\tmv\t\t%s, %s", get_name(get_atr1(output_index) - 1), get_name(FUN_REG));
  }
  else if(get_kind(output_index) == PAR && get_kind(input_index) == VAR){
	code("\n\t\tmv\t\t%s, %s", get_name(FUN_REG), get_name(get_atr1(output_index) - 1));
  }
  else if(get_kind(output_index) == PAR && get_kind(input_index) == REG){
	code("\n\t\tmv\t\t%s, ", get_name(FUN_REG));
	gen_sym_name(input_index);
  }
  else if(get_kind(output_index) == REG && get_kind(input_index) == REG){
	code("\n\t\tmv\t\t");
	gen_sym_name(output_index);
	//code(", %s", get_name(get_atr1(input_index) - 1));
	code(", ");
	gen_sym_name(input_index);
	
	if(output_index >= 0 && output_index <= LAST_WORKING_REG)
		set_type(output_index, get_type(input_index));
	
	//if(strcmp(get_name(output_index), "a0") != 0 || strcmp(get_name(output_index), "a1") != 0)
		//free_if_reg(input_index);
	
	return;
  }
  
  
  //ako se smešta u registar, treba preneti tip 
  if(output_index >= 0 && output_index <= LAST_WORKING_REG)
    set_type(output_index, get_type(input_index));
  free_if_reg(input_index);
}

