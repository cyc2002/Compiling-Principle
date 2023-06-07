%{
#include <stdio.h>
#include <stdlib.h>

extern int row_num;

%}

%token EOF_SYMBOL PLUS_MINUS TIMES_DIVIDE EQUAL SEMI LPAREN RPAREN LBPAREN RBPAREN
%token INT FLOAT IF ELSE WHILE IDENTIFIER CONSTANT OPERATOR CONDITION_OPERATOR

%left PLUS_MINUS
%left TIMES_DIVIDE
%nonassoc LOWER_THAN_ELSE
%nonassoc ELSE

%%

program : statement EOF_SYMBOL
        ;

statement : declaration_statement
          | assignment_statement
          | if_statement
          | while_statement
          | LBPAREN statement_list RBPAREN
          ;

declaration_statement : INT IDENTIFIER SEMI 
                      | FLOAT IDENTIFIER SEMI
                      ;

assignment_statement : IDENTIFIER EQUAL expression SEMI
                      ;

if_statement : IF LPAREN condition_expression RPAREN statement %prec LOWER_THAN_ELSE
             | IF LPAREN condition_expression RPAREN statement ELSE statement
             ;

while_statement : WHILE LPAREN condition_expression RPAREN statement
                ;

expression : term
           | expression PLUS_MINUS term   %prec PLUS_MINUS
           ;

term : factor
     | term TIMES_DIVIDE factor   %prec TIMES_DIVIDE
     ;

factor : IDENTIFIER
       | CONSTANT
       | LPAREN expression RPAREN
       | PLUS_MINUS factor
       ;

condition_expression : expression CONDITION_OPERATOR expression
                     ;

statement_list : statement
               | statement_list statement
               ;

%%

int main() {
    if(!yyparse())
        printf("Compile successfully!");
    return 0;
}

int yyerror(const char* message) {
    fprintf(stderr, "%s! row:%d\n", message,row_num);
    return 0;
}
