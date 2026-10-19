%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
void yyerror(const char *s);
%}

/* Define the data type for semantic values */
%union {
    double val;
}

/* Tokens and Types */
%token <val> NUM
%type <val> expr

/* Operator Precedence and Associativity */
%left '+' '-'
%left '*' '/'
%right UMINUS

%%

/* Grammar Rules */
program:
    /* empty */
  | program statement '\n'
  | program error '\n' { 
        yyerrok; /* Reset parser error state */
        printf("--> Ready for new input.\n"); 
    }
  ;

statement:
    expr { printf("Result: %g\n", $1); }
  | '\n' /* Ignore blank lines */
  ;

expr:
    NUM             { $$ = $1; }
  | expr '+' expr   { $$ = $1 + $3; }
  | expr '-' expr   { $$ = $1 - $3; }
  | expr '*' expr   { $$ = $1 * $3; }
  | expr '/' expr   { 
        if ($3 == 0.0) {
            yyerror("Division by zero");
            YYERROR; /* Forcibly trigger error recovery */
        } else {
            $$ = $1 / $3; 
        }
    }
  | '-' expr %prec UMINUS { $$ = -$2; }
  | '(' expr ')'    { $$ = $2; }
  ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main(void) {
    printf("Desk Calculator. Enter expressions (e.g., 2 + 3 * 4). Ctrl+C to quit.\n");
    return yyparse();
}
