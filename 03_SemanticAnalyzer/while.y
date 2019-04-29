%baseclass-preinclude "semantics.h"

%lsp-needed

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

%union {
	std::string* text;
	type* typ;
}

%token <text> TOKEN_IDENTIFIER;
%type <typ> var_type;
%type <typ> constant;
%type <typ> expression;

%%

start:
    TOKEN_PROGRAM TOKEN_IDENTIFIER declarations TOKEN_BEGIN commands TOKEN_END
    {
        std::cout << "The program is correct!" << std::endl;
    }
;

var_type:
	TOKEN_NATURAL
	{
		$$ = new type(natural_type);
    }
|
	TOKEN_BOOLEAN
	{
		$$ = new type(boolean_type);
    }
;

constant:
	TOKEN_TRUE
	{
		$$ = new type(boolean_type);
    }
|
	TOKEN_FALSE
	{
		$$ = new type(boolean_type);
    }
|
	TOKEN_NUMERIC
	{
		$$ = new type(natural_type);
    }
;

declarations:
    // empty
|
    declaration declarations
;

declaration:
    var_type TOKEN_IDENTIFIER TOKEN_SEMICOLN
    {
        if(table.count(*$2) > 0){
			std::stringstream ss;
			ss << "Ujradeklaralt valtozo: "<< *$2<<".\n"
				<< "Korabbi deklaracio sora: " << table[*$2].decl_row << std::endl;
			error(ss.str().c_str());
		}
		table[*$2] = var_data(d_loc__.first_line, *$1);
		delete $2;
		delete $1;
    }
|
    var_type TOKEN_IDENTIFIER TOKEN_SEMICOLN
    {
		if(table.count(*$2) > 0){
			std::stringstream ss;
			ss << "Ujradeklaralt valtozo: "<< *$2<<".\n"
				<< "Korabbi deklaracio sora: " << table[*$2].decl_row << std::endl;
			error(ss.str().c_str());
		}
		table[*$2] = var_data(d_loc__.first_line, *$1);
		delete $2;
		delete $1;
    }
;

commands:
    command
|
    command commands
;

command:
    TOKEN_SKIP TOKEN_SEMICOLN
|
    set_value
|
    in
|
    out
|
    branch
|
    cycle
;

set_value:
    TOKEN_IDENTIFIER TOKEN_SET_VALUE expression TOKEN_SEMICOLN
    {
        if( table.count(*$1) == 0 )
		{
			std::stringstream ss;
			ss << "Nem deklaralt valtozo: " << *$1 << ".\n" << std::endl;
			error( ss.str().c_str() );
		}
		if( table[*$1].var_type != *$3 )
		{
			error( "Tipushibas ertekadas.\n" );
		}
		delete $1;
		delete $3;
    }
;

in:
    TOKEN_READ TOKEN_LEFT_BRACKET TOKEN_IDENTIFIER TOKEN_RIGHT_BRACKET TOKEN_SEMICOLN
    {
        if(table.count(*$3) == 0){
			std::stringstream ss;
			ss << "Nem deklaralt valtozo: " << *$3 << ".\n" << std::endl;
			error( ss.str().c_str() );
		}
		delete $3;
    }
;

out:
    TOKEN_WRITE TOKEN_LEFT_BRACKET expression TOKEN_RIGHT_BRACKET TOKEN_SEMICOLN
;

branch:
    TOKEN_IF expression TOKEN_THEN commands else_if TOKEN_ENDIF
    {
        if(*$2 != boolean_type){
			std::stringstream ss;
			ss << "Tipushibas elagazas-feltetel" << std::endl;
			error( ss.str().c_str() );
		}
		delete $2;
    }
|
    TOKEN_IF expression TOKEN_THEN commands else_if TOKEN_ELSE commands TOKEN_ENDIF
    {
		if(*$2 != boolean_type){
			std::stringstream ss;
			ss << "Tipushibas elagazas-feltetel" << std::endl;
			error( ss.str().c_str() );
		}
		delete $2;
    }
;

else_if:
    // empty
|
    TOKEN_ELSIF expression TOKEN_THEN commands else_if
    {
		if(*$2 != boolean_type){
			std::stringstream ss;
			ss << "Tipushibas elagazas-feltetel" << std::endl;
			error( ss.str().c_str() );
		}
		delete $2;
    }
;

