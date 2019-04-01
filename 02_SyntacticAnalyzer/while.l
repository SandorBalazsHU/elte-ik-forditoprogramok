%option noyywrap c++ yylineno

%{
    #include <iostream>
    #include "Parserbase.h"
%}

NUMERIC         [0-9]
WHITESPACE      [ \t\n]
LETTER          [a-zA-Z]

%%

program    return Parser::TOKEN_PROGRAM;
begin      return Parser::TOKEN_BEGIN;
end        return Parser::TOKEN_END;
natural    return Parser::TOKEN_NATURAL;
boolean    return Parser::TOKEN_BOOLEAN;
true       return Parser::TOKEN_TRUE;
false      return Parser::TOKEN_FALSE;
div        return Parser::TOKEN_DIV;
mod        return Parser::TOKEN_MOD; 
and        return Parser::TOKEN_AND;
or         return Parser::TOKEN_OR;
not        return Parser::TOKEN_NOT;
skip       return Parser::TOKEN_SKIP;
if         return Parser::TOKEN_IF;   
then       return Parser::TOKEN_THEN;
else       return Parser::TOKEN_ELSE;
elseif     return Parser::TOKEN_ELSIF;
endif      return Parser::TOKEN_ENDIF;
while      return Parser::TOKEN_WHILE;
do         return Parser::TOKEN_DO;
done       return Parser::TOKEN_DONE;
read       return Parser::TOKEN_READ;
write      return Parser::TOKEN_WRITE;
";"        return Parser::TOKEN_SEMICOLN;
"<"        return Parser::TOKEN_LOWER;
">"        return Parser::TOKEN_GREATER;
"+"        return Parser::TOKEN_PLUS;
"-"        return Parser::TOKEN_MINUS;
"="        return Parser::TOKEN_EQUAL;
":="       return Parser::TOKEN_SET_VALUE;
"*"        return Parser::TOKEN_MULTIPLICATION;
"("        return Parser::TOKEN_LEFT_BRACKET;
")"        return Parser::TOKEN_RIGHT_BRACKET;


{NUMERIC}+                      return Parser:: TOKEN_NUMERIC;
{LETTER}({LETTER}|{NUMERIC}|_)* return Parser:: TOKEN_IDENTIFIER;
#[^#]*#                         //Multiple line COMMENT - Nothig to do.
{WHITESPACE}+                   //WHITESPACES - Nothig to do.

. {
    std::cerr << "Lexical error in line: " << lineno() << std::endl;
    exit(1);
}

%%