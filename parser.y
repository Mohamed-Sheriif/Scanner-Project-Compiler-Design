%{
 #include <stdio.h>
 #include <math.h>
 int yylex(void);
 void yyerror(char *);
%}
%token INTEGER VARIABLE
%left '+' '-'
%left '*' '/'
%{
 void yyerror(char *);
 int yylex(void);
 int sym[26];
%}
%%
program: 
 program statement '\n'   // a=3
 |
 ;
statement:
 expr { printf("%d\n", $1); }
 | VARIABLE '=' expr { sym[$1] = $3; }  
 ;
expr:
 INTEGER
 | VARIABLE { $$ =sym[$1]; }
 | expr '+' expr { $$ = $1 + $3; }
 | expr '-' expr { $$ = $1 - $3; }
 | expr '*' expr { $$ = $1 * $3; }
 | expr '/' expr { $$ = $1 / $3; }
 | expr '^' expr { $$ =pow( $1 , $3); }
 | '(' expr ')' { $$ = $2; }
 ;
%%
void yyerror(char *s) {
 fprintf(stderr, "%s\n", s);
 return 0;
}
int main(void) {
 yyparse();
 return 0;
}
