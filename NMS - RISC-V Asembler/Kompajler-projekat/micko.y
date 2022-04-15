%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "defs.h"
  #include "symtab.h"
  #include "codegen.h"

  int yyparse(void);
  int yylex(void);
  int yyerror(char *s);
  void warning(char *s);

  extern int yylineno;
  int out_lin = 0;
  char char_buffer[CHAR_BUFFER_LENGTH];
  int error_count = 0;
  int warning_count = 0;
  
  int var_num = 0;
  int tmp = 0;
  
  int fun_idx = -1;
  int fcall_idx = -1;
  int lab_num = -1;
  FILE *output;
  
  int for_num = -1;
  int if_num = -1;
  int while_num = -1;
  int ternary_num = -1;
  
  int main_reg = -1;
  
  int multiplication_num = -1;
  int division_num = -1;
  
  int if_reg = -1;
  int while_reg = -1;
  int for_reg = -1;
  
  int if_flag = 0;
  int while_flag = 0;
  int for_flag = 0;
  
  int fun_flag = 0;
%}

%union {
  int i;
  char *s;
}

%token <i> _TYPE
%token _IF
%token _ELSE
%token _RETURN
%token <s> _ID
%token <s> _INT_NUMBER
%token <s> _UINT_NUMBER
%token _LPAREN
%token _RPAREN
%token _LBRACKET
%token _RBRACKET
%token _ASSIGN
%token _SEMICOLON
%token <i> _AROP
%token <i> _RELOP

%token _INCLUDE

%token _FOR
%token _INC
%token _WHILE
%token _QMARK
%token _COLON

%type <i> num_exp exp literal
%type <i> function_call argument rel_exp if_part cond_exp

%nonassoc ONLY_IF
%nonassoc _ELSE

%%

program
  : function_list
      {  
        if(lookup_symbol("main", FUN) == NO_INDEX)
          err("undefined reference to 'main'");
      }
  ;

function_list
  : function
  | function_list function
  ;

function
  : _TYPE _ID
      {
		if(strcmp(get_name(fun_idx), "main") != 0){
			fun_idx = lookup_symbol($2, FUN);
			if(fun_idx == NO_INDEX)
				fun_idx = insert_symbol($2, FUN, $1, NO_ATR, NO_ATR);
			else 
				err("redefinition of function '%s'", $2);
		
			if(strcmp(get_name(fun_idx), "main") != 0)
				fun_flag++;
		
			if(strcmp(get_name(fun_idx), "main") == 0){
				code("\n.data\n");
				code("str1:\t.string \"Result is \"\n\n");
				code(".text\n");
			}
		}
		code("\n%s:", $2);
		
		
		
        //code("\n\t\tPUSH\t%%14");
        //code("\n\t\tMOV \t%%15,%%14");
      }
    _LPAREN parameter _RPAREN body
      {
		if(strcmp(get_name(fun_idx), "main") == 0)
			code("\n%s_exit:", $2);
		else
			code("\n%s_exit:\n", $2);
		
		if(var_num){
			int tmp1 = var_num;
			for(int i = 0;i < var_num;i++){
				tmp1 -= 1;
				code("\n\t\tlw\t\t%s, %d(sp)", get_name(tmp1), tmp);
				tmp += 4;
				//if(strcmp(get_name(fun_idx), "main") != 0)
					//free_if_reg(tmp1);
			}
		
			code("\n\t\taddi\tsp, sp, %d\n", 4 * var_num);
		}
		
		if(strcmp(get_name(fun_idx), "main") != 0)
			code("\t\tret\n");
		
		if(strcmp(get_name(fun_idx), "main") == 0){
			code("\n\t\tli a7, 10");
			code("\n\t\tecall");
		}
		
		
        clear_symbols(fun_idx + 1);
        var_num = 0;
        
		
		
        //code("\n\t\tMOV \t%%14,%%15");
        //code("\n\t\tPOP \t%%14");
        //code("\n\t\tRET");
      }
  ;


  

