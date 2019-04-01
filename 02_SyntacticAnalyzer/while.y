%baseclass-preinclude <iostream>

%lsp-needed

%token IDENTIFIER
%token PROGRAM;
%token BEGIN;
%token END;
%token NATURAL;
%token BOOLEAN;
%token TRUE;
%token FALSE;
%token DIV;
%token MOD; 
%token AND;
%token OR;
%token NOT;
%token SKIP;
%token IF;   
%token THEN;
%token ELSE;
%token ELSIF;
%token ENDIF;
%token WHILE;
%token DO;
%token DONE;
%token READ;
%token WRITE;

%token SEMICOLN;
%token LOWER;
%token GREATER;
%token PLUS;
%token MINUS;
%token EQUAL;
%token SET_VALUE;
%token MULTIPLICATION;
%token LEFT_BRACKET;
%token RIGHT_BRACKET;

%%

start:
    PROGRAM IDENTIFIER declarations BEGIN commands END
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
    NATURAL IDENTIFIER SEMICOLN
    {
        std::cout << "declaration -> NATURAL IDENTIFIER SEMICOLN" << std::endl;
    }
|
    BOOLEAN IDENTIFIER SEMICOLN
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
    SKIP SEMICOLN
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
    IDENTIFIER SET_VALUE expression SEMICOLN
    {
        std::cout << "set_value -> IDENTIFIER SET_VALUE expression SEMICOLN" << std::endl;
    }
;

in:
    READ LEFT_BRACKET IDENTIFIER RIGHT_BRACKET SEMICOLN
    {
        std::cout << "in -> READ LEFT_BRACKET IDENTIFIER RIGHT_BRACKET SEMICOLN" << std::endl;
    }
;

out:
    WRITE LEFT_BRACKET expression RIGHT_BRACKET SEMICOLN
    {
        std::cout << "out -> WRITE LEFT_BRACKET expression RIGHT_BRACKET SEMICOLN" << std::endl;
    }
;

branch:
    IF expression THEN commands ENDIF
    {
        std::cout << "branch -> IF expression THEN commands ENDIF" << std::endl;
    }
|
    IF expression THEN commands ELSE commands ELSIF
    {
        std::cout << "branch -> IF expression THEN commands ELSE commands ELSIF" << std::endl;
    }
;

cycle:
    WHILE expression DO commands DONE
    {
        std::cout << "cycle -> WHILE expression DO commands DONE" << std::endl;
    }
;

expression:
    NATURAL
    {
        std::cout << "expression -> NATURAL" << std::endl;
    }
|
    TRUE
    {
        std::cout << "expression -> TRUE" << std::endl;
    }
|
    FALSE
    {
        std::cout << "expression -> FALSE" << std::endl;
    }
|
    IDENTIFIER
    {
        std::cout << "expression -> IDENTIFIER" << std::endl;
    }
|
    expression PLUS expression
    {
        std::cout << "expression -> expression PLUS expression" << std::endl;
    }
|
    expression MINUS expression
    {
        std::cout << "expression -> expression MINUS expression" << std::endl;
    }
|
    expression MULTIPLICATION expression
    {
        std::cout << "expression -> expression MULTIPLICATION expression" << std::endl;
    }
|
    expression DIV expression
    {
        std::cout << "expression -> expression DIV expression" << std::endl;
    }
|
    expression MOD expression
    {
        std::cout << "expression -> expression MOD expression" << std::endl;
    }
|
    expression LOWER expression
    {
        std::cout << "expression -> expression LOWER expression" << std::endl;
    }
|
    expression GREATER expression
    {
        std::cout << "expression -> expression GREATER expression" << std::endl;
    }
|
    expression EQUAL expression
    {
        std::cout << "expression -> expression EQUAL expression" << std::endl;
    }
|
    expression AND expression
    {
        std::cout << "expression -> expression AND expression" << std::endl;
    }
|
    expression OR expression
    {
        std::cout << "expression -> expression OR expression" << std::endl;
    }
|
    NOT expression
    {
        std::cout << "expression -> NOT expression" << std::endl;
    }
|
    LEFT_BRACKET expression RIGHT_BRACKET
    {
        std::cout << "expression -> LEFT_BRACKET expression RIGHT_BRACKET" << std::endl;
    }
;