cycle:
    TOKEN_WHILE expression TOKEN_DO commands TOKEN_DONE
    {
        if(*$3 != boolean_type){
			std::stringstream ss;
			ss << "Tipushibas ciklusfeltetel!" << std::endl;
			error( ss.str().c_str() );
		}
		delete $3;
    }
;

expression:
    constant
    {
       	$$ = new type(*$1);
		delete $1; 
    }
|
    TOKEN_IDENTIFIER
    {
		if( table.count(*$1) == 0 )
		{
			std::stringstream ss;
			ss << "Nem deklaralt valtozo: " << *$1 << ".\n" << std::endl;
			error( ss.str().c_str() );
		}
		$$ = new type(table[*$1].var_type);
		delete $1;
    }
|
    expression TOKEN_PLUS expression
    {
		if(*$1 != natural_type || *$3 != natural_type) {
			std::stringstream ss;
			ss << "Tipushibas 'PLUSZ' operator" << std::endl;
			error( ss.str().c_str() );
		}
		$$ = new type(*$1);
		delete $1; delete $3;
    }
|
    expression TOKEN_MINUS expression
    {
		if(*$1 != natural_type || *$3 != natural_type) {
			std::stringstream ss;
			ss << "Tipushibas 'MINUS' operator" << std::endl;
			error( ss.str().c_str() );
		}
		$$ = new type(*$1);
		delete $1; delete $3;
    }
|
    expression TOKEN_MULTIPLICATION expression
    {
		if(*$1 != natural_type || *$3 != natural_type) {
			std::stringstream ss;
			ss << "Tipushibas 'CSILLAG' operator" << std::endl;
			error( ss.str().c_str() );
		}
		$$ = new type(*$1);
		delete $1; delete $3;
    }
|
    expression TOKEN_DIV expression
    {
		if(*$1 != natural_type || *$3 != natural_type) {
			std::stringstream ss;
			ss << "Tipushibas 'PER' operator" << std::endl;
			error( ss.str().c_str() );
		}
		$$ = new type(*$1);
		delete $1; delete $3;
    }
|
    expression TOKEN_MOD expression
    {
		if(*$1 != natural_type || *$3 != natural_type) {
			std::stringstream ss;
			ss << "Tipushibas 'SZAZALEK' operator" << std::endl;
			error( ss.str().c_str() );
		}
		$$ = new type(*$1);
		delete $1; delete $3;
    }
|
    expression TOKEN_LOWER expression
    {
		if(*$1 != natural_type || *$3 != natural_type) {
			std::stringstream ss;
			ss << "Tipushibas 'KISEBB' operator" << std::endl;
			error( ss.str().c_str() );
		}
		$$ = new type(boolean_type);
		delete $1; delete $3;
    }
|
    expression TOKEN_GREATER expression
    {
		if(*$1 != natural_type || *$3 != natural_type) {
			std::stringstream ss;
			ss << "Tipushibas 'NAGYOBB' operator" << std::endl;
			error( ss.str().c_str() );
		}
		$$ = new type(boolean_type);
		delete $1; delete $3;
    }
|
    expression TOKEN_EQUAL expression
    {
		if(*$1 != *$3) {
			std::stringstream ss;
			ss << "Tipushibas 'EGYENLO' operator" << std::endl;
			error( ss.str().c_str() );
		}
		$$ = new type(boolean_type);
		delete $1; delete $3;
    }
|
    expression TOKEN_AND expression
    {
		if(*$1 != boolean_type || *$3 != boolean_type) {
			std::stringstream ss;
			ss << "Tipushibas 'ES' operator! " << std::endl;
			error( ss.str().c_str() );
		}
		$$ = new type(*$1);
		delete $1; delete $3;
    }
|
    expression TOKEN_OR expression
    {
		if(*$1 != boolean_type || *$3 != boolean_type) {
			std::stringstream ss;
			ss << "Tipushibas 'VAGY' operator! " << std::endl;
			error( ss.str().c_str() );
		}
		$$ = new type(*$1);
		delete $1; delete $3;
    }
|
    TOKEN_NOT expression
    {
		if(*$2 != boolean_type) {
			std::stringstream ss;
			ss << "Tipushibas 'NEM' operator" << std::endl;
			error( ss.str().c_str() );
		}
		$$ = new type(*$2);
		delete $2;
    }
|
    TOKEN_LEFT_BRACKET expression TOKEN_RIGHT_BRACKET
    {
        $$ = new type(*$2);
		delete $2;
    }
;