%option noyywrap c++ yylineno

%{
    #include <iostream>
    #include <stdlib.h>
    #include "Parser.h"
%}

NUMERIC         [0-9]
WHITESPACE      [ \t\n]
LETTER          [a-zA-Z]

%%

program    return Parser::PROGRAM;
begin      return Parser::BEGIN;
end        return Parser::END;
natural    return Parser::NATURAL;
boolean    return Parser::BOOLEAN;
true       return Parser::TRUE;
false      return Parser::FALSE;
div        return Parser::DIV;
mod        return Parser::MOD; 
and        return Parser::AND;
or         return Parser::OR;
not        return Parser::NOT;
skip       return Parser::SKIP;
if         return Parser::IF;   
then       return Parser::THEN;
else       return Parser::ELSE;
elseif     return Parser::ELSIF;
endif      return Parser::ENDIF;
while      return Parser::WHILE;
do         return Parser::DO;
done       return Parser::DONE;
read       return Parser::READ;
write      return Parser::WRITE;

";"        return Parser::SEMICOLN;
"<"        return Parser::LOWER;
">"        return Parser::GREATER;
"+"        return Parser::PLUS;
"-"        return Parser::MINUS;
"="        return Parser::EQUAL;
":="       return Parser::SET_VALUE;
"*"        return Parser::MULTIPLICATION;
"("        return Parser::LEFT_BRACKET;
")"        return Parser::RIGHT_BRACKET;


{NUMERIC}+                      return Parser:: NUMERIC;
{LETTER}({LETTER}|{NUMERIC}|_)* return Parser:: IDENTIFIER;
^#.*                            //One line COMMENT - Nothig to do.
^#(.|\n)*#                      //Multiple line COMMENT - Nothig to do.
{WHITESPACE}+                   //WHITESPACES - Nothig to do.

. {
    std::cerr << "Lexical error in line: " << lineno() << std::endl;
    exit(1);
}