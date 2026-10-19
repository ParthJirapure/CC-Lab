%{
#include <stdio.h>
#include <stdlib.h>

int stack[100];
int top = -1;

void push(int val) {
    stack[++top] = val;
}

int pop() {
    if (top == -1) {
        printf("Invalid Postfix Expression\n");
        exit(1);
    }
    return stack[top--];
}
%}

%%

[0-9]+  { push(atoi(yytext)); }
"+"     { int b = pop(); int a = pop(); push(a + b); }
"-"     { int b = pop(); int a = pop(); push(a - b); }
"*"     { int b = pop(); int a = pop(); push(a * b); }
"/"     {
            int b = pop();
            int a = pop();
            if (b == 0) { printf("Error: Division by zero\n"); exit(1); }
            push(a / b);
        }
[ \t]   ; /* Ignore spaces and tabs */
\n      {
            if (top == 0) {
                printf("Result = %d\n", pop());
            } else {
                printf("Invalid Expression\n");
            }
            top = -1; /* Reset stack for next input */
        }
.       { printf("Invalid character: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}

int main() {
    printf("Enter a Postfix Expression (e.g., 5 3 + 2 *):\n");
    yylex();
    return 0;
}
