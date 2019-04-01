%option noyywrap c++ yylineno

%{
    #include <iostream>
    #include <stdlib.h>
%}

NUMERIC         [0-9]
WHITESPACE      [ \t\n]
LETTER          [a-zA-Z]

%%

program     std::cout << "PROGRAM"  << std::endl;
begin       std::cout << "BEGIN"    << std::endl;
end         std::cout << "END"      << std::endl;
natural     std::cout << "NATURAL"  << std::endl;
boolean     std::cout << "BOOLEAN"  << std::endl;
true        std::cout << "TRUE"     << std::endl;
false       std::cout << "FALSE"    << std::endl;
div         std::cout << "DIV"      << std::endl; 
mod         std::cout << "MOD"      << std::endl;
and         std::cout << "AND"      << std::endl;
or          std::cout << "OR"       << std::endl;
not         std::cout << "NOT"      << std::endl;
skip        std::cout << "SKIP"     << std::endl;
if          std::cout << "IF"       << std::endl;
then        std::cout << "THEN"     << std::endl;
else        std::cout << "ELSE"     << std::endl;
elseif      std::cout << "ELSIF"    << std::endl;
endif       std::cout << "ENDIF"    << std::endl;
while       std::cout << "WHILE"    << std::endl;
do          std::cout << "DO"       << std::endl;
done        std::cout << "DONE"     << std::endl;
read        std::cout << "READ"     << std::endl;
write       std::cout << "WRITE"    << std::endl;

";"         std::cout << "SEMICOLN" << std::endl;
"<"         std::cout << "LOWER"    << std::endl;
">"         std::cout << "GREATER"  << std::endl;
"+"         std::cout << "PLUS"     << std::endl;
"-"         std::cout << "MINUS"    << std::endl;
"="         std::cout << "EQUAL"    << std::endl;
":="        std::cout << "SET_VALUE"        << std::endl;
"*"         std::cout << "MULTIPLICATION"   << std::endl;
"("         std::cout << "LEFT_BRACKET"     << std::endl;
")"         std::cout << "RIGHT_BRACKET"    << std::endl;


{NUMERIC}+                      std::cout << "NUMERIC"      << std::endl;
{LETTER}({LETTER}|{NUMERIC}|_)* std::cout << "IDENTIFIER"   << std::endl;
^#.*                            //One line COMMENT - Nothig to do.
^#(.|\n)*#                          //Multiple line COMMENT - Nothig to do.
{WHITESPACE}+                   //WHITESPACES - Nothig to do.

. {
    std::cerr << "Lexical error in line: " << lineno() << std::endl;
    exit(1);
}

%%