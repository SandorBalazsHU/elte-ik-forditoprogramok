%baseclass-preinclude "semantics.h"

%lsp-needed

%token TOKEN_IDENTIFIER;
%token TOKEN_PROGRAM;
%token TOKEN_BEGIN;
%token TOKEN_END;
%token TOKEN_NATURAL;
%token TOKEN_NUMERIC;
%token TOKEN_BOOLEAN;
%token TOKEN_TRUE;
%token TOKEN_FALSE;
%token TOKEN_SKIP;
%token TOKEN_IF;   
%token TOKEN_THEN;
%token TOKEN_ELSE;
%token TOKEN_ELSIF;
%token TOKEN_ENDIF;
%token TOKEN_WHILE;
%token TOKEN_DO;
%token TOKEN_DONE;
%token TOKEN_READ;
%token TOKEN_WRITE;
%token TOKEN_SEMICOLN;
%token TOKEN_SET_VALUE;
%token TOKEN_LEFT_BRACKET;
%token TOKEN_RIGHT_BRACKET;

%left TOKEN_AND;
%left TOKEN_OR;
%left TOKEN_NOT;
%left TOKEN_EQUAL;
%left TOKEN_LOWER TOKEN_GREATER;
%left TOKEN_PLUS TOKEN_MINUS;
%left TOKEN_DIV TOKEN_MULTIPLICATION TOKEN_MOD; 


%%

start:
    TOKEN_PROGRAM TOKEN_IDENTIFIER declarations TOKEN_BEGIN commands TOKEN_END
    {
        std::cout << "start -> PROGRAM IDENTIFIER declarations BEGIN commands END" << std::endl;
    }
;

declarations:
    // empty
    {
        std::cout << "declarations -> epsylon" << std::endl;
    }
|
    declaration declarations
    {
        std::cout << "declarations -> declaration datas" << std::endl;
    }
;

declaration:
    TOKEN_NATURAL TOKEN_IDENTIFIER TOKEN_SEMICOLN
    {
        std::cout << "declaration -> NATURAL IDENTIFIER SEMICOLN" << std::endl;
    }
|
    TOKEN_BOOLEAN TOKEN_IDENTIFIER TOKEN_SEMICOLN
    {
        std::cout << "declaration -> BOOLEAN IDENTIFIER SEMICOLN" << std::endl;
    }
;

commands:
    command
    {
        std::cout << "commands -> command" << std::endl;
    }
|
    command commands
    {
        std::cout << "commands -> command commands" << std::endl;
    }
;

command:
    TOKEN_SKIP TOKEN_SEMICOLN
    {
        std::cout << "command -> SKIP SEMICOLN" << std::endl;
    }
|
    set_value
    {
        std::cout << "command -> set_value" << std::endl;
    }
|
    in
    {
        std::cout << "command -> in" << std::endl;
    }
|
    out
    {
        std::cout << "command -> out" << std::endl;
    }
|
    branch
    {
        std::cout << "command -> branch" << std::endl;
    }
|
    cycle
    {
        std::cout << "command -> cycle" << std::endl;
    }
;

set_value:
    TOKEN_IDENTIFIER TOKEN_SET_VALUE expression TOKEN_SEMICOLN
    {
        std::cout << "set_value -> IDENTIFIER SET_VALUE expression SEMICOLN" << std::endl;
    }
;

in:
    TOKEN_READ TOKEN_LEFT_BRACKET TOKEN_IDENTIFIER TOKEN_RIGHT_BRACKET TOKEN_SEMICOLN
    {
        std::cout << "in -> READ LEFT_BRACKET IDENTIFIER RIGHT_BRACKET SEMICOLN" << std::endl;
    }
;

out:
    TOKEN_WRITE TOKEN_LEFT_BRACKET expression TOKEN_RIGHT_BRACKET TOKEN_SEMICOLN
    {
        std::cout << "out -> WRITE LEFT_BRACKET expression RIGHT_BRACKET SEMICOLN" << std::endl;
    }
;

branch:
    TOKEN_IF expression TOKEN_THEN commands else_if TOKEN_ENDIF
    {
        std::cout << "branch -> IF expression THEN commands else_if ENDIF" << std::endl;
    }
|
    TOKEN_IF expression TOKEN_THEN commands else_if TOKEN_ELSE commands TOKEN_ENDIF
    {
        std::cout << "branch -> IF expression THEN commands else_if ELSE commands ENDIF" << std::endl;
    }
;

else_if:
    // empty
    {
        std::cout << "else_if -> epsylon" << std::endl;
    }
|
    TOKEN_ELSIF expression TOKEN_THEN commands else_if
    {
        std::cout << "else_if -> ELSIF expression THEN commands else_if" << std::endl;
    }
;

cycle:
    TOKEN_WHILE expression TOKEN_DO commands TOKEN_DONE
    {
        std::cout << "cycle -> WHILE expression DO commands DONE" << std::endl;
    }
;

expression:
    TOKEN_NUMERIC
    {
        std::cout << "expression -> NUMERIC" << std::endl;
    }
|
    TOKEN_TRUE
    {
        std::cout << "expression -> TRUE" << std::endl;
    }
|
    TOKEN_FALSE
    {
        std::cout << "expression -> FALSE" << std::endl;
    }
|
    TOKEN_IDENTIFIER
    {
        std::cout << "expression -> IDENTIFIER" << std::endl;
    }
|
    expression TOKEN_PLUS expression
    {
        std::cout << "expression -> expression PLUS expression" << std::endl;
    }
|
    expression TOKEN_MINUS expression
    {
        std::cout << "expression -> expression MINUS expression" << std::endl;
    }
|
    expression TOKEN_MULTIPLICATION expression
    {
        std::cout << "expression -> expression MULTIPLICATION expression" << std::endl;
    }
|
    expression TOKEN_DIV expression
    {
        std::cout << "expression -> expression DIV expression" << std::endl;
    }
|
    expression TOKEN_MOD expression
    {
        std::cout << "expression -> expression MOD expression" << std::endl;
    }
|
    expression TOKEN_LOWER expression
    {
        std::cout << "expression -> expression LOWER expression" << std::endl;
    }
|
    expression TOKEN_GREATER expression
    {
        std::cout << "expression -> expression GREATER expression" << std::endl;
    }
|
    expression TOKEN_EQUAL expression
    {
        std::cout << "expression -> expression EQUAL expression" << std::endl;
    }
|
    expression TOKEN_AND expression
    {
        std::cout << "expression -> expression AND expression" << std::endl;
    }
|
    expression TOKEN_OR expression
    {
        std::cout << "expression -> expression OR expression" << std::endl;
    }
|
    TOKEN_NOT expression
    {
        std::cout << "expression -> NOT expression" << std::endl;
    }
|
    TOKEN_LEFT_BRACKET expression TOKEN_RIGHT_BRACKET
    {
        std::cout << "expression -> LEFT_BRACKET expression RIGHT_BRACKET" << std::endl;
    }
;