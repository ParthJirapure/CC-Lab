%{
#include "y.tab.h"
#include <stdlib.h>
%}

/* Tell flex to read only one input file */
%option noyywrap

%%

[ \t]+          { /* Ignore spaces and tabs */ }
[0-9]+(\.[0-9]+)? { 
                    yylval.val = atof(yytext); 
                    return NUM; 
                }
[-+*/()\n]      { return yytext[0]; }
.               { 
                    fprintf(stderr, "Unrecognized character: %s\n", yytext); 
                    /* Return the character so yacc triggers a syntax error */
                    return yytext[0]; 
                }

%%
