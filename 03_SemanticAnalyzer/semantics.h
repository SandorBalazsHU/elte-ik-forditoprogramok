#include <iostream>
#include <string>
#include <map>
#include <sstream>

enum type {natural_type, boolean_type};

struct var_data {
	int decl_row;
	type var_type;
	
	var_data(int n, type t):decl_row(n),var_type(t){};
	var_data(){};
};