parameter
  : /* empty */
      { set_atr1(fun_idx, 0); }

  | _TYPE _ID
      {
        insert_symbol($2, PAR, $1, 1, NO_ATR);
        set_atr1(fun_idx, 1);
        set_atr2(fun_idx, $1);
      }
  ;

body
  : _LBRACKET variable_list
      {
        if(var_num){
		  code("\n\t\taddi\tsp, sp, -%d", 4 * var_num);
		  
		  tmp = var_num;
		  for(int i = 0;i < var_num;i++){
			int reg = take_reg();
			//main_reg = take_reg();
			//set_type(reg, get_type($2));
			
			code("\n\t\tsw\t\t");
			gen_sym_name(reg);
			code(", %d(sp)", (4 * tmp) - 4);
			tmp -= 1;
		  }
		  
          //code("\n\t\tSUBS\t%%15,$%d,%%15", 4*var_num);
		}
		
        code("\n%s_body:", get_name(fun_idx));
      }
    statement_list _RBRACKET
  ;

variable_list
  : /* empty */
  | variable_list variable
  ;

variable
  : _TYPE _ID _SEMICOLON
      {
        if(lookup_symbol($2, VAR|PAR) == NO_INDEX)
           insert_symbol($2, VAR, $1, ++var_num, NO_ATR);
        else 
           err("redefinition of '%s'", $2);
      }
  ;

statement_list
  : /* empty */
  | statement_list statement
  ;

statement
  : compound_statement
  | assignment_statement
  | if_statement
  | return_statement
  | for_statement
  | while_statement
  ;
  
for_statement
  : _FOR _LPAREN _ID _ASSIGN literal
    {
	  $<i>$ = ++for_num;
	  for_flag = 1;
	  
	  int i = lookup_symbol($3, VAR|PAR);
	  if(i == NO_INDEX)
	    err("'%s' undeclared", $3);
		
	  if(get_type(i) != get_type($5))
	    err("incompatible types");
		

	  //gen_mov($5, i);
	  
	  
	  code("\n\n\t\tli\t\t");
	  gen_sym_name(i);
	  code(", ");
	  gen_sym_name($5);
	  
	  
	  code("\nfor%d:", for_num);
	}
  _SEMICOLON rel_exp
    {
	  //code("\n\t\t%s\t\t@exit_for%d", opp_jumps[$8], $<i>6);
	  code("for_exit%d", $<i>6);
	}
  _SEMICOLON _ID _INC _RPAREN statement
    {
	  int i = lookup_symbol($11, VAR|PAR);
	  if(i == NO_INDEX)
	    err("'%s' undeclared", $11);
		
	  /*if(get_type(i) == INT)
	    code("\n\t\tADDS\t");
	  else
	    code("\n\t\tADDU\t");*/
		
	  code("\n\t\taddi\t");
		
	  gen_sym_name(i);
	  code(", ");
	  gen_sym_name(i);
	  code(", 1");
	  
	  code("\n\t\tj\t\tfor%d", $<i>6);
	  code("\nfor_exit%d:", $<i>6);
	  
	  free_if_reg(for_reg);
	}
  ;
  
while_statement
  : _WHILE
    {
	  $<i>$ = ++while_num;
	  while_flag = 1;
	  code("\nwhile%d:", while_num);
	}
  _LPAREN rel_exp
    {
	  //code("\n\t\t%s\t@exit_while%d", opp_jumps[$4], $<i>2);
	  code("while_exit%d", $<i>2);
	}
  _RPAREN statement
    {
	  code("\n\t\tj\t\twhile%d", $<i>2);
	  code("\nwhile_exit%d:", $<i>2);
	  free_if_reg(while_reg);
	}
  ;

compound_statement
  : _LBRACKET statement_list _RBRACKET
  ;

