%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bison.tab.h"

int row_num=1;

%}


%%

int             {  return INT;}
float           {  return FLOAT;}
if              {  return IF;}
else            {  return ELSE;}
while           {  return WHILE;}
[a-zA-Z_][a-zA-Z0-9_]*    {  return IDENTIFIER;}
[0-9]+          {  return CONSTANT;}
[+\-]        {  return PLUS_MINUS;}
[*/]        {  return TIMES_DIVIDE;}
[=]        {  return EQUAL;}
[<>]=?          {  return CONDITION_OPERATOR;}
==          {  return CONDITION_OPERATOR;}
[;]         { return SEMI;}
[(]         { return LPAREN;}
[)]         { return RPAREN;}
[{]         { return LBPAREN;}
[}]         { return RBPAREN;}
\n              { row_num ++; }
[ \t]           { /* 消耗空格和制表符 */ }
\$             { return EOF_SYMBOL; }
.               { printf("Invalid character %c row:%d\n", *yytext,row_num); }

%%


//int main() {
//    yylex();
//    return 0;
//}
int yywrap(){
	return 1;
}

