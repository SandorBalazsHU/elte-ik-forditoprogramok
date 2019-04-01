#include <iostream>
#include <fstream>
#include "Parser.h"
#include <FlexLexer.h>


using namespace std;

yyFlexLexer *flexLexer;

int Parser::lex()
{
    int returnValue = flexLexer->yylex();
    d_loc__.first_line = flexLexer->lineno();
    return returnValue;
}

void input_handler( ifstream& inputStream, int argumentsNumber, char* arguments[] );

int main( int argumentsNumber, char* arguments[] )
{
    ifstream inputStream;
    input_handler( inputStream, argumentsNumber, arguments );
    flexLexer = new yyFlexLexer( &inputStream, &cout );
    Parser parser( inputStream );
    parser.parse();
    return 0;
}

void input_handler( ifstream& inputStream, int argumentsNumber, char* arguments[] )
{
    if( argumentsNumber < 2 )
    {
        cerr << "Few command line argument! Pleas give the input file name!" << endl;
        exit(1);
    }
    inputStream.open( arguments[1] );
    if( !inputStream )
    {
        cerr << "The " << arguments[1] << " does not exist!" << endl;
        exit(1);
    }
}