assignment_statement
  : _ID _ASSIGN num_exp _SEMICOLON
      {
        int idx = lookup_symbol($1, VAR|PAR);
        if(idx == NO_INDEX)
          err("invalid lvalue '%s' in assignment", $1);
        else
          if(get_type(idx) != get_type($3)){
            err("incompatible types in assignment");
		  }
		
		
		if(get_kind($3) == LIT){
		  //code("\n\t\tli\t\t%s", get_name(get_atr1(idx) - fun_flag));
		  code("\n\t\tli\t\t");
		  gen_sym_name(idx);
		  code(", ");
		  gen_sym_name($3);
		}
		else{
		  gen_mov_risc(idx, $3);
		}
		
		
			
        //gen_mov($3, idx);
      }
  ;

num_exp
  : exp
  | num_exp _AROP exp
      {
        if(get_type($1) != get_type($3))
          err("invalid operands: arithmetic operation");
		  
		int t1 = get_type($1);
		
		free_if_reg($3);
		free_if_reg($1);
		
		if(get_kind($3) == LIT && $2 == 0)
			code("\n\t\taddi\t");
		else if(get_kind($3) == LIT && $2 == 1)
			code("\n\t\taddi\t");
		else if(get_kind($3) == LIT && $2 == 2){
			multiplication_num++;
			//mul_flag = 1;
			
			code("\n");
			gen_mov_risc(TMP_REG, $$);
			
			$$ = take_reg();
			set_type($$, t1);
			code("\n\t\tli\t\t");
			gen_sym_name($$);
			code(", 0\n");
			
			int reg1 = take_reg();
			code("\t\tli\t\t");
			gen_sym_name(reg1);
			set_type(reg1, t1);
			code(", 0\n");
			
			int reg2 = take_reg();
			code("\t\tli\t\t");
			gen_sym_name(reg2);
			set_type(reg2, t1);
			code(", %s\n", get_name($3));
			
			code("mul%d:\n", multiplication_num);
			/*code("\t\tbeq\t\t");
			gen_sym_name($$);
			code(", ");
			gen_sym_name(reg2);
			code(", mul%d_end\n", multiplication_num);*/
			
			code("\t\tadd\t\t");
			gen_sym_name($$);
			code(", ");
			gen_sym_name($$);
			code(", %s\n", get_name(TMP_REG));

			
			code("\t\taddi\t");
			gen_sym_name(reg1);
			code(", ");
			gen_sym_name(reg1);
			code(", 1\n");
			
			code("\t\tblt\t\t");
			gen_sym_name(reg1);
			code(", ");
			gen_sym_name(reg2);
			code(", mul%d\n", multiplication_num);
			
			code("mul%d_end:", multiplication_num);
			
			free_if_reg(reg2);
			free_if_reg(reg1);
		}
		else if(get_kind($3) == LIT && $2 == 3){
			division_num++;
			//div_flag = 1;
			
			code("\n");
			gen_mov_risc(TMP_REG, $$);
			
			$$ = take_reg();
			set_type($$, t1);
			code("\n\t\tli\t\t");
			gen_sym_name($$);
			code(", 0\n");
			
			int reg1 = take_reg();
			code("\t\tmv\t\t");
			gen_sym_name(reg1);
			set_type(reg1, t1);
			code(", %s\n", get_name(TMP_REG));
			
			code("div%d:\n", division_num);
			
			code("\t\taddi\t");
			gen_sym_name(reg1);
			code(", ");
			gen_sym_name(reg1);
			code(", -%s\n", get_name($3));
			
			code("\t\tblt\t\t");
			gen_sym_name(reg1);
			code(", zero, div%d_exit\n", division_num);
			
			code("\t\taddi\t");
			gen_sym_name($$);
			code(", ");
			gen_sym_name($$);
			code(", 1\n");
			
			code("\t\tj\t\tdiv%d\n", division_num);
			code("div%d_exit:", division_num);
			
			free_if_reg(reg1);
		}
		else
			code("\n\t\t%s\t\t", ar_instructions[$2 + (t1 - 1) * AROP_NUMBER]);
		
		
		
		if((get_kind($3) != LIT && $2 != 2) || 
		   (get_kind($3) != LIT && $2 == 2) || 
		   (get_kind($3) == LIT && $2 == 0) || 
		   (get_kind($3) == LIT && $2 == 1)){
		   
		
			$$ = take_reg();
			gen_sym_name($$);
			set_type($$, t1);
		
			//print_symtab();
		
			code(", ");
			gen_sym_name($1);
			code(", ");
		
			if(get_kind($3) == LIT && $2 == 1)
				code("-%s", get_name($3));
			else
				gen_sym_name($3);
		
			/*if(get_kind($3) == LIT)
				gen_sym_name($3);
			else if(get_kind($1) != LIT || get_kind($3) != LIT)
				code("%s", get_name(get_atr1($3) - 1));*/
			
		}
		
		
      }
  ;

