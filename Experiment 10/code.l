%{
#include "y.tab.h"
%}

%option noyywrap

%%

"for"                   { return FOR; }

"<="                    { return LE; }
">="                    { return GE; }
"=="                    { return EQ; }
"!="                    { return NE; }
"<"                     { return LT; }
">"                     { return GT; }

"++"                    { return INC; }
"--"                    { return DEC; }

[a-zA-Z_][a-zA-Z0-9_]*  { return ID; }
[0-9]+(\.[0-9]+)?       { return NUM; }

[ \t\n]+                { /* Ignore whitespace and newlines */ }

.                       { return yytext[0]; } /* Pass other chars (like = ; { } ( )) directly to yacc */

%%
