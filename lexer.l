%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}

%option noyywrap

%{
// 定义符号类别的字符串常量
#define KEYWORD "KEYWORD"
#define IDENTIFIER "IDENTIFIER"
#define CONSTANT "CONSTANT"
#define OPERATOR "OPERATOR"
#define CONDITION_OPERATOR "CONDITION_OPERATOR"
#define DELIMITER "DELIMITER"
#define EOF_SYMBOL "EOF"
%}

%%

int             { printf("(%s, %s)\n", KEYWORD, yytext); }
float           { printf("(%s, %s)\n", KEYWORD, yytext); }
if              { printf("(%s, %s)\n", KEYWORD, yytext); }
else            { printf("(%s, %s)\n", KEYWORD, yytext); }
while           { printf("(%s, %s)\n", KEYWORD, yytext); }
[a-zA-Z_][a-zA-Z0-9_]*    { printf("(%s, %s)\n", IDENTIFIER, yytext); }
[0-9]+          { printf("(%s, %s)\n", CONSTANT, yytext); }
[+\-*/=]        { printf("(%s, %s)\n", OPERATOR, yytext); }
[<>]=?          { printf("(%s, %s)\n", CONDITION_OPERATOR, yytext); }
==          { printf("(%s, %s)\n", CONDITION_OPERATOR, yytext); }
[(){};]         { printf("(%s, %s)\n", DELIMITER, yytext); }
\n              { /* 消耗换行符 */ }
[ \t]           { /* 消耗空格和制表符 */ }
\$             { printf("(%s, %s)\n", EOF_SYMBOL, "$"); }
.               { printf("Invalid character %c\n", *yytext); }

%%


int main() {
    yylex();
    return 0;
}