exp
  : literal
  | _ID
      {
        $$ = lookup_symbol($1, VAR|PAR);
        if($$ == NO_INDEX)
          err("'%s' undeclared", $1);
      }
  | function_call
      {
        $$ = take_reg();
		gen_mov_risc($$, FUN_REG);
		
        //gen_mov(FUN_REG, $$);
      }
  | _LPAREN num_exp _RPAREN
      { $$ = $2; }
  | _LPAREN rel_exp _RPAREN _QMARK cond_exp _COLON cond_exp
    {
	  int out = take_reg();
	  ++ternary_num;
	  
	
	  if(get_type($5) != get_type($7))
	    err("expressions don't have same types in ternary exp");
		
	  //code("\n\n\t\t%s\t@false_ternary%d", opp_jumps[$2], ternary_num);
	  code("ternary_false%d", ternary_num);
	  code("\nternary_true%d:", ternary_num);
	  
	  if(get_kind($5) == LIT){
		code("\n\t\tli\t\t");
		gen_sym_name(out);
		code(", ");
		gen_sym_name($5);
	  }
	  else
		gen_mov_risc(out, $5);
	  
	  
	  //gen_mov($5, out);
	  
	  
	  code("\n\t\tj\t\tternary_exit%d", ternary_num);
	  code("\nternary_false%d:", ternary_num);
	  
	  if(get_kind($7) == LIT){
		code("\n\t\tli\t\t");
		gen_sym_name(out);
		code(", ");
		gen_sym_name($7);
	  }
	  else
		gen_mov_risc(out, $7);
	  
	  
	  //gen_mov($7, out);
	  code("\nternary_exit%d:", ternary_num);
	  $$ = out;
	}
  ;
  
cond_exp
  : _ID
    {
	  if(($$ = lookup_symbol($1, VAR|PAR)) == NO_INDEX)
	    err("'%s' udeclared", $1);
	}
  | literal
  ;

literal
  : _INT_NUMBER
      { $$ = insert_literal($1, INT); }

  | _UINT_NUMBER
      { $$ = insert_literal($1, UINT); }
  ;

function_call
  : _ID 
      {
        fcall_idx = lookup_symbol($1, FUN);
        if(fcall_idx == NO_INDEX)
          err("'%s' is not a function", $1);
      }
    _LPAREN argument _RPAREN
      {
        if(get_atr1(fcall_idx) != $4)
          err("wrong number of arguments");
        //code("\n\t\tCALL\t%s", get_name(fcall_idx));
		code("\n\t\tjal\t\t%s", get_name(fcall_idx));
        if($4 > 0)
          //code("\n\t\tADDS\t%%15,$%d,%%15", $4 * 4);
        set_type(FUN_REG, get_type(fcall_idx));
        $$ = FUN_REG;
      }
  ;

argument
  : /* empty */
    { $$ = 0; }

  | num_exp
    { 
      if(get_atr2(fcall_idx) != get_type($1))
        err("incompatible type for argument");
      free_if_reg($1);
	  
	  
      //code("\n\t\tPUSH\t");
	  //gen_sym_name($1);
	  
	  
	  gen_mov_risc(FUN_REG, $1);
   
      $$ = 1;
    }
  ;

if_statement
  : if_part %prec ONLY_IF
      { code("\nif_exit%d:", $1);
		free_if_reg(if_reg);
	  }

  | if_part _ELSE statement
      { code("\nif_exit%d:", $1);
		free_if_reg(if_reg);
	  }
  ;

