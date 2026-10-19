%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
void yyerror(const char *s);
%}

/* Tokens provided by the lexer */
%token FOR ID NUM
%token INC DEC
%token LE GE EQ NE LT GT

/* Operator Precedence */
%left '+' '-'
%left '*' '/'

%%

/* Root rule */
program:
    stmt_list { printf("--> Valid FOR loop syntax.\n"); return 0; }
    ;

stmt_list:
    stmt
    | stmt_list stmt
    ;

stmt:
    for_loop
    | assign ';'
    | ';'
    ;

/* FOR Loop Structure */
for_loop:
    FOR '(' init_opt ';' cond_opt ';' inc_opt ')' body
    ;

init_opt:
    assign
    | /* empty */
    ;

cond_opt:
    expr relop expr
    | /* empty */
    ;

inc_opt:
    ID INC          /* e.g., i++ */
    | ID DEC        /* e.g., i-- */
    | assign        /* e.g., i = i + 1 */
    | /* empty */
    ;

/* Loop Body */
body:
    '{' stmt_list '}'
    | stmt
    ;

/* Expressions and Assignments */
assign:
    ID '=' expr
    ;

expr:
    ID
    | NUM
    | expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | '(' expr ')'
    ;

relop:
    LT | GT | LE | GE | EQ | NE
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
}

int main(void) {
    printf("Enter a FOR loop (Press Ctrl+D when finished):\n");
    return yyparse();
}
