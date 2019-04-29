#include <iostream>
#include <string>
#include <map>
#include <sstream>

enum types {natural_type, boolean_type};

struct var_data {
	int decl_row;
	types var_type;
	
	var_data(int n, types t):decl_row(n),var_type(t){};
	var_data(){};
};