if_part
  : _IF _LPAREN
      {
        $<i>$ = ++if_num;
		
		//if_reg = take_reg();
		if_flag = 1;
        code("\nif%d:", if_num);
      }
    rel_exp
      {
        //code("\n\t\t%s\t\tif_false%d", opp_jumps[$4], $<i>3);
		code("if_false%d", $<i>3);
        code("\nif_true%d:", $<i>3);
      }
    _RPAREN statement
      {
        code("\n\t\tj\t\tif_exit%d", $<i>3);
        code("\nif_false%d:", $<i>3);
        $$ = $<i>3;
      }
  ;

rel_exp
  : num_exp _RELOP num_exp
      {
        if(get_type($1) != get_type($3))
          err("invalid operands: relational operator");
        $$ = $2 + ((get_type($1) - 1) * RELOP_NUMBER);
		
		if(get_kind($3) == LIT && if_flag == 1){
			if_reg = take_reg();
			code("\n\t\tli\t\t%s, %s", get_name(if_reg), get_name($3));
		}
		else if(get_kind($3) == LIT && while_flag == 1){
			while_reg = take_reg();
			code("\n\t\tli\t\t%s, %s", get_name(while_reg), get_name($3));
		}
		else if(get_kind($3) == LIT && for_flag == 1){
			for_reg = take_reg();
			code("\n\t\tli\t\t%s, %s", get_name(for_reg), get_name($3));
		}
		
		
		code("\n\n\t\t%s\t\t", opp_jumps[$$]);
		gen_sym_name($1);
		code(", ");
		if(get_kind($3) == LIT && if_flag == 1){
			code("%s", get_name(if_reg));
			if_flag = 0;
		}
		else if(get_kind($3) == LIT && for_flag == 1){
			code("%s", get_name(for_reg));
			for_flag = 0;
		}
		else if(get_kind($3) == LIT && while_flag == 1){
			code("%s", get_name(while_reg));
			while_flag = 0;
		}
		else
			gen_sym_name($3);
		
		code(", ");
		
        //gen_cmp($1, $3);
      }
  ;

return_statement
  : _RETURN num_exp _SEMICOLON
      {
        if(get_type(fun_idx) != get_type($2))
          err("incompatible types in return");
		  
        //gen_mov($2, FUN_REG);
		

		if(strcmp(get_name(fun_idx), "main") == 0){
			code("\n\n\t\tla\t\t%s, str1\n", get_name(FUN_REG));
			code("\t\tli\t\ta7, 4\n");
			code("\t\tecall");
		}

		
		if(get_kind($2) == LIT){
			code("\n\n\t\tli\t\t");
			gen_sym_name(FUN_REG);
			code(", ");
			gen_sym_name($2);
		}
		else{
			code("\n");
			gen_mov_risc(FUN_REG, $2);
		}
		
		if(strcmp(get_name(fun_idx), "main") == 0){
			code("\n\t\tli\t\ta7, 1\n");
			code("\t\tecall\n");
		}
		
		code("\n\t\tj\t\t%s_exit", get_name(fun_idx));
      }
  ;

%%

int yyerror(char *s) {
  fprintf(stderr, "\nline %d: ERROR: %s", yylineno, s);
  error_count++;
  return 0;
}

void warning(char *s) {
  fprintf(stderr, "\nline %d: WARNING: %s", yylineno, s);
  warning_count++;
}

int main() {
  int synerr;
  init_symtab();
  output = fopen("output.asm", "w+");
  
  //print_symtab();

  synerr = yyparse();

  clear_symtab();
  fclose(output);
  
  if(warning_count)
    printf("\n%d warning(s).\n", warning_count);

  if(error_count) {
    remove("output.asm");
    printf("\n%d error(s).\n", error_count);
  }

  if(synerr)
    return -1;  //syntax error
  else if(error_count)
    return error_count & 127; //semantic errors
  else if(warning_count)
    return (warning_count & 127) + 127; //warnings
  else
    return 0; //OK
}